Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTLOGJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbTLOGIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:08:52 -0500
Received: from dp.samba.org ([66.70.73.150]:58300 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263269AbTLOGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] More MODULE_ALIASes
Date: Mon, 15 Dec 2003 11:47:46 +1100
Message-Id: <20031215060838.A08CD2C18C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Three more MODULE_ALIASes.  Trivial, but useful if people want things
to "just work" in 2.6.0.

If you drop this I'll just keep collecting them.

Cheers,
Rusty.

Name: Aliases for Character Devices
Author: Steve Youngs, Stephen Hemminger
Status: Trivial

D: Add more MODULE_ALIASes where required.

diff -urN -X dontdiff linux-2.6.0-test11/sound/core/sound.c linux-2.6.0-test11-sy/sound/core/sound.c
--- linux-2.6.0-test11/sound/core/sound.c	2003-11-27 11:02:48.000000000 +1000
+++ linux-2.6.0-test11-sy/sound/core/sound.c	2003-11-28 10:40:27.000000000 +1000
@@ -31,6 +31,7 @@
 #include <sound/initval.h>
 #include <linux/kmod.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #define SNDRV_OS_MINORS 256
 
@@ -52,6 +54,7 @@
 MODULE_PARM(cards_limit, "i");
 MODULE_PARM_DESC(cards_limit, "Count of soundcards installed in the system.");
 MODULE_PARM_SYNTAX(cards_limit, "default:8,skill:advanced");
+MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
 #ifdef CONFIG_DEVFS_FS
 MODULE_PARM(device_mode, "i");
 MODULE_PARM_DESC(device_mode, "Device file permission mask for devfs.");
diff -urN -X dontdiff linux-2.6.0-test11/sound/sound_core.c linux-2.6.0-test11-sy/sound/sound_core.c
--- linux-2.6.0-test11/sound/sound_core.c	2003-11-27 11:01:58.000000000 +1000
+++ linux-2.6.0-test11-sy/sound/sound_core.c	2003-11-28 10:39:46.000000000 +1000
@@ -45,6 +45,7 @@
 #include <linux/major.h>
 #include <linux/kmod.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #define SOUND_STEP 16
 
@@ -547,6 +548,7 @@
 MODULE_DESCRIPTION("Core sound module");
 MODULE_AUTHOR("Alan Cox");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_CHARDEV_MAJOR(SOUND_MAJOR);
 
 static void __exit cleanup_soundcore(void)
 {
diff -Nru a/drivers/net/pppoe.c b/drivers/net/pppoe.c
--- a/drivers/net/pppoe.c	Wed Dec 10 10:20:36 2003
+++ b/drivers/net/pppoe.c	Wed Dec 10 10:20:36 2003
@@ -1151,3 +1151,4 @@
 MODULE_AUTHOR("Michal Ostrowski <mostrows@speakeasy.net>");
 MODULE_DESCRIPTION("PPP over Ethernet driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NETPROTO(PF_PPPOX);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
