Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVCHLtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVCHLtp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbVCHLqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:46:18 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:21123 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261975AbVCHLpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:45:21 -0500
Subject: PATCH: Allow ATI SATA to use siimage if serial ATA layer is not in
	use
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110282209.28860.115.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Mar 2005 11:43:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ATI chipset serial ATA is an SI3112 cell. While this is supported by
the sata layer (you'll need to grep by id because naughty Mr Garzik
doesn't use the PCI ID defines) the sata layer driver still gives some
users real problems.

Alan
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.11/drivers/ide/pci/siimage.c linux-2.6.11/drivers/ide/pci/siimage.c
--- linux.vanilla-2.6.11/drivers/ide/pci/siimage.c	2005-03-05 15:17:01.000000000 +0000
+++ linux-2.6.11/drivers/ide/pci/siimage.c	2005-03-07 13:18:10.000000000 +0000
@@ -48,6 +48,8 @@
 	{
 		case PCI_DEVICE_ID_SII_3112:
 		case PCI_DEVICE_ID_SII_1210SA:
+		case PCI_DEVICE_ID_ATI_IXP300_SATA:
+		case PCI_DEVICE_ID_ATI_IXP400_SATA:
 			return 1;
 		case PCI_DEVICE_ID_SII_680:
 			return 0;
@@ -1088,7 +1090,9 @@
 static ide_pci_device_t siimage_chipsets[] __devinitdata = {
 	/* 0 */ DECLARE_SII_DEV("SiI680"),
 	/* 1 */ DECLARE_SII_DEV("SiI3112 Serial ATA"),
-	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA")
+	/* 2 */ DECLARE_SII_DEV("Adaptec AAR-1210SA"),
+	/* 3 */ DECLARE_SII_DEV("ATI IXP300"),
+	/* 4 */ DECLARE_SII_DEV("ATI IXP400")
 };
 
 /**
@@ -1110,6 +1114,8 @@
 #ifdef CONFIG_BLK_DEV_IDE_SATA
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
 	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP300_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
 #endif
 	{ 0, },
 };

