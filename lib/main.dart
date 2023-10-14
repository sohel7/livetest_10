import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ItemListScreen(),
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  List<Item> items = List.generate(5, (index) => Item(index, false));
  int selectedCount = 0;

  void toggleItemSelection(int index) {
    setState(() {
      items[index].isSelected = !items[index].isSelected;
      selectedCount = items.where((item) => item.isSelected).length;
    });
  }

  void showSelectedCountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selected Items'),
          content: Text('Number of selected items: $selectedCount'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selection Screen'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item ${items[index].id +1}'),
           // child: Text('${index + 1}'),
            tileColor: items[index].isSelected ? Colors.blue : null,
            onTap: () {
              toggleItemSelection(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSelectedCountDialog(context);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class Item {
  final int id;
  bool isSelected;

  Item(this.id, this.isSelected);
}
