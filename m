Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVCHKpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVCHKpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 05:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261971AbVCHKpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 05:45:38 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:10987 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261982AbVCHKpP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 05:45:15 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 8 Mar 2005 11:44:55 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: bttv IR driver update
Message-ID: <20050308104455.GA30713@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

minor bttv IR driver update: drop a keytable and use the one in
ir-common.ko instead.

This patch depends on the ir-common update.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/ir-kbd-gpio.c |   51 +-----------------------------
 1 files changed, 3 insertions(+), 48 deletions(-)

diff -u linux-2.6.11/drivers/media/video/ir-kbd-gpio.c linux/drivers/media/video/ir-kbd-gpio.c
--- linux-2.6.11/drivers/media/video/ir-kbd-gpio.c	2005-03-07 10:14:58.000000000 +0100
+++ linux/drivers/media/video/ir-kbd-gpio.c	2005-03-07 15:19:06.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * $Id: ir-kbd-gpio.c,v 1.11 2004/10/25 11:26:36 kraxel Exp $
+ * $Id: ir-kbd-gpio.c,v 1.12 2005/02/22 12:28:40 kraxel Exp $
  *
  * Copyright (c) 2003 Gerd Knorr
  * Copyright (c) 2003 Pavel Machek
@@ -114,51 +114,6 @@
 	[ 0x3e ] = KEY_VOLUMEUP,    // 'volume +'
 };
 
-static IR_KEYTAB_TYPE winfast_codes[IR_KEYTAB_SIZE] = {
-	[  5 ] = KEY_KP1,
-	[  6 ] = KEY_KP2,
-	[  7 ] = KEY_KP3,
-	[  9 ] = KEY_KP4,
-	[ 10 ] = KEY_KP5,
-	[ 11 ] = KEY_KP6,
-	[ 13 ] = KEY_KP7,
-	[ 14 ] = KEY_KP8,
-	[ 15 ] = KEY_KP9,
-	[ 18 ] = KEY_KP0,
-
-	[  0 ] = KEY_POWER,
-//      [ 27 ] = MTS button
-	[  2 ] = KEY_TUNER,     // TV/FM
-	[ 30 ] = KEY_VIDEO,
-//      [ 22 ] = display button
-	[  4 ] = KEY_VOLUMEUP,
-	[  8 ] = KEY_VOLUMEDOWN,
-	[ 12 ] = KEY_CHANNELUP,
-	[ 16 ] = KEY_CHANNELDOWN,
-	[  3 ] = KEY_ZOOM,      // fullscreen
-	[ 31 ] = KEY_SUBTITLE,  // closed caption/teletext
-	[ 32 ] = KEY_SLEEP,
-//      [ 41 ] = boss key
-	[ 20 ] = KEY_MUTE,
-	[ 43 ] = KEY_RED,
-	[ 44 ] = KEY_GREEN,
-	[ 45 ] = KEY_YELLOW,
-	[ 46 ] = KEY_BLUE,
-	[ 24 ] = KEY_KPPLUS,    //fine tune +
-	[ 25 ] = KEY_KPMINUS,   //fine tune -
-//      [ 42 ] = picture in picture
-        [ 33 ] = KEY_KPDOT,
-	[ 19 ] = KEY_KPENTER,
-//      [ 17 ] = recall
-	[ 34 ] = KEY_BACK,
-	[ 35 ] = KEY_PLAYPAUSE,
-	[ 36 ] = KEY_NEXT,
-//      [ 37 ] = time shifting
-	[ 38 ] = KEY_STOP,
-	[ 39 ] = KEY_RECORD
-//      [ 40 ] = snapshot
-};
-
 static IR_KEYTAB_TYPE ir_codes_pixelview[IR_KEYTAB_SIZE] = {
 	[  2 ] = KEY_KP0,
 	[  1 ] = KEY_KP1,
@@ -388,12 +343,12 @@
                 break;
 
 	case BTTV_WINFAST2000:
-		ir_codes         = winfast_codes;
+		ir_codes         = ir_codes_winfast;
 		ir->mask_keycode = 0x1f8;
 		break;
 	case BTTV_MAGICTVIEW061:
 	case BTTV_MAGICTVIEW063:
-		ir_codes         = winfast_codes;
+		ir_codes         = ir_codes_winfast;
 		ir->mask_keycode = 0x0008e000;
 		ir->mask_keydown = 0x00200000;
 		break;

-- 
#define printk(args...) fprintf(stderr, ## args)
