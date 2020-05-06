import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './main.dart';

class EditData extends StatefulWidget {
  final List list;
  final int index;

  EditData({this.list, this.index});

  @override
  _EditDataState createState() => new _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController controllerName;
  TextEditingController controllerPrice;
  GlobalKey<FormState> formnew = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scafoldstate = GlobalKey<ScaffoldState>();

  void validasi() {
    FormState form = this.formnew.currentState;
    ScaffoldState scafold = this.scafoldstate.currentState;
    SnackBar pesangagal = new SnackBar(content: Text("Gagagl mengubah data"));
    if (form.validate()) {
      try {
        editData();
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Home()));
      } catch (e) {
        scafold.showSnackBar(pesangagal);
      }
    }
  }

  void editData() {
    var url = "http://localhost/xphone/edit_phone.php";
    http.post(url, body: {
      "id": widget.list[widget.index]['id'],
      "phone_name": controllerName.text,
      "price": controllerPrice.text,
    });
  }

  @override
  void initState() {
    controllerName = new TextEditingController(
        text: widget.list[widget.index]['phone_name']);
    controllerPrice =
        new TextEditingController(text: widget.list[widget.index]['price']);

    super.initState()
    ;
  }

  @override
  Widget build(BuildContext context) {
    var textFormField = new TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Harga tidak boleh kosong";
                      }
                    },
                    controller: controllerPrice,
                    decoration: new InputDecoration(
                        hintText: "Harga", labelText: "Harga"),
                    keyboardType: TextInputType.number,
                  );
    return new Scaffold(
      key: scafoldstate,
      appBar: new AppBar(
        title: new Text("Ubah Data"),
        backgroundColor: Colors.green[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: formnew,
              child: new Column(
                children: <Widget>[
                  new TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Nama Hp Tidak boleh kosong";
                      }
                    },
                    controller: controllerName,
                    decoration: new InputDecoration(
                        hintText: "Nama HP", labelText: "Nama Hp"),
                  ),
                  textFormField,
                  new Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  new RaisedButton(
                    child: new Text("EDIT DATA"),
                    color: Colors.blueGrey,
                    onPressed: () {
                      validasi();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
