Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUIXFn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUIXFn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 01:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIXFn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 01:43:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:9187 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267974AbUIXFkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 01:40:18 -0400
Subject: [PATCH] ppc32: ADB keycode conversion update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1096004388.4011.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 15:39:48 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch makes the ADB->Linux keycodes conversion table a lot more
readable (and thus easy to fix :) and adds conversion of the laptop
Fn-enter (keypad enter, also present on apple laptop keyboards on the
bottom right, left of the arrow keys) to "compose" (or menu key on
modern PC keyboard).

Thanks to Frank Murphy <murphyf@f-m.fm> for spotting this keycode
feature of MacOS (and apple docs)

It also fixes a small possible race in the LED code

diff -urN linux-2.5/drivers/macintosh/adbhid.c linux-lappy/drivers/macintosh/adbhid.c
--- linux-2.5/drivers/macintosh/adbhid.c	2004-09-24 14:34:04.000000000 +1000
+++ linux-lappy/drivers/macintosh/adbhid.c	2004-09-24 14:44:53.000000000 +1000
@@ -74,15 +74,135 @@
 #define ADB_KEY_POWER_OLD	0x7e
 #define ADB_KEY_POWER		0x7f
 
-unsigned char adb_to_linux_keycodes[128] = {
-	 30, 31, 32, 33, 35, 34, 44, 45, 46, 47, 86, 48, 16, 17, 18, 19,
-	 21, 20,  2,  3,  4,  5,  7,  6, 13, 10,  8, 12,  9, 11, 27, 24,
-	 22, 26, 23, 25, 28, 38, 36, 40, 37, 39, 43, 51, 53, 49, 50, 52,
-	 15, 57, 41, 14, 96,  1, 29,125, 42, 58, 56,105,106,108,103,  0,
-	  0, 83,  0, 55,  0, 78,  0, 69,  0,  0,  0, 98, 96,  0, 74,  0,
-	  0,117, 82, 79, 80, 81, 75, 76, 77, 71,  0, 72, 73,124, 89,121,
-	 63, 64, 65, 61, 66, 67,123, 87,122, 99,  0, 70,  0, 68,101, 88,
-	  0,119,110,102,104,111, 62,107, 60,109, 59, 54,100, 97,126,116
+u8 adb_to_linux_keycodes[128] = {
+	/* 0x00 */ KEY_A, 		/*  30 */
+	/* 0x01 */ KEY_S, 		/*  31 */
+	/* 0x02 */ KEY_D,		/*  32 */
+	/* 0x03 */ KEY_F,		/*  33 */
+	/* 0x04 */ KEY_H,		/*  35 */
+	/* 0x05 */ KEY_G,		/*  34 */
+	/* 0x06 */ KEY_Z,		/*  44 */
+	/* 0x07 */ KEY_X,		/*  45 */
+	/* 0x08 */ KEY_C,		/*  46 */
+	/* 0x09 */ KEY_V,		/*  47 */
+	/* 0x0a */ KEY_102ND,		/*  86 */
+	/* 0x0b */ KEY_B,		/*  48 */
+	/* 0x0c */ KEY_Q,		/*  16 */
+	/* 0x0d */ KEY_W,		/*  17 */
+	/* 0x0e */ KEY_E,		/*  18 */
+	/* 0x0f */ KEY_R,		/*  19 */
+	/* 0x10 */ KEY_Y,		/*  21 */
+	/* 0x11 */ KEY_T,		/*  20 */
+	/* 0x12 */ KEY_1,		/*   2 */
+	/* 0x13 */ KEY_2,		/*   3 */
+	/* 0x14 */ KEY_3,		/*   4 */
+	/* 0x15 */ KEY_4,		/*   5 */
+	/* 0x16 */ KEY_6,		/*   7 */
+	/* 0x17 */ KEY_5,		/*   6 */
+	/* 0x18 */ KEY_EQUAL,		/*  13 */
+	/* 0x19 */ KEY_9,		/*  10 */
+	/* 0x1a */ KEY_7,		/*   8 */
+	/* 0x1b */ KEY_MINUS,		/*  12 */
+	/* 0x1c */ KEY_8,		/*   9 */
+	/* 0x1d */ KEY_0,		/*  11 */
+	/* 0x1e */ KEY_RIGHTBRACE,	/*  27 */
+	/* 0x1f */ KEY_O,		/*  24 */
+	/* 0x20 */ KEY_U,		/*  22 */
+	/* 0x21 */ KEY_LEFTBRACE,	/*  26 */
+	/* 0x22 */ KEY_I,		/*  23 */
+	/* 0x23 */ KEY_P,		/*  25 */
+	/* 0x24 */ KEY_ENTER,		/*  28 */
+	/* 0x25 */ KEY_L,		/*  38 */
+	/* 0x26 */ KEY_J,		/*  36 */
+	/* 0x27 */ KEY_APOSTROPHE,	/*  40 */
+	/* 0x28 */ KEY_K,		/*  37 */
+	/* 0x29 */ KEY_SEMICOLON,	/*  39 */
+	/* 0x2a */ KEY_BACKSLASH,	/*  43 */
+	/* 0x2b */ KEY_COMMA,		/*  51 */
+	/* 0x2c */ KEY_SLASH,		/*  53 */
+	/* 0x2d */ KEY_N,		/*  49 */
+	/* 0x2e */ KEY_M,		/*  50 */
+	/* 0x2f */ KEY_DOT,		/*  52 */
+	/* 0x30 */ KEY_TAB,		/*  15 */
+	/* 0x31 */ KEY_SPACE,		/*  57 */
+	/* 0x32 */ KEY_GRAVE,		/*  41 */
+	/* 0x33 */ KEY_BACKSPACE,	/*  14 */
+	/* 0x34 */ KEY_KPENTER,		/*  96 */
+	/* 0x35 */ KEY_ESC,		/*   1 */
+	/* 0x36 */ KEY_LEFTCTRL,	/*  29 */
+	/* 0x37 */ KEY_LEFTMETA,	/* 125 */
+	/* 0x38 */ KEY_LEFTSHIFT,	/*  42 */
+	/* 0x39 */ KEY_CAPSLOCK,	/*  58 */
+	/* 0x3a */ KEY_LEFTALT,		/*  56 */
+	/* 0x3b */ KEY_LEFT,		/* 105 */
+	/* 0x3c */ KEY_RIGHT,		/* 106 */
+	/* 0x3d */ KEY_DOWN,		/* 108 */
+	/* 0x3e */ KEY_UP,		/* 103 */
+	/* 0x3f */ 0,
+	/* 0x40 */ 0,
+	/* 0x41 */ KEY_KPDOT,		/*  83 */
+	/* 0x42 */ 0,
+	/* 0x43 */ KEY_KPASTERISK,	/*  55 */
+	/* 0x44 */ 0,
+	/* 0x45 */ KEY_KPPLUS,		/*  78 */
+	/* 0x46 */ 0,
+	/* 0x47 */ KEY_NUMLOCK,		/*  69 */
+	/* 0x48 */ 0,
+	/* 0x49 */ 0,
+	/* 0x4a */ 0,
+	/* 0x4b */ KEY_KPSLASH,		/*  98 */
+	/* 0x4c */ KEY_KPENTER,		/*  96 */
+	/* 0x4d */ 0,
+	/* 0x4e */ KEY_KPMINUS,		/*  74 */
+	/* 0x4f */ 0,
+	/* 0x50 */ 0,
+	/* 0x51 */ KEY_KPEQUAL,		/* 117 */
+	/* 0x52 */ KEY_KP0,		/*  82 */
+	/* 0x53 */ KEY_KP1,		/*  79 */
+	/* 0x54 */ KEY_KP2,		/*  80 */
+	/* 0x55 */ KEY_KP3,		/*  81 */
+	/* 0x56 */ KEY_KP4,		/*  75 */
+	/* 0x57 */ KEY_KP5,		/*  76 */
+	/* 0x58 */ KEY_KP6,		/*  77 */
+	/* 0x59 */ KEY_KP7,		/*  71 */
+	/* 0x5a */ 0,
+	/* 0x5b */ KEY_KP8,		/*  72 */
+	/* 0x5c */ KEY_KP9,		/*  73 */
+	/* 0x5d */ KEY_YEN,		/* 124 */
+	/* 0x5e */ KEY_RO,		/*  89 */
+	/* 0x5f */ KEY_KPCOMMA,		/* 121 */
+	/* 0x60 */ KEY_F5,		/*  63 */
+	/* 0x61 */ KEY_F6,		/*  64 */
+	/* 0x62 */ KEY_F7,		/*  65 */
+	/* 0x63 */ KEY_F3,		/*  61 */
+	/* 0x64 */ KEY_F8,		/*  66 */
+	/* 0x65 */ KEY_F9,		/*  67 */
+	/* 0x66 */ KEY_HANJA,		/* 123 */
+	/* 0x67 */ KEY_F11,		/*  87 */
+	/* 0x68 */ KEY_HANGUEL,		/* 122 */
+	/* 0x69 */ KEY_SYSRQ,		/*  99 */
+	/* 0x6a */ 0,
+	/* 0x6b */ KEY_SCROLLLOCK,	/*  70 */
+	/* 0x6c */ 0,
+	/* 0x6d */ KEY_F10,		/*  68 */
+	/* 0x6e */ KEY_COMPOSE,		/* 127 */
+	/* 0x6f */ KEY_F12,		/*  88 */
+	/* 0x70 */ 0,
+	/* 0x71 */ KEY_PAUSE,		/* 119 */
+	/* 0x72 */ KEY_INSERT,		/* 110 */
+	/* 0x73 */ KEY_HOME,		/* 102 */
+	/* 0x74 */ KEY_PAGEUP,		/* 104 */
+	/* 0x75 */ KEY_DELETE,		/* 111 */
+	/* 0x76 */ KEY_F4,		/*  62 */
+	/* 0x77 */ KEY_END,		/* 107 */
+	/* 0x78 */ KEY_F2,		/*  60 */
+	/* 0x79 */ KEY_PAGEDOWN,	/* 109 */
+	/* 0x7a */ KEY_F1,		/*  59 */
+	/* 0x7b */ KEY_RIGHTSHIFT,	/*  54 */
+	/* 0x7c */ KEY_RIGHTALT,	/* 100 */
+	/* 0x7d */ KEY_RIGHTCTRL,	/*  97 */
+	/* 0x7e */ KEY_RIGHTMETA,	/* 126 */
+	/* 0x7f */ KEY_POWER,		/* 116 */
 };
 
 struct adbhid {
@@ -453,7 +573,7 @@
 
 static void leds_done(struct adb_request *req)
 {
-	int leds, device;
+	int leds = 0, device = 0, pending = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&leds_lock, flags);
@@ -464,11 +584,11 @@
 		leds_pending[device] = 0;
 		pending_led_start++;
 		pending_led_start = (pending_led_start < 16) ? pending_led_start : 0;
+		pending = leds_req_pending;
 	} else
 		leds_req_pending = 0;
-
 	spin_unlock_irqrestore(&leds_lock, flags);
-	if (leds_req_pending)
+	if (pending)
 		adb_request(&led_request, leds_done, 0, 3,
 			    ADB_WRITEREG(device, KEYB_LEDREG), 0xff, ~leds);
 }


