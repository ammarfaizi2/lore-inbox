Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFJMrQ>; Mon, 10 Jun 2002 08:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFJMql>; Mon, 10 Jun 2002 08:46:41 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26631 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313898AbSFJMpO>; Mon, 10 Jun 2002 08:45:14 -0400
Message-ID: <3D049198.2060706@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:46:32 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 15/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000004090904080802080702"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000004090904080802080702
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irlmp abused __FUNCTION__ and the space bar as well.

--------------000004090904080802080702
Content-Type: text/plain;
 name="warn-2.5.21-15.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-15.diff"

diff -urN linux-2.5.21/net/irda/irlmp.c linux/net/irda/irlmp.c
--- linux-2.5.21/net/irda/irlmp.c	2002-06-09 07:31:21.000000000 +0200
+++ linux/net/irda/irlmp.c	2002-06-09 21:46:26.000000000 +0200
@@ -1,25 +1,25 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      irlmp.c
  * Version:       1.0
- * Description:   IrDA Link Management Protocol (LMP) layer             =
   =20
+ * Description:   IrDA Link Management Protocol (LMP) layer
  * Status:        Stable.
  * Author:        Dag Brattli <dagb@cs.uit.no>
  * Created at:    Sun Aug 17 20:54:32 1997
  * Modified at:   Wed Jan  5 11:26:03 2000
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
- *=20
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,=20
+ *
+ *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
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
@@ -82,7 +82,7 @@
 	if (irlmp =3D=3D NULL)
 		return -ENOMEM;
 	memset(irlmp, 0, sizeof(struct irlmp_cb));
-=09
+
 	irlmp->magic =3D LMP_MAGIC;
 	spin_lock_init(&irlmp->log_lock);
=20
@@ -91,13 +91,13 @@
 	irlmp->links =3D hashbin_new(HB_GLOBAL);
 	irlmp->unconnected_lsaps =3D hashbin_new(HB_GLOBAL);
 	irlmp->cachelog =3D hashbin_new(HB_GLOBAL);
-=09
+
 	irlmp->free_lsap_sel =3D 0x10; /* Reserved 0x00-0x0f */
 	strcpy(sysctl_devname, "Linux");
-=09
+
 	/* Do discovery every 3 seconds */
 	init_timer(&irlmp->discovery_timer);
-   	irlmp_start_discovery_timer(irlmp, sysctl_discovery_timeout*HZ);
+	irlmp_start_discovery_timer(irlmp, sysctl_discovery_timeout*HZ);
=20
 	return 0;
 }
@@ -108,20 +108,20 @@
  *    Remove IrLMP layer
  *
  */
-void irlmp_cleanup(void)=20
+void irlmp_cleanup(void)
 {
 	/* Check for main structure */
 	ASSERT(irlmp !=3D NULL, return;);
 	ASSERT(irlmp->magic =3D=3D LMP_MAGIC, return;);
=20
 	del_timer(&irlmp->discovery_timer);
-=09
+
 	hashbin_delete(irlmp->links, (FREE_FUNC) kfree);
 	hashbin_delete(irlmp->unconnected_lsaps, (FREE_FUNC) kfree);
 	hashbin_delete(irlmp->clients, (FREE_FUNC) kfree);
 	hashbin_delete(irlmp->services, (FREE_FUNC) kfree);
 	hashbin_delete(irlmp->cachelog, (FREE_FUNC) kfree);
-=09
+
 	/* De-allocate main structure */
 	kfree(irlmp);
 	irlmp =3D NULL;
@@ -152,11 +152,11 @@
 	/* Allocate new instance of a LSAP connection */
 	self =3D kmalloc(sizeof(struct lsap_cb), GFP_ATOMIC);
 	if (self =3D=3D NULL) {
-		ERROR(__FUNCTION__ "(), can't allocate memory");
+		ERROR("%s: can't allocate memory", __FUNCTION__);
 		return NULL;
 	}
 	memset(self, 0, sizeof(struct lsap_cb));
-=09
+
 	self->magic =3D LMP_LSAP_MAGIC;
 	self->slsap_sel =3D slsap_sel;
=20
@@ -176,11 +176,11 @@
 	self->notify =3D *notify;
=20
 	self->lsap_state =3D LSAP_DISCONNECTED;
-=09
+
 	/* Insert into queue of unconnected LSAPs */
 	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) s=
elf,=20
 		       NULL);
-=09
+
 	return self;
 }
