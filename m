Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSFJMjh>; Mon, 10 Jun 2002 08:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFJMjg>; Mon, 10 Jun 2002 08:39:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:18439 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313537AbSFJMia>; Mon, 10 Jun 2002 08:38:30 -0400
Message-ID: <3D049004.6010104@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:39:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 9/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090101080201080303020805"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101080201080303020805
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix improper __FUNCTION__ usage in iriap.c
- Trailing white garbage removal as well.

--------------090101080201080303020805
Content-Type: text/plain;
 name="warn-2.5.21-9.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-9.diff"

diff -urN linux-2.5.21/net/irda/iriap.c linux/net/irda/iriap.c
--- linux-2.5.21/net/irda/iriap.c	2002-06-09 07:28:38.000000000 +0200
+++ linux/net/irda/iriap.c	2002-06-09 21:52:11.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      iriap.c
  * Version:       0.8
  * Description:   Information Access Protocol (IAP)
@@ -8,18 +8,18 @@
  * Created at:    Thu Aug 21 00:02:07 1997
  * Modified at:   Sat Dec 25 16:42:42 1999
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- *=20
- *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,=20
+ *
+ *     Copyright (c) 1998-1999 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
  *     Copyright (c) 2000-2001 Jean Tourrilhes <jt@hpl.hp.com>
- *    =20
- *     This program is free software; you can redistribute it and/or=20
- *     modify it under the terms of the GNU General Public License as=20
- *     published by the Free Software Foundation; either version 2 of=20
+ *
+ *     This program is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
  *     the License, or (at your option) any later version.
  *
  *     Neither Dag Brattli nor University of Troms=F8 admit liability no=
r
- *     provide warranty for any of this software. This material is=20
+ *     provide warranty for any of this software. This material is
  *     provided "AS-IS" and at no charge.
  *
  ********************************************************************/
@@ -59,30 +59,30 @@
 #endif	/* CONFIG_IRDA_DEBUG */
=20
 static hashbin_t *iriap =3D NULL;
-static __u32 service_handle;=20
+static __u32 service_handle;
=20
 extern char *lmp_reasons[];
