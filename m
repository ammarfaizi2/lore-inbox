Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262564AbVAUXSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262564AbVAUXSx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 18:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVAUXSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 18:18:03 -0500
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:7085 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S262569AbVAUXJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 18:09:24 -0500
Date: Sat, 22 Jan 2005 00:02:47 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [ide-dev 1/5] ignore BIOS enable bits for Promise controllers
Message-ID: <Pine.GSO.4.58.0501220001110.23959@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since there are no Promise binary drivers for 2.6.x kernels:
* ignore BIOS enable bits completely
* remove CONFIG_PDC202XX_FORCE
* kill IDEPCI_FLAG_FORCE_PDC hack

diff -Nru a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig	2005-01-21 23:53:09 +01:00
+++ b/drivers/ide/Kconfig	2005-01-21 23:53:09 +01:00
@@ -659,13 +659,6 @@
 config BLK_DEV_PDC202XX_NEW
 	tristate "PROMISE PDC202{68|69|70|71|75|76|77} support"

-# FIXME - probably wants to be one for old and for new
-config PDC202XX_FORCE
-	bool "Enable controller even if disabled by BIOS"
-	depends on BLK_DEV_PDC202XX_NEW
-	help
-	  Enable the PDC202xx controller even if it has been disabled in the BIOS setup.
-
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
 	help
diff -Nru a/drivers/ide/pci/pdc202xx_new.h b/drivers/ide/pci/pdc202xx_new.h
--- a/drivers/ide/pci/pdc202xx_new.h	2005-01-21 23:53:09 +01:00
+++ b/drivers/ide/pci/pdc202xx_new.h	2005-01-21 23:53:09 +01:00
@@ -73,9 +73,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 3 */
 		.name		= "PDC20271",
@@ -100,9 +97,6 @@
 		.init_hwif	= init_hwif_pdc202new,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 	},{	/* 6 */
 		.name		= "PDC20277",
diff -Nru a/drivers/ide/pci/pdc202xx_old.h b/drivers/ide/pci/pdc202xx_old.h
--- a/drivers/ide/pci/pdc202xx_old.h	2005-01-21 23:53:09 +01:00
+++ b/drivers/ide/pci/pdc202xx_old.h	2005-01-21 23:53:09 +01:00
@@ -79,9 +79,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 16,
 	},{	/* 1 */
@@ -92,12 +89,8 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 2 */
 		.name		= "PDC20263",
 		.init_setup	= init_setup_pdc202ata4,
@@ -106,9 +99,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	},{	/* 3 */
@@ -119,12 +109,8 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
-		.flags		= IDEPCI_FLAG_FORCE_PDC,
 	},{	/* 4 */
 		.name		= "PDC20267",
 		.init_setup	= init_setup_pdc202xx,
@@ -133,9 +119,6 @@
 		.init_dma	= init_dma_pdc202xx,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-#ifndef CONFIG_PDC202XX_FORCE
-		.enablebits	= {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
-#endif
 		.bootable	= OFF_BOARD,
 		.extra		= 48,
 	}
diff -Nru a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2005-01-21 23:53:09 +01:00
+++ b/drivers/ide/setup-pci.c	2005-01-21 23:53:09 +01:00
@@ -579,7 +579,6 @@
 	int port;
 	int at_least_one_hwif_enabled = 0;
 	ide_hwif_t *hwif, *mate = NULL;
-	static int secondpdc = 0;
 	u8 tmp;

 	index->all = 0xf0f0;
@@ -590,22 +589,10 @@

 	for (port = 0; port <= 1; ++port) {
 		ide_pci_enablebit_t *e = &(d->enablebits[port]);
-
-		/*
-		 * If this is a Promise FakeRaid controller,
-		 * the 2nd controller will be marked as
-		 * disabled while it is actually there and enabled
-		 * by the bios for raid purposes.
-		 * Skip the normal "is it enabled" test for those.
-		 */
-		if ((d->flags & IDEPCI_FLAG_FORCE_PDC) &&
-		    (secondpdc++==1) && (port==1))
-			goto controller_ok;
-
+
 		if (e->reg && (pci_read_config_byte(dev, e->reg, &tmp) ||
 		    (tmp & e->mask) != e->val))
 			continue;	/* port not enabled */
-controller_ok:

 		if (d->channels	<= port)
 			break;
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	2005-01-21 23:53:09 +01:00
+++ b/include/linux/ide.h	2005-01-21 23:53:09 +01:00
@@ -1405,7 +1405,6 @@
 enum {
 	/* Uses ISA control ports not PCI ones. */
 	IDEPCI_FLAG_ISA_PORTS		= (1 << 0),
-	IDEPCI_FLAG_FORCE_PDC		= (1 << 1),
 };

 typedef struct ide_pci_device_s {
