Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266778AbUHOPZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbUHOPZk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266817AbUHOPYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:24:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45795 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266778AbUHOPUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:20:14 -0400
Date: Sun, 15 Aug 2004 11:19:17 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: enable hotplug in various IDE controller drivers
Message-ID: <20040815151917.GA16888@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/aec62xx.c linux-2.6.8-rc3/drivers/ide/pci/aec62xx.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/aec62xx.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/aec62xx.c	2004-08-11 23:21:17.000000000 +0100
@@ -529,6 +529,19 @@
 	return 0;
 }
 
+/**
+ *	aec62xx_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit aec62xx_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
+
 static struct pci_device_id aec62xx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
@@ -543,6 +556,7 @@
 	.name		= "AEC62xx IDE",
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
+	.remove		= aec62xx_remove_one
 };
 
 static int aec62xx_ide_init(void)
@@ -552,6 +566,13 @@
 
 module_init(aec62xx_ide_init);
 
+static void aec62xx_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(aec62xx_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for ARTOP AEC62xx IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/alim15x3.c linux-2.6.8-rc3/drivers/ide/pci/alim15x3.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/alim15x3.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/alim15x3.c	2004-08-11 23:51:32.000000000 +0100
@@ -885,6 +885,17 @@
 	return 0;
 }
 
+/**
+ *	alim15x3_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit alim15x3_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
 
 static struct pci_device_id alim15x3_pci_tbl[] = {
 	{ PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M5229, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
@@ -896,6 +907,7 @@
 	.name		= "ALI15x3 IDE",
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
+	.remove		= alim15x3_remove_one,
 };
 
 static int ali15x3_ide_init(void)
@@ -905,6 +917,13 @@
 
 module_init(ali15x3_ide_init);
 
+static void alim15x3_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(alim15x3_ide_exit);
+
 MODULE_AUTHOR("Michael Aubry, Andrzej Krzysztofowicz, CJ, Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for ALi 15x3 IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/cmd64x.c linux-2.6.8-rc3/drivers/ide/pci/cmd64x.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/cmd64x.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/cmd64x.c	2004-08-11 23:30:27.000000000 +0100
@@ -750,6 +750,11 @@
 	return 0;
 }
 
+static void __devexit cmd64x_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id cmd64x_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_643, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_646, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -763,6 +768,7 @@
 	.name		= "CMD64x IDE",
 	.id_table	= cmd64x_pci_tbl,
 	.probe		= cmd64x_init_one,
+	.remove		= cmd64x_remove_one,
 };
 
 static int cmd64x_ide_init(void)
@@ -772,6 +778,13 @@
 
 module_init(cmd64x_ide_init);
 
+static void cmd64x_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(cmd64x_ide_exit);
+
 MODULE_AUTHOR("Eddie Dost, David Miller, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for CMD64x IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/cy82c693.c linux-2.6.8-rc3/drivers/ide/pci/cy82c693.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/cy82c693.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/cy82c693.c	2004-08-11 23:21:04.000000000 +0100
@@ -437,6 +437,11 @@
 	return 0;
 }
 
+static void __devexit cy82c693_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id cy82c693_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CONTAQ, PCI_DEVICE_ID_CONTAQ_82C693, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ 0, },
@@ -447,6 +452,7 @@
 	.name		= "Cypress IDE",
 	.id_table	= cy82c693_pci_tbl,
 	.probe		= cy82c693_init_one,
+	.remove		= cy82c693_remove_one,
 };
 
 static int cy82c693_ide_init(void)
@@ -456,6 +462,14 @@
 
 module_init(cy82c693_ide_init);
 
+static void cy82c693_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(cy82c693_ide_exit);
+
+
 MODULE_AUTHOR("Andreas Krebs, Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for the Cypress CY82C693 IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/generic.c linux-2.6.8-rc3/drivers/ide/pci/generic.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/generic.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/generic.c	2004-08-11 23:30:26.000000000 +0100
@@ -117,6 +117,11 @@
 	return 0;
 }
 
+static void __devexit generic_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id generic_pci_tbl[] = {
 	{ PCI_VENDOR_ID_NS,     PCI_DEVICE_ID_NS_87410,            PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -141,6 +146,7 @@
 	.name		= "PCI IDE",
 	.id_table	= generic_pci_tbl,
 	.probe		= generic_init_one,
+	.remove		= generic_remove_one,
 };
 
 static int generic_ide_init(void)
@@ -150,6 +156,14 @@
 
 module_init(generic_ide_init);
 
+static void generic_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(generic_ide_exit);
+
+
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for generic PCI IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/hpt366.c linux-2.6.8-rc3/drivers/ide/pci/hpt366.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/hpt366.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/hpt366.c	2004-08-14 23:59:56.000000000 +0100
@@ -1391,6 +1391,19 @@
 	return 0;
 }
 
+/**
+ *	hpt366_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit hpt366_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
+
 static struct pci_device_id hpt366_pci_tbl[] = {
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT372, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -1406,6 +1419,7 @@
 	.name		= "HPT366 IDE",
 	.id_table	= hpt366_pci_tbl,
 	.probe		= hpt366_init_one,
+	.remove		= hpt366_remove_one,
 };
 
 static int hpt366_ide_init(void)
@@ -1415,6 +1429,13 @@
 
 module_init(hpt366_ide_init);
 
+static void hpt366_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(hpt366_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick");
 MODULE_DESCRIPTION("PCI driver module for Highpoint HPT366 IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/pdc202xx_new.c linux-2.6.8-rc3/drivers/ide/pci/pdc202xx_new.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/pdc202xx_new.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/pdc202xx_new.c	2004-08-11 23:58:22.000000000 +0100
@@ -502,6 +502,18 @@
 }
 
 /**
+ *	pdc202new_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit pdc202new_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
+/**
  *	pdc202new_init_one	-	called when a pdc202xx is found
  *	@dev: the pdc202new device
  *	@id: the matching pci id
@@ -534,6 +546,7 @@
 	.name		= "Promise IDE",
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
+	.remove		= pdc202new_remove_one,
 };
 
 static int pdc202new_ide_init(void)
@@ -543,6 +556,13 @@
 
 module_init(pdc202new_ide_init);
 
+static void pdc202new_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(pdc202new_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick, Frank Tiernan");
 MODULE_DESCRIPTION("PCI driver module for Promise PDC20268 and higher");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/pdc202xx_old.c linux-2.6.8-rc3/drivers/ide/pci/pdc202xx_old.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/pdc202xx_old.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/pdc202xx_old.c	2004-08-12 00:02:14.000000000 +0100
@@ -894,6 +894,18 @@
 	return 0;
 }
 
+/**
+ *	pdc202xx_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit pdc202xx_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id pdc202xx_pci_tbl[] = {
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20246, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20262, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -908,6 +920,7 @@
 	.name		= "Promise Old IDE",
 	.id_table	= pdc202xx_pci_tbl,
 	.probe		= pdc202xx_init_one,
+	.remove		= pdc202xx_remove_one,
 };
 
 static int pdc202xx_ide_init(void)
@@ -917,6 +930,13 @@
 
 module_init(pdc202xx_ide_init);
 
+static void pdc202xx_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(pdc202xx_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick, Frank Tiernan");
 MODULE_DESCRIPTION("PCI driver module for older Promise IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/piix.c linux-2.6.8-rc3/drivers/ide/pci/piix.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/piix.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/piix.c	2004-08-11 23:58:46.000000000 +0100
@@ -765,7 +765,7 @@
 		if(rev == 0x00)
 			no_piix_dma = 1;
 		/* On all revisions below 5 PXB bus lock must be disabled for IDE */