=20
@@ -247,11 +247,11 @@
 	self->lap =3D NULL;
 	/* Check if we found the LSAP! If not then try the unconnected lsaps */=

 	if (!lsap) {
-		lsap =3D hashbin_remove(irlmp->unconnected_lsaps, (int) self,=20
+		lsap =3D hashbin_remove(irlmp->unconnected_lsaps, (int) self,
 				      NULL);
 	}
 	if (!lsap) {
-		IRDA_DEBUG(0, __FUNCTION__=20
+		IRDA_DEBUG(0, __FUNCTION__
 		     "(), Looks like somebody has removed me already!\n");
 		return;
 	}
@@ -278,11 +278,11 @@
 	 */
 	lap =3D kmalloc(sizeof(struct lap_cb), GFP_KERNEL);
 	if (lap =3D=3D NULL) {
-		ERROR(__FUNCTION__ "(), unable to kmalloc\n");
+		ERROR("%s: unable to kmalloc\n", __FUNCTION__);
 		return;
 	}
 	memset(lap, 0, sizeof(struct lap_cb));
-=09
+
 	lap->irlap =3D irlap;
 	lap->magic =3D LMP_LAP_MAGIC;
 	lap->saddr =3D saddr;
@@ -293,7 +293,7 @@
 #endif
=20
 	lap->lap_state =3D LAP_STANDBY;
-=09
+
 	init_timer(&lap->idle_timer);
=20
 	/*
@@ -301,9 +301,9 @@
 	 */
 	hashbin_insert(irlmp->links, (irda_queue_t *) lap, lap->saddr, NULL);
=20
-	/*=20
+	/*
 	 *  We set only this variable so IrLAP can tell us on which link the
-	 *  different events happened on=20
+	 *  different events happened on
 	 */
 	irda_notify_init(notify);
 	notify->instance =3D lap;
@@ -328,7 +328,7 @@
 		/* Remove all discoveries discovered at this link */
 		irlmp_expire_discoveries(irlmp->cachelog, link->saddr, TRUE);
=20
-		del_timer(&link->idle_timer);=09
+		del_timer(&link->idle_timer);
=20
 		link->magic =3D 0;
 		kfree(link);
@@ -338,12 +338,12 @@
 /*
  * Function irlmp_connect_request (handle, dlsap, userdata)
  *
- *    Connect with a peer LSAP =20
+ *    Connect with a peer LSAP
  *
  */
-int irlmp_connect_request(struct lsap_cb *self, __u8 dlsap_sel,=20
-			  __u32 saddr, __u32 daddr,=20
-			  struct qos_info *qos, struct sk_buff *userdata)=20
+int irlmp_connect_request(struct lsap_cb *self, __u8 dlsap_sel,
+			  __u32 saddr, __u32 daddr,
+			  struct qos_info *qos, struct sk_buff *userdata)
 {
 	struct sk_buff *skb =3D NULL;
 	struct lap_cb *lap;
@@ -352,18 +352,18 @@
=20
 	ASSERT(self !=3D NULL, return -EBADR;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return -EBADR;);
-=09
-	IRDA_DEBUG(2, __FUNCTION__=20
-	      "(), slsap_sel=3D%02x, dlsap_sel=3D%02x, saddr=3D%08x, daddr=3D%0=
8x\n",=20
+
+	IRDA_DEBUG(2, __FUNCTION__
+	      "(), slsap_sel=3D%02x, dlsap_sel=3D%02x, saddr=3D%08x, daddr=3D%0=
8x\n",
 	      self->slsap_sel, dlsap_sel, saddr, daddr);
-=09
+
 	if (test_bit(0, &self->connected))
 		return -EISCONN;
-=09
+
 	/* Client must supply destination device address */
 	if (!daddr)
 		return -EINVAL;
-=09
+
 	/* Any userdata? */
 	if (userdata =3D=3D NULL) {
 		skb =3D dev_alloc_skb(64);
@@ -373,27 +373,27 @@
 		skb_reserve(skb, LMP_MAX_HEADER);
 	} else
 		skb =3D userdata;
-=09
+
 	/* Make room for MUX control header (3 bytes) */
 	ASSERT(skb_headroom(skb) >=3D LMP_CONTROL_HEADER, return -1;);
 	skb_push(skb, LMP_CONTROL_HEADER);
=20
 	self->dlsap_sel =3D dlsap_sel;
-=09
-	/* =20
+
+	/*
 	 * Find the link to where we should try to connect since there may
 	 * be more than one IrDA port on this machine. If the client has
 	 * passed us the saddr (and already knows which link to use), then
 	 * we use that to find the link, if not then we have to look in the
 	 * discovery log and check if any of the links has discovered a
-	 * device with the given daddr=20
+	 * device with the given daddr
 	 */
 	if ((!saddr) || (saddr =3D=3D DEV_ADDR_ANY)) {
 		if (daddr !=3D DEV_ADDR_ANY)
 			discovery =3D hashbin_find(irlmp->cachelog, daddr, NULL);
 		else {
 			IRDA_DEBUG(2, __FUNCTION__ "(), no daddr\n");
-			discovery =3D (discovery_t *)=20
+			discovery =3D (discovery_t *)
 				hashbin_get_first(irlmp->cachelog);
 		}
=20
@@ -402,7 +402,7 @@
 			daddr =3D discovery->daddr;
 		}
 	}
-	lap =3D hashbin_find(irlmp->links, saddr, NULL);=09
+	lap =3D hashbin_find(irlmp->links, saddr, NULL);
 	if (lap =3D=3D NULL) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unable to find a usable link!\n");
 		return -EHOSTUNREACH;
@@ -433,9 +433,9 @@
=20
 	self->lap =3D lap;
=20
-	/*=20
-	 *  Remove LSAP from list of unconnected LSAPs and insert it into the=20
-	 *  list of connected LSAPs for the particular link=20
+	/*
+	 *  Remove LSAP from list of unconnected LSAPs and insert it into the
+	 *  list of connected LSAPs for the particular link
 	 */
 	lsap =3D hashbin_remove(irlmp->unconnected_lsaps, (int) self, NULL);
=20
@@ -447,13 +447,13 @@
 	hashbin_insert(self->lap->lsaps, (irda_queue_t *) self, (int) self, NUL=
L);
=20
 	set_bit(0, &self->connected);	/* TRUE */
-=09
+
 	/*
 	 *  User supplied qos specifications?
 	 */
 	if (qos)
 		self->qos =3D *qos;
-=09
+
 	irlmp_do_lsap_event(self, LM_CONNECT_REQUEST, skb);
=20
 	return 0;
@@ -465,18 +465,18 @@
  *    Incoming connection
  *
  */
-void irlmp_connect_indication(struct lsap_cb *self, struct sk_buff *skb)=
=20
+void irlmp_connect_indication(struct lsap_cb *self, struct sk_buff *skb)=

 {
 	int max_seg_size;
 	int lap_header_size;
 	int max_header_size;
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);
 	ASSERT(skb !=3D NULL, return;);
 	ASSERT(self->lap !=3D NULL, return;);
=20
-	IRDA_DEBUG(2, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n", =

+	IRDA_DEBUG(2, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n",
 		   self->slsap_sel, self->dlsap_sel);
=20
 	/* Note : self->lap is set in irlmp_link_data_indication(),
@@ -492,10 +492,10 @@
=20
 	/* Hide LMP_CONTROL_HEADER header from layer above */
 	skb_pull(skb, LMP_CONTROL_HEADER);
-=09
+
 	if (self->notify.connect_indication)
-		self->notify.connect_indication(self->notify.instance, self,=20
-						&self->qos, max_seg_size,=20
+		self->notify.connect_indication(self->notify.instance, self,
+						&self->qos, max_seg_size,
 						max_header_size, skb);
 	else
 		dev_kfree_skb(skb);
@@ -507,7 +507,7 @@
  *    Service user is accepting connection
  *
  */
-int irlmp_connect_response(struct lsap_cb *self, struct sk_buff *userdat=
a)=20
+int irlmp_connect_response(struct lsap_cb *self, struct sk_buff *userdat=
a)
 {
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return -1;);
@@ -515,13 +515,13 @@
=20
 	set_bit(0, &self->connected);	/* TRUE */
=20
-	IRDA_DEBUG(2, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n", =

+	IRDA_DEBUG(2, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n",
 		   self->slsap_sel, self->dlsap_sel);
=20
 	/* Make room for MUX control header (3 bytes) */
 	ASSERT(skb_headroom(userdata) >=3D LMP_CONTROL_HEADER, return -1;);
 	skb_push(userdata, LMP_CONTROL_HEADER);
-=09
+
 	irlmp_do_lsap_event(self, LM_CONNECT_RESPONSE, userdata);
=20
 	return 0;
@@ -532,26 +532,26 @@
  *
  *    LSAP connection confirmed peer device!
  */
-void irlmp_connect_confirm(struct lsap_cb *self, struct sk_buff *skb)=20
+void irlmp_connect_confirm(struct lsap_cb *self, struct sk_buff *skb)
 {
 	int max_header_size;
 	int lap_header_size;
 	int max_seg_size;
=20
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(skb !=3D NULL, return;);
 	ASSERT(self !=3D NULL, return;);
-	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);=09
+	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);
 	ASSERT(self->lap !=3D NULL, return;);
=20
 	self->qos =3D *self->lap->qos;
=20
 	max_seg_size    =3D self->lap->qos->data_size.value-LMP_HEADER;
-	lap_header_size =3D IRLAP_GET_HEADER_SIZE(self->lap->irlap);=09
+	lap_header_size =3D IRLAP_GET_HEADER_SIZE(self->lap->irlap);
 	max_header_size =3D LMP_HEADER + lap_header_size;
=20
-	IRDA_DEBUG(2, __FUNCTION__ "(), max_header_size=3D%d\n",=20
+	IRDA_DEBUG(2, __FUNCTION__ "(), max_header_size=3D%d\n",
 		   max_header_size);
=20
 	/* Hide LMP_CONTROL_HEADER header from layer above */
@@ -572,7 +572,7 @@
  *    new LSAP so it can keep listening on the old one.
  *
  */
-struct lsap_cb *irlmp_dup(struct lsap_cb *orig, void *instance)=20
+struct lsap_cb *irlmp_dup(struct lsap_cb *orig, void *instance)
 {
 	struct lsap_cb *new;
=20
@@ -595,8 +595,8 @@
 	/* new->slsap_sel =3D orig->slsap_sel; =3D> done in the memcpy() */
=20
 	init_timer(&new->watchdog_timer);
-=09
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new, (int) ne=
w,=20
+
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) new, (int) ne=
w,
 		       NULL);
=20
 	/* Make sure that we invalidate the cache */
@@ -610,10 +610,10 @@
 /*
  * Function irlmp_disconnect_request (handle, userdata)
  *
- *    The service user is requesting disconnection, this will not remove=
 the=20
+ *    The service user is requesting disconnection, this will not remove=
 the
  *    LSAP, but only mark it as disconnected
  */
-int irlmp_disconnect_request(struct lsap_cb *self, struct sk_buff *userd=
ata)=20
+int irlmp_disconnect_request(struct lsap_cb *self, struct sk_buff *userd=
ata)
 {
 	struct lsap_cb *lsap;
=20
@@ -633,13 +633,13 @@
=20
 	skb_push(userdata, LMP_CONTROL_HEADER);
=20
-	/*=20
+	/*
 	 *  Do the event before the other stuff since we must know
 	 *  which lap layer that the frame should be transmitted on
 	 */
 	irlmp_do_lsap_event(self, LM_DISCONNECT_REQUEST, userdata);
=20
-	/*=20
+	/*
 	 *  Remove LSAP from list of connected LSAPs for the particular link
 	 *  and insert it into the list of unconnected LSAPs
 	 */
@@ -653,13 +653,13 @@
 	ASSERT(lsap->magic =3D=3D LMP_LSAP_MAGIC, return -1;);
 	ASSERT(lsap =3D=3D self, return -1;);
=20
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) s=
elf,=20
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) self, (int) s=
elf,
 		       NULL);
-=09
+
 	/* Reset some values */
 	self->dlsap_sel =3D LSAP_ANY;
 	self->lap =3D NULL;
-=09
+
 	return 0;
 }
=20
@@ -668,8 +668,8 @@
  *
  *    LSAP is being closed!
  */
-void irlmp_disconnect_indication(struct lsap_cb *self, LM_REASON reason,=
=20
-				 struct sk_buff *userdata)=20
+void irlmp_disconnect_indication(struct lsap_cb *self, LM_REASON reason,=

+				 struct sk_buff *userdata)
 {
 	struct lsap_cb *lsap;
=20
@@ -677,7 +677,7 @@
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);
=20
-	IRDA_DEBUG(3, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n", =

+	IRDA_DEBUG(3, __FUNCTION__ "(), slsap_sel=3D%02x, dlsap_sel=3D%02x\n",
 		   self->slsap_sel, self->dlsap_sel);
=20
 	/* Already disconnected ?
@@ -691,12 +691,12 @@
 		return;
 	}
=20
-	/*=20
-	 *  Remove association between this LSAP and the link it used=20
+	/*
+	 *  Remove association between this LSAP and the link it used
 	 */
 	ASSERT(self->lap !=3D NULL, return;);
 	ASSERT(self->lap->lsaps !=3D NULL, return;);
-=09
+
 	lsap =3D hashbin_remove(self->lap->lsaps, (int) self, NULL);
 #ifdef CONFIG_IRDA_CACHE_LAST_LSAP
 	self->lap->cache.valid =3D FALSE;
@@ -704,17 +704,17 @@
=20
 	ASSERT(lsap !=3D NULL, return;);
 	ASSERT(lsap =3D=3D self, return;);
-	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) lsap, (int) l=
sap,=20
+	hashbin_insert(irlmp->unconnected_lsaps, (irda_queue_t *) lsap, (int) l=
sap,
 		       NULL);
=20
 	self->dlsap_sel =3D LSAP_ANY;
 	self->lap =3D NULL;
-=09
+
 	/*
 	 *  Inform service user
 	 */
 	if (self->notify.disconnect_indication)
-		self->notify.disconnect_indication(self->notify.instance,=20
+		self->notify.disconnect_indication(self->notify.instance,
 						   self, reason, userdata);
 	else {
 		IRDA_DEBUG(0, __FUNCTION__ "(), no handler\n");
@@ -747,7 +747,7 @@
 	lap =3D (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap !=3D NULL) {
 		ASSERT(lap->magic =3D=3D LMP_LAP_MAGIC, return;);
-	=09
+
 		if (lap->lap_state =3D=3D LAP_STANDBY) {
 			/* Expire discoveries discovered on this link */
 			irlmp_expire_discoveries(irlmp->cachelog, lap->saddr,
@@ -770,35 +770,35 @@
=20
 	/* Make sure the value is sane */
 	if ((nslots !=3D 1) && (nslots !=3D 6) && (nslots !=3D 8) && (nslots !=3D=
 16)){
-		WARNING(__FUNCTION__=20
-		       "(), invalid value for number of slots!\n");
+		WARNING("%s: invalid value for number of slots!\n",
+				__FUNCTION__);
 		nslots =3D sysctl_discovery_slots =3D 8;
 	}
=20
 	/* Construct new discovery info to be used by IrLAP, */
 	irlmp->discovery_cmd.hints.word =3D irlmp->hints.word;
-=09
-	/*=20
-	 *  Set character set for device name (we use ASCII), and=20
-	 *  copy device name. Remember to make room for a \0 at the=20
+
+	/*
+	 *  Set character set for device name (we use ASCII), and
+	 *  copy device name. Remember to make room for a \0 at the
 	 *  end
 	 */
 	irlmp->discovery_cmd.charset =3D CS_ASCII;
-	strncpy(irlmp->discovery_cmd.nickname, sysctl_devname,=20
+	strncpy(irlmp->discovery_cmd.nickname, sysctl_devname,
 		NICKNAME_MAX_LEN);
 	irlmp->discovery_cmd.name_len =3D strlen(irlmp->discovery_cmd.nickname)=
;
 	irlmp->discovery_cmd.nslots =3D nslots;
-=09
+
 	/*
 	 * Try to send discovery packets on all links
 	 */
 	lap =3D (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap !=3D NULL) {
 		ASSERT(lap->magic =3D=3D LMP_LAP_MAGIC, return;);
-	=09
+
 		if (lap->lap_state =3D=3D LAP_STANDBY) {
 			/* Try to discover */
-			irlmp_do_lap_event(lap, LM_LAP_DISCOVERY_REQUEST,=20
+			irlmp_do_lap_event(lap, LM_LAP_DISCOVERY_REQUEST,
 					   NULL);
 		}
 		lap =3D (struct lap_cb *) hashbin_get_next(irlmp->links);
@@ -816,9 +816,9 @@
 	/* Return current cached discovery log */
 	irlmp_discovery_confirm(irlmp->cachelog, DISCOVERY_LOG);
=20
-	/*=20
+	/*
 	 * Start a single discovery operation if discovery is not already
-         * running=20
+         * running
 	 */
 	if (!sysctl_discovery) {
 		/* Check if user wants to override the default */
@@ -864,9 +864,6 @@
 #if 0
 /*
  * Function irlmp_check_services (discovery)
- *
- *   =20
- *
  */
 void irlmp_check_services(discovery_t *discovery)
 {
@@ -896,7 +893,7 @@
 			/* Don't notify about the ANY service */
 			if (service =3D=3D S_ANY)
 				continue;
-			/* =20
+			/*
 			 * Found no clients for dealing with this service,
 			 */
 		}
@@ -923,20 +920,20 @@
 	discovery_t *discovery;
=20
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
-=09
+
 	/* Check if client wants or not partial/selective log (optimisation) */=

 	if (!client->disco_callback)
 		return;
=20
-	/*=20
-	 * Now, check all discovered devices (if any), and notify client=20
-	 * only about the services that the client is interested in=20
+	/*
+	 * Now, check all discovered devices (if any), and notify client
+	 * only about the services that the client is interested in
 	 */
 	discovery =3D (discovery_t *) hashbin_get_first(log);
 	while (discovery !=3D NULL) {
-		IRDA_DEBUG(3, "discovery->daddr =3D 0x%08x\n", discovery->daddr);=20
-	=09
-		/*=20
+		IRDA_DEBUG(3, "discovery->daddr =3D 0x%08x\n", discovery->daddr);
+
+		/*
 		 * Any common hint bits? Remember to mask away the extension
 		 * bits ;-)
 		 */
@@ -952,24 +949,24 @@
  *
  *    Some device(s) answered to our discovery request! Check to see whi=
ch
  *    device it is, and give indication to the client(s)
- *=20
+ *
  */
-void irlmp_discovery_confirm(hashbin_t *log, DISCOVERY_MODE mode)=20
+void irlmp_discovery_confirm(hashbin_t *log, DISCOVERY_MODE mode)
 {
 	irlmp_client_t *client;
-=09
+
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(log !=3D NULL, return;);
-=09
+
 	if (!(HASHBIN_GET_SIZE(log)))
 		return;
-=09
+
 	client =3D (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (client !=3D NULL) {
 		/* Check if we should notify client */
 		irlmp_notify_client(client, log, mode);
-		=09
+
 		client =3D (irlmp_client_t *) hashbin_get_next(irlmp->clients);
 	}
 }
@@ -980,19 +977,19 @@
  *	This device is no longer been discovered, and therefore it is beeing
  *	purged from the discovery log. Inform all clients who have
  *	registered for this event...
- *=20
+ *
  *	Note : called exclusively from discovery.c
  *	Note : as we are currently processing the log, the clients callback
  *	should *NOT* attempt to touch the log now.
  */
-void irlmp_discovery_expiry(discovery_t *expiry)=20
+void irlmp_discovery_expiry(discovery_t *expiry)
 {
 	irlmp_client_t *client;
-=09
+
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
=20
 	ASSERT(expiry !=3D NULL, return;);
-=09
+
 	client =3D (irlmp_client_t *) hashbin_get_first(irlmp->clients);
 	while (client !=3D NULL) {
 		/* Check if we should notify client */
@@ -1020,14 +1017,14 @@
=20
 	irlmp->discovery_rsp.hints.word =3D irlmp->hints.word;
=20
-	/*=20
-	 *  Set character set for device name (we use ASCII), and=20
-	 *  copy device name. Remember to make room for a \0 at the=20
+	/*
+	 *  Set character set for device name (we use ASCII), and
+	 *  copy device name. Remember to make room for a \0 at the
 	 *  end
 	 */
 	irlmp->discovery_rsp.charset =3D CS_ASCII;
=20
-	strncpy(irlmp->discovery_rsp.nickname, sysctl_devname,=20
+	strncpy(irlmp->discovery_rsp.nickname, sysctl_devname,
 		NICKNAME_MAX_LEN);
 	irlmp->discovery_rsp.name_len =3D strlen(irlmp->discovery_rsp.nickname)=
;
=20
@@ -1040,15 +1037,15 @@
  *    Send some data to peer device
  *
  */
-int irlmp_data_request(struct lsap_cb *self, struct sk_buff *skb)=20
+int irlmp_data_request(struct lsap_cb *self, struct sk_buff *skb)
 {
 	ASSERT(self !=3D NULL, return -1;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return -1;);
-=09
+
 	/* Make room for MUX header */
 	ASSERT(skb_headroom(skb) >=3D LMP_HEADER, return -1;);
 	skb_push(skb, LMP_HEADER);
-=09
+
 	return irlmp_do_lsap_event(self, LM_DATA_REQUEST, skb);
 }
=20
@@ -1058,7 +1055,7 @@
  *    Got data from LAP layer so pass it up to upper layer
  *
  */
-void irlmp_data_indication(struct lsap_cb *self, struct sk_buff *skb)=20
+void irlmp_data_indication(struct lsap_cb *self, struct sk_buff *skb)
 {
 	/* Hide LMP header from layer above */
 	skb_pull(skb, LMP_HEADER);
@@ -1071,16 +1068,13 @@
=20
 /*
  * Function irlmp_udata_request (self, skb)
- *
- *   =20
- *
  */
-int irlmp_udata_request(struct lsap_cb *self, struct sk_buff *skb)=20
+int irlmp_udata_request(struct lsap_cb *self, struct sk_buff *skb)
 {
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(skb !=3D NULL, return -1;);
-=09
+
 	/* Make room for MUX header */
 	ASSERT(skb_headroom(skb) >=3D LMP_HEADER, return -1;);
 	skb_push(skb, LMP_HEADER);
@@ -1094,9 +1088,9 @@
  *    Send unreliable data (but still within the connection)
  *
  */
-void irlmp_udata_indication(struct lsap_cb *self, struct sk_buff *skb)=20
+void irlmp_udata_indication(struct lsap_cb *self, struct sk_buff *skb)
 {
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);
@@ -1106,7 +1100,7 @@
 	skb_pull(skb, LMP_HEADER);
=20
 	if (self->notify.udata_indication)
-		self->notify.udata_indication(self->notify.instance, self,=20
+		self->notify.udata_indication(self->notify.instance, self,
 					      skb);
 	else
 		dev_kfree_skb(skb);
@@ -1114,23 +1108,20 @@
=20
 /*
  * Function irlmp_connless_data_request (self, skb)
- *
- *   =20
- *
  */
 #ifdef CONFIG_IRDA_ULTRA
-int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *sk=
b)=20
+int irlmp_connless_data_request(struct lsap_cb *self, struct sk_buff *sk=
b)
 {
 	struct sk_buff *clone_skb;
 	struct lap_cb *lap;
=20
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(skb !=3D NULL, return -1;);
-=09
+
 	/* Make room for MUX and PID header */
 	ASSERT(skb_headroom(skb) >=3D LMP_HEADER+LMP_PID_HEADER, return -1;);
-=09
+
 	/* Insert protocol identifier */
 	skb_push(skb, LMP_PID_HEADER);
 	skb->data[0] =3D self->pid;
@@ -1149,7 +1140,7 @@
 			return -ENOMEM;
=20
 		irlap_unitdata_request(lap->irlap, clone_skb);
-	=09
+
 		lap =3D (struct lap_cb *) hashbin_get_next(irlmp->links);
 	}
 	dev_kfree_skb(skb);
@@ -1165,9 +1156,9 @@
  *
  */
 #ifdef CONFIG_IRDA_ULTRA
-void irlmp_connless_data_indication(struct lsap_cb *self, struct sk_buff=
 *skb)=20
+void irlmp_connless_data_indication(struct lsap_cb *self, struct sk_buff=
 *skb)
 {
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");=20
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return;);
@@ -1184,7 +1175,7 @@
 }
 #endif /* CONFIG_IRDA_ULTRA */
=20
-void irlmp_status_request(void)=20
+void irlmp_status_request(void)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "(), Not implemented\n");
 }
@@ -1197,7 +1188,7 @@
  * Jean II
  */
 void irlmp_status_indication(struct lap_cb *self,
-			     LINK_STATUS link, LOCK_STATUS lock)=20
+			     LINK_STATUS link, LOCK_STATUS lock)
 {
 	struct lsap_cb *next;
 	struct lsap_cb *curr;
@@ -1213,7 +1204,7 @@
 		 *  Inform service user if he has requested it
 		 */
 		if (curr->notify.status_indication !=3D NULL)
-			curr->notify.status_indication(curr->notify.instance,=20
+			curr->notify.status_indication(curr->notify.instance,
 						       link, lock);
 		else
 			IRDA_DEBUG(2, __FUNCTION__ "(), no handler\n");
@@ -1279,7 +1270,7 @@
=20
 		/* Inform lsap user that it can send one more packet. */
 		if (curr->notify.flow_indication !=3D NULL)
-			curr->notify.flow_indication(curr->notify.instance,=20
+			curr->notify.flow_indication(curr->notify.instance,
 						     curr, flow);
 		else
 			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
@@ -1297,8 +1288,8 @@
 	__u8 *service;
 	int i =3D 0;
=20
-	/*=20
-	 * Allocate array to store services in. 16 entries should be safe=20
+	/*
+	 * Allocate array to store services in. 16 entries should be safe
 	 * since we currently only support 2 hint bytes
 	 */
 	service =3D kmalloc(16, GFP_ATOMIC);
@@ -1327,10 +1318,10 @@
 	if (hint[0] & HINT_FAX)
 		IRDA_DEBUG(1, "Fax ");
 	if (hint[0] & HINT_LAN) {
-		IRDA_DEBUG(1, "LAN Access ");	=09
+		IRDA_DEBUG(1, "LAN Access ");
 		service[i++] =3D S_LAN;
 	}
-	/*=20
+	/*
 	 *  Test if extension byte exists. This byte will usually be
 	 *  there, but this is not really required by the standard.
 	 *  (IrLMP p. 29)
@@ -1341,7 +1332,7 @@
 			service[i++] =3D S_TELEPHONY;
 		} if (hint[1] & HINT_FILE_SERVER)
 			IRDA_DEBUG(1, "File Server ");
-	=09
+
 		if (hint[1] & HINT_COMM) {
 			IRDA_DEBUG(1, "IrCOMM ");
 			service[i++] =3D S_COMM;
@@ -1357,7 +1348,7 @@
 	service[i++] =3D S_ANY;
=20
 	service[i] =3D S_END;
-=09
+
 	return service;
 }
=20
@@ -1436,7 +1427,7 @@
 	irlmp->hints.word |=3D hints;
=20
 	/* Make a new registration */
- 	service =3D kmalloc(sizeof(irlmp_service_t), GFP_ATOMIC);
+	service =3D kmalloc(sizeof(irlmp_service_t), GFP_ATOMIC);
 	if (!service) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unable to kmalloc!\n");
 		return 0;
@@ -1450,19 +1441,19 @@
 /*
  * Function irlmp_unregister_service (handle)
  *
- *    Unregister service with IrLMP.=20
+ *    Unregister service with IrLMP.
  *
  *    Returns: 0 on success, -1 on error
  */
 int irlmp_unregister_service(__u32 handle)
 {
 	irlmp_service_t *service;
-	=09
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	if (!handle)
 		return -1;
-=20
+
 	service =3D hashbin_find(irlmp->services, handle, NULL);
 	if (!service) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown service!\n");
@@ -1503,14 +1494,14 @@
=20
 	IRDA_DEBUG(1, __FUNCTION__ "()\n");
 	ASSERT(irlmp !=3D NULL, return 0;);
-=09
+
 	/* Get a unique handle for this client */
 	get_random_bytes(&handle, sizeof(handle));
 	while (hashbin_find(irlmp->clients, handle, NULL) || !handle)
 		get_random_bytes(&handle, sizeof(handle));
=20
 	/* Make a new registration */
- 	client =3D kmalloc(sizeof(irlmp_client_t), GFP_ATOMIC);
+	client =3D kmalloc(sizeof(irlmp_client_t), GFP_ATOMIC);
 	if (!client) {
 		IRDA_DEBUG( 1, __FUNCTION__ "(), Unable to kmalloc!\n");
 		return 0;
@@ -1522,7 +1513,7 @@
 	client->expir_callback =3D expir_clb;
 	client->priv =3D priv;
=20
- 	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);=

+	hashbin_insert(irlmp->clients, (irda_queue_t *) client, handle, NULL);
=20
 	return handle;
 }
@@ -1535,8 +1526,8 @@
  *
  *    Returns: 0 on success, -1 on error
  */
-int irlmp_update_client(__u32 handle, __u16 hint_mask,=20
-			DISCOVERY_CALLBACK1 disco_clb,=20
+int irlmp_update_client(__u32 handle, __u16 hint_mask,
+			DISCOVERY_CALLBACK1 disco_clb,
 			DISCOVERY_CALLBACK1 expir_clb, void *priv)
 {
 	irlmp_client_t *client;
@@ -1554,7 +1545,7 @@
 	client->disco_callback =3D disco_clb;
 	client->expir_callback =3D expir_clb;
 	client->priv =3D priv;
-=09
+
 	return 0;
 }
=20
@@ -1566,13 +1557,13 @@
  */
 int irlmp_unregister_client(__u32 handle)
 {
- 	struct irlmp_client *client;
-=20
- 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
+	struct irlmp_client *client;
+
+	IRDA_DEBUG(4, __FUNCTION__ "()\n");
=20
 	if (!handle)
 		return -1;
-=20
+
 	client =3D hashbin_find(irlmp->clients, handle, NULL);
 	if (!client) {
 		IRDA_DEBUG(1, __FUNCTION__ "(), Unknown client!\n");
@@ -1583,7 +1574,7 @@
 	client =3D hashbin_remove( irlmp->clients, handle, NULL);
 	if (client)
 		kfree(client);
-=09
+
 	return 0;
 }
=20
@@ -1628,13 +1619,13 @@
=20
 			if ((self->slsap_sel =3D=3D slsap_sel)) {
 				IRDA_DEBUG(4, "Source LSAP selector=3D%02x in use\n",
-				      self->slsap_sel);=20
+				      self->slsap_sel);
 				return TRUE;
 			}
 			self =3D (struct lsap_cb*) hashbin_get_next(lap->lsaps);
 		}
 		lap =3D (struct lap_cb *) hashbin_get_next(irlmp->links);
-	}    =20
+	}
 	return FALSE;
 }
=20
@@ -1644,16 +1635,16 @@
  *    Find a free source LSAP to use. This function is called if the ser=
vice
  *    user has requested a source LSAP equal to LM_ANY
  */
-__u8 irlmp_find_free_slsap(void)=20
+__u8 irlmp_find_free_slsap(void)
 {
 	__u8 lsap_sel;
 	int wrapped =3D 0;
=20
 	ASSERT(irlmp !=3D NULL, return -1;);
 	ASSERT(irlmp->magic =3D=3D LMP_MAGIC, return -1;);
-     =20
+
 	lsap_sel =3D irlmp->free_lsap_sel++;
-=09
+
 	/* Check if the new free lsap is really free */
 	while (irlmp_slsap_inuse(irlmp->free_lsap_sel)) {
 		irlmp->free_lsap_sel++;
@@ -1668,7 +1659,7 @@
 		}
 	}
 	IRDA_DEBUG(4, __FUNCTION__ "(), next free lsap_sel=3D%02x\n", lsap_sel)=
;
-=09
+
 	return lsap_sel;
 }
=20
@@ -1683,7 +1674,7 @@
 {
 	int reason =3D LM_LAP_DISCONNECT;
=20
-	switch (lap_reason) {	=09
+	switch (lap_reason) {
 	case LAP_DISC_INDICATION: /* Received a disconnect request from peer */=

 		IRDA_DEBUG( 1, __FUNCTION__ "(), LAP_DISC_INDICATION\n");
 		reason =3D LM_USER_REQUEST;
@@ -1703,14 +1694,14 @@
 		reason =3D LM_CONNECT_FAILURE;
 		break;
 	default:
-		IRDA_DEBUG(1, __FUNCTION__=20
+		IRDA_DEBUG(1, __FUNCTION__
 		      "(), Unknow IrLAP disconnect reason %d!\n", lap_reason);
 		reason =3D LM_LAP_DISCONNECT;
 		break;
 	}
=20
 	return reason;
-}=09
+}
=20
 __u32 irlmp_get_saddr(struct lsap_cb *self)
 {
@@ -1724,7 +1715,7 @@
 {
 	ASSERT(self !=3D NULL, return 0;);
 	ASSERT(self->lap !=3D NULL, return 0;);
-=09
+
 	return self->lap->daddr;
 }
=20
@@ -1742,37 +1733,37 @@
 	unsigned long flags;
=20
 	ASSERT(irlmp !=3D NULL, return 0;);
-=09
+
 	save_flags( flags);
 	cli();
=20
 	len =3D 0;
-=09
+
 	len +=3D sprintf( buf+len, "Unconnected LSAPs:\n");
 	self =3D (struct lsap_cb *) hashbin_get_first( irlmp->unconnected_lsaps=
);
 	while (self !=3D NULL) {
 		ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return 0;);
-		len +=3D sprintf(buf+len, "lsap state: %s, ",=20
+		len +=3D sprintf(buf+len, "lsap state: %s, ",
 			       irlsap_state[ self->lsap_state]);
-		len +=3D sprintf(buf+len,=20
+		len +=3D sprintf(buf+len,
 			       "slsap_sel: %#02x, dlsap_sel: %#02x, ",
-			       self->slsap_sel, self->dlsap_sel);=20
+			       self->slsap_sel, self->dlsap_sel);
 		len +=3D sprintf(buf+len, "(%s)", self->notify.name);
 		len +=3D sprintf(buf+len, "\n");
=20
 		self =3D (struct lsap_cb *) hashbin_get_next(
 			irlmp->unconnected_lsaps);
- 	}=20
+	}
=20
 	len +=3D sprintf(buf+len, "\nRegistred Link Layers:\n");
=20
 	lap =3D (struct lap_cb *) hashbin_get_first(irlmp->links);
 	while (lap !=3D NULL) {
-		len +=3D sprintf(buf+len, "lap state: %s, ",=20
+		len +=3D sprintf(buf+len, "lap state: %s, ",
 			       irlmp_state[lap->lap_state]);
=20
 		len +=3D sprintf(buf+len, "saddr: %#08x, daddr: %#08x, ",
-			       lap->saddr, lap->daddr);=20
+			       lap->saddr, lap->daddr);
 		len +=3D sprintf(buf+len, "num lsaps: %d",
 			       HASHBIN_GET_SIZE(lap->lsaps));
 		len +=3D sprintf(buf+len, "\n");
@@ -1781,27 +1772,24 @@
 		self =3D (struct lsap_cb *) hashbin_get_first(lap->lsaps);
 		while (self !=3D NULL) {
 			ASSERT(self->magic =3D=3D LMP_LSAP_MAGIC, return 0;);
-			len +=3D sprintf(buf+len, "  lsap state: %s, ",=20
+			len +=3D sprintf(buf+len, "  lsap state: %s, ",
 				       irlsap_state[ self->lsap_state]);
-			len +=3D sprintf(buf+len,=20
+			len +=3D sprintf(buf+len,
 				       "slsap_sel: %#02x, dlsap_sel: %#02x, ",
 				       self->slsap_sel, self->dlsap_sel);
 			len +=3D sprintf(buf+len, "(%s)", self->notify.name);
 			len +=3D sprintf(buf+len, "\n");
-		=09
-			self =3D (struct lsap_cb *) hashbin_get_next(=20
+
+			self =3D (struct lsap_cb *) hashbin_get_next(
 				lap->lsaps);
-		}=20
+		}
 		len +=3D sprintf(buf+len, "\n");
=20
 		lap =3D (struct lap_cb *) hashbin_get_next(irlmp->links);
- 	}=20
+	}
 	restore_flags(flags);
-=09
+
 	return len;
 }
=20
 #endif /* PROC_FS */
-
-
-

--------------000004090904080802080702--

