Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313626AbSDHTzJ>; Mon, 8 Apr 2002 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313666AbSDHTzI>; Mon, 8 Apr 2002 15:55:08 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:4501 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S313626AbSDHTzH>; Mon, 8 Apr 2002 15:55:07 -0400
Date: Mon, 8 Apr 2002 20:24:50 +0100
From: Graham Cobb <g+linux@cobb.uk.net>
Message-Id: <200204081924.UAA30635@vranx.cobb.uk.net>
To: linux-kernel@vger.kernel.org
CC: alan@lxorguk.ukuu.org.uk, g+linux@cobb.uk.net, mj@ucw.cz
Subject: [PATCH] PCI fixup for old NCR 53C810 SCSI chips, kernel 2.4.18 [not wrapped]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repost of my patch for DECpc XL systems and other old motherboards using the NCR 53C810.  
This one should not be wrapped by my mailer.  Apologies for the earlier mail screwup.

Graham

--- linux-2.4.18.orig/arch/i386/kernel/pci-pc.c	Mon Feb 25 19:37:53 2002
+++ linux-2.4.18/arch/i386/kernel/pci-pc.c	Sun Mar 31 23:29:30 2002
@@ -1058,6 +1058,18 @@
 		d->resource[i].flags |= PCI_BASE_ADDRESS_SPACE_IO;
 }
 
+static void __devinit  pci_fixup_ncr53c810(struct pci_dev *d)
+{
+	/*
+	 * NCR 53C810 returns class code 0 (at least on some systems).
+	 * Fix class to be PCI_CLASS_STORAGE_SCSI
+	 */
+	if (!d->class) {
+		printk("PCI: fixing NCR 53C810 class code for %s\n", d->slot_name);
+		d->class = PCI_CLASS_STORAGE_SCSI << 8;
+	}
+}
+
 static void __devinit pci_fixup_ide_bases(struct pci_dev *d)
 {
 	int i;
@@ -1148,6 +1160,7 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8622,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8361,	        pci_fixup_via_northbridge_bug },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8367_0,	pci_fixup_via_northbridge_bug },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	pci_fixup_ncr53c810 },
 	{ 0 }
 };
 
