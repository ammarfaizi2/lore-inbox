Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264402AbTCXUeX>; Mon, 24 Mar 2003 15:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264405AbTCXUeX>; Mon, 24 Mar 2003 15:34:23 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:21129 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264402AbTCXUeV>; Mon, 24 Mar 2003 15:34:21 -0500
Message-Id: <200303242045.h2OKjX35023101@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 20:45:19 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: guard mad16 debug macro.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still pretty ugly debug macro, but this at least
makes it do the right thing when used in if/else blocks

Fix from Joe Perches <joe@perches.com>

--- sound/oss/mad16.c.old	2003-03-24 09:31:49.000000000 -0800
+++ sound/oss/mad16.c	2003-03-24 09:39:14.000000000 -0800
@@ -99,7 +99,7 @@
 #ifdef DDB
 #undef DDB
 #endif
-#define DDB(x) {if (debug) x;}
+#define DDB(x) do {if (debug) x;} while (0)
 
 static unsigned char mad_read(int port)
 {
@@ -278,7 +278,8 @@
 	}
 	for (i = 0xf8d; i <= 0xf98; i++)
 		if (!c924pnp)
-			DDB(printk("Port %0x (init value) = %0x\n", i, mad_read(i))) else
+			DDB(printk("Port %0x (init value) = %0x\n", i, mad_read(i)));
+		else
 			DDB(printk("Port %0x (init value) = %0x\n", i-0x80, mad_read(i)));
 
 	if (board_type == C930)
--- sound/oss/sound_config.h.old	2003-02-17 14:55:56.000000000 -0800
+++ sound/oss/sound_config.h	2003-03-24 09:36:09.000000000 -0800
@@ -137,7 +137,7 @@
 #endif
 
 #ifndef DDB
-#define DDB(x) {}
+#define DDB(x) do {} while (0)
 #endif
 
 #ifndef MDB


