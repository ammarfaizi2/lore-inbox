Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDMNDs>; Fri, 13 Apr 2001 09:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130768AbRDMNDi>; Fri, 13 Apr 2001 09:03:38 -0400
Received: from napalm.go.cz ([212.24.148.98]:3332 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S130552AbRDMNDX>;
	Fri, 13 Apr 2001 09:03:23 -0400
Date: Fri, 13 Apr 2001 15:02:19 +0200
From: Jan Dvorak <johnydog@go.cz>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Unisys pc keyboard new keys patch, kernel 2.4.3
Message-ID: <20010413150219.A440@napalm.go.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Organization: (XNET.cz)
X-URL: http://doga.go.cz/
X-OS: Linux 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

i recently met with a new (Unisys) keyboard, which have (among 'normal'
windows keys) 3 more keys on top of arrows, labeled by pictures as
halfsun, halfmoon, and power switch. Following patch adds 'support' for them
(or at least gets rid of 'unknown scancode' messages), but beacuse i am
new to kernl programming, i don't know if it is the right approach. If it'll
be OK, it should apply to drivers/char/q40_keyb.c, drivers/sbus/char/sunkbd.c
and drivers/sbus/char/pcikbd.c as well. I found no maintainer of charaacter
devices/keyboards/input, so i am posting here.

Jan Dvorak <johnydog@go.cz>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="unikey.patch"

--- linux/drivers/char/pc_keyb.c.orig	Mon Apr  9 13:58:31 2001
+++ linux/drivers/char/pc_keyb.c	Fri Apr 13 13:34:05 2001
@@ -224,6 +224,15 @@
 #define E0_MSRW	126
 #define E0_MSTM	127
 
+/*
+ * Another new microsoft (Unikey) keyboard seems to have just another
+ * three keys: e0 63 (half- or rising- sun), e0 5f (halfmoon) 
+ * and e0 5e (power button?)
+ */
+#define E0_MSPOWER	128
+#define E0_MSHALFMOON	129
+#define E0_MSHALFSUN	130
+
 static unsigned char e0_keys[128] = {
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x00-0x07 */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x08-0x0f */
@@ -236,8 +245,8 @@
   E0_DO, E0_F17, 0, 0, 0, 0, E0_BREAK, E0_HOME,	      /* 0x40-0x47 */
   E0_UP, E0_PGUP, 0, E0_LEFT, E0_OK, E0_RIGHT, E0_KPMINPLUS, E0_END,/* 0x48-0x4f */
   E0_DOWN, E0_PGDN, E0_INS, E0_DEL, 0, 0, 0, 0,	      /* 0x50-0x57 */
-  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, 0, 0,	      /* 0x58-0x5f */
-  0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x60-0x67 */
+  0, 0, 0, E0_MSLW, E0_MSRW, E0_MSTM, E0_MSPOWER, E0_MSHALFMOON,/* 0x58-0x5f */
+  0, 0, 0, E0_MSHALFSUN, 0, 0, 0, 0,		      /* 0x60-0x67 */
   0, 0, 0, 0, 0, 0, 0, E0_MACRO,		      /* 0x68-0x6f */
   0, 0, 0, 0, 0, 0, 0, 0,			      /* 0x70-0x77 */
   0, 0, 0, 0, 0, 0, 0, 0			      /* 0x78-0x7f */

--liOOAslEiF7prFVr--