=20
 static void __iriap_close(struct iriap_cb *self);
 static int iriap_register_lsap(struct iriap_cb *self, __u8 slsap_sel, in=
t mode);
-static void iriap_disconnect_indication(void *instance, void *sap,=20
+static void iriap_disconnect_indication(void *instance, void *sap,
 					LM_REASON reason, struct sk_buff *skb);
-static void iriap_connect_indication(void *instance, void *sap,=20
+static void iriap_connect_indication(void *instance, void *sap,
 				     struct qos_info *qos, __u32 max_sdu_size,
-				     __u8 max_header_size,=20
+				     __u8 max_header_size,
 				     struct sk_buff *skb);
-static void iriap_connect_confirm(void *instance, void *sap,=20
-				  struct qos_info *qos,=20
+static void iriap_connect_confirm(void *instance, void *sap,
+				  struct qos_info *qos,
 				  __u32 max_sdu_size, __u8 max_header_size,
 				  struct sk_buff *skb);
-static int iriap_data_indication(void *instance, void *sap,=20
+static int iriap_data_indication(void *instance, void *sap,
 				 struct sk_buff *skb);
=20
 /*
  * Function iriap_init (void)
  *
  *    Initializes the IrIAP layer, called by the module initialization c=
ode
- *    in irmod.c=20
+ *    in irmod.c
  */
 int __init iriap_init(void)
 {
@@ -98,12 +98,12 @@
=20
 	objects =3D hashbin_new(HB_LOCAL);
 	if (!objects) {
-		WARNING(__FUNCTION__ "(), Can't allocate objects hashbin!\n");
+		WARNING("%s: Can't allocate objects hashbin!\n", __FUNCTION__);
 		return -ENOMEM;
 	}
=20
-	/*=20
-	 *  Register some default services for IrLMP=20
+	/*
+	 *  Register some default services for IrLMP
 	 */
 	hints  =3D irlmp_service_to_hint(S_COMPUTER);
 	service_handle =3D irlmp_register_service(hints);
@@ -122,9 +122,9 @@
 				IAS_KERNEL_ATTR);
 	irias_insert_object(obj);
=20
-	/* =20
-	 *  Register server support with IrLMP so we can accept incoming=20
-	 *  connections=20
+	/*
+	 *  Register server support with IrLMP so we can accept incoming
+	 *  connections
 	 */
 	server =3D iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL);
 	if (!server) {
@@ -139,15 +139,15 @@
 /*
  * Function iriap_cleanup (void)
  *
- *    Initializes the IrIAP layer, called by the module cleanup code in =

+ *    Initializes the IrIAP layer, called by the module cleanup code in
  *    irmod.c
  */
 void iriap_cleanup(void)
 {
 	irlmp_unregister_service(service_handle);
-=09
+
 	hashbin_delete(iriap, (FREE_FUNC) __iriap_close);
-	hashbin_delete(objects, (FREE_FUNC) __irias_delete_object);=09
+	hashbin_delete(objects, (FREE_FUNC) __irias_delete_object);
 }
=20
 /*
@@ -155,7 +155,7 @@
  *
  *    Opens an instance of the IrIAP layer, and registers with IrLMP
  */
-struct iriap_cb *iriap_open(__u8 slsap_sel, int mode, void *priv,=20
+struct iriap_cb *iriap_open(__u8 slsap_sel, int mode, void *priv,
 			    CONFIRM_CALLBACK callback)
 {
 	struct iriap_cb *self;
@@ -164,7 +164,7 @@
=20
 	self =3D kmalloc(sizeof(struct iriap_cb), GFP_ATOMIC);
 	if (!self) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s: Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
=20
@@ -172,7 +172,7 @@
 	 *  Initialize instance
 	 */
 	memset(self, 0, sizeof(struct iriap_cb));
-=09
+
 	self->magic =3D IAS_MAGIC;
 	self->mode =3D mode;
 	if (mode =3D=3D IAS_CLIENT)
@@ -184,13 +184,13 @@
 	init_timer(&self->watchdog_timer);
=20
 	hashbin_insert(iriap, (irda_queue_t *) self, (int) self, NULL);
-=09
+
 	/* Initialize state machines */
 	iriap_next_client_state(self, S_DISCONNECT);
 	iriap_next_call_state(self, S_MAKE_CALL);
 	iriap_next_server_state(self, R_DISCONNECT);
 	iriap_next_r_connect_state(self, R_WAITING);
-=09
+
 	return self;
 }
=20
@@ -261,7 +261,7 @@
=20
 	self->lsap =3D irlmp_open_lsap(slsap_sel, &notify, 0);
 	if (self->lsap =3D=3D NULL) {
-		ERROR(__FUNCTION__ "(), Unable to allocated LSAP!\n");
+		ERROR("%s: Unable to allocated LSAP!\n", __FUNCTION__);
 		return -1;
 	}
 	self->slsap_sel =3D self->lsap->slsap_sel;
@@ -275,8 +275,8 @@
  *    Got disconnect, so clean up everything assosiated with this connec=
tion
  *
  */
-static void iriap_disconnect_indication(void *instance, void *sap,=20
-					LM_REASON reason,=20
+static void iriap_disconnect_indication(void *instance, void *sap,
+					LM_REASON reason,
 					struct sk_buff *userdata)
 {
 	struct iriap_cb *self;
@@ -296,18 +296,18 @@
 		IRDA_DEBUG(4, __FUNCTION__ "(), disconnect as client\n");
=20
=20
-		iriap_do_client_event(self, IAP_LM_DISCONNECT_INDICATION,=20
+		iriap_do_client_event(self, IAP_LM_DISCONNECT_INDICATION,
 				      NULL);
-		/*=20
-		 * Inform service user that the request failed by sending=20
+		/*
+		 * Inform service user that the request failed by sending
 		 * it a NULL value. Warning, the client might close us, so
 		 * remember no to use self anymore after calling confirm
 		 */
 		if (self->confirm)
- 			self->confirm(IAS_DISCONNECT, 0, NULL, self->priv);
+			self->confirm(IAS_DISCONNECT, 0, NULL, self->priv);
 	} else {
 		IRDA_DEBUG(4, __FUNCTION__ "(), disconnect as server\n");
-		iriap_do_server_event(self, IAP_LM_DISCONNECT_INDICATION,=20
+		iriap_do_server_event(self, IAP_LM_DISCONNECT_INDICATION,
 				      NULL);
 		iriap_close(self);
 	}
@@ -318,9 +318,6 @@
=20
 /*
  * Function iriap_disconnect_request (handle)
- *
- *   =20
- *
  */
 void iriap_disconnect_request(struct iriap_cb *self)
 {
@@ -338,35 +335,35 @@
 		return;
 	}
=20
-	/*=20
-	 *  Reserve space for MUX control and LAP header=20
+	/*
+	 *  Reserve space for MUX control and LAP header
 	 */
- 	skb_reserve(skb, LMP_MAX_HEADER);
+	skb_reserve(skb, LMP_MAX_HEADER);
=20
 	irlmp_disconnect_request(self->lsap, skb);
 }
=20
-void iriap_getinfobasedetails_request(void)=20
+void iriap_getinfobasedetails_request(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
 }
=20
-void iriap_getinfobasedetails_confirm(void)=20
+void iriap_getinfobasedetails_confirm(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
 }
=20
-void iriap_getobjects_request(void)=20
+void iriap_getobjects_request(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
 }
=20
-void iriap_getobjects_confirm(void)=20
+void iriap_getobjects_confirm(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
 }
=20
-void iriap_getvalue(void)=20
+void iriap_getvalue(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
 }
@@ -378,7 +375,7 @@
  *    name
  */
 int iriap_getvaluebyclass_request(struct iriap_cb *self,
-				  __u32 saddr, __u32 daddr,=20
+				  __u32 saddr, __u32 daddr,
 				  char *name, char *attr)
 {
 	struct sk_buff *skb;
@@ -391,18 +388,18 @@
 	/* Client must supply the destination device address */
 	if (!daddr)
 		return -1;
-=09
+
 	self->daddr =3D daddr;
 	self->saddr =3D saddr;
=20
-	/*=20
+	/*
 	 *  Save operation, so we know what the later indication is about
 	 */
-	self->operation =3D GET_VALUE_BY_CLASS;=20
+	self->operation =3D GET_VALUE_BY_CLASS;
=20
 	/* Give ourselves 10 secs to finish this operation */
 	iriap_start_watchdog_timer(self, 10*HZ);
-=09
+
 	name_len =3D strlen(name);	/* Up to IAS_MAX_CLASSNAME =3D 60 */
 	attr_len =3D strlen(attr);	/* Up to IAS_MAX_ATTRIBNAME =3D 60 */
=20
@@ -412,7 +409,7 @@
 		return -ENOMEM;
=20
 	/* Reserve space for MUX and LAP header */
- 	skb_reserve(skb, self->max_header_size);
+	skb_reserve(skb, self->max_header_size);
 	skb_put(skb, 3+name_len+attr_len);
 	frame =3D skb->data;
=20
@@ -435,7 +432,7 @@
  *    to service user.
  *
  */
-void iriap_getvaluebyclass_confirm(struct iriap_cb *self, struct sk_buff=
 *skb)=20
+void iriap_getvaluebyclass_confirm(struct iriap_cb *self, struct sk_buff=
 *skb)
 {
 	struct ias_value *value;
 	int charset;
@@ -473,7 +470,7 @@
 		value =3D irias_new_integer_value(tmp_cpu32);
=20
 		/*  Legal values restricted to 0x01-0x6f, page 15 irttp */
-		IRDA_DEBUG(4, __FUNCTION__ "(), lsap=3D%d\n", value->t.integer);=20
+		IRDA_DEBUG(4, __FUNCTION__ "(), lsap=3D%d\n", value->t.integer);
 		break;
 	case IAS_STRING:
 		charset =3D fp[n++];
@@ -481,16 +478,16 @@
 		switch (charset) {
 		case CS_ASCII:
 			break;
-/* 		case CS_ISO_8859_1: */
-/* 		case CS_ISO_8859_2: */
-/* 		case CS_ISO_8859_3: */
-/* 		case CS_ISO_8859_4: */
-/* 		case CS_ISO_8859_5: */
-/* 		case CS_ISO_8859_6: */
-/* 		case CS_ISO_8859_7: */
-/* 		case CS_ISO_8859_8: */
-/* 		case CS_ISO_8859_9: */
-/* 		case CS_UNICODE: */
+/*		case CS_ISO_8859_1: */
+/*		case CS_ISO_8859_2: */
+/*		case CS_ISO_8859_3: */
+/*		case CS_ISO_8859_4: */
+/*		case CS_ISO_8859_5: */
+/*		case CS_ISO_8859_6: */
+/*		case CS_ISO_8859_7: */
+/*		case CS_ISO_8859_8: */
+/*		case CS_ISO_8859_9: */
+/*		case CS_UNICODE: */
 		default:
 			IRDA_DEBUG(0, __FUNCTION__
 				   "(), charset %s, not supported\n",
@@ -504,7 +501,7 @@
 		}
 		value_len =3D fp[n++];
 		IRDA_DEBUG(4, __FUNCTION__ "(), strlen=3D%d\n", value_len);
-	=09
+
 		/* Make sure the string is null-terminated */
 		fp[n+value_len] =3D 0x00;
 		IRDA_DEBUG(4, "Got string %s\n", fp+n);
@@ -515,7 +512,7 @@
 	case IAS_OCT_SEQ:
 		value_len =3D be16_to_cpu(get_unaligned((__u16 *)(fp+n)));
 		n +=3D 2;
-	=09
+
 		/* Will truncate to IAS_MAX_OCTET_STRING bytes */
 		value =3D irias_new_octseq_value(fp+n, value_len);
 		break;
@@ -523,12 +520,12 @@
 		value =3D irias_new_missing_value();
 		break;
 	}
-=09
+
 	/* Finished, close connection! */
 	iriap_disconnect_request(self);
=20
 	/* Warning, the client might close us, so remember no to use self
-	 * anymore after calling confirm=20
+	 * anymore after calling confirm
 	 */
 	if (self->confirm)
 		self->confirm(IAS_SUCCESS, obj_id, value, self->priv);
@@ -543,9 +540,9 @@
  * Function iriap_getvaluebyclass_response ()
  *
  *    Send answer back to remote LM-IAS
- *=20
+ *
  */
-void iriap_getvaluebyclass_response(struct iriap_cb *self, __u16 obj_id,=
=20
+void iriap_getvaluebyclass_response(struct iriap_cb *self, __u16 obj_id,=

 				    __u8 ret_code, struct ias_value *value)
 {
 	struct sk_buff *skb;
@@ -563,8 +560,8 @@
 	/* Initialize variables */
 	n =3D 0;
=20
-	/*=20
-	 *  We must adjust the size of the response after the length of the=20
+	/*
+	 *  We must adjust the size of the response after the length of the
 	 *  value. We add 32 bytes because of the 6 bytes for the frame and
 	 *  max 5 bytes for the value coding.
 	 */
@@ -573,9 +570,9 @@
 		return;
=20
 	/* Reserve space for MUX and LAP header */
- 	skb_reserve(skb, self->max_header_size);
+	skb_reserve(skb, self->max_header_size);
 	skb_put(skb, 6);
-=09
+
 	fp =3D skb->data;
=20
 	/* Build frame */
@@ -584,7 +581,7 @@
=20
 	/* Insert list length (MSB first) */
 	tmp_be16 =3D __constant_htons(0x0001);
-	memcpy(fp+n, &tmp_be16, 2);  n +=3D 2;=20
+	memcpy(fp+n, &tmp_be16, 2);  n +=3D 2;
=20
 	/* Insert object identifier ( MSB first) */
 	tmp_be16 =3D cpu_to_be16(obj_id);
@@ -601,7 +598,7 @@
 	case IAS_INTEGER:
 		skb_put(skb, 5);
 		fp[n++] =3D value->type;
-	=09
+
 		tmp_be32 =3D cpu_to_be32(value->t.integer);
 		memcpy(fp+n, &tmp_be32, 4); n +=3D 4;
 		break;
@@ -631,10 +628,10 @@
  *    getvaluebyclass is requested from peer LM-IAS
  *
  */
-void iriap_getvaluebyclass_indication(struct iriap_cb *self,=20
+void iriap_getvaluebyclass_indication(struct iriap_cb *self,
 				      struct sk_buff *skb)
 {
- 	struct ias_object *obj;
+	struct ias_object *obj;
 	struct ias_attrib *attrib;
 	int name_len;
 	int attr_len;
@@ -656,7 +653,7 @@
 	memcpy(name, fp+n, name_len); n+=3Dname_len;
 	name[name_len] =3D '\0';
=20
-	attr_len =3D fp[n++];=20
+	attr_len =3D fp[n++];
 	memcpy(attr, fp+n, attr_len); n+=3Dattr_len;
 	attr[attr_len] =3D '\0';
=20
@@ -665,7 +662,7 @@
=20
 	IRDA_DEBUG(4, "LM-IAS: Looking up %s: %s\n", name, attr);
 	obj =3D irias_find_object(name);
-=09
+
 	if (obj =3D=3D NULL) {
 		IRDA_DEBUG(2, "LM-IAS: Object %s not found\n", name);
 		iriap_getvaluebyclass_response(self, 0x1235, IAS_CLASS_UNKNOWN,
@@ -673,7 +670,7 @@
 		return;
 	}
 	IRDA_DEBUG(4, "LM-IAS: found %s, id=3D%d\n", obj->name, obj->id);
-=09
+
 	attrib =3D irias_find_attrib(obj, attr);
 	if (attrib =3D=3D NULL) {
 		IRDA_DEBUG(2, "LM-IAS: Attribute %s not found\n", attr);
@@ -681,11 +678,11 @@
 					       IAS_ATTRIB_UNKNOWN, &missing);
 		return;
 	}
-=09
+
 	/* We have a match; send the value.  */
-	iriap_getvaluebyclass_response(self, obj->id, IAS_SUCCESS,=20
+	iriap_getvaluebyclass_response(self, obj->id, IAS_SUCCESS,
 				       attrib->value);
-=09
+
 	return;
 }
=20
@@ -695,7 +692,7 @@
  *    Currently not used
  *
  */
-void iriap_send_ack(struct iriap_cb *self)=20
+void iriap_send_ack(struct iriap_cb *self)
 {
 	struct sk_buff *skb;
 	__u8 *frame;
@@ -710,7 +707,7 @@
 		return;
=20
 	/* Reserve space for MUX and LAP header */
- 	skb_reserve(skb, self->max_header_size);
+	skb_reserve(skb, self->max_header_size);
 	skb_put(skb, 1);
 	frame =3D skb->data;
=20
@@ -727,8 +724,8 @@
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
=20
-	ret =3D irlmp_connect_request(self->lsap, LSAP_IAS,=20
-				    self->saddr, self->daddr,=20
+	ret =3D irlmp_connect_request(self->lsap, LSAP_IAS,
+				    self->saddr, self->daddr,
 				    NULL, NULL);
 	if (ret < 0) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), connect failed!\n");
@@ -742,22 +739,22 @@
  *    LSAP connection confirmed!
  *
  */
-static void iriap_connect_confirm(void *instance, void *sap,=20
-				  struct qos_info *qos, __u32 max_seg_size,=20
-				  __u8 max_header_size,=20
+static void iriap_connect_confirm(void *instance, void *sap,
+				  struct qos_info *qos, __u32 max_seg_size,
+				  __u8 max_header_size,
 				  struct sk_buff *userdata)
 {
 	struct iriap_cb *self;
-=09
+
 	self =3D (struct iriap_cb *) instance;
=20
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
 	ASSERT(userdata !=3D NULL, return;);
-=09
+
 	self->max_data_size =3D max_seg_size;
 	self->max_header_size =3D max_header_size;
-=09
+
 	del_timer(&self->watchdog_timer);
=20
 	iriap_do_client_event(self, IAP_LM_CONNECT_CONFIRM, userdata);
@@ -769,9 +766,9 @@
  *    Remote LM-IAS is requesting connection
  *
  */
-static void iriap_connect_indication(void *instance, void *sap,=20
+static void iriap_connect_indication(void *instance, void *sap,
 				     struct qos_info *qos, __u32 max_seg_size,
-				     __u8 max_header_size,=20
+				     __u8 max_header_size,
 				     struct sk_buff *userdata)
 {
 	struct iriap_cb *self, *new;
@@ -782,46 +779,46 @@
=20
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
-=09
+
 	/* Start new server */
-	new =3D iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL);=20
+	new =3D iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL);
 	if (!new) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), open failed\n");
 		dev_kfree_skb(userdata);
 		return;
 	}
-=09
+
 	/* Now attach up the new "socket" */
 	new->lsap =3D irlmp_dup(self->lsap, new);
 	if (!new->lsap) {
 		IRDA_DEBUG(0, __FUNCTION__ "(), dup failed!\n");
 		return;
 	}
-	=09
+
 	new->max_data_size =3D max_seg_size;
 	new->max_header_size =3D max_header_size;
=20
 	/* Clean up the original one to keep it in listen state */
 	irlmp_listen(self->lsap);
-=09
+
 	iriap_do_server_event(new, IAP_LM_CONNECT_INDICATION, userdata);
 }
-=20
+
 /*
  * Function iriap_data_indication (handle, skb)
  *
  *    Receives data from connection identified by handle from IrLMP
  *
  */
-static int iriap_data_indication(void *instance, void *sap,=20
-				 struct sk_buff *skb)=20
+static int iriap_data_indication(void *instance, void *sap,
+				 struct sk_buff *skb)
 {
 	struct iriap_cb *self;
 	__u8  *frame;
 	__u8  opcode;
-=09
-	IRDA_DEBUG(3, __FUNCTION__ "()\n");=20
-=09
+
+	IRDA_DEBUG(3, __FUNCTION__ "()\n");
+
 	self =3D (struct iriap_cb *) instance;
=20
 	ASSERT(self !=3D NULL, return 0;);
@@ -830,7 +827,7 @@
 	ASSERT(skb !=3D NULL, return 0;);
=20
 	frame =3D skb->data;
-=09
+
 	if (self->mode =3D=3D IAS_SERVER) {
 		/* Call server */
 		IRDA_DEBUG(4, __FUNCTION__ "(), Calling server!\n");
@@ -840,17 +837,17 @@
 	}
 	opcode =3D frame[0];
 	if (~opcode & IAP_LST) {
-		WARNING(__FUNCTION__ "(), IrIAS multiframe commands or "
-			"results is not implemented yet!\n");
+		WARNING("%s:, IrIAS multiframe commands or "
+			"results is not implemented yet!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return 0;
 	}
-=09
+
 	/* Check for ack frames since they don't contain any data */
 	if (opcode & IAP_ACK) {
 		IRDA_DEBUG(0, __FUNCTION__ "() Got ack frame!\n");
 		dev_kfree_skb(skb);
-	 	return 0;
+		return 0;
 	}
=20
 	opcode &=3D ~IAP_LST; /* Mask away LST bit */
@@ -862,7 +859,7 @@
 		break;
 	case GET_VALUE_BY_CLASS:
 		iriap_do_call_event(self, IAP_RECV_F_LST, NULL);
-		=09
+
 		switch (frame[1]) {
 		case IAS_SUCCESS:
 			iriap_getvaluebyclass_confirm(self, skb);
@@ -872,9 +869,9 @@
 			/* Finished, close connection! */
 			iriap_disconnect_request(self);
=20
-			/*=20
+			/*
 			 * Warning, the client might close us, so remember
-			 * no to use self anymore after calling confirm=20
+			 * no to use self anymore after calling confirm
 			 */
 			if (self->confirm)
 				self->confirm(IAS_CLASS_UNKNOWN, 0, NULL,
@@ -883,22 +880,22 @@
 			break;
 		case IAS_ATTRIB_UNKNOWN:
 			IRDA_DEBUG(1, __FUNCTION__ "(), No such attribute!\n");
-		       	/* Finished, close connection! */
+			/* Finished, close connection! */
 			iriap_disconnect_request(self);
=20
-			/*=20
+			/*
 			 * Warning, the client might close us, so remember
-			 * no to use self anymore after calling confirm=20
+			 * no to use self anymore after calling confirm
 			 */
 			if (self->confirm)
-				self->confirm(IAS_ATTRIB_UNKNOWN, 0, NULL,=20
+				self->confirm(IAS_ATTRIB_UNKNOWN, 0, NULL,
 					      self->priv);
 			dev_kfree_skb(skb);
 			break;
-		}	=09
+		}
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown op-code: %02x\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown op-code: %02x\n",
 			   opcode);
 		dev_kfree_skb(skb);
 		break;
@@ -927,16 +924,16 @@
=20
 	opcode =3D fp[0];
 	if (~opcode & 0x80) {
-		WARNING(__FUNCTION__ "(), IrIAS multiframe commands or results"
-			"is not implemented yet!\n");
+		WARNING("%s: IrIAS multiframe commands or results"
+			"is not implemented yet!\n", __FUNCTION__);
 		return;
 	}
 	opcode &=3D 0x7f; /* Mask away LST bit */
-=09
+
 	switch (opcode) {
 	case GET_INFO_BASE:
-		WARNING(__FUNCTION__=20
-			"(), GetInfoBaseDetails not implemented yet!\n");
+		WARNING("%s: GetInfoBaseDetails not implemented yet!\n",
+				__FUNCTION__);
 		break;
 	case GET_VALUE_BY_CLASS:
 		iriap_getvaluebyclass_indication(self, skb);
@@ -953,7 +950,7 @@
 void iriap_watchdog_timer_expired(void *data)
 {
 	struct iriap_cb *self =3D (struct iriap_cb *) data;
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D IAS_MAGIC, return;);
=20
@@ -994,23 +991,23 @@
 		len +=3D sprintf(buf+len, "\n");
=20
 		/* List all attributes for this object */
-		attrib =3D (struct ias_attrib *)=20
+		attrib =3D (struct ias_attrib *)
 			hashbin_get_first(obj->attribs);
 		while (attrib !=3D NULL) {
 			ASSERT(attrib->magic =3D=3D IAS_ATTRIB_MAGIC, return 0;);
=20
 			len +=3D sprintf(buf+len, " - Attribute name: \"%s\", ",
 				       attrib->name);
-			len +=3D sprintf(buf+len, "value[%s]: ",=20
+			len +=3D sprintf(buf+len, "value[%s]: ",
 				       ias_value_types[attrib->value->type]);
-		=09
+
 			switch (attrib->value->type) {
 			case IAS_INTEGER:
-				len +=3D sprintf(buf+len, "%d\n",=20
+				len +=3D sprintf(buf+len, "%d\n",
 					       attrib->value->t.integer);
 				break;
 			case IAS_STRING:
-				len +=3D sprintf(buf+len, "\"%s\"\n",=20
+				len +=3D sprintf(buf+len, "\"%s\"\n",
 					       attrib->value->t.string);
 				break;
 			case IAS_OCT_SEQ:
@@ -1020,17 +1017,17 @@
 				len +=3D sprintf(buf+len, "missing\n");
 				break;
 			default:
-				IRDA_DEBUG(0, __FUNCTION__=20
+				IRDA_DEBUG(0, __FUNCTION__
 				      "(), Unknown value type!\n");
 				return -1;
 			}
 			len +=3D sprintf(buf+len, "\n");
-		=09
-			attrib =3D (struct ias_attrib *)=20
+
+			attrib =3D (struct ias_attrib *)
 				hashbin_get_next(obj->attribs);
 		}
 	        obj =3D (struct ias_object *) hashbin_get_next(objects);
- 	}=20
+	}
 	restore_flags(flags);
=20
 	return len;

--------------090101080201080303020805--

