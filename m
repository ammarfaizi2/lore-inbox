Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264266AbTFUXrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFUXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:47:11 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34792 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264266AbTFUXrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:47:02 -0400
Date: Sun, 22 Jun 2003 02:01:03 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Cc: trivial@rustcorp.com.au
Subject: [2.5 patch] fix three OSS u16 comparisons
Message-ID: <20030622000103.GK23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixed three OSS drivers that compared an u16 with 
0xFFFFFF ...

cu
Adrian

--- linux-2.5.72-mm2/sound/oss/ymfpci.c.old	2003-06-22 01:19:52.000000000 +0200
+++ linux-2.5.72-mm2/sound/oss/ymfpci.c	2003-06-22 01:20:12.000000000 +0200
@@ -2462,7 +2462,7 @@
 	}
 
 	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-	if (eid==0xFFFFFF) {
+	if (eid==0xFFFF) {
 		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
 		goto out_kfree;
 	}
--- linux-2.5.72-mm2/sound/oss/i810_audio.c.old	2003-06-22 01:20:41.000000000 +0200
+++ linux-2.5.72-mm2/sound/oss/i810_audio.c	2003-06-22 01:21:09.000000000 +0200
@@ -2922,7 +2922,7 @@
 		/* Don't attempt to get eid until powerup is complete */
 		eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
 
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "i810_audio: no codec attached ?\n");
 			kfree(codec);
--- linux-2.5.72-mm2/sound/oss/cs46xx.c.old	2003-06-22 01:22:06.000000000 +0200
+++ linux-2.5.72-mm2/sound/oss/cs46xx.c	2003-06-22 01:23:32.000000000 +0200
@@ -4269,7 +4269,7 @@
 
 		eid = cs_ac97_get(codec, AC97_EXTENDED_ID);
 		
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "cs46xx: codec %d not present\n",num_ac97);
 			kfree(codec);
