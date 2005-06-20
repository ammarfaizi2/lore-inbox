Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVFTUZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVFTUZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVFTUY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:24:27 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27038 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261556AbVFTUXq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:23:46 -0400
Subject: PATCH: Fix crashes with hotplug serverworks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119298859.3325.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Jun 2005 21:21:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can't install the base kernel on a Stratus box because of the
overuse of __init. Affects both IDE layers identically. It isn't the
only misuser of __init so more review of other drivers (or fixing
ide_register code to know about hotplug v non-hotplug chipsets) would be
good.

Signed-off-by: Alan Cox <alan@redhat.com>
Original issue found by Stratus and their patch was the inspiration for
this trivial one.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.12/drivers/ide/pci/serverworks.c linux-2.6.12/drivers/ide/pci/serverworks.c
--- linux.vanilla-2.6.12/drivers/ide/pci/serverworks.c	2005-06-19 11:30:47.000000000 +0100
+++ linux-2.6.12/drivers/ide/pci/serverworks.c	2005-06-20 20:45:50.000000000 +0100
@@ -442,7 +442,7 @@
 	return (dev->irq) ? dev->irq : 0;
 }
 
-static unsigned int __init ata66_svwks_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_svwks (ide_hwif_t *hwif)
 {
 	return 1;
 }
@@ -454,7 +454,7 @@
  * Bit 14 clear = primary IDE channel does not have 80-pin cable.
  * Bit 14 set   = primary IDE channel has 80-pin cable.
  */
-static unsigned int __init ata66_svwks_dell (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_dell (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_DELL &&
@@ -472,7 +472,7 @@
  *
  * WARNING: this only works on Alpine hardware!
  */
-static unsigned int __init ata66_svwks_cobalt (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks_cobalt (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_SUN &&
@@ -483,7 +483,7 @@
 	return 0;
 }
 
-static unsigned int __init ata66_svwks (ide_hwif_t *hwif)
+static unsigned int __devinit ata66_svwks (ide_hwif_t *hwif)
 {
 	struct pci_dev *dev = hwif->pci_dev;
 
@@ -573,7 +573,7 @@
 	return ide_setup_pci_device(dev, d);
 }
 
-static int __init init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
+static int __devinit init_setup_csb6 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if (!(PCI_FUNC(dev->devfn) & 1)) {
 		d->bootable = NEVER_BOARD;

