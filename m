Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUDEMVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 08:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262325AbUDEMVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 08:21:12 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:37794 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262248AbUDEMU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 08:20:29 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Apr 2004 14:23:31 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] v4l: add support for pv951 remote to ir-kbd-i2c
Message-ID: <20040405122331.GA30038@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

Trivial patch, $subject says all, just a new keytable.

  Gerd

diff -up linux-2.6.5/drivers/media/video/ir-kbd-i2c.c linux/drivers/media/video/ir-kbd-i2c.c
--- linux-2.6.5/drivers/media/video/ir-kbd-i2c.c	2004-04-05 10:38:38.000000000 +0200
+++ linux/drivers/media/video/ir-kbd-i2c.c	2004-04-05 10:49:58.309206520 +0200
@@ -41,6 +41,44 @@
 
 #include <media/ir-common.h>
 
+/* Mark Phalan <phalanm@o2.ie> */
+static IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE] = {
+	[  0 ] = KEY_KP0, 
+	[  1 ] = KEY_KP1, 
+	[  2 ] = KEY_KP2, 
+	[  3 ] = KEY_KP3, 
+	[  4 ] = KEY_KP4, 
+	[  5 ] = KEY_KP5, 
+	[  6 ] = KEY_KP6, 
+	[  7 ] = KEY_KP7, 
+	[  8 ] = KEY_KP8, 
+	[  9 ] = KEY_KP9, 
+
+	[ 18 ] = KEY_POWER, 
+	[ 16 ] = KEY_MUTE, 
+	[ 31 ] = KEY_VOLUMEDOWN, 
+	[ 27 ] = KEY_VOLUMEUP, 
+	[ 26 ] = KEY_CHANNELUP,
+	[ 30 ] = KEY_CHANNELDOWN,
+	[ 14 ] = KEY_PAGEUP,
+	[ 29 ] = KEY_PAGEDOWN,	
+	[ 19 ] = KEY_SOUND, 
+
+	[ 24 ] = KEY_KPPLUSMINUS,	// CH +/-
+	[ 22 ] = KEY_SUBTITLE,		// CC
+	[ 13 ] = KEY_TEXT,		// TTX
+	[ 11 ] = KEY_TV,		// AIR/CBL
+	[ 17 ] = KEY_PC,		// PC/TV
+	[ 23 ] = KEY_OK,		// CH RTN
+	[ 25 ] = KEY_MODE, 		// FUNC
+	[ 12 ] = KEY_SEARCH, 		// AUTOSCAN
+
+	/* Not sure what to do with these ones! */
+	[ 15 ] = KEY_SELECT, 		// SOURCE
+	[ 10 ] = KEY_KPPLUS,		// +100  
+	[ 20 ] = KEY_KPEQUAL,		// SYNC
+};
+
 struct IR;
 struct IR {
 	struct i2c_client      c;
@@ -247,7 +285,7 @@ static int ir_attach(struct i2c_adapter 
 		name        = "PV951";
 		ir->get_key = get_key_pv951;
 		ir_type     = IR_TYPE_OTHER;
-		ir_codes    = ir_codes_empty;
+		ir_codes    = ir_codes_pv951;
 		break;
 	case 0x18:
 	case 0x1a:

-- 
http://bigendian.bytesex.org
