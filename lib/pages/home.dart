import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url = "http://192.168.254.40/api/city.php";
  String valCity;
  List<dynamic> dataCity = List();

  Future getCity() async {
    final response = await http.get(url); 
    var listData = jsonDecode(response.body); 
    setState(() {
      dataCity = listData; 
    });
    // print("data : $listData");
  }

  @override
  void initState() {
    super.initState();
    getCity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rest API data into Dropdown menu'),
      ),
      // body: SingleChildScrollView(
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     physics: NeverScrollableScrollPhysics(),
      //     itemCount: dataCity.length,
      //     itemBuilder:(context, index){
      //       var callData = dataCity[index];
      //       return ListTile(
      //         title: Text(callData['ctname']),
      //         trailing: Text(callData['cid'].toString()),
      //       );
      //     }
      //     ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DropdownButton(
              hint: Text("Select City"),
              value: valCity,
              items: dataCity.map((item) {
                return DropdownMenuItem(
                  child: Text(item['ctname']),
                  value: item['ctname'],
                );
              }).toList(),
              onChanged: (value) {
               setState(() {
                 valCity = value;
               });
              },
            ),
            Text('City you choose $valCity',
            style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
