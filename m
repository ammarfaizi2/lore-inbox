Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWE1Opo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWE1Opo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 10:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWE1Opo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 10:45:44 -0400
Received: from mx2.go2.pl ([193.17.41.42]:4331 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1750771AbWE1Opn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 10:45:43 -0400
From: Zbigniew Luszpinski <zbiggy@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: [Patch] Logitech TrackMan trackball - unknown device
Date: Sun, 28 May 2006 16:46:05 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tebeE/IBSM/kxrj"
Message-Id: <200605281646.05765.zbiggy@o2.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_tebeE/IBSM/kxrj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

When I connect to my linux 2.6.16.18 box a Logitech TrackMan trackball the 
kernel welcomes me with message:

logips2pp: Detected unknown logitech mouse model 79
input: ImExPS/2 Logitech Explorer Mouse as /class/input/input1

My patch makes TrackMan known for kernel 2.6.16.18. Other recent kernels 
should work with this patch too. After applying patch kenel 2.6.16.18 says:

input: PS2++ Logitech TrackMan Whell as /class/input/input1

have a nice day,
Zbigniew 'zbiggy' Luszpinski

--Boundary-00=_tebeE/IBSM/kxrj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="logips2pp.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="logips2pp.c.patch"

--- linux-2.6.16.18/drivers/input/mouse/logips2pp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6.16.18/drivers/input/mouse/logips2pp.c	2006-05-27 20:35:26.000000000 +0200
@@ -19,6 +19,7 @@
 #define PS2PP_KIND_WHEEL	1
 #define PS2PP_KIND_MX		2
 #define PS2PP_KIND_TP3		3
+#define PS2PP_KIND_TBW		4
 
 /* Logitech mouse features */
 #define PS2PP_WHEEL		0x01
@@ -223,6 +224,7 @@
 		{ 73,	0,			PS2PP_SIDE_BTN },
 		{ 75,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 76,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
+		{ 79,	PS2PP_KIND_TBW,		PS2PP_WHEEL }, /* Trackball with wheel */
 		{ 80,	PS2PP_KIND_WHEEL,	PS2PP_SIDE_BTN | PS2PP_WHEEL },
 		{ 81,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
 		{ 83,	PS2PP_KIND_WHEEL,	PS2PP_WHEEL },
@@ -298,6 +300,10 @@
 			psmouse->name = "TouchPad 3";
 			break;
 
+		case PS2PP_KIND_TBW:
+			psmouse->name = "TrackMan Wheel";
+			break;
+
 		default:
 			/*
 			 * Set name to "Mouse" only when using PS2++,

--Boundary-00=_tebeE/IBSM/kxrj--
