Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315170AbSFJMt1>; Mon, 10 Jun 2002 08:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSFJMrk>; Mon, 10 Jun 2002 08:47:40 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25351 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314227AbSFJMoK>; Mon, 10 Jun 2002 08:44:10 -0400
Message-ID: <3D049157.3040600@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:45:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warinigs 14/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------000404010308010500040208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404010308010500040208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

irlap_frame this time. Let me guess they used emacs?!

--------------000404010308010500040208
Content-Type: text/plain;
 name="warn-2.5.21-14.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-14.diff"

diff -urN linux-2.5.21/net/irda/irlap_frame.c linux/net/irda/irlap_frame.=
c
--- linux-2.5.21/net/irda/irlap_frame.c	2002-06-09 07:28:13.000000000 +02=
00
+++ linux/net/irda/irlap_frame.c	2002-06-09 21:12:20.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      irlap_frame.c
  * Version:       1.0
  * Description:   Build and transmit IrLAP frames
@@ -8,18 +8,18 @@
  * Created at:    Tue Aug 19 10:27:26 1997
  * Modified at:   Wed Jan  5 08:59:04 2000
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
@@ -29,10 +29,10 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/irda.h>
-=20
+
 #include <net/pkt_sched.h>
 #include <net/sock.h>
-=20
+
 #include <asm/byteorder.h>
=20
 #include <net/irda/irda.h>
@@ -46,18 +46,18 @@
 /*
  * Function irlap_insert_info (self, skb)
  *
- *    Insert minimum turnaround time and speed information into the skb.=
 We=20
+ *    Insert minimum turnaround time and speed information into the skb.=
 We
  *    need to do this since it's per packet relevant information. Safe t=
o
  *    have this function inlined since it's only called from one place
  */
