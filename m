Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSFJMt2>; Mon, 10 Jun 2002 08:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314483AbSFJMsV>; Mon, 10 Jun 2002 08:48:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:28167 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313898AbSFJMqr>; Mon, 10 Jun 2002 08:46:47 -0400
Message-ID: <3D0491F5.6080306@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:48:05 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 16/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------090200020201070407010206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200020201070407010206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irlmp_event was abusing __FUCTION__ too.
And of course it appears all red in my gvim as well.

--------------090200020201070407010206
Content-Type: text/plain;
 name="warn-2.5.21-16.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-16.diff"

diff -urN linux-2.5.21/net/irda/irlmp_event.c linux/net/irda/irlmp_event.=
c
--- linux-2.5.21/net/irda/irlmp_event.c	2002-06-09 07:28:07.000000000 +02=
00
+++ linux/net/irda/irlmp_event.c	2002-06-09 21:37:58.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      irlmp_event.c
  * Version:       0.8
  * Description:   An IrDA LMP event driver for Linux
@@ -8,18 +8,18 @@
  * Created at:    Mon Aug  4 20:40:53 1997
  * Modified at:   Tue Dec 14 23:04:16 1999
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
@@ -52,52 +52,52 @@
 #ifdef CONFIG_IRDA_DEBUG
 static const char *irlmp_event[] =3D {
 	"LM_CONNECT_REQUEST",
- 	"LM_CONNECT_CONFIRM",
+	"LM_CONNECT_CONFIRM",
 	"LM_CONNECT_RESPONSE",
- 	"LM_CONNECT_INDICATION", =09
-=09
+	"LM_CONNECT_INDICATION",
+
 	"LM_DISCONNECT_INDICATION",
 	"LM_DISCONNECT_REQUEST",
=20
- 	"LM_DATA_REQUEST",
+	"LM_DATA_REQUEST",
 	"LM_UDATA_REQUEST",
- 	"LM_DATA_INDICATION",
+	"LM_DATA_INDICATION",
 	"LM_UDATA_INDICATION",
=20
 	"LM_WATCHDOG_TIMEOUT",
=20
 	/* IrLAP events */
 	"LM_LAP_CONNECT_REQUEST",
- 	"LM_LAP_CONNECT_INDICATION",=20
- 	"LM_LAP_CONNECT_CONFIRM",
- 	"LM_LAP_DISCONNECT_INDICATION",=20
+	"LM_LAP_CONNECT_INDICATION",
+	"LM_LAP_CONNECT_CONFIRM",
+	"LM_LAP_DISCONNECT_INDICATION",
 	"LM_LAP_DISCONNECT_REQUEST",
 	"LM_LAP_DISCOVERY_REQUEST",
- 	"LM_LAP_DISCOVERY_CONFIRM",
+	"LM_LAP_DISCOVERY_CONFIRM",
 	"LM_LAP_IDLE_TIMEOUT",
 };
 #endif	/* CONFIG_IRDA_DEBUG */
=20
 /* LAP Connection control proto declarations */
