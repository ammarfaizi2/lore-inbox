Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSLCUBR>; Tue, 3 Dec 2002 15:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSLCUBQ>; Tue, 3 Dec 2002 15:01:16 -0500
Received: from smtp0.libero.it ([193.70.192.33]:26832 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id <S265578AbSLCUBP>;
	Tue, 3 Dec 2002 15:01:15 -0500
From: Roby <robylit@inwind.it>
Reply-To: robylit@inwind.it
To: linux-kernel@vger.kernel.org
Subject: little bug in ac97_codec.c
Date: Tue, 3 Dec 2002 20:53:53 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_T97KH0660IM31577OYAG"
Message-Id: <200212032053.53526.robylit@inwind.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_T97KH0660IM31577OYAG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I discovered a little bug into the file drivers/sound/ac97_codec.c

It only affects the display of the PnP hexadecimal string of the codec, d=
uring=20
the boot.

The function codec_id(...) has simply a nonsense code. I think someone=20
forgotten to complete it.
Anyhow, here is my patch.
If it is ok for the developers, good, otherwise I will use it onluy on my=
=20
system.

--=20
Roby

email
robylit@inwind.it
robylit@tiscali.it

WEB Page
http://robylit.risorse.com
http://web.tiscalinet.it/robylit

--------------Boundary-00=_T97KH0660IM31577OYAG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ac97_codec.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ac97_codec.diff"

--- drivers/sound/ac97_codec.orig	2002-11-29 00:53:14.000000000 +0100
+++ drivers/sound/ac97_codec.c	2002-12-03 20:33:13.000000000 +0100
@@ -657,7 +657,7 @@
  *	codec_id	-  Turn id1/id2 into a PnP string
  *	@id1: Vendor ID1
  *	@id2: Vendor ID2
- *	@buf: 10 byte buffer
+ *	@buf: 14 byte buffer
  *
  *	Fills buf with a zero terminated PnP ident string for the id1/id2
  *	pair. For convenience the return is the passed in buffer pointer.
@@ -665,13 +665,9 @@
  
 static char *codec_id(u16 id1, u16 id2, char *buf)
 {
-	if(id1&0x8080)
-		snprintf(buf, 10, "%0x4X:%0x4X", id1, id2);
-	buf[0] = (id1 >> 8);
-	buf[1] = (id1 & 0xFF);
-	buf[2] = (id2 >> 8);
-	snprintf(buf+3, 7, "%d", id2&0xFF);
-	return buf;
+    snprintf(buf, 14, "0x%04X:0x%04X", id1, id2);
+     
+    return buf;
 }
  
 /**
@@ -702,7 +698,7 @@
 	u16 id1, id2;
 	u16 audio, modem;
 	int i;
-	char cidbuf[10];
+	char cidbuf[14];
 
 	/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00 (reset) should 
 	 * be read zero.

--------------Boundary-00=_T97KH0660IM31577OYAG--


