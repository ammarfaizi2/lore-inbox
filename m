Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264235AbTFUX70 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 19:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTFUX70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 19:59:26 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:25064 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264235AbTFUX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 19:59:24 -0400
Date: Sun, 22 Jun 2003 02:13:26 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.4 patch] fix four OSS u16 comparisons
Message-ID: <20030622001326.GN23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixees four OSS drivers that compared an u16 with
0xFFFFFF ...

cu
Adrian

--- linux-2.4.22-pre1-full/drivers/sound/ymfpci.c.old	2003-06-22 02:07:21.000000000 +0200
+++ linux-2.4.22-pre1-full/drivers/sound/ymfpci.c	2003-06-22 02:07:44.000000000 +0200
@@ -2460,7 +2460,7 @@
 	}
 
 	eid = ymfpci_codec_read(codec, AC97_EXTENDED_ID);
-	if (eid==0xFFFFFF) {
+	if (eid==0xFFFF) {
 		printk(KERN_WARNING "ymfpci: no codec attached ?\n");
 		goto out_kfree;
 	}
--- linux-2.4.22-pre1-full/drivers/sound/i810_audio.c.old	2003-06-22 02:08:17.000000000 +0200
+++ linux-2.4.22-pre1-full/drivers/sound/i810_audio.c	2003-06-22 02:08:34.000000000 +0200
@@ -2921,7 +2921,7 @@
 		/* Don't attempt to get eid until powerup is complete */
 		eid = i810_ac97_get(codec, AC97_EXTENDED_ID);
 
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "i810_audio: no codec attached ?\n");
 			kfree(codec);
--- linux-2.4.22-pre1-full/drivers/sound/cs46xx.c.old	2003-06-22 02:09:03.000000000 +0200
+++ linux-2.4.22-pre1-full/drivers/sound/cs46xx.c	2003-06-22 02:09:18.000000000 +0200
@@ -4260,7 +4260,7 @@
 
 		eid = cs_ac97_get(codec, AC97_EXTENDED_ID);
 		
-		if(eid==0xFFFFFF)
+		if(eid==0xFFFF)
 		{
 			printk(KERN_WARNING "cs46xx: codec %d not present\n",num_ac97);
 			kfree(codec);
--- linux-2.4.22-pre1-full/drivers/sound/ali5455.c.old	2003-06-22 02:11:07.000000000 +0200
+++ linux-2.4.22-pre1-full/drivers/sound/ali5455.c	2003-06-22 02:11:26.000000000 +0200
@@ -3277,7 +3277,7 @@
 		card->ac97_status = 0;
 		/* Don't attempt to get eid until powerup is complete */
 		eid = ali_ac97_get(codec, AC97_EXTENDED_ID);
-		if (eid == 0xFFFFFF) {
+		if (eid == 0xFFFF) {
 			printk(KERN_ERR "ali_audio: no codec attached ?\n");
 			kfree(codec);
 			break;