-static inline void irlap_insert_info(struct irlap_cb *self,=20
+static inline void irlap_insert_info(struct irlap_cb *self,
 				     struct sk_buff *skb)
 {
 	struct irda_skb_cb *cb =3D (struct irda_skb_cb *) skb->cb;
=20
-	/* =20
+	/*
 	 * Insert MTT (min. turn time) and speed into skb, so that the
-	 * device driver knows which settings to use=20
+	 * device driver knows which settings to use
 	 */
 	cb->magic =3D LAP_MAGIC;
 	cb->mtt =3D self->mtt_required;
@@ -65,15 +65,15 @@
=20
 	/* Reset */
 	self->mtt_required =3D 0;
-=09
-	/*=20
-	 * Delay equals negotiated BOFs count, plus the number of BOFs to=20
-	 * force the negotiated minimum turnaround time=20
+
+	/*
+	 * Delay equals negotiated BOFs count, plus the number of BOFs to
+	 * force the negotiated minimum turnaround time
 	 */
 	cb->xbofs =3D self->bofs_count;
 	cb->next_xbofs =3D self->next_bofs;
 	cb->xbofs_delay =3D self->xbofs_delay;
-=09
+
 	/* Reset XBOF's delay (used only for getting min turn time) */
 	self->xbofs_delay =3D 0;
 	/* Put the correct xbofs value for the next packet */
@@ -91,7 +91,7 @@
 	/* Some common init stuff */
 	skb->dev =3D self->netdev;
 	skb->h.raw =3D skb->nh.raw =3D skb->mac.raw =3D skb->data;
- 	skb->protocol =3D htons(ETH_P_IRDA);
+	skb->protocol =3D htons(ETH_P_IRDA);
 	skb->priority =3D TC_PRIO_BESTEFFORT;
=20
 	irlap_insert_info(self, skb);
@@ -104,7 +104,7 @@
  *
  *    Transmits a connect SNRM command frame
  */
-void irlap_send_snrm_frame(struct irlap_cb *self, struct qos_info *qos) =

+void irlap_send_snrm_frame(struct irlap_cb *self, struct qos_info *qos)
 {
 	struct sk_buff *skb;
 	struct snrm_frame *frame;
@@ -118,7 +118,7 @@
 	if (!skb)
 		return;
=20
-	frame =3D (struct snrm_frame *) skb_put(skb, 2);=20
+	frame =3D (struct snrm_frame *) skb_put(skb, 2);
=20
 	/* Insert connection address field */
 	if (qos)
@@ -127,10 +127,10 @@
 		frame->caddr =3D CMD_FRAME | self->caddr;
=20
 	/* Insert control field */
- 	frame->control =3D SNRM_CMD | PF_BIT;
-=09
+	frame->control =3D SNRM_CMD | PF_BIT;
+
 	/*
-	 *  If we are establishing a connection then insert QoS paramerters=20
+	 *  If we are establishing a connection then insert QoS paramerters
 	 */
 	if (qos) {
 		skb_put(skb, 9); /* 21 left */
@@ -138,7 +138,7 @@
 		frame->daddr =3D cpu_to_le32(self->daddr);
=20
 		frame->ncaddr =3D self->caddr;
-			=09
+
 		ret =3D irlap_insert_qos_negotiation_params(self, skb);
 		if (ret < 0) {
 			dev_kfree_skb(skb);
@@ -154,28 +154,28 @@
  *    Received SNRM (Set Normal Response Mode) command frame
  *
  */
-static void irlap_recv_snrm_cmd(struct irlap_cb *self, struct sk_buff *s=
kb,=20
-				struct irlap_info *info)=20
+static void irlap_recv_snrm_cmd(struct irlap_cb *self, struct sk_buff *s=
kb,
+				struct irlap_info *info)
 {
 	struct snrm_frame *frame;
=20
 	frame =3D (struct snrm_frame *) skb->data;
-=09
+
 	if (skb->len >=3D sizeof(struct snrm_frame)) {
 		/* Copy the new connection address */
 		info->caddr =3D frame->ncaddr;
=20
 		/* Check if the new connection address is valid */
 		if ((info->caddr =3D=3D 0x00) || (info->caddr =3D=3D 0xfe)) {
-			IRDA_DEBUG(3, __FUNCTION__=20
+			IRDA_DEBUG(3, __FUNCTION__
 			      "(), invalid connection address!\n");
 			return;
 		}
-	=09
+
 		/* Copy peer device address */
 		info->daddr =3D le32_to_cpu(frame->saddr);
 		info->saddr =3D le32_to_cpu(frame->daddr);
-	=09
+
 		/* Only accept if addressed directly to us */
 		if (info->saddr !=3D self->saddr) {
 			IRDA_DEBUG(2, __FUNCTION__ "(), not addressed to us!\n");
@@ -199,9 +199,9 @@
 	struct sk_buff *skb;
 	struct ua_frame *frame;
 	int ret;
-=09
+
 	IRDA_DEBUG(2, __FUNCTION__ "() <%ld>\n", jiffies);
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
=20
@@ -213,10 +213,10 @@
 		return;
=20
 	frame =3D (struct ua_frame *) skb_put(skb, 10);
-=09
+
 	/* Build UA response */
 	frame->caddr =3D self->caddr;
- 	frame->control =3D UA_RSP | PF_BIT;
+	frame->control =3D UA_RSP | PF_BIT;
=20
 	frame->saddr =3D cpu_to_le32(self->saddr);
 	frame->daddr =3D cpu_to_le32(self->daddr);
@@ -244,7 +244,7 @@
 {
 	struct sk_buff *skb =3D NULL;
 	__u8 *frame;
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
=20
@@ -253,7 +253,7 @@
 		return;
=20
 	frame =3D skb_put( skb, 2);
-=09
+
 	if (self->state =3D=3D LAP_NDM)
 		frame[0] =3D CBROADCAST;
 	else
@@ -261,7 +261,7 @@
=20
 	frame[1] =3D DM_RSP | PF_BIT;
=20
-	irlap_queue_xmit(self, skb);=09
+	irlap_queue_xmit(self, skb);
 }
=20
 /*
@@ -270,11 +270,11 @@
  *    Send disconnect (DISC) frame
  *
  */
-void irlap_send_disc_frame(struct irlap_cb *self)=20
+void irlap_send_disc_frame(struct irlap_cb *self)
 {
 	struct sk_buff *skb =3D NULL;
 	__u8 *frame;
-=09
+
 	IRDA_DEBUG(3, __FUNCTION__ "()\n");
=20
 	ASSERT(self !=3D NULL, return;);
@@ -285,7 +285,7 @@
 		return;
=20
 	frame =3D skb_put(skb, 2);
-=09
+
 	frame[0] =3D self->caddr | CMD_FRAME;
 	frame[1] =3D DISC_CMD | PF_BIT;
=20
@@ -296,17 +296,17 @@
  * Function irlap_send_discovery_xid_frame (S, s, command)
  *
  *    Build and transmit a XID (eXchange station IDentifier) discovery
- *    frame.=20
+ *    frame.
  */
-void irlap_send_discovery_xid_frame(struct irlap_cb *self, int S, __u8 s=
,=20
-				    __u8 command, discovery_t *discovery)=20
+void irlap_send_discovery_xid_frame(struct irlap_cb *self, int S, __u8 s=
,
+				    __u8 command, discovery_t *discovery)
 {
 	struct sk_buff *skb =3D NULL;
 	struct xid_frame *frame;
 	__u32 bcast =3D BROADCAST;
 	__u8 *info;
=20
- 	IRDA_DEBUG(4, __FUNCTION__ "(), s=3D%d, S=3D%d, command=3D%d\n", s, S,=
=20
+	IRDA_DEBUG(4, __FUNCTION__ "(), s=3D%d, S=3D%d, command=3D%d\n", s, S,
 		   command);
=20
 	ASSERT(self !=3D NULL, return;);
@@ -335,7 +335,7 @@
 		frame->daddr =3D cpu_to_le32(bcast);
 	else
 		frame->daddr =3D cpu_to_le32(discovery->daddr);
-=09
+
 	switch (S) {
 	case 1:
 		frame->flags =3D 0x00;
@@ -354,10 +354,10 @@
 		break;
 	}
=20
-	frame->slotnr =3D s;=20
+	frame->slotnr =3D s;
 	frame->version =3D 0x00;
=20
-	/* =20
+	/*
 	 *  Provide info for final slot only in commands, and for all
 	 *  responses. Send the second byte of the hint only if the
 	 *  EXTENSION bit is set in the first byte.
@@ -366,7 +366,7 @@
 		int len;
=20
 		if (discovery->hints.byte[0] & HINT_EXTENSION) {
-			info =3D skb_put(skb, 2);	=09
+			info =3D skb_put(skb, 2);
 			info[0] =3D discovery->hints.byte[0];
 			info[1] =3D discovery->hints.byte[1];
 		} else {
@@ -379,7 +379,7 @@
 		len =3D IRDA_MIN(discovery->name_len, skb_tailroom(skb));
 		info =3D skb_put(skb, len);
 		memcpy(info, discovery->nickname, len);
-	}=20
+	}
 	irlap_queue_xmit(self, skb);
 }
=20
@@ -389,9 +389,9 @@
  *    Received a XID discovery response
  *
  */
-static void irlap_recv_discovery_xid_rsp(struct irlap_cb *self,=20
-					 struct sk_buff *skb,=20
-					 struct irlap_info *info)=20
+static void irlap_recv_discovery_xid_rsp(struct irlap_cb *self,
+					 struct sk_buff *skb,
+					 struct irlap_info *info)
 {
 	struct xid_frame *xid;
 	discovery_t *discovery =3D NULL;
@@ -410,13 +410,13 @@
=20
 	/* Make sure frame is addressed to us */
 	if ((info->saddr !=3D self->saddr) && (info->saddr !=3D BROADCAST)) {
-		IRDA_DEBUG(0, __FUNCTION__=20
+		IRDA_DEBUG(0, __FUNCTION__
 			   "(), frame is not addressed to us!\n");
 		return;
 	}
=20
 	if ((discovery =3D kmalloc(sizeof(discovery_t), GFP_ATOMIC)) =3D=3D NUL=
L) {
-		WARNING(__FUNCTION__ "(), kmalloc failed!\n");
+		WARNING("%s: kmalloc failed!\n", __FUNCTION__);
 		return;
 	}
 	memset(discovery, 0, sizeof(discovery_t));
@@ -441,11 +441,11 @@
 		discovery->charset =3D discovery_info[1];
 		text =3D (char *) &discovery_info[2];
 	}
-	/*=20
-	 *  Terminate info string, should be safe since this is where the=20
+	/*
+	 *  Terminate info string, should be safe since this is where the
 	 *  FCS bytes resides.
 	 */
-	skb->data[skb->len] =3D '\0';=20
+	skb->data[skb->len] =3D '\0';
 	strncpy(discovery->nickname, text, NICKNAME_MAX_LEN);
 	discovery->name_len =3D strlen(discovery->nickname);
=20
@@ -460,9 +460,9 @@
  *    Received a XID discovery command
  *
  */
-static void irlap_recv_discovery_xid_cmd(struct irlap_cb *self,=20
-					 struct sk_buff *skb,=20
-					 struct irlap_info *info)=20
+static void irlap_recv_discovery_xid_cmd(struct irlap_cb *self,
+					 struct sk_buff *skb,
+					 struct irlap_info *info)
 {
 	struct xid_frame *xid;
 	discovery_t *discovery =3D NULL;
@@ -476,7 +476,7 @@
=20
 	/* Make sure frame is addressed to us */
 	if ((info->saddr !=3D self->saddr) && (info->saddr !=3D BROADCAST)) {
-		IRDA_DEBUG(0, __FUNCTION__=20
+		IRDA_DEBUG(0, __FUNCTION__
 			   "(), frame is not addressed to us!\n");
 		return;
 	}
@@ -500,16 +500,16 @@
 		return;
 	}
 	info->s =3D xid->slotnr;
-=09
+
 	discovery_info =3D skb_pull(skb, sizeof(struct xid_frame));
=20
-	/*=20
-	 *  Check if last frame=20
+	/*
+	 *  Check if last frame
 	 */
 	if (info->s =3D=3D 0xff) {
 		/* Check if things are sane at this point... */
 		if((discovery_info =3D=3D NULL) || (skb->len < 3)) {
-			ERROR(__FUNCTION__ "(), discovery frame to short!\n");
+			ERROR("%s: discovery frame to short!\n", __FUNCTION__);
 			return;
 		}
=20
@@ -518,10 +518,10 @@
 		 */
 		discovery =3D kmalloc(sizeof(discovery_t), GFP_ATOMIC);
 		if (!discovery) {
-			WARNING(__FUNCTION__ "(), unable to malloc!\n");
+			WARNING("%s: unable to malloc!\n", __FUNCTION__);
 			return;
 		}
-	     =20
+
 		discovery->daddr =3D info->daddr;
 		discovery->saddr =3D self->saddr;
 		discovery->timestamp =3D jiffies;
@@ -536,11 +536,11 @@
 			discovery->charset =3D discovery_info[1];
 			text =3D (char *) &discovery_info[2];
 		}
-		/*=20
-		 *  Terminate string, should be safe since this is where the=20
+		/*
+		 *  Terminate string, should be safe since this is where the
 		 *  FCS bytes resides.
 		 */
-		skb->data[skb->len] =3D '\0';=20
+		skb->data[skb->len] =3D '\0';
 		strncpy(discovery->nickname, text, NICKNAME_MAX_LEN);
 		discovery->name_len =3D strlen(discovery->nickname);
=20
@@ -557,7 +557,7 @@
  *    Build and transmit RR (Receive Ready) frame. Notice that it is cur=
rently
  *    only possible to send RR frames with the poll bit set.
  */
-void irlap_send_rr_frame(struct irlap_cb *self, int command)=20
+void irlap_send_rr_frame(struct irlap_cb *self, int command)
 {
 	struct sk_buff *skb;
 	__u8 *frame;
@@ -565,9 +565,9 @@
 	skb =3D dev_alloc_skb(16);
 	if (!skb)
 		return;
-=09
+
 	frame =3D skb_put(skb, 2);
-=09
+
 	frame[0] =3D self->caddr;
 	frame[0] |=3D (command) ? CMD_FRAME : 0;
=20
@@ -579,7 +579,7 @@
 /*
  * Function irlap_send_rd_frame (self)
  *
- *    Request disconnect. Used by a secondary station to request the=20
+ *    Request disconnect. Used by a secondary station to request the
  *    disconnection of the link.
  */
 void irlap_send_rd_frame(struct irlap_cb *self)
@@ -590,9 +590,9 @@
 	skb =3D dev_alloc_skb(16);
 	if (!skb)
 		return;
-=09
+
 	frame =3D skb_put(skb, 2);
-=09
+
 	frame[0] =3D self->caddr;
 	frame[1] =3D RD_RSP | PF_BIT;
=20
@@ -606,8 +606,8 @@
  *    making it inline since its called only from one single place
  *    (irlap_driver_rcv).
  */
-static inline void irlap_recv_rr_frame(struct irlap_cb *self,=20
-				       struct sk_buff *skb,=20
+static inline void irlap_recv_rr_frame(struct irlap_cb *self,
+				       struct sk_buff *skb,
 				       struct irlap_info *info, int command)
 {
 	info->nr =3D skb->data[1] >> 5;
@@ -623,7 +623,7 @@
 {
 	struct sk_buff *skb =3D NULL;
 	__u8 *frame;
-=09
+
 	ASSERT( self !=3D NULL, return;);
 	ASSERT( self->magic =3D=3D LAP_MAGIC, return;);
=20
@@ -632,7 +632,7 @@
 		return;
=20
 	frame =3D skb_put( skb, 2);
-=09
+
 	frame[0] =3D self->caddr;
 	frame[0] |=3D (command) ? CMD_FRAME : 0;
=20
@@ -642,7 +642,7 @@
=20
 	frame[2] =3D 0;
=20
-   	IRDA_DEBUG(4, __FUNCTION__ "(), vr=3D%d, %ld\n",self->vr, jiffies); =

+	IRDA_DEBUG(4, __FUNCTION__ "(), vr=3D%d, %ld\n",self->vr, jiffies);
=20
 	irlap_queue_xmit(self, skb);
 }
@@ -653,8 +653,8 @@
  *    Received RNR (Receive Not Ready) frame from peer station
  *
  */
-static void irlap_recv_rnr_frame(struct irlap_cb *self, struct sk_buff *=
skb,=20
-				 struct irlap_info *info, int command)=20
+static void irlap_recv_rnr_frame(struct irlap_cb *self, struct sk_buff *=
skb,
+				 struct irlap_info *info, int command)
 {
 	info->nr =3D skb->data[1] >> 5;
=20
@@ -666,13 +666,13 @@
 		irlap_do_event(self, RECV_RNR_RSP, skb, info);
 }
=20
-static void irlap_recv_rej_frame(struct irlap_cb *self, struct sk_buff *=
skb,=20
+static void irlap_recv_rej_frame(struct irlap_cb *self, struct sk_buff *=
skb,
 				 struct irlap_info *info, int command)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
=20
 	info->nr =3D skb->data[1] >> 5;
-=09
+
 	/* Check if this is a command or a response frame */
 	if (command)
 		irlap_do_event(self, RECV_REJ_CMD, skb, info);
@@ -680,13 +680,13 @@
 		irlap_do_event(self, RECV_REJ_RSP, skb, info);
 }
=20
-static void irlap_recv_srej_frame(struct irlap_cb *self, struct sk_buff =
*skb,=20
+static void irlap_recv_srej_frame(struct irlap_cb *self, struct sk_buff =
*skb,
 				  struct irlap_info *info, int command)
 {
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
=20
 	info->nr =3D skb->data[1] >> 5;
-=09
+
 	/* Check if this is a command or a response frame */
 	if (command)
 		irlap_do_event(self, RECV_SREJ_CMD, skb, info);
@@ -694,7 +694,7 @@
 		irlap_do_event(self, RECV_SREJ_RSP, skb, info);
 }
=20
-static void irlap_recv_disc_frame(struct irlap_cb *self, struct sk_buff =
*skb,=20
+static void irlap_recv_disc_frame(struct irlap_cb *self, struct sk_buff =
*skb,
 				  struct irlap_info *info, int command)
 {
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
@@ -712,9 +712,9 @@
  *    Received UA (Unnumbered Acknowledgement) frame
  *
  */
-static inline void irlap_recv_ua_frame(struct irlap_cb *self,=20
-				       struct sk_buff *skb,=20
-				       struct irlap_info *info)=20
+static inline void irlap_recv_ua_frame(struct irlap_cb *self,
+				       struct sk_buff *skb,
+				       struct irlap_info *info)
 {
 	irlap_do_event(self, RECV_UA_RSP, skb, info);
 }
@@ -731,25 +731,25 @@
=20
 	if (skb->data[1] =3D=3D I_FRAME) {
=20
-		/* =20
+		/*
 		 *  Insert frame sequence number (Vs) in control field before
 		 *  inserting into transmit window queue.
 		 */
 		skb->data[1] =3D I_FRAME | (self->vs << 1);
-	=09
+
 		/* Copy buffer */
 		tx_skb =3D skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb =3D=3D NULL) {
 			return;
 		}
-	=09
-		/*=20
-		 *  Insert frame in store, in case of retransmissions=20
+
+		/*
+		 *  Insert frame in store, in case of retransmissions
 		 */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
-	=09
+
 		self->vs =3D (self->vs + 1) % 8;
-		self->ack_required =3D FALSE;	=09
+		self->ack_required =3D FALSE;
 		self->window -=3D 1;
=20
 		irlap_send_i_frame( self, tx_skb, CMD_FRAME);
@@ -764,40 +764,40 @@
  *
  *    Send I(nformation) frame as primary with poll bit set
  */
-void irlap_send_data_primary_poll(struct irlap_cb *self, struct sk_buff =
*skb)=20
+void irlap_send_data_primary_poll(struct irlap_cb *self, struct sk_buff =
*skb)
 {
 	struct sk_buff *tx_skb;
=20
 	/* Stop P timer */
 	del_timer(&self->poll_timer);
-	=09
+
 	/* Is this reliable or unreliable data? */
 	if (skb->data[1] =3D=3D I_FRAME) {
-	=09
-		/* =20
+
+		/*
 		 *  Insert frame sequence number (Vs) in control field before
 		 *  inserting into transmit window queue.
 		 */
 		skb->data[1] =3D I_FRAME | (self->vs << 1);
-	=09
+
 		/* Copy buffer */
 		tx_skb =3D skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb =3D=3D NULL) {
 			return;
 		}
-	=09
-		/*=20
-		 *  Insert frame in store, in case of retransmissions=20
+
+		/*
+		 *  Insert frame in store, in case of retransmissions
 		 */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
-	=09
-		/* =20
+
+		/*
 		 *  Set poll bit if necessary. We do this to the copied
 		 *  skb, since retransmitted need to set or clear the poll
-		 *  bit depending on when they are sent. =20
+		 *  bit depending on when they are sent.
 		 */
 		tx_skb->data[1] |=3D PF_BIT;
-	=09
+
 		self->vs =3D (self->vs + 1) % 8;
 		self->ack_required =3D FALSE;
=20
@@ -830,8 +830,8 @@
  *    Send I(nformation) frame as secondary with final bit set
  *
  */
-void irlap_send_data_secondary_final(struct irlap_cb *self,=20
-				     struct sk_buff *skb)=20
+void irlap_send_data_secondary_final(struct irlap_cb *self,
+				     struct sk_buff *skb)
 {
 	struct sk_buff *tx_skb =3D NULL;
=20
@@ -842,26 +842,26 @@
 	/* Is this reliable or unreliable data? */
 	if (skb->data[1] =3D=3D I_FRAME) {
=20
-		/* =20
+		/*
 		 *  Insert frame sequence number (Vs) in control field before
 		 *  inserting into transmit window queue.
 		 */
 		skb->data[1] =3D I_FRAME | (self->vs << 1);
-	=09
+
 		tx_skb =3D skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb =3D=3D NULL) {
 			return;
-		}	=09
+		}
=20
 		/* Insert frame in store */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
-	=09
+
 		tx_skb->data[1] |=3D PF_BIT;
-	=09
-		self->vs =3D (self->vs + 1) % 8;=20
+
+		self->vs =3D (self->vs + 1) % 8;
 		self->ack_required =3D FALSE;
-	=09
-		irlap_send_i_frame(self, tx_skb, RSP_FRAME);=20
+
+		irlap_send_i_frame(self, tx_skb, RSP_FRAME);
 	} else {
 		if (self->ack_required) {
 			irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
@@ -888,32 +888,32 @@
  *    Send I(nformation) frame as secondary without final bit set
  *
  */
-void irlap_send_data_secondary(struct irlap_cb *self, struct sk_buff *sk=
b)=20
+void irlap_send_data_secondary(struct irlap_cb *self, struct sk_buff *sk=
b)
 {
 	struct sk_buff *tx_skb =3D NULL;
=20
 	/* Is this reliable or unreliable data? */
 	if (skb->data[1] =3D=3D I_FRAME) {
-	=09
-		/* =20
+
+		/*
 		 *  Insert frame sequence number (Vs) in control field before
 		 *  inserting into transmit window queue.
 		 */
 		skb->data[1] =3D I_FRAME | (self->vs << 1);
-	=09
+
 		tx_skb =3D skb_clone(skb, GFP_ATOMIC);
 		if (tx_skb =3D=3D NULL) {
 			return;
-		}	=09
-	=09
+		}
+
 		/* Insert frame in store */
 		skb_queue_tail(&self->wx_list, skb_get(skb));
-	=09
+
 		self->vs =3D (self->vs + 1) % 8;
-		self->ack_required =3D FALSE;	=09
+		self->ack_required =3D FALSE;
 		self->window -=3D 1;
=20
-		irlap_send_i_frame(self, tx_skb, RSP_FRAME);=20
+		irlap_send_i_frame(self, tx_skb, RSP_FRAME);
 	} else {
 		irlap_send_ui_frame(self, skb_get(skb), self->caddr, RSP_FRAME);
 		self->window -=3D 1;
@@ -923,8 +923,8 @@
 /*
  * Function irlap_resend_rejected_frames (nr)
  *
- *    Resend frames which has not been acknowledged. Should be safe to=20
- *    traverse the list without locking it since this function will only=
 be=20
+ *    Resend frames which has not been acknowledged. Should be safe to
+ *    traverse the list without locking it since this function will only=
 be
  *    called from interrupt context (BH)
  */
 void irlap_resend_rejected_frames(struct irlap_cb *self, int command)
@@ -946,8 +946,8 @@
 	while (skb !=3D NULL) {
 		irlap_wait_min_turn_around(self, &self->qos_tx);
=20
-		/* We copy the skb to be retransmitted since we will have to=20
-		 * modify it. Cloning will confuse packet sniffers=20
+		/* We copy the skb to be retransmitted since we will have to
+		 * modify it. Cloning will confuse packet sniffers
 		 */
 		/* tx_skb =3D skb_clone( skb, GFP_ATOMIC); */
 		tx_skb =3D skb_copy(skb, GFP_ATOMIC);
@@ -962,17 +962,17 @@
 		/* Clear old Nr field + poll bit */
 		tx_skb->data[1] &=3D 0x0f;
=20
-		/*=20
+		/*
 		 *  Set poll bit on the last frame retransmitted
 		 */
-	 	if (count-- =3D=3D 1)
-	 		tx_skb->data[1] |=3D PF_BIT; /* Set p/f bit */
+		if (count-- =3D=3D 1)
+			tx_skb->data[1] |=3D PF_BIT; /* Set p/f bit */
 		else
 			tx_skb->data[1] &=3D ~PF_BIT; /* Clear p/f bit */
-	      =09
+
 		irlap_send_i_frame(self, tx_skb, command);
=20
-		/*=20
+		/*
 		 *  If our skb is the last buffer in the list, then
 		 *  we are finished, if not, move to the next sk-buffer
 		 */
@@ -982,23 +982,23 @@
 			skb =3D skb->next;
 	}
 #if 0 /* Not yet */
-	/*=20
+	/*
 	 *  We can now fill the window with additinal data frames
 	 */
 	while (skb_queue_len( &self->txq) > 0) {
-	=09
+
 		IRDA_DEBUG(0, __FUNCTION__ "(), sending additional frames!\n");
-		if ((skb_queue_len( &self->txq) > 0) &&=20
+		if ((skb_queue_len( &self->txq) > 0) &&
 		    (self->window > 0)) {
-			skb =3D skb_dequeue( &self->txq);=20
+			skb =3D skb_dequeue( &self->txq);
 			ASSERT(skb !=3D NULL, return;);
=20
 			/*
-			 *  If send window > 1 then send frame with pf=20
+			 *  If send window > 1 then send frame with pf
 			 *  bit cleared
-			 */=20
-			if ((self->window > 1) &&=20
-			    skb_queue_len(&self->txq) > 0)=20
+			 */
+			if ((self->window > 1) &&
+			    skb_queue_len(&self->txq) > 0)
 			{
 				irlap_send_data_primary(self, skb);
 			} else {
@@ -1026,14 +1026,14 @@
 	if (skb !=3D NULL) {
 		irlap_wait_min_turn_around(self, &self->qos_tx);
=20
-		/* We copy the skb to be retransmitted since we will have to=20
-		 * modify it. Cloning will confuse packet sniffers=20
+		/* We copy the skb to be retransmitted since we will have to
+		 * modify it. Cloning will confuse packet sniffers
 		 */
 		/* tx_skb =3D skb_clone( skb, GFP_ATOMIC); */
 		tx_skb =3D skb_copy(skb, GFP_ATOMIC);
 		if (!tx_skb) {
 			IRDA_DEBUG(0, __FUNCTION__ "(), unable to copy\n");
-			return;=09
+			return;
 		}
 		/* Unlink tx_skb from list */
 		tx_skb->next =3D tx_skb->prev =3D NULL;
@@ -1044,7 +1044,7 @@
=20
 		/*  Set poll/final bit */
 		tx_skb->data[1] |=3D PF_BIT; /* Set p/f bit */
-	      =09
+
 		irlap_send_i_frame(self, tx_skb, command);
 	}
 }
@@ -1055,15 +1055,15 @@
  *    Contruct and transmit an Unnumbered Information (UI) frame
  *
  */
-void irlap_send_ui_frame(struct irlap_cb *self, struct sk_buff *skb,=20
+void irlap_send_ui_frame(struct irlap_cb *self, struct sk_buff *skb,
 			 __u8 caddr, int command)
 {
 	IRDA_DEBUG(4, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
 	ASSERT(skb !=3D NULL, return;);
-=09
+
 	/* Insert connection address */
 	skb->data[0] =3D caddr | ((command) ? CMD_FRAME : 0);
=20
@@ -1075,13 +1075,13 @@
  *
  *    Contruct and transmit Information (I) frame
  */
-void irlap_send_i_frame(struct irlap_cb *self, struct sk_buff *skb,=20
-			int command)=20
+void irlap_send_i_frame(struct irlap_cb *self, struct sk_buff *skb,
+			int command)
 {
 	/* Insert connection address */
 	skb->data[0] =3D self->caddr;
 	skb->data[0] |=3D (command) ? CMD_FRAME : 0;
-=09
+
 	/* Insert next to receive (Vr) */
 	skb->data[1] |=3D (self->vr << 5);  /* insert nr */
=20
@@ -1094,9 +1094,9 @@
  *    Receive and parse an I (Information) frame, no harm in making it i=
nline
  *    since it's called only from one single place (irlap_driver_rcv).
  */
-static inline void irlap_recv_i_frame(struct irlap_cb *self,=20
-				      struct sk_buff *skb,=20
-				      struct irlap_info *info, int command)=20
+static inline void irlap_recv_i_frame(struct irlap_cb *self,
+				      struct sk_buff *skb,
+				      struct irlap_info *info, int command)
 {
 	info->nr =3D skb->data[1] >> 5;          /* Next to receive */
 	info->pf =3D skb->data[1] & PF_BIT;      /* Final bit */
@@ -1115,7 +1115,7 @@
  *    Receive and parse an Unnumbered Information (UI) frame
  *
  */
-static void irlap_recv_ui_frame(struct irlap_cb *self, struct sk_buff *s=
kb,=20
+static void irlap_recv_ui_frame(struct irlap_cb *self, struct sk_buff *s=
kb,
 				struct irlap_info *info)
 {
 	IRDA_DEBUG( 4, __FUNCTION__ "()\n");
@@ -1131,19 +1131,19 @@
  *    Received Frame Reject response.
  *
  */
-static void irlap_recv_frmr_frame(struct irlap_cb *self, struct sk_buff =
*skb,=20
-				  struct irlap_info *info)=20
+static void irlap_recv_frmr_frame(struct irlap_cb *self, struct sk_buff =
*skb,
+				  struct irlap_info *info)
 {
 	__u8 *frame;
 	int w, x, y, z;
=20
 	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-=09
+
 	ASSERT(self !=3D NULL, return;);
 	ASSERT(self->magic =3D=3D LAP_MAGIC, return;);
 	ASSERT(skb !=3D NULL, return;);
 	ASSERT(info !=3D NULL, return;);
-=09
+
 	frame =3D skb->data;
=20
 	info->nr =3D frame[2] >> 5;          /* Next to receive */
@@ -1154,11 +1154,11 @@
 	x =3D frame[3] & 0x02;
 	y =3D frame[3] & 0x04;
 	z =3D frame[3] & 0x08;
-=09
+
 	if (w) {
 		IRDA_DEBUG(0, "Rejected control field is undefined or not "
 		      "implemented.\n");
-	}=20
+	}
 	if (x) {
 		IRDA_DEBUG(0, "Rejected control field was invalid because it "
 		      "contained a non permitted I field.\n");
@@ -1181,7 +1181,7 @@
  *    Send a test frame response
  *
  */
-void irlap_send_test_frame(struct irlap_cb *self, __u8 caddr, __u32 dadd=
r,=20
+void irlap_send_test_frame(struct irlap_cb *self, __u8 caddr, __u32 dadd=
r,
 			   struct sk_buff *cmd)
 {
 	struct sk_buff *skb;
@@ -1194,7 +1194,7 @@
=20
 	/* Broadcast frames must include saddr and daddr fields */
 	if (caddr =3D=3D CBROADCAST) {
-		frame =3D (struct test_frame *)=20
+		frame =3D (struct test_frame *)
 			skb_put(skb, sizeof(struct test_frame));
=20
 		/* Insert the swapped addresses */
@@ -1221,29 +1221,29 @@
  *    Receive a test frame
  *
  */
-static void irlap_recv_test_frame(struct irlap_cb *self, struct sk_buff =
*skb,=20
+static void irlap_recv_test_frame(struct irlap_cb *self, struct sk_buff =
*skb,
 				  struct irlap_info *info, int command)
 {
 	struct test_frame *frame;
=20
 	IRDA_DEBUG(2, __FUNCTION__ "()\n");
-=09
+
 	frame =3D (struct test_frame *) skb->data;
-	=09
+
 	/* Broadcast frames must carry saddr and daddr fields */
 	if (info->caddr =3D=3D CBROADCAST) {
 		if (skb->len < sizeof(struct test_frame)) {
-			IRDA_DEBUG(0, __FUNCTION__=20
+			IRDA_DEBUG(0, __FUNCTION__
 				   "() test frame to short!\n");
 			return;
 		}
-	=09
+
 		/* Read and swap addresses */
 		info->daddr =3D le32_to_cpu(frame->saddr);
 		info->saddr =3D le32_to_cpu(frame->daddr);
=20
 		/* Make sure frame is addressed to us */
-		if ((info->saddr !=3D self->saddr) &&=20
+		if ((info->saddr !=3D self->saddr) &&
 		    (info->saddr !=3D BROADCAST)) {
 			return;
 		}
@@ -1258,18 +1258,18 @@
 /*
  * Function irlap_driver_rcv (skb, netdev, ptype)
  *
- *    Called when a frame is received. Dispatches the right receive func=
tion=20
+ *    Called when a frame is received. Dispatches the right receive func=
tion
  *    for processing of the frame.
  *
  */
-int irlap_driver_rcv(struct sk_buff *skb, struct net_device *dev,=20
+int irlap_driver_rcv(struct sk_buff *skb, struct net_device *dev,
 		     struct packet_type *ptype)
 {
 	struct irlap_info info;
 	struct irlap_cb *self;
 	int command;
 	__u8 control;
-=09
+
 	/* FIXME: should we get our own field? */
 	self =3D (struct irlap_cb *) dev->atalk_ptr;
=20
@@ -1281,14 +1281,14 @@
=20
 	/* Check if frame is large enough for parsing */
 	if (skb->len < 2) {
-		ERROR(__FUNCTION__ "(), frame to short!\n");
+		ERROR("%s: frame to short!\n", __FUNCTION__);
 		dev_kfree_skb(skb);
 		return -1;
 	}
-=09
+
 	command    =3D skb->data[0] & CMD_FRAME;
 	info.caddr =3D skb->data[0] & CBROADCAST;
-=09
+
 	info.pf      =3D skb->data[1] &  PF_BIT;
 	info.control =3D skb->data[1] & ~PF_BIT; /* Mask away poll/final bit */=

=20
@@ -1299,7 +1299,7 @@
 		IRDA_DEBUG(0, __FUNCTION__ "(), wrong connection address!\n");
 		goto out;
 	}
-	/* =20
+	/*
 	 *  Optimize for the common case and check if the frame is an
 	 *  I(nformation) frame. Only I-frames have bit 0 set to 0
 	 */
@@ -1308,11 +1308,11 @@
 		goto out;
 	}
 	/*
-	 *  We now check is the frame is an S(upervisory) frame. Only=20
+	 *  We now check is the frame is an S(upervisory) frame. Only
 	 *  S-frames have bit 0 set to 1 and bit 1 set to 0
 	 */
 	if (~control & 0x02) {
-		/*=20
+		/*
 		 *  Received S(upervisory) frame, check which frame type it is
 		 *  only the first nibble is of interest
 		 */
@@ -1330,15 +1330,14 @@
 			irlap_recv_srej_frame(self, skb, &info, command);
 			break;
 		default:
-			WARNING(__FUNCTION__=20
-				"() Unknown S-frame %02x received!\n",
-				info.control);
+			WARNING("%s: Unknown S-frame %02x received!\n",
+				__FUNCTION__, info.control);
 			break;
 		}
 		goto out;
 	}
-	/*=20
-	 *  This must be a C(ontrol) frame=20
+	/*
+	 *  This must be a C(ontrol) frame
 	 */
 	switch (control) {
 	case XID_RSP:
@@ -1369,11 +1368,11 @@
 		irlap_recv_ui_frame(self, skb, &info);
 		break;
 	default:
-		WARNING(__FUNCTION__ "(), Unknown frame %02x received!\n",=20
-			info.control);
+		WARNING("%s: Unknown frame %02x received!\n",
+				__FUNCTION__, info.control);
 		break;
 	}
 out:
-	dev_kfree_skb(skb);=20
+	dev_kfree_skb(skb);
 	return 0;
 }

--------------000404010308010500040208--

