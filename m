Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVBFQNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVBFQNB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 11:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVBFQMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 11:12:53 -0500
Received: from 1-1-3-46a.gml.gbg.bostream.se ([82.182.110.161]:31186 "EHLO
	kotiaho.net") by vger.kernel.org with ESMTP id S261197AbVBFQMf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 11:12:35 -0500
Date: Sun, 6 Feb 2005 17:15:16 +0100 (CET)
From: "J.O. Aho" <trizt@iname.com>
X-X-Sender: trizt@linux.local.lan
To: linux-kernel@vger.kernel.org
Subject: Map Hauppauge PVR250/350 remote buttons right in ir-kbd-i2c
Message-ID: <Pine.LNX.4.61.0502061713030.32320@linux.local.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Version: 2.6.10
Description: This patch fixes the buttons mapping for the Hauppauge
   PVR 250/350 remotes (at least those sold in Sweden),
   all buttons are now bound.
Fixes: All buttons are bound to a key
   Mute button works now as mute on/off
Notes: I'm not part of the maillist, so CC me if you want me to know
   something.


--- drivers/media/video/ir-kbd-i2c.c.org 2005-02-06 16:02:52.793914120 +0100
+++ drivers/media/video/ir-kbd-i2c.c 2005-02-06 16:39:16.376959040 +0100
@@ -43,6 +43,51 @@

  #include <media/ir-common.h>

+/*  J.O. Aho <trizt@iname.com>
+ *  The ir_codes_rc5_tv causes that keys are wrongly
+ *  mapped on for the Hauppauge PVR 250/350 remotes,
+ *  at least those sold in Sweden.
+ *  The ATI-REMOTE keybindings has been used as
+ *  guidelines.
+ */
+static IR_KEYTAB_TYPE ir_codes_pvr[IR_KEYTAB_SIZE] = {
+	[ 0x00 ] = KEY_KP0,             // 0
+	[ 0x01 ] = KEY_KP1,             // 1
+	[ 0x02 ] = KEY_KP2,             // 2
+	[ 0x03 ] = KEY_KP3,             // 3
+	[ 0x04 ] = KEY_KP4,             // 4
+	[ 0x05 ] = KEY_KP5,             // 5
+	[ 0x06 ] = KEY_KP6,             // 6
+	[ 0x07 ] = KEY_KP7,             // 7
+	[ 0x08 ] = KEY_KP8,             // 8
+	[ 0x09 ] = KEY_KP9,             // 9
+
+	[ 0x0b ] = KEY_R,               // Red Button
+	[ 0x0c ] = KEY_REFRESH,         // Unmarked button on PVR250
+	[ 0x0f ] = KEY_MUTE,            // mute / demute
+	[ 0x0d ] = KEY_MENU,            // display, PVR Menu
+	[ 0x10 ] = KEY_VOLUMEUP,        // volume +
+	[ 0x11 ] = KEY_VOLUMEDOWN,      // volume -
+	[ 0x1e ] = KEY_NEXTSONG,        // Next >>|
+	[ 0x1f ] = KEY_BACKSPACE,       // PVR Back/Exit
+	[ 0x20 ] = KEY_UP,              // channel / program +
+	[ 0x21 ] = KEY_DOWN,            // channel / program -
+	[ 0x24 ] = KEY_PREVIOUSSONG,    // Previous |<<
+	[ 0x25 ] = KEY_ENTER,           // PVR Ok
+	[ 0x29 ] = KEY_B,               // Blue Button
+	[ 0x2e ] = KEY_G,               // Green Button
+	[ 0x30 ] = KEY_PAUSE,           // pause
+	[ 0x32 ] = KEY_REWIND,          // rewind <<
+	[ 0x34 ] = KEY_FORWARD,         // wind >>
+	[ 0x35 ] = KEY_PLAYPAUSE,       // play
+	[ 0x36 ] = KEY_STOP,            // stop
+	[ 0x37 ] = KEY_RECORD,          // recording
+	[ 0x38 ] = KEY_Y,               // Yellow button
+	[ 0x3b ] = KEY_GOTO,            // Go button
+	[ 0x3c ] = KEY_FRONT,           // full
+	[ 0x3d ] = KEY_POWER,           // power (green, left upper corner)
+};
+
  /* Mark Phalan <phalanm@o2.ie> */
  static IR_KEYTAB_TYPE ir_codes_pv951[IR_KEYTAB_SIZE] = {
  	[  0 ] = KEY_KP0,
@@ -362,6 +407,11 @@
  ir_codes    = ir_codes_pv951;
  break;
  	case 0x18:
+		name        = "Hauppauge PVR";
+		ir->get_key = get_key_haup;
+		ir_type     = IR_TYPE_RC5;
+		ir_codes    = ir_codes_pvr;
+		break;
  case 0x1a:
  name        = "Hauppauge";
  ir->get_key = get_key_haup;

