Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268145AbTBMXue>; Thu, 13 Feb 2003 18:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTBMXud>; Thu, 13 Feb 2003 18:50:33 -0500
Received: from fepB.post.tele.dk ([195.41.46.145]:28155 "EHLO
	fepB.post.tele.dk") by vger.kernel.org with ESMTP
	id <S268145AbTBMXuc>; Thu, 13 Feb 2003 18:50:32 -0500
Message-ID: <000e01c2d3bb$be3c1970$0b00a8c0@runner>
From: "Rune" <runner@mail.tele.dk>
To: <linux-kernel@vger.kernel.org>, <ollie@sis.com.tw>
Subject: [fix 2.5] fix sis900 <-> Crossfire 8720 (switch) auto-negotiation, please test 
Date: Fri, 14 Feb 2003 00:58:01 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C2D3C4.1F892E90"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C2D3C4.1F892E90
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,
by accident I discovered a fix for auto-negotiation on the sis-900.

in sis900_open(), sis900_check_mode() looks redundant, and when removing it
auto-negotiation works for sis900 and Crossfire 8720 (perhaps others).

I have tested it, but I have no ideas if there is any side effects,
so please test this on non-Crossfire setups.

the patch is made against 2.5.60-bk2 but this code havent changed for a long
time.
for some reason this has no effect on kernel 2.4...

Rune Petersen

------=_NextPart_000_000B_01C2D3C4.1F892E90
Content-Type: application/octet-stream;
	name="sis900.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sis900.diff"

--- sis900.c.orig	2003-02-14 05:52:06.000000000 +0100=0A=
+++ sis900.c	2003-02-14 06:16:29.000000000 +0100=0A=
@@ -937,8 +937,6 @@=0A=
 	outl(RxENA | inl(ioaddr + cr), ioaddr + cr);=0A=
 	outl(IE, ioaddr + ier);=0A=
 =0A=
-	sis900_check_mode(net_dev, sis_priv->mii);=0A=
-=0A=
 	/* Set the timer to switch to check for link beat and perhaps switch=0A=
 	   to an alternate media type. */=0A=
 	init_timer(&sis_priv->timer);=0A=

------=_NextPart_000_000B_01C2D3C4.1F892E90--

