Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbTCaQMm>; Mon, 31 Mar 2003 11:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbTCaQMm>; Mon, 31 Mar 2003 11:12:42 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:27776 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261697AbTCaQMl>; Mon, 31 Mar 2003 11:12:41 -0500
Date: Tue, 1 Apr 2003 01:22:27 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.66-ac1] Update PC-9800 support (2/3) ALSA sound driver
Message-ID: <20030331162227.GA1148@yuzuki.cinet.co.jp>
References: <20030331161604.GA1124@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331161604.GA1124@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the update patch for NEC PC-9800 subarchitecture
against 2.5.66-ac1. (2/3)
Please apply.

Update ALSA sound driver for PC-98.
Fix DMA initialze failure on some sound cards.

diff -Nru linux-2.5.66-ac1/sound/isa/cs423x/pc98.c linux98-2.5.66-ac1/sound/isa/cs423x/pc98.c
--- linux-2.5.66-ac1/sound/isa/cs423x/pc98.c	2003-03-25 07:00:18.000000000 +0900
+++ linux98-2.5.66-ac1/sound/isa/cs423x/pc98.c	2003-03-30 22:06:51.000000000 +0900
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

Regards,
Osamu Tomita

