Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVHUM1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVHUM1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 08:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVHUM1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 08:27:13 -0400
Received: from postman1.arcor-online.net ([151.189.20.156]:28406 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S1750972AbVHUM1M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 08:27:12 -0400
To: linux-kernel@vger.kernel.org
Cc: georg.schwarz@freenet.de
Subject: patch for drivers/sound/sb_card.c to recognize mpu_io bootline parameter
From: georg.schwarz@freenet.de (Georg Schwarz)
Date: Sun, 21 Aug 2005 14:27:59 +0200
Message-ID: <1h1ndw0.bpnm8a1nxej8yM@geos.net.eu.org>
User-Agent: MacSOUP/D-2.7 (Mac OS 8.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developes,

I could not find any maintainer for the sound blaster audio driver so I chose
to address this to the kernel developer list.

Problem:

Unlike in kernels 2.2.X it seems no longer possible to specify during kernel
configuration the sound blaster mpu io address. This might be necessary with
old non-PNP ISA sb cards when not using the sb driver as a kernel module but
directly compiling it in.
The alternative would be to specify that address on boot time via a kernel
option; however sb= supports sb IO address, IRQ, DMA and DMA16 only.

Solution:

Add support for a fifth parameter to sb= representing the sb mpu IO address.

This is what the following patch, developed on Linux 2.4.31, does:


--- drivers/sound/sb_card.c.orig        2005-08-20 23:37:09.000000000 +0200
+++ drivers/sound/sb_card.c     2005-08-20 23:39:10.000000000 +0200
@@ -1019,8 +1019,8 @@
 #ifndef MODULE
 static int __init setup_sb(char *str)
 {
-       /* io, irq, dma, dma2 - just the basics */
-       int ints[5];
+       /* io, irq, dma, dma2, mpu io - just the basics */
+       int ints[6];
 
        str = get_options(str, ARRAY_SIZE(ints), ints);
 
@@ -1028,6 +1028,7 @@
        irq     = ints[2];
        dma     = ints[3];
        dma16   = ints[4];
+       mpu_io  = ints[5];
 
        return 1;
 }




I could not find any documentation that would mention sb=, let alone its
parameters. If that one exists nonetheless it would of course also have to be
complemented.

Georg




-- 
Georg Schwarz    http://home.pages.de/~schwarz/
 georg.schwarz@freenet.de     +49 178 8545053