-static void irlmp_state_standby  (struct lap_cb *, IRLMP_EVENT,=20
+static void irlmp_state_standby  (struct lap_cb *, IRLMP_EVENT,
 				  struct sk_buff *);
-static void irlmp_state_u_connect(struct lap_cb *, IRLMP_EVENT,=20
+static void irlmp_state_u_connect(struct lap_cb *, IRLMP_EVENT,
 				  struct sk_buff *);
-static void irlmp_state_active   (struct lap_cb *, IRLMP_EVENT,=20
+static void irlmp_state_active   (struct lap_cb *, IRLMP_EVENT,
 				  struct sk_buff *);
=20
 /* LSAP Connection control proto declarations */
-static int irlmp_state_disconnected(struct lsap_cb *, IRLMP_EVENT,=20
+static int irlmp_state_disconnected(struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
-static int irlmp_state_connect     (struct lsap_cb *, IRLMP_EVENT,=20
+static int irlmp_state_connect     (struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
 static int irlmp_state_connect_pend(struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
-static int irlmp_state_dtr         (struct lsap_cb *, IRLMP_EVENT,=20
+static int irlmp_state_dtr         (struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
-static int irlmp_state_setup       (struct lsap_cb *, IRLMP_EVENT,=20
+static int irlmp_state_setup       (struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
-static int irlmp_state_setup_pend  (struct lsap_cb *, IRLMP_EVENT,=20
+static int irlmp_state_setup_pend  (struct lsap_cb *, IRLMP_EVENT,
 				    struct sk_buff *);
=20
 static void (*lap_state[]) (struct lap_cb *, IRLMP_EVENT, struct sk_buff=
 *) =3D
@@ -118,7 +118,7 @@
 };
=20
 static inline void irlmp_next_lap_state(struct lap_cb *self,
-					IRLMP_STATE state)=20
+					IRLMP_STATE state)
 {
 	/*
 	IRDA_DEBUG(4, __FUNCTION__ "(), LMP LAP =3D %s\n", irlmp_state[state]);=

@@ -127,7 +127,7 @@
 }
=20
 static inline void irlmp_next_lsap_state(struct lsap_cb *self,
-					 LSAP_STATE state)=20
+					 LSAP_STATE state)
 {
 	/*
 	ASSERT(self !=3D NULL, return;);
@@ -137,7 +137,7 @@
 }
=20
 /* Do connection control events */
-int irlmp_do_lsap_event(struct lsap_cb *self, IRLMP_EVENT event,=20
+int irlmp_do_lsap_event(struct lsap_cb *self, IRLMP_EVENT event,
 			struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return -1;);
@@ -155,14 +155,14 @@
  *    Do IrLAP control events
  *
  */
-void irlmp_do_lap_event(struct lap_cb *self, IRLMP_EVENT event,=20
-			struct sk_buff *skb)=20
+void irlmp_do_lap_event(struct lap_cb *self, IRLMP_EVENT event,
+			struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LMP_LAP_MAGIC, return;);
-=09
+
 	IRDA_DEBUG(4, __FUNCTION__ "(), EVENT =3D %s, STATE =3D %s\n",
-		   irlmp_event[event],=20
+		   irlmp_event[event],
 		   irlmp_state[self->lap_state]);
=20
 	(*lap_state[self->lap_state]) (self, event, skb);
@@ -171,8 +171,8 @@
 void irlmp_discovery_timer_expired(void *data)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-=09
-	/* We always cleanup the log (active & passive discovery) */=20
+
+	/* We always cleanup the log (active & passive discovery) */
 	irlmp_do_expiry();
=20
 	/* Active discovery is conditional */
@@ -186,7 +186,7 @@
 void irlmp_watchdog_timer_expired(void *data)
 {
 	struct lsap_cb *self =3D (struct lsap_cb *) data;
-=09
+
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return;);
@@ -198,7 +198,7 @@
 void irlmp_idle_timer_expired(void *data)
 {
 	struct lap_cb *self =3D (struct lap_cb *) data;
-=09
+
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return;);
@@ -219,20 +219,20 @@
  *    STANDBY, The IrLAP connection does not exist.
  *
  */
-static void irlmp_state_standby(struct lap_cb *self, IRLMP_EVENT event, =

+static void irlmp_state_standby(struct lap_cb *self, IRLMP_EVENT event,
 				struct sk_buff *skb)
-{=09
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+{
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
 	ASSERT(self->irlap !=3D NULL, return;);
-=09
+
 	switch (event) {
 	case LM_LAP_DISCOVERY_REQUEST:
 		/* irlmp_next_station_state( LMP_DISCOVER); */
-	=09
+
 		irlap_discovery_request(self->irlap, &irlmp->discovery_cmd);
 		break;
 	case LM_LAP_CONNECT_INDICATION:
-		/*  It's important to switch state first, to avoid IrLMP to=20
+		/*  It's important to switch state first, to avoid IrLMP to
 		 *  think that the link is free since IrLMP may then start
 		 *  discovery before the connection is properly set up. DB.
 		 */
@@ -250,16 +250,16 @@
 		irlap_connect_request(self->irlap, self->daddr, NULL, 0);
 		break;
 	case LM_LAP_DISCONNECT_INDICATION:
-		IRDA_DEBUG(4, __FUNCTION__=20
+		IRDA_DEBUG(4, __FUNCTION__
 			   "(), Error LM_LAP_DISCONNECT_INDICATION\n");
-	=09
+
 		irlmp_next_lap_state(self, LAP_STANDBY);
 		break;
 	default:
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 		break;
 	}
 }
@@ -271,17 +271,17 @@
  *    since the IrLAP connection does not exist, we must first start an
  *    IrLAP connection. We are now waiting response from IrLAP.
  * */
-static void irlmp_state_u_connect(struct lap_cb *self, IRLMP_EVENT event=
,=20
+static void irlmp_state_u_connect(struct lap_cb *self, IRLMP_EVENT event=
,
 				  struct sk_buff *skb)
 {
 	struct lsap_cb *lsap;
 	struct lsap_cb *lsap_current;
-=09
+
 	IRDA_DEBUG(2, __FUNCTION__ "(), event=3D%s\n", irlmp_event[event]);
=20
 	switch (event) {
 	case LM_LAP_CONNECT_INDICATION:
-		/*  It's important to switch state first, to avoid IrLMP to=20
+		/*  It's important to switch state first, to avoid IrLMP to
 		 *  think that the link is free since IrLMP may then start
 		 *  discovery before the connection is properly set up. DB.
 		 */
@@ -331,12 +331,12 @@
 		lsap =3D (struct lsap_cb *) hashbin_get_first( self->lsaps);
 		while (lsap !=3D NULL ) {
 			ASSERT(lsap->magic =3D=3D LMP_LSAP_MAGIC, return;);
-		=09
+
 			lsap_current =3D lsap;
=20
 			/* Be sure to stay one item ahead */
 			lsap =3D (struct lsap_cb *) hashbin_get_next(self->lsaps);
-			irlmp_do_lsap_event(lsap_current,=20
+			irlmp_do_lsap_event(lsap_current,
 					    LM_LAP_DISCONNECT_INDICATION,
 					    NULL);
 		}
@@ -354,9 +354,9 @@
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 		break;
-	}=09
+	}
 }
=20
 /*
@@ -365,38 +365,38 @@
  *    ACTIVE, IrLAP connection is active
  *
  */
-static void irlmp_state_active(struct lap_cb *self, IRLMP_EVENT event,=20
+static void irlmp_state_active(struct lap_cb *self, IRLMP_EVENT event,
 			       struct sk_buff *skb)
 {
 	struct lsap_cb *lsap;
 	struct lsap_cb *lsap_current;
=20
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
- 	switch (event) {
+	switch (event) {
 	case LM_LAP_CONNECT_REQUEST:
 		IRDA_DEBUG(4, __FUNCTION__ "(), LS_CONNECT_REQUEST\n");
=20
 		/*
-		 *  LAP connection allready active, just bounce back! Since we=20
-		 *  don't know which LSAP that tried to do this, we have to=20
+		 *  LAP connection allready active, just bounce back! Since we
+		 *  don't know which LSAP that tried to do this, we have to
 		 *  notify all LSAPs using this LAP, but that should be safe to
 		 *  do anyway.
 		 */
 		lsap =3D (struct lsap_cb *) hashbin_get_first(self->lsaps);
 		while (lsap !=3D NULL) {
 			irlmp_do_lsap_event(lsap, LM_LAP_CONNECT_CONFIRM, NULL);
- 			lsap =3D (struct lsap_cb*) hashbin_get_next(self->lsaps);
+			lsap =3D (struct lsap_cb*) hashbin_get_next(self->lsaps);
 		}
-	=09
+
 		/* Needed by connect indication */
 		lsap =3D (struct lsap_cb *) hashbin_get_first(irlmp->unconnected_lsaps=
);
 		while (lsap !=3D NULL) {
 			lsap_current =3D lsap;
-		=09
+
 			/* Be sure to stay one item ahead */
- 			lsap =3D (struct lsap_cb*) hashbin_get_next(irlmp->unconnected_lsaps=
);
-			irlmp_do_lsap_event(lsap_current,=20
+			lsap =3D (struct lsap_cb*) hashbin_get_next(irlmp->unconnected_lsaps)=
;
+			irlmp_do_lsap_event(lsap_current,
 					    LM_LAP_CONNECT_CONFIRM, NULL);
 		}
 		/* Keep state */
@@ -404,8 +404,8 @@
 	case LM_LAP_DISCONNECT_REQUEST:
 		/*
 		 *  Need to find out if we should close IrLAP or not. If there
-		 *  is only one LSAP connection left on this link, that LSAP=20
-		 *  must be the one that tries to close IrLAP. It will be=20
+		 *  is only one LSAP connection left on this link, that LSAP
+		 *  must be the one that tries to close IrLAP. It will be
 		 *  removed later and moved to the list of unconnected LSAPs
 		 */
 		if (HASHBIN_GET_SIZE(self->lsaps) > 0) {
@@ -434,8 +434,8 @@
 		}
 		break;
 	case LM_LAP_DISCONNECT_INDICATION:
-		irlmp_next_lap_state(self, LAP_STANDBY);	=09
-	=09
+		irlmp_next_lap_state(self, LAP_STANDBY);
+
 		/* In some case, at this point our side has already closed
 		 * all lsaps, and we are waiting for the idle_timer to
 		 * expire. If another device reconnect immediately, the
@@ -444,18 +444,18 @@
 		 * Therefore, we must stop the timer... */
 		irlmp_stop_idle_timer(self);
=20
-		/*=20
+		/*
 		 *  Inform all connected LSAP's using this link
 		 */
 		lsap =3D (struct lsap_cb *) hashbin_get_first(self->lsaps);
 		while (lsap !=3D NULL ) {
 			ASSERT(lsap->magic =3D=3D LMP_LSAP_MAGIC, return;);
-		=09
+
 			lsap_current =3D lsap;
=20
 			/* Be sure to stay one item ahead */
 			lsap =3D (struct lsap_cb *) hashbin_get_next(self->lsaps);
-			irlmp_do_lsap_event(lsap_current,=20
+			irlmp_do_lsap_event(lsap_current,
 					    LM_LAP_DISCONNECT_INDICATION,
 					    NULL);
 		}
@@ -473,9 +473,9 @@
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 		break;
-	}=09
+	}
 }
=20
 /*********************************************************************
@@ -491,7 +491,7 @@
  *
  */
 static int irlmp_state_disconnected(struct lsap_cb *self, IRLMP_EVENT ev=
ent,
-				    struct sk_buff *skb)=20
+				    struct sk_buff *skb)
 {
 	int ret =3D 0;
=20
@@ -503,15 +503,15 @@
 	switch (event) {
 #ifdef CONFIG_IRDA_ULTRA
 	case LM_UDATA_INDICATION:
-		irlmp_connless_data_indication(self, skb);=20
+		irlmp_connless_data_indication(self, skb);
 		break;
 #endif /* CONFIG_IRDA_ULTRA */
 	case LM_CONNECT_REQUEST:
 		IRDA_DEBUG(4, __FUNCTION__ "(), LM_CONNECT_REQUEST\n");
=20
 		if (self->conn_skb) {
-			WARNING(__FUNCTION__=20
-				"(), busy with another request!\n");
+			WARNING("%s: busy with another request!\n",
+					__FUNCTION__);
 			return -EBUSY;
 		}
 		self->conn_skb =3D skb;
@@ -525,8 +525,8 @@
 		break;
 	case LM_CONNECT_INDICATION:
 		if (self->conn_skb) {
-			WARNING(__FUNCTION__=20
-				"(), busy with another request!\n");
+			WARNING("%s: busy with another request!\n",
+					__FUNCTION__);
 			return -EBUSY;
 		}
 		self->conn_skb =3D skb;
@@ -549,10 +549,10 @@
 		irlmp_start_watchdog_timer(self, 1*HZ);
 		break;
 	default:
-		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(2, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
-  			dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -564,34 +564,34 @@
  *    CONNECT
  *
  */
-static int irlmp_state_connect(struct lsap_cb *self, IRLMP_EVENT event, =

-				struct sk_buff *skb)=20
+static int irlmp_state_connect(struct lsap_cb *self, IRLMP_EVENT event,
+				struct sk_buff *skb)
 {
 	struct lsap_cb *lsap;
 	int ret =3D 0;
=20
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return -1;);
=20
 	switch (event) {
 	case LM_CONNECT_RESPONSE:
-		/*=20
+		/*
 		 *  Bind this LSAP to the IrLAP link where the connect was
-		 *  received=20
+		 *  received
 		 */
-		lsap =3D hashbin_remove(irlmp->unconnected_lsaps, (int) self,=20
+		lsap =3D hashbin_remove(irlmp->unconnected_lsaps, (int) self,
 				      NULL);
=20
-		ASSERT(lsap =3D=3D self, return -1;);	=09
+		ASSERT(lsap =3D=3D self, return -1;);
 		ASSERT(self->lap !=3D NULL, return -1;);
 		ASSERT(self->lap->lsaps !=3D NULL, return -1;);
-	=09
-		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self,=20
+
+		hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self,
 			       NULL);
=20
-		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,=20
+		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,
 				   self->slsap_sel, CONNECT_CNF, skb);
=20
 		del_timer(&self->watchdog_timer);
@@ -611,7 +611,7 @@
 		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
+			dev_kfree_skb(skb);
 		break;
 	}
 	return ret;
@@ -624,7 +624,7 @@
  *
  */
 static int irlmp_state_connect_pend(struct lsap_cb *self, IRLMP_EVENT ev=
ent,
-				    struct sk_buff *skb)=20
+				    struct sk_buff *skb)
 {
 	int ret =3D 0;
=20
@@ -665,16 +665,16 @@
 		/* Go back to disconnected mode, keep the socket waiting */
 		self->dlsap_sel =3D LSAP_ANY;
 		if(self->conn_skb)
- 			dev_kfree_skb(self->conn_skb);
+			dev_kfree_skb(self->conn_skb);
 		self->conn_skb =3D NULL;
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "Unknown event %s\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
-		break;=09
+			dev_kfree_skb(skb);
+		break;
 	}
 	return ret;
 }
@@ -685,13 +685,13 @@
  *    DATA_TRANSFER_READY
  *
  */
-static int irlmp_state_dtr(struct lsap_cb *self, IRLMP_EVENT event,=20
-			   struct sk_buff *skb)=20
+static int irlmp_state_dtr(struct lsap_cb *self, IRLMP_EVENT event,
+			   struct sk_buff *skb)
 {
 	LM_REASON reason;
 	int ret =3D 0;
=20
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return -1;);
@@ -699,19 +699,19 @@
=20
 	switch (event) {
 	case LM_DATA_REQUEST: /* Optimize for the common case */
-		irlmp_send_data_pdu(self->lap, self->dlsap_sel,=20
+		irlmp_send_data_pdu(self->lap, self->dlsap_sel,
 				    self->slsap_sel, FALSE, skb);
 		break;
 	case LM_DATA_INDICATION: /* Optimize for the common case */
-		irlmp_data_indication(self, skb);=20
+		irlmp_data_indication(self, skb);
 		break;
 	case LM_UDATA_REQUEST:
 		ASSERT(skb !=3D NULL, return -1;);
-		irlmp_send_data_pdu(self->lap, self->dlsap_sel,=20
+		irlmp_send_data_pdu(self->lap, self->dlsap_sel,
 				    self->slsap_sel, TRUE, skb);
 		break;
 	case LM_UDATA_INDICATION:
-		irlmp_udata_indication(self, skb);=20
+		irlmp_udata_indication(self, skb);
 		break;
 	case LM_CONNECT_REQUEST:
 		IRDA_DEBUG(0, __FUNCTION__ "(), LM_CONNECT_REQUEST, "
@@ -719,7 +719,7 @@
 		/* Keep state */
 		break;
 	case LM_CONNECT_RESPONSE:
-		IRDA_DEBUG(0, __FUNCTION__ "(), LM_CONNECT_RESPONSE, "=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), LM_CONNECT_RESPONSE, "
 			   "error, LSAP allready connected\n");
 		/* Keep state */
 		break;
@@ -727,12 +727,12 @@
 		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel, self->slsap_sel,
 				   DISCONNECT, skb);
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
-	=09
+
 		/* Try to close the LAP connection if its still there */
 		if (self->lap) {
 			IRDA_DEBUG(4, __FUNCTION__ "(), trying to close IrLAP\n");
-			irlmp_do_lap_event(self->lap,=20
-					   LM_LAP_DISCONNECT_REQUEST,=20
+			irlmp_do_lap_event(self->lap,
+					   LM_LAP_DISCONNECT_REQUEST,
 					   NULL);
 		}
 		break;
@@ -745,10 +745,10 @@
 		break;
 	case LM_DISCONNECT_INDICATION:
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
-		=09
+
 		ASSERT(self->lap !=3D NULL, return -1;);
 		ASSERT(self->lap->magic =3D=3D LMP_LAP_MAGIC, return -1;);
-=09
+
 		ASSERT(skb !=3D NULL, return -1;);
 		ASSERT(skb->len > 3, return -1;);
 		reason =3D skb->data[3];
@@ -760,11 +760,11 @@
 		irlmp_disconnect_indication(self, reason, skb);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
-		break;=09
+			dev_kfree_skb(skb);
+		break;
 	}
 	return ret;
 }
@@ -776,8 +776,8 @@
  *    An LSAP connection request has been transmitted to the peer
  *    LSAP-Connection Control FSM and we are awaiting reply.
  */
-static int irlmp_state_setup(struct lsap_cb *self, IRLMP_EVENT event,=20
-			     struct sk_buff *skb)=20
+static int irlmp_state_setup(struct lsap_cb *self, IRLMP_EVENT event,
+			     struct sk_buff *skb)
 {
 	LM_REASON reason;
 	int ret =3D 0;
@@ -792,15 +792,15 @@
 		irlmp_next_lsap_state(self, LSAP_DATA_TRANSFER_READY);
=20
 		del_timer(&self->watchdog_timer);
-	=09
+
 		irlmp_connect_confirm(self, skb);
 		break;
 	case LM_DISCONNECT_INDICATION:
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
-		=09
+
 		ASSERT(self->lap !=3D NULL, return -1;);
 		ASSERT(self->lap->magic =3D=3D LMP_LAP_MAGIC, return -1;);
-=09
+
 		ASSERT(skb !=3D NULL, return -1;);
 		ASSERT(skb->len > 3, return -1;);
 		reason =3D skb->data[3];
@@ -818,26 +818,26 @@
=20
 		ASSERT(self->lap !=3D NULL, return -1;);
 		ASSERT(self->lap->magic =3D=3D LMP_LAP_MAGIC, return -1;);
-	=09
+
 		reason =3D irlmp_convert_lap_reason(self->lap->reason);
=20
 		irlmp_disconnect_indication(self, reason, skb);
 		break;
 	case LM_WATCHDOG_TIMEOUT:
 		IRDA_DEBUG(0, __FUNCTION__ "() WATCHDOG_TIMEOUT!\n");
-	=09
+
 		ASSERT(self->lap !=3D NULL, return -1;);
 		irlmp_do_lap_event(self->lap, LM_LAP_DISCONNECT_REQUEST, NULL);
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
-	=09
+
 		irlmp_disconnect_indication(self, LM_CONNECT_FAILURE, NULL);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
-		break;=09
+			dev_kfree_skb(skb);
+		break;
 	}
 	return ret;
 }
@@ -850,13 +850,13 @@
  *    LAP FSM to set up the underlying IrLAP connection, and we
  *    are awaiting confirm.
  */
-static int irlmp_state_setup_pend(struct lsap_cb *self, IRLMP_EVENT even=
t,=20
-				  struct sk_buff *skb)=20
+static int irlmp_state_setup_pend(struct lsap_cb *self, IRLMP_EVENT even=
t,
+				  struct sk_buff *skb)
 {
 	LM_REASON reason;
 	int ret =3D 0;
=20
-	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(irlmp !=3D NULL, return -1;);
@@ -868,7 +868,7 @@
 		skb =3D self->conn_skb;
 		self->conn_skb =3D NULL;
=20
-		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,=20
+		irlmp_send_lcf_pdu(self->lap, self->dlsap_sel,
 				   self->slsap_sel, CONNECT_CMD, skb);
=20
 		irlmp_next_lsap_state(self, LSAP_SETUP);
@@ -886,17 +886,17 @@
 		del_timer( &self->watchdog_timer);
=20
 		irlmp_next_lsap_state(self, LSAP_DISCONNECTED);
-	=09
+
 		reason =3D irlmp_convert_lap_reason(self->lap->reason);
-	=09
+
 		irlmp_disconnect_indication(self, reason, NULL);
 		break;
 	default:
-		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",=20
+		IRDA_DEBUG(0, __FUNCTION__ "(), Unknown event %s\n",
 			   irlmp_event[event]);
 		if (skb)
- 			dev_kfree_skb(skb);
-		break;=09
+			dev_kfree_skb(skb);
+		break;
 	}
 	return ret;
 }

--------------090200020201070407010206--

