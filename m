Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318222AbSIEVyV>; Thu, 5 Sep 2002 17:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318221AbSIEVwz>; Thu, 5 Sep 2002 17:52:55 -0400
Received: from hermes.domdv.de ([193.102.202.1]:39945 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318207AbSIEVva>;
	Thu, 5 Sep 2002 17:51:30 -0400
Message-ID: <3D77D2BF.9090102@domdv.de>
Date: Thu, 05 Sep 2002 23:55:11 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.20pre5 trivial compile warning fix for iriap.c
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080407020603000008090200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080407020603000008090200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

the attached patch fixes deprecated usage warnings for __FUNCTION__ in 
iriap.c.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

--------------080407020603000008090200
Content-Type: text/plain;
 name="iriap.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iriap.c.diff"

--- net/irda/iriap.c.orig	2002-09-05 23:42:22.000000000 +0200
+++ net/irda/iriap.c	2002-09-05 23:51:11.000000000 +0200
@@ -98,7 +98,8 @@
 
 	objects = hashbin_new(HB_LOCAL);
 	if (!objects) {
-		WARNING(__FUNCTION__ "(), Can't allocate objects hashbin!\n");
+		WARNING("%s(), Can't allocate objects hashbin!\n",
+			__FUNCTION__);
 		return -ENOMEM;
 	}
 
@@ -128,7 +129,7 @@
 	 */
 	server = iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL);
 	if (!server) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), unable to open server\n");
+		IRDA_DEBUG(0, "%s(), unable to open server\n", __FUNCTION__);
 		return -1;
 	}
 	iriap_register_lsap(server, LSAP_IAS, IAS_SERVER);
