Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265681AbSL3TdO>; Mon, 30 Dec 2002 14:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265727AbSL3TdO>; Mon, 30 Dec 2002 14:33:14 -0500
Received: from ra.abo.fi ([130.232.213.1]:14485 "EHLO ra.abo.fi")
	by vger.kernel.org with ESMTP id <S265681AbSL3TdN>;
	Mon, 30 Dec 2002 14:33:13 -0500
Date: Mon, 30 Dec 2002 21:41:30 +0200 (EET)
From: Marcus Alanen <maalanen@ra.abo.fi>
To: trivial@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Subject: [patch, 2.5] move snd_legacy_find_free_ioport to opti92x-ad1848.c
Message-ID: <Pine.LNX.4.44.0212302140130.30703-100000@tuxedo.abo.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moves the snd_legacy_find_free_ioport definition to opti92x-ad1848.c, 
since it is the only user.

#
# create_patch: move_snd_legacy_find_free_ioport-2002-12-30-A.patch
# Date: Mon Dec 30 21:13:59 EET 2002
#
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.53/include/sound/initval.h initval-2.5.53/include/sound/initval.h
--- linus-2.5.53/include/sound/initval.h	Fri Dec 27 00:04:28 2002
+++ initval-2.5.53/include/sound/initval.h	Mon Dec 30 19:11:42 2002
@@ -97,18 +97,6 @@
 }
 #endif
 
-#ifdef SNDRV_LEGACY_FIND_FREE_IOPORT
-static long snd_legacy_find_free_ioport(long *port_table, long size)
-{
-	while (*port_table != -1) {
-		if (!check_region(*port_table, size))
-			return *port_table;
-		port_table++;
-	}
-	return -1;
-}
-#endif
-
 #ifdef SNDRV_LEGACY_FIND_FREE_IRQ
 #include <linux/interrupt.h>
 
diff -Naurd --exclude-from=/home/maalanen/linux/base/diff_exclude linus-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c initval-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c
--- linus-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Thu Oct 31 20:24:38 2002
+++ initval-2.5.53/sound/isa/opti9xx/opti92x-ad1848.c	Mon Dec 30 19:13:17 2002
@@ -47,7 +47,6 @@
 #endif	/* CS4231 */
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
-#define SNDRV_LEGACY_FIND_FREE_IOPORT
 #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #define SNDRV_GET_ID
@@ -323,6 +322,16 @@
 	"82C930",	"82C931",	"82C933"
 };
 
+
+static long snd_legacy_find_free_ioport(long *port_table, long size)
+{
+	while (*port_table != -1) {
+		if (!check_region(*port_table, size))
+			return *port_table;
+		port_table++;
+	}
+	return -1;
+}
 
 static int __init snd_opti9xx_init(opti9xx_t *chip, unsigned short hardware)
 {

