Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbTDGXay (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbTDGXae (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 19:30:34 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16513
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S263740AbTDGXUJ (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 19:20:09 -0400
Date: Tue, 8 Apr 2003 01:39:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200304080039.h380d25r009288@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: small pc98xx fix for sound
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.67/sound/isa/cs423x/pc98.c linux-2.5.67-ac1/sound/isa/cs423x/pc98.c
--- linux-2.5.67/sound/isa/cs423x/pc98.c	2003-03-26 20:00:02.000000000 +0000
+++ linux-2.5.67-ac1/sound/isa/cs423x/pc98.c	2003-04-03 23:42:15.000000000 +0100
@@ -3,6 +3,7 @@
  *  Copyright (c) by Jaroslav Kysela <perex@suse.cz>
  *                   Osamu Tomita <tomita@cinet.co.jp>
  *                   Takashi Iwai <tiwai@suse.de>
+ *                   Hideaki Okubo <okubo@msh.biglobe.ne.jp>
  *
  *
  *   This program is free software; you can redistribute it and/or modify
@@ -290,8 +291,13 @@
 		snd_printk(KERN_ERR IDENT ": Bad DMA %d\n", dma2[dev]);
 		return -EINVAL;
 	}
-	if (dma1[dev] != dma2[dev] && dma2[dev] >= 0)
+
+	outb(dma1[dev], 0x29);		/* dma1 boundary 64KB */
+	if (dma1[dev] != dma2[dev] && dma2[dev] >= 0) {
+		outb(0, 0x5f);		/* wait */
+		outb(dma2[dev], 0x29);	/* dma2 boundary 64KB */
 		intr_bits |= 0x04;
+	}
 
 	if (PC9800_SOUND_ID() == PC9800_SOUND_ID_118) {
 		/* Set up CanBe control registers. */
