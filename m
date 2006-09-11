Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964769AbWIKNWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964769AbWIKNWg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 09:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbWIKNWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 09:22:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:2030 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964769AbWIKNWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 09:22:35 -0400
Subject: PATCH: Fix 2.6.18-rc6 IDE breakage, add missing ident needed for
	current VIA boards
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 14:45:07 +0100
Message-Id: <1157982307.23085.140.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok Linus this should do the trick and is tested on the chipsets I have.
There are two patches here. The first reverses the broken PCI_DEVICE
conversion back to the old format. The second adds a missing PCI ID so 
you can actually boot 2.6.18 on 2 month old VIA motherboards (right now only
2.6.18-mm works).

CC'd to Jeff to check the PCI ident but its a) in several distro kernels
and b) in 2.6.18-mm [twice ??]

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6/drivers/ide/pci/aec62xx.c linux-2.6.18-rc6/drivers/ide/pci/aec62xx.c
--- linux.vanilla-2.6.18-rc6/drivers/ide/pci/aec62xx.c	2006-09-11 11:02:12.000000000 +0100
+++ linux-2.6.18-rc6/drivers/ide/pci/aec62xx.c	2006-09-11 11:13:16.000000000 +0100
@@ -425,12 +425,12 @@
 	return d->init_setup(dev, d);
 }
 
-static const struct pci_device_id aec62xx_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF), 0 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860), 1 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R), 2 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865), 3 },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R), 4 },
+static struct pci_device_id aec62xx_pci_tbl[] = {
+	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP850UF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1 },
+	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP860R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2 },
+	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3 },
+	{ PCI_VENDOR_ID_ARTOP, PCI_DEVICE_ID_ARTOP_ATP865R,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6/drivers/ide/pci/serverworks.c linux-2.6.18-rc6/drivers/ide/pci/serverworks.c
--- linux.vanilla-2.6.18-rc6/drivers/ide/pci/serverworks.c	2006-09-11 11:02:12.000000000 +0100
+++ linux-2.6.18-rc6/drivers/ide/pci/serverworks.c	2006-09-11 11:13:33.000000000 +0100
@@ -649,11 +649,11 @@
 }
 
 static struct pci_device_id svwks_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE), 0},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE), 2},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2), 3},
-	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE), 4},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6/drivers/ide/pci/siimage.c linux-2.6.18-rc6/drivers/ide/pci/siimage.c
--- linux.vanilla-2.6.18-rc6/drivers/ide/pci/siimage.c	2006-09-11 11:02:12.000000000 +0100
+++ linux-2.6.18-rc6/drivers/ide/pci/siimage.c	2006-09-11 11:13:58.000000000 +0100
@@ -1082,10 +1082,10 @@
 }
 
 static struct pci_device_id siimage_pci_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680), 0},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_680,  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 #ifdef CONFIG_BLK_DEV_IDE_SATA
-	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112), 1},
-	{ PCI_DEVICE(PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA), 2},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_3112, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
+	{ PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_SII_1210SA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
 #endif
 	{ 0, },
 };
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6/drivers/scsi/sata_via.c linux-2.6.18-rc6/drivers/scsi/sata_via.c
--- linux.vanilla-2.6.18-rc6/drivers/scsi/sata_via.c	2006-09-11 11:02:26.000000000 +0100
+++ linux-2.6.18-rc6/drivers/scsi/sata_via.c	2006-09-11 11:15:30.000000000 +0100
@@ -77,6 +77,7 @@
 static void vt6420_error_handler(struct ata_port *ap);
 
 static const struct pci_device_id svia_pci_tbl[] = {
+	{ 0x1106, 0x0591, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3149, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6420 },
 	{ 0x1106, 0x3249, PCI_ANY_ID, PCI_ANY_ID, 0, 0, vt6421 },
 

