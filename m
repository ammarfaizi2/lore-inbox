Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbSLHX1V>; Sun, 8 Dec 2002 18:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbSLHX1V>; Sun, 8 Dec 2002 18:27:21 -0500
Received: from p0015.as-l043.contactel.cz ([194.108.242.15]:17136 "EHLO
	SnowWhite.janik.cz") by vger.kernel.org with ESMTP
	id <S261857AbSLHX1S> convert rfc822-to-8bit; Sun, 8 Dec 2002 18:27:18 -0500
To: linux-kernel@vger.kernel.org
Subject: PATCH: Four function buttons on DELL Latitude X200
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Mon, 09 Dec 2002 00:35:42 +0100
Message-ID: <m3d6ocjd81.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch add support for four functions key on DELL Latitude X200.

--- pc_keyb.c.orig	2002-12-07 18:03:00.000000000 +0100
+++ pc_keyb.c	2002-12-07 18:37:04.000000000 +0100
@@ -214,6 +214,23 @@
 #define E0_DO      116
 #define E0_F17     117
 #define E0_KPMINPLUS 118
+
+/*
+ * DELL Latitude X200
+ *
+ * The keyboard of DELL Latitude has one special key - `i' button and
+ * three Function keys: End, Page Up and Page Down.
+ *
+ */
+
+/* The `i' button in the top-right corner */
+#define E0_I      120
+
+/* Function key + {End, Page Up, Page Down} */
+#define E0_FN_END    121
+#define E0_FN_PGUP   122
+#define E0_FN_PGDOWN 123
+
 /*
  * My OmniKey generates e0 4c for  the "OMNI" key and the
  * right alt key does nada. [kkoller@nyx10.cs.du.edu]
@@ -230,13 +247,13 @@
 #define E0_MSTM	127
 
 static unsigned char e0_keys[128] = {
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
+  0, E0_I, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x10-0x17 */
   0, 0, 0, 0, E0_KPENTER, E0_RCTRL, 0, 0,	      /* 0x18-0x1f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x20-0x27 */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x28-0x2f */
-  0, 0, 0, 0, 0, E0_KPSLASH, 0, E0_PRSCR,	      /* 0x30-0x37 */
+  E0_FN_END, 0, 0, 0, 0, 0, 0, 0,			      /* 0x20-0x27 */
+  0, 0, 0, 0, 0, 0, E0_FN_PGDOWN, 0,			      /* 0x28-0x2f */
+  E0_FN_PGUP, 0, 0, 0, 0, E0_KPSLASH, 0, E0_PRSCR,	      /* 0x30-0x37 */
   E0_RALT, 0, 0, 0, 0, E0_F13, E0_F14, E0_HELP,	      /* 0x38-0x3f */
   E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
   E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x48-0x4f */


If you want to use it, loadkeys something like this:


#
# This is the supplemental keymap for DELL Latitude X200 keyboard.
#

# (c) 2002, Pavel Janík <Pavel@Janik.cz>

#
# Dell Latitude X200 has four additional keys with the following scancodes:
#
# - e0 01: `i' button in the top-right corner
# - e0 20: Fn + End
# - e0 30: Fn + Page Up
# - e0 2e: Fn + Page Down
#

keycode 120 = F120
keycode 121 = F121
keycode 122 = F122
keycode 123 = F123

string F120 = "#Dell `i' button pressed - please edit dell_latitude_X200.map\n"
string F121 = "#Dell Fn+End pressed - please edit dell_latitude_X200.map\n"
string F122 = "#Dell Fn+Page Up pressed - please edit dell_latitude_X200.map\n"
string F123 = "#Dell Fn+Page Down pressed - please edit dell_latitude_X200.map\n"

-- 
Pavel Janík

Document your data layouts.
                  --  The Elements of Programming Style (Kernighan & Plaugher)
