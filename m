Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSFJMnk>; Mon, 10 Jun 2002 08:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSFJMnN>; Mon, 10 Jun 2002 08:43:13 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20999 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313711AbSFJMk5>; Mon, 10 Jun 2002 08:40:57 -0400
Message-ID: <3D049097.6080605@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:42:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 11/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000206020306060808060602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000206020306060808060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irias_object missused __FUNCTION__ too.

--------------000206020306060808060602
Content-Type: text/plain;
 name="warn-2.5.21-11.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-11.diff"

diff -urN linux-2.5.21/net/irda/irias_object.c linux/net/irda/irias_objec=
t.c
--- linux-2.5.21/net/irda/irias_object.c	2002-06-09 07:27:15.000000000 +0=
200
+++ linux/net/irda/irias_object.c	2002-06-09 20:50:51.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      irias_object.c
  * Version:       0.3
  * Description:   IAS object database and functions
@@ -8,18 +8,18 @@
  * Created at:    Thu Oct  1 22:50:04 1998
  * Modified at:   Wed Dec 15 11:23:16 1999
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- *=20
+ *
  *     Copyright (c) 1998-1999 Dag Brattli, All Rights Reserved.
- *     =20
- *     This program is free software; you can redistribute it and/or=20
- *     modify it under the terms of the GNU General Public License as=20
- *     published by the Free Software Foundation; either version 2 of=20
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
- * =20
+ *
  *     Neither Dag Brattli nor University of Troms=F8 admit liability no=
r
- *     provide warranty for any of this software. This material is=20
+ *     provide warranty for any of this software. This material is
  *     provided "AS-IS" and at no charge.
- *    =20
+ *
  ********************************************************************/
=20
 #include <linux/string.h>
@@ -47,7 +47,7 @@
 {
 	char *new_str;
 	int len;
-=09
+
 	/* Check string */
 	if (str =3D=3D NULL)
 		return NULL;
@@ -59,14 +59,14 @@
 	/* Allocate new string */
         new_str =3D kmalloc(len + 1, GFP_ATOMIC);
         if (new_str =3D=3D NULL) {
-		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
=20
 	/* Copy and truncate */
 	memcpy(new_str, str, len);
 	new_str[len] =3D '\0';
-=09
+
 	return new_str;
 }
=20
@@ -79,10 +79,10 @@
 struct ias_object *irias_new_object( char *name, int id)
 {
         struct ias_object *obj;
-=09
+
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
=20
-	obj =3D (struct ias_object *) kmalloc(sizeof(struct ias_object),=20
+	obj =3D (struct ias_object *) kmalloc(sizeof(struct ias_object),
 					    GFP_ATOMIC);
 	if (obj =3D=3D NULL) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unable to allocate object!\n");
@@ -95,7 +95,7 @@
 	obj->id =3D id;
=20
 	obj->attribs =3D hashbin_new(HB_LOCAL);
-=09
+
 	return obj;
 }
=20
@@ -115,7 +115,7 @@
=20
 	irias_delete_value(attrib->value);
 	attrib->magic =3D ~IAS_ATTRIB_MAGIC;
-=09
+
 	kfree(attrib);
 }
=20
@@ -126,11 +126,11 @@
=20
 	if (obj->name)
 		kfree(obj->name);
-=09
+
 	hashbin_delete(obj->attribs, (FREE_FUNC) __irias_delete_attrib);
-=09
+
 	obj->magic =3D ~IAS_OBJECT_MAGIC;
-=09
+
 	kfree(obj);
 }
=20
@@ -141,7 +141,7 @@
  *    with this object and the object itself
  *
  */