@@ -160,11 +161,11 @@
 {
 	struct iriap_cb *self;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	self = kmalloc(sizeof(struct iriap_cb), GFP_ATOMIC);
 	if (!self) {
-		WARNING(__FUNCTION__ "(), Unable to kmalloc!\n");
+		WARNING("%s(), Unable to kmalloc!\n", __FUNCTION__);
 		return NULL;
 	}
 
@@ -202,7 +203,7 @@
  */
 static void __iriap_close(struct iriap_cb *self)
 {
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -226,7 +227,7 @@
 {
 	struct iriap_cb *entry;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -246,7 +247,7 @@
 {
 	notify_t notify;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	irda_notify_init(&notify);
 	notify.connect_confirm       = iriap_connect_confirm;
@@ -261,7 +262,7 @@
 
 	self->lsap = irlmp_open_lsap(slsap_sel, &notify, 0);
 	if (self->lsap == NULL) {
-		ERROR(__FUNCTION__ "(), Unable to allocated LSAP!\n");
+		ERROR("%s(), Unable to allocated LSAP!\n", __FUNCTION__);
 		return -1;
 	}
 	self->slsap_sel = self->lsap->slsap_sel;
@@ -281,7 +282,7 @@
 {
 	struct iriap_cb *self;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), reason=%s\n", lmp_reasons[reason]);
+	IRDA_DEBUG(4, "%s(), reason=%s\n", __FUNCTION__, lmp_reasons[reason]);
 
 	self = (struct iriap_cb *) instance;
 
@@ -293,7 +294,7 @@
 	del_timer(&self->watchdog_timer);
 
 	if (self->mode == IAS_CLIENT) {
-		IRDA_DEBUG(4, __FUNCTION__ "(), disconnect as client\n");
+		IRDA_DEBUG(4, "%s(), disconnect as client\n", __FUNCTION__);
 
 
 		iriap_do_client_event(self, IAP_LM_DISCONNECT_INDICATION, 
@@ -306,7 +307,7 @@
 		if (self->confirm)
  			self->confirm(IAS_DISCONNECT, 0, NULL, self->priv);
 	} else {
-		IRDA_DEBUG(4, __FUNCTION__ "(), disconnect as server\n");
+		IRDA_DEBUG(4, "%s(), disconnect as server\n", __FUNCTION__);
 		iriap_do_server_event(self, IAP_LM_DISCONNECT_INDICATION, 
 				      NULL);
 		iriap_close(self);
@@ -326,15 +327,16 @@
 {
 	struct sk_buff *skb;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
 
 	skb = dev_alloc_skb(64);
 	if (skb == NULL) {
-		IRDA_DEBUG(0, __FUNCTION__
-		      "(), Could not allocate an sk_buff of length %d\n", 64);
+		IRDA_DEBUG(0,
+		      "%s(), Could not allocate an sk_buff of length %d\n",
+		      __FUNCTION__, 64);
 		return;
 	}
 
@@ -348,27 +350,27 @@
 
 void iriap_getinfobasedetails_request(void) 
 {
-	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
+	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
 }
 
 void iriap_getinfobasedetails_confirm(void) 
 {
-	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
+	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
 }
 
 void iriap_getobjects_request(void) 
 {
-	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
+	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
 }
 
 void iriap_getobjects_confirm(void) 
 {
-	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
+	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
 }
 
 void iriap_getvalue(void) 
 {
-	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented!\n");
+	IRDA_DEBUG(0, "%s(), Not implemented!\n", __FUNCTION__);
 }
 
 /*
@@ -458,13 +460,13 @@
 	/* Get length, MSB first */
 	len = be16_to_cpu(get_unaligned((__u16 *)(fp+n))); n += 2;
 
-	IRDA_DEBUG(4, __FUNCTION__ "(), len=%d\n", len);
+	IRDA_DEBUG(4, "%s(), len=%d\n", __FUNCTION__, len);
 
 	/* Get object ID, MSB first */
 	obj_id = be16_to_cpu(get_unaligned((__u16 *)(fp+n))); n += 2;
 
 	type = fp[n++];
-	IRDA_DEBUG(4, __FUNCTION__ "(), Value type = %d\n", type);
+	IRDA_DEBUG(4, "%s(), Value type = %d\n", __FUNCTION__, type);
 
 	switch (type) {
 	case IAS_INTEGER:
@@ -473,7 +475,8 @@
 		value = irias_new_integer_value(tmp_cpu32);
 
 		/*  Legal values restricted to 0x01-0x6f, page 15 irttp */
-		IRDA_DEBUG(4, __FUNCTION__ "(), lsap=%d\n", value->t.integer); 
+		IRDA_DEBUG(4, "%s(), lsap=%d\n", __FUNCTION__,
+			   value->t.integer); 
 		break;
 	case IAS_STRING:
 		charset = fp[n++];
@@ -492,9 +495,8 @@
 /* 		case CS_ISO_8859_9: */
 /* 		case CS_UNICODE: */
 		default:
-			IRDA_DEBUG(0, __FUNCTION__
-				   "(), charset %s, not supported\n",
-				   ias_charset_types[charset]);
+			IRDA_DEBUG(0, "%s(), charset %s, not supported\n",
+				   __FUNCTION__, ias_charset_types[charset]);
 
 			/* Aborting, close connection! */
 			iriap_disconnect_request(self);
@@ -503,7 +505,7 @@
 			/* break; */
 		}
 		value_len = fp[n++];
-		IRDA_DEBUG(4, __FUNCTION__ "(), strlen=%d\n", value_len);
+		IRDA_DEBUG(4, "%s(), strlen=%d\n", __FUNCTION__, value_len);
 		
 		/* Make sure the string is null-terminated */
 		fp[n+value_len] = 0x00;
@@ -533,7 +535,7 @@
 	if (self->confirm)
 		self->confirm(IAS_SUCCESS, obj_id, value, self->priv);
 	else {
-		IRDA_DEBUG(0, __FUNCTION__ "(), missing handler!\n");
+		IRDA_DEBUG(0, "%s(), missing handler!\n", __FUNCTION__);
 		irias_delete_value(value);
 	}
 	dev_kfree_skb(skb);
@@ -553,7 +555,7 @@
 	__u32 tmp_be32, tmp_be16;
 	__u8 *fp;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -614,12 +616,12 @@
 		memcpy(fp+n, value->t.oct_seq, value->len); n+=value->len;
 		break;
 	case IAS_MISSING:
-		IRDA_DEBUG( 3, __FUNCTION__ ": sending IAS_MISSING\n");
+		IRDA_DEBUG( 3, "%s: sending IAS_MISSING\n", __FUNCTION__);
 		skb_put(skb, 1);
 		fp[n++] = value->type;
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), type not implemented!\n");
+		IRDA_DEBUG(0, "%s(), type not implemented!\n", __FUNCTION__);
 		break;
 	}
 	iriap_do_r_connect_event(self, IAP_CALL_RESPONSE, skb);
@@ -643,7 +645,7 @@
 	__u8 *fp;
 	int n;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -700,7 +702,7 @@
 	struct sk_buff *skb;
 	__u8 *frame;
 
-	IRDA_DEBUG(2, __FUNCTION__ "()\n");
+	IRDA_DEBUG(2, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -731,7 +733,7 @@
 				    self->saddr, self->daddr, 
 				    NULL, NULL);
 	if (ret < 0) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), connect failed!\n");
+		IRDA_DEBUG(0, "%s(), connect failed!\n", __FUNCTION__);
 		self->confirm(IAS_DISCONNECT, 0, NULL, self->priv);
 	}
 }
@@ -776,7 +778,7 @@
 {
 	struct iriap_cb *self, *new;
 
-	IRDA_DEBUG(1, __FUNCTION__ "()\n");
+	IRDA_DEBUG(1, "%s()\n", __FUNCTION__);
 
 	self = (struct iriap_cb *) instance;
 
@@ -786,7 +788,7 @@
 	/* Start new server */
 	new = iriap_open(LSAP_IAS, IAS_SERVER, NULL, NULL); 
 	if (!new) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), open failed\n");
+		IRDA_DEBUG(0, "%s(), open failed\n", __FUNCTION__);
 		dev_kfree_skb(userdata);
 		return;
 	}
@@ -794,7 +796,7 @@
 	/* Now attach up the new "socket" */
 	new->lsap = irlmp_dup(self->lsap, new);
 	if (!new->lsap) {
-		IRDA_DEBUG(0, __FUNCTION__ "(), dup failed!\n");
+		IRDA_DEBUG(0, "%s(), dup failed!\n", __FUNCTION__);
 		return;
 	}
 		
@@ -820,7 +822,7 @@
 	__u8  *frame;
 	__u8  opcode;
 	
-	IRDA_DEBUG(3, __FUNCTION__ "()\n"); 
+	IRDA_DEBUG(3, "%s()\n", __FUNCTION__); 
 	
 	self = (struct iriap_cb *) instance;
 
@@ -833,22 +835,22 @@
 	
 	if (self->mode == IAS_SERVER) {
 		/* Call server */
-		IRDA_DEBUG(4, __FUNCTION__ "(), Calling server!\n");
+		IRDA_DEBUG(4, "%s(), Calling server!\n", __FUNCTION__);
 		iriap_do_r_connect_event(self, IAP_RECV_F_LST, skb);
 
 		return 0;
 	}
 	opcode = frame[0];
 	if (~opcode & IAP_LST) {
-		WARNING(__FUNCTION__ "(), IrIAS multiframe commands or "
-			"results is not implemented yet!\n");
+		WARNING("%s(), IrIAS multiframe commands or "
+			"results is not implemented yet!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return 0;
 	}
 	
 	/* Check for ack frames since they don't contain any data */
 	if (opcode & IAP_ACK) {
-		IRDA_DEBUG(0, __FUNCTION__ "() Got ack frame!\n");
+		IRDA_DEBUG(0, "%s() Got ack frame!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 	 	return 0;
 	}
@@ -868,7 +870,7 @@
 			iriap_getvaluebyclass_confirm(self, skb);
 			break;
 		case IAS_CLASS_UNKNOWN:
-			IRDA_DEBUG(1, __FUNCTION__ "(), No such class!\n");
+			IRDA_DEBUG(1, "%s(), No such class!\n", __FUNCTION__);
 			/* Finished, close connection! */
 			iriap_disconnect_request(self);
 
@@ -882,7 +884,8 @@
 			dev_kfree_skb(skb);
 			break;
 		case IAS_ATTRIB_UNKNOWN:
-			IRDA_DEBUG(1, __FUNCTION__ "(), No such attribute!\n");
+			IRDA_DEBUG(1, "%s(), No such attribute!\n",
+				   __FUNCTION__);
 		       	/* Finished, close connection! */
 			iriap_disconnect_request(self);
 
@@ -898,7 +901,7 @@
 		}		
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown op-code: %02x\n", 
+		IRDA_DEBUG(0, "%s(), Unknown op-code: %02x\n", __FUNCTION__,
 			   opcode);
 		dev_kfree_skb(skb);
 		break;
@@ -917,7 +920,7 @@
 	__u8 *fp;
 	__u8 opcode;
 
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, "%s()\n", __FUNCTION__);
 
 	ASSERT(self != NULL, return;);
 	ASSERT(self->magic == IAS_MAGIC, return;);
@@ -927,16 +930,16 @@
 
 	opcode = fp[0];
 	if (~opcode & 0x80) {
-		WARNING(__FUNCTION__ "(), IrIAS multiframe commands or results"
-			"is not implemented yet!\n");
+		WARNING("%s(), IrIAS multiframe commands or results"
+			"is not implemented yet!\n", __FUNCTION__);
 		return;
 	}
 	opcode &= 0x7f; /* Mask away LST bit */
 	
 	switch (opcode) {
 	case GET_INFO_BASE:
-		WARNING(__FUNCTION__ 
-			"(), GetInfoBaseDetails not implemented yet!\n");
+		WARNING("%s(), GetInfoBaseDetails not implemented yet!\n",
+			__FUNCTION__);
 		break;
 	case GET_VALUE_BY_CLASS:
 		iriap_getvaluebyclass_indication(self, skb);
@@ -1020,8 +1023,8 @@
 				len += sprintf(buf+len, "missing\n");
 				break;
 			default:
-				IRDA_DEBUG(0, __FUNCTION__ 
-				      "(), Unknown value type!\n");
+				IRDA_DEBUG(0,"%s(), Unknown value type!\n",
+					   __FUNCTION__);
 				return -1;
 			}
 			len += sprintf(buf+len, "\n");

--------------080407020603000008090200--


