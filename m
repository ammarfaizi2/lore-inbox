Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSFJMuv>; Mon, 10 Jun 2002 08:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314485AbSFJMtq>; Mon, 10 Jun 2002 08:49:46 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32007 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314835AbSFJMtT>; Mon, 10 Jun 2002 08:49:19 -0400
Message-ID: <3D04928C.4080401@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:50:36 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.21 kill warnings 19/19
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060106070308090309060403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106070308090309060403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

and now the final irda offender :-).

--------------060106070308090309060403
Content-Type: text/plain;
 name="warn-2.5.21-19.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="warn-2.5.21-19.diff"

diff -urN linux-2.5.21/net/irda/wrapper.c linux/net/irda/wrapper.c
--- linux-2.5.21/net/irda/wrapper.c	2002-06-09 07:27:50.000000000 +0200
+++ linux/net/irda/wrapper.c	2002-06-09 20:49:58.000000000 +0200
@@ -1,5 +1,5 @@
 /*********************************************************************
- *               =20
+ *
  * Filename:      wrapper.c
  * Version:       1.2
  * Description:   IrDA SIR async wrapper layer
@@ -10,17 +10,17 @@
  * Modified by:   Dag Brattli <dagb@cs.uit.no>
  * Modified at:   Fri May 28  3:11 CST 1999
  * Modified by:   Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
- *=20
- *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,=20
+ *
+ *     Copyright (c) 1998-2000 Dag Brattli <dagb@cs.uit.no>,
  *     All Rights Reserved.
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
@@ -39,22 +39,22 @@
=20
 static inline int stuff_byte(__u8 byte, __u8 *buf);
=20
-static void state_outside_frame(struct net_device *dev,=20
-				struct net_device_stats *stats,=20
+static void state_outside_frame(struct net_device *dev,
+				struct net_device_stats *stats,
 				iobuff_t *rx_buff, __u8 byte);
-static void state_begin_frame(struct net_device *dev,=20
-			      struct net_device_stats *stats,=20
+static void state_begin_frame(struct net_device *dev,
+			      struct net_device_stats *stats,
 			      iobuff_t *rx_buff, __u8 byte);
-static void state_link_escape(struct net_device *dev,=20
-			      struct net_device_stats *stats,=20
+static void state_link_escape(struct net_device *dev,
+			      struct net_device_stats *stats,
 			      iobuff_t *rx_buff, __u8 byte);
-static void state_inside_frame(struct net_device *dev,=20
-			       struct net_device_stats *stats,=20
+static void state_inside_frame(struct net_device *dev,
+			       struct net_device_stats *stats,
 			       iobuff_t *rx_buff, __u8 byte);
=20
-static void (*state[])(struct net_device *dev, struct net_device_stats *=
stats,=20
-		       iobuff_t *rx_buff, __u8 byte) =3D=20
-{=20
+static void (*state[])(struct net_device *dev, struct net_device_stats *=
stats,
+		       iobuff_t *rx_buff, __u8 byte) =3D
+{
 	state_outside_frame,
 	state_begin_frame,
 	state_link_escape,
@@ -64,14 +64,14 @@
 /*
  * Function async_wrap (skb, *tx_buff, buffsize)
  *
- *    Makes a new buffer with wrapping and stuffing, should check that=20
+ *    Makes a new buffer with wrapping and stuffing, should check that
  *    we don't get tx buffer overflow.
  */
 int async_wrap_skb(struct sk_buff *skb, __u8 *tx_buff, int buffsize)
 {
 	struct irda_skb_cb *cb =3D (struct irda_skb_cb *) skb->cb;
 	int xbofs;
- 	int i;
+	int i;
 	int n;
 	union {
 		__u16 value;
@@ -86,11 +86,11 @@
 	 *  Send  XBOF's for required min. turn time and for the negotiated
 	 *  additional XBOFS
 	 */
-=09
+
 	if (cb->magic !=3D LAP_MAGIC) {
-		/*=20
+		/*
 		 * This will happen for all frames sent from user-space.
-		 * Nothing to worry about, but we set the default number of=20
+		 * Nothing to worry about, but we set the default number of
 		 * BOF's
 		 */
 		IRDA_DEBUG(1, __FUNCTION__ "(), wrong magic in skb!\n");
@@ -116,7 +116,7 @@
 	for (i=3D0; i < skb->len; i++) {
 		/*
 		 *  Check for the possibility of tx buffer overflow. We use
-		 *  bufsize-5 since the maximum number of bytes that can be=20
+		 *  bufsize-5 since the maximum number of bytes that can be
 		 *  transmitted after this point is 5.
 		 */
 		ASSERT(n < (buffsize-5), return n;);
@@ -124,7 +124,7 @@
 		n +=3D stuff_byte(skb->data[i], tx_buff+n);
 		fcs.value =3D irda_fcs(fcs.value, skb->data[i]);
 	}
-=09
+
 	/* Insert CRC in little endian format (LSB first) */
 	fcs.value =3D ~fcs.value;
 #ifdef __LITTLE_ENDIAN
@@ -144,9 +144,9 @@
  *
  *    Byte stuff one single byte and put the result in buffer pointed to=
 by
  *    buf. The buffer must at all times be able to have two bytes insert=
ed.
- *=20
+ *
  */
-static inline int stuff_byte(__u8 byte, __u8 *buf)=20
+static inline int stuff_byte(__u8 byte, __u8 *buf)
 {
 	switch (byte) {
 	case BOF: /* FALLTHROUGH */
@@ -174,7 +174,7 @@
 inline void async_bump(struct net_device *dev, struct net_device_stats *=
stats,
 		       __u8 *buf, int len)
 {
-       	struct sk_buff *skb;
+	struct sk_buff *skb;
=20
 	skb =3D dev_alloc_skb(len+1);
 	if (!skb)  {
@@ -184,10 +184,10 @@
=20
 	/* Align IP header to 20 bytes */
 	skb_reserve(skb, 1);
-=09
+
         /* Copy data without CRC */
-	memcpy(skb_put(skb, len-2), buf, len-2);=20
-=09
+	memcpy(skb_put(skb, len-2), buf, len-2);
+
 	/* Feed it to IrLAP layer */
 	skb->dev =3D dev;
 	skb->mac.raw  =3D skb->data;
@@ -196,7 +196,7 @@
 	netif_rx(skb);
=20
 	stats->rx_packets++;
-	stats->rx_bytes +=3D len;=09
+	stats->rx_bytes +=3D len;
 }
=20
 /*
@@ -205,21 +205,21 @@
  *    Parse and de-stuff frame received from the IrDA-port
  *
  */
-inline void async_unwrap_char(struct net_device *dev,=20
-			      struct net_device_stats *stats,=20
+inline void async_unwrap_char(struct net_device *dev,
+			      struct net_device_stats *stats,
 			      iobuff_t *rx_buff, __u8 byte)
 {
 	(*state[rx_buff->state])(dev, stats, rx_buff, byte);
 }
-	=20
+
 /*
  * Function state_outside_frame (dev, rx_buff, byte)
  *
  *    Not receiving any frame (or just bogus data)
  *
  */
-static void state_outside_frame(struct net_device *dev,=20
-				struct net_device_stats *stats,=20
+static void state_outside_frame(struct net_device *dev,
+				struct net_device_stats *stats,
 				iobuff_t *rx_buff, __u8 byte)
 {
 	switch (byte) {
@@ -245,8 +245,8 @@
  *    Begin of frame detected
  *
  */
-static void state_begin_frame(struct net_device *dev,=20
-			      struct net_device_stats *stats,=20
+static void state_begin_frame(struct net_device *dev,
+			      struct net_device_stats *stats,
 			      iobuff_t *rx_buff, __u8 byte)
 {
 	/* Time to initialize receive buffer */
@@ -283,27 +283,27 @@
  *    Found link escape character
  *
  */
-static void state_link_escape(struct net_device *dev,=20
-			      struct net_device_stats *stats,=20
+static void state_link_escape(struct net_device *dev,
+			      struct net_device_stats *stats,
 			      iobuff_t *rx_buff, __u8 byte)
 {
 	switch (byte) {
 	case BOF: /* New frame? */
-		IRDA_DEBUG(1, __FUNCTION__=20
+		IRDA_DEBUG(1, __FUNCTION__
 			   "(), Discarding incomplete frame\n");
 		rx_buff->state =3D BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
 		break;
 	case CE:
-		WARNING(__FUNCTION__ "(), state not defined\n");
+		WARNING("%s: state not defined\n", __FUNCTION__);
 		break;
 	case EOF: /* Abort frame */
 		rx_buff->state =3D OUTSIDE_FRAME;
 		break;
 	default:
-		/*=20
-		 *  Stuffed char, complement bit 5 of byte=20
-		 *  following CE, IrLAP p.114=20
+		/*
+		 *  Stuffed char, complement bit 5 of byte
+		 *  following CE, IrLAP p.114
 		 */
 		byte ^=3D IRDA_TRANS;
 		if (rx_buff->len < rx_buff->truesize)  {
@@ -324,15 +324,15 @@
  *    Handle bytes received within a frame
  *
  */
-static void state_inside_frame(struct net_device *dev,=20
+static void state_inside_frame(struct net_device *dev,
 			       struct net_device_stats *stats,
 			       iobuff_t *rx_buff, __u8 byte)
 {
-	int ret =3D 0;=20
+	int ret =3D 0;
=20
 	switch (byte) {
 	case BOF: /* New frame? */
-		IRDA_DEBUG(1, __FUNCTION__=20
+		IRDA_DEBUG(1, __FUNCTION__
 			   "(), Discarding incomplete frame\n");
 		rx_buff->state =3D BEGIN_FRAME;
 		irda_device_set_media_busy(dev, TRUE);
@@ -343,7 +343,7 @@
 	case EOF: /* End of frame */
 		rx_buff->state =3D OUTSIDE_FRAME;
 		rx_buff->in_frame =3D FALSE;
-	=09
+
 		/* Test FCS and signal success if the frame is good */
 		if (rx_buff->fcs =3D=3D GOOD_FCS) {
 			/* Deliver frame */
@@ -352,24 +352,22 @@
 			break;
 		} else {
 			/* Wrong CRC, discard frame!  */
-			irda_device_set_media_busy(dev, TRUE);=20
+			irda_device_set_media_busy(dev, TRUE);
=20
 			IRDA_DEBUG(1, __FUNCTION__ "(), crc error\n");
 			stats->rx_errors++;
 			stats->rx_crc_errors++;
-		}		=09
+		}
 		break;
 	default: /* Must be the next byte of the frame */
 		if (rx_buff->len < rx_buff->truesize)  {
 			rx_buff->data[rx_buff->len++] =3D byte;
 			rx_buff->fcs =3D irda_fcs(rx_buff->fcs, byte);
 		} else {
-			IRDA_DEBUG(1, __FUNCTION__=20
+			IRDA_DEBUG(1, __FUNCTION__
 			      "(), Rx buffer overflow, aborting\n");
 			rx_buff->state =3D OUTSIDE_FRAME;
 		}
 		break;
 	}
 }
-
-

--------------060106070308090309060403--

