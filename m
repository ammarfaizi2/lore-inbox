Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264960AbTGKSXb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTGKSWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:22:45 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18308
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264957AbTGKSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:01:39 -0400
Date: Fri, 11 Jul 2003 19:15:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111815.h6BIFQET017362@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: switch maestro3 to new ac97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/sound/oss/maestro3.c linux-2.5.75-ac1/sound/oss/maestro3.c
--- linux-2.5.75/sound/oss/maestro3.c	2003-07-10 21:14:15.000000000 +0100
+++ linux-2.5.75-ac1/sound/oss/maestro3.c	2003-07-11 16:47:14.000000000 +0100
@@ -2301,9 +2301,8 @@
 {
     struct ac97_codec *codec;
 
-    if ((codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL)) == NULL)
+    if ((codec = ac97_alloc_codec()) == NULL)
         return -ENOMEM;
-    memset(codec, 0, sizeof(struct ac97_codec));
 
     codec->private_data = card;
     codec->codec_read = m3_ac97_read;
@@ -2313,13 +2312,13 @@
 
     if (ac97_probe_codec(codec) == 0) {
         printk(KERN_ERR PFX "codec probe failed\n");
-        kfree(codec);
+        ac97_release_codec(codec);
         return -1;
     }
 
     if ((codec->dev_mixer = register_sound_mixer(&m3_mixer_fops, -1)) < 0) {
         printk(KERN_ERR PFX "couldn't register mixer!\n");
-        kfree(codec);
+        ac97_release_codec(codec);
         return -1;
     }
 