-int irias_delete_object(struct ias_object *obj)=20
+int irias_delete_object(struct ias_object *obj)
 {
 	struct ias_object *node;
=20
@@ -164,7 +164,7 @@
  *    the object, remove the object as well.
  *
  */
-int irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attri=
b)=20
+int irias_delete_attrib(struct ias_object *obj, struct ias_attrib *attri=
b)
 {
 	struct ias_attrib *node;
=20
@@ -198,7 +198,7 @@
 {
 	ASSERT(obj !=3D NULL, return;);
 	ASSERT(obj->magic =3D=3D IAS_OBJECT_MAGIC, return;);
-=09
+
 	hashbin_insert(objects, (irda_queue_t *) obj, 0, obj->name);
 }
=20
@@ -247,7 +247,7 @@
 {
 	ASSERT(obj !=3D NULL, return;);
 	ASSERT(obj->magic =3D=3D IAS_OBJECT_MAGIC, return;);
-=09
+
 	ASSERT(attrib !=3D NULL, return;);
 	ASSERT(attrib->magic =3D=3D IAS_ATTRIB_MAGIC, return;);
=20
@@ -263,8 +263,8 @@
  *    Change the value of an objects attribute.
  *
  */
-int irias_object_change_attribute(char *obj_name, char *attrib_name,=20
-				  struct ias_value *new_value)=20
+int irias_object_change_attribute(char *obj_name, char *attrib_name,
+				  struct ias_value *new_value)
 {
 	struct ias_object *obj;
 	struct ias_attrib *attrib;
@@ -272,7 +272,7 @@
 	/* Find object */
 	obj =3D hashbin_find(objects, 0, obj_name);
 	if (obj =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to find object: %s\n",
+		WARNING("%s: Unable to find object: %s\n", __FUNCTION__,
 			obj_name);
 		return -1;
 	}
@@ -280,20 +280,20 @@
 	/* Find attribute */
 	attrib =3D hashbin_find(obj->attribs, 0, attrib_name);
 	if (attrib =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to find attribute: %s\n",
+		WARNING("%s: Unable to find attribute: %s\n", __FUNCTION__,
 			attrib_name);
 		return -1;
 	}
-=09
+
 	if ( attrib->value->type !=3D new_value->type) {
-		IRDA_DEBUG( 0, __FUNCTION__=20
+		IRDA_DEBUG( 0, __FUNCTION__
 		       "(), changing value type not allowed!\n");
 		return -1;
 	}
=20
 	/* Delete old value */
 	irias_delete_value(attrib->value);
-=09
+
 	/* Insert new value */
 	attrib->value =3D new_value;
=20
@@ -315,11 +315,11 @@
 	ASSERT(obj !=3D NULL, return;);
 	ASSERT(obj->magic =3D=3D IAS_OBJECT_MAGIC, return;);
 	ASSERT(name !=3D NULL, return;);
-=09
-	attrib =3D (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib),=20
+
+	attrib =3D (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib),
 					       GFP_ATOMIC);
 	if (attrib =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to allocate attribute!\n");
+		WARNING("%s: Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
@@ -329,7 +329,7 @@
=20
 	/* Insert value */
 	attrib->value =3D irias_new_integer_value(value);
-=09
+
 	irias_add_attrib(obj, attrib, owner);
 }
=20
@@ -344,27 +344,26 @@
 			     int len, int owner)
 {
 	struct ias_attrib *attrib;
-=09
+
 	ASSERT(obj !=3D NULL, return;);
 	ASSERT(obj->magic =3D=3D IAS_OBJECT_MAGIC, return;);
-=09
+
 	ASSERT(name !=3D NULL, return;);
 	ASSERT(octets !=3D NULL, return;);
-=09
-	attrib =3D (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib),=20
+
+	attrib =3D (struct ias_attrib *) kmalloc(sizeof(struct ias_attrib),
 					       GFP_ATOMIC);
 	if (attrib =3D=3D NULL) {
-		WARNING(__FUNCTION__=20
-			"(), Unable to allocate attribute!\n");
+		WARNING("%s: Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
-=09
+
 	attrib->magic =3D IAS_ATTRIB_MAGIC;
 	attrib->name =3D strndup(name, IAS_MAX_ATTRIBNAME);
-=09
+
 	attrib->value =3D irias_new_octseq_value( octets, len);
-=09
+
 	irias_add_attrib(obj, attrib, owner);
 }
=20
@@ -384,11 +383,11 @@
=20
 	ASSERT(name !=3D NULL, return;);
 	ASSERT(value !=3D NULL, return;);
-=09
-	attrib =3D (struct ias_attrib *) kmalloc(sizeof( struct ias_attrib),=20
+
+	attrib =3D (struct ias_attrib *) kmalloc(sizeof( struct ias_attrib),
 					       GFP_ATOMIC);
 	if (attrib =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to allocate attribute!\n");
+		WARNING("%s: Unable to allocate attribute!\n", __FUNCTION__);
 		return;
 	}
 	memset(attrib, 0, sizeof( struct ias_attrib));
@@ -413,7 +412,7 @@
=20
 	value =3D kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -438,7 +437,7 @@
=20
 	value =3D kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset( value, 0, sizeof( struct ias_value));
@@ -465,7 +464,7 @@
=20
 	value =3D kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -478,7 +477,7 @@
=20
 	value->t.oct_seq =3D kmalloc(len, GFP_ATOMIC);
 	if (value->t.oct_seq =3D=3D NULL){
-		WARNING(__FUNCTION__"(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		kfree(value);
 		return NULL;
 	}
@@ -492,7 +491,7 @@
=20
 	value =3D kmalloc(sizeof(struct ias_value), GFP_ATOMIC);
 	if (value =3D=3D NULL) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 	memset(value, 0, sizeof(struct ias_value));
@@ -536,6 +535,3 @@
 	}
 	kfree(value);
 }
-
-
-

--------------000206020306060808060602--

