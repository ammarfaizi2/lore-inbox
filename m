Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268379AbTAMWbY>; Mon, 13 Jan 2003 17:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268371AbTAMWbX>; Mon, 13 Jan 2003 17:31:23 -0500
Received: from [213.171.53.133] ([213.171.53.133]:57358 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id <S268379AbTAMWaI>;
	Mon, 13 Jan 2003 17:30:08 -0500
Date: Tue, 14 Jan 2003 01:38:38 +0300 (MSK)
From: "Ruslan U. Zakirov" <cubic@miee.ru>
To: Linus Torvalds <torvalds@transmeta.com>
cc: vojtech@suse.cz, Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.57
In-Reply-To: <Pine.LNX.4.44.0301131039050.13791-100000@penguin.transmeta.com>
Message-ID: <Pine.BSF.4.05.10301140123440.36033-100000@wildrose.miee.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Linus Torvalds wrote:

> 
> Ok, Alan worked on fixing the network packet padding thing (small changes
> to a _lot_ of network drivers), and merged some more of his IDE work.  
> And latency fixes and some VM updates from Andrew Morton.
> 
> Ppc, ppc64, ISDN and sparc updates. NFSd and sysfs updates.
> 
> And special mention for Brian Gerst, who figured out and fixed a x86 page
> table initialization fix that would leave old machines unable to boot
> 2.5.x. That might explain a number of the "I can't run 2.5.x" that weren't
> seen by developers (most developers tend to have hardware studly enough
> that they'd never see the problem).
> 
> 			Linus
Hello All.
Patch fix wrong order of array(amd_ide_chips) that cause BUG() in 436 line
with any conditions, because we use wrong amd_config.

--- drivers/ide/pci/amd74xx.c~	2003-01-14 01:08:06.000000000 +0300
+++ drivers/ide/pci/amd74xx.c	2003-01-14 00:58:27.000000000 +0300
@@ -54,11 +54,11 @@
 	unsigned long base;
 	unsigned char flags;
 } amd_ide_chips[] = {
-	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
-	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
-	{ PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, 0x40, AMD_UDMA_100 | AMD_BAD_FIFO },	/* AMD-766 Viper */
-	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, 0x40, AMD_UDMA_66 | AMD_CHECK_SWDMA },	/* AMD-756 Viper */
 	{ PCI_DEVICE_ID_AMD_COBRA_7401, 0x00, 0x40, AMD_UDMA_33 | AMD_BAD_SWDMA },	/* AMD-755 Cobra */
+	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, 0x40, AMD_UDMA_66 | AMD_CHECK_SWDMA },	/* AMD-756 Viper */
+	{ PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, 0x40, AMD_UDMA_100 | AMD_BAD_FIFO },	/* AMD-766 Viper */
+	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
+	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
         { PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },                  /* nVidia nForce */
 
 	{ 0 }

------------
Best regards.
Thanks, Ruslan.

