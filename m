Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTJCXmH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 19:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTJCXmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 19:42:06 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:26580 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261598AbTJCXkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 19:40:46 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill dummy init_dma_* from drivers/ide/pci/
Date: Sat, 4 Oct 2003 01:44:15 +0200
User-Agent: KMail/1.5.4
References: <200310040138.08690.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200310040138.08690.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310040144.15228.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] piix: kill dummy init_dma_piix()

 drivers/ide/pci/piix.c |   15 ---------------
 drivers/ide/pci/piix.h |   21 ---------------------
 2 files changed, 36 deletions(-)

diff -puN drivers/ide/pci/piix.c~ide-piix-init_dma drivers/ide/pci/piix.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/piix.c~ide-piix-init_dma	2003-10-04 01:07:20.860376848 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/piix.c	2003-10-04 01:07:20.866375936 +0200
@@ -709,21 +709,6 @@ static void __init init_hwif_piix (ide_h
 	hwif->drives[0].autodma = hwif->autodma;
 }
 
-/**
- *	init_dma_piix		-	set up the PIIX DMA
- *	@hwif: IDE interface
- *	@dmabase: DMA PCI base
- *
- *	Set up the DMA on the PIIX controller, providing a DMA base is
- *	available. The PIIX follows the normal specs so we do nothing
- *	magical here.
- */
-
-static void __init init_dma_piix (ide_hwif_t *hwif, unsigned long dmabase)
-{
-	ide_setup_dma(hwif, dmabase, 8);
-}
-
 extern void ide_setup_pci_device(struct pci_dev *, ide_pci_device_t *);
 
 /**
diff -puN drivers/ide/pci/piix.h~ide-piix-init_dma drivers/ide/pci/piix.h
--- linux-2.6.0-test6-bk2/drivers/ide/pci/piix.h~ide-piix-init_dma	2003-10-04 01:07:20.863376392 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/piix.h	2003-10-04 01:08:50.420761600 +0200
@@ -30,8 +30,6 @@ static ide_pci_host_proc_t piix_procs[] 
 static void init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);
-static void init_dma_piix(ide_hwif_t *, unsigned long);
-
 
 /*
  *	Table of the various PIIX capability blocks
@@ -47,7 +45,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -61,7 +58,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -75,7 +71,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= NULL,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= NULL,
 		.channels	= 2,
 		.autodma	= NODMA,
 		.enablebits	= {{0x6D,0x80,0x80}, {0x6F,0x80,0x80}},
@@ -89,7 +84,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -103,7 +97,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -117,7 +110,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -131,7 +123,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -145,7 +136,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -159,7 +149,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -173,7 +162,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= NOAUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -187,7 +175,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -201,7 +188,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -215,7 +201,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -229,7 +214,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -243,7 +227,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -257,7 +240,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -271,7 +253,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -285,7 +266,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
@@ -299,7 +279,6 @@ static ide_pci_device_t piix_pci_info[] 
 		.init_chipset	= init_chipset_piix,
 		.init_iops	= NULL,
 		.init_hwif	= init_hwif_piix,
-		.init_dma	= init_dma_piix,
 		.channels	= 2,
 		.autodma	= AUTODMA,
 		.enablebits	= {{0x41,0x80,0x80}, {0x43,0x80,0x80}},

_