-		else if(cfg & (1<<14) && rev < 5)
+		else if((cfg & (1<<14)) && rev < 5)
 			no_piix_dma = 2;
 	}
 	if(no_piix_dma)
@@ -774,6 +774,18 @@
 		printk(KERN_WARNING "piix: A BIOS update may resolve this.\n");
 }		
 
+/**
+ *	piix_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit piix_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id piix_pci_tbl[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_1, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
@@ -806,6 +818,7 @@
 	.name		= "PIIX IDE",
 	.id_table	= piix_pci_tbl,
 	.probe		= piix_init_one,
+	.remove		= piix_remove_one,
 };
 
 static int __init piix_ide_init(void)
@@ -816,6 +829,13 @@
 
 module_init(piix_ide_init);
 
+static void piix_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(piix_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick, Andrzej Krzysztofowicz");
 MODULE_DESCRIPTION("PCI driver module for Intel PIIX IDE");
 MODULE_LICENSE("GPL");
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/pci/siimage.c linux-2.6.8-rc3/drivers/ide/pci/siimage.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/pci/siimage.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/pci/siimage.c	2004-08-11 23:51:32.000000000 +0100
@@ -1126,6 +1126,18 @@
 	return 0;
 }
 
+/**
+ *	siimage_remove_one	-	called on hot unplug
+ *	@dev: the pci device
+ *
+ *	Callback from hot unplug or driver unload
+ */
+ 
+static void __devexit siimage_remove_one(struct pci_dev *dev)
+{
+	ide_pci_remove_hwifs(dev);
+}
+
 static struct pci_device_id siimage_pci_tbl[] = {
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
@@ -1140,6 +1152,7 @@
 	.name		= "SiI IDE",
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
+	.remove		= siimage_remove_one,
 };
 
 static int siimage_ide_init(void)
@@ -1149,6 +1162,13 @@
 
 module_init(siimage_ide_init);
 
+static void siimage_ide_exit(void)
+{
+	return ide_pci_unregister_driver(&driver);
+}
+
+module_exit(siimage_ide_exit);
+
 MODULE_AUTHOR("Andre Hedrick, Alan Cox");
 MODULE_DESCRIPTION("PCI driver module for SiI IDE");
 MODULE_LICENSE("GPL");
