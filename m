Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265103AbUFGWzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265103AbUFGWzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUFGWzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 18:55:53 -0400
Received: from ozlabs.org ([203.10.76.45]:43655 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265103AbUFGWzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 18:55:44 -0400
Date: Tue, 8 Jun 2004 08:51:15 +1000
From: Anton Blanchard <anton@samba.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix PCI hotplug of promise IDE cards
Message-ID: <20040607225115.GC7412@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It looks like no one has tried hotplugging Promise IDE cards :)

Anton

--

Change some __init functions in the pdc202xx driver to be __devinit, they
are used when hotpluging.

Signed-off-by: Anton Blanchard <anton@samba.org>


diff -puN drivers/ide/pci/pdc202xx_new.c~fix_promise_hotplug drivers/ide/pci/pdc202xx_new.c
--- gr_work/drivers/ide/pci/pdc202xx_new.c~fix_promise_hotplug	2004-06-07 02:44:59.180717024 -0500
+++ gr_work-anton/drivers/ide/pci/pdc202xx_new.c	2004-06-07 02:46:04.067307100 -0500
@@ -404,7 +404,7 @@ static void __devinit apple_kiwi_init(st
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static unsigned int __init init_chipset_pdcnew (struct pci_dev *dev, const char *name)
+static unsigned int __devinit init_chipset_pdcnew (struct pci_dev *dev, const char *name)
 {
 	if (dev->resource[PCI_ROM_RESOURCE].start) {
 		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
@@ -429,7 +429,7 @@ static unsigned int __init init_chipset_
 	return dev->irq;
 }
 
-static void __init init_hwif_pdc202new (ide_hwif_t *hwif)
+static void __devinit init_hwif_pdc202new (ide_hwif_t *hwif)
 {
 	hwif->autodma = 0;
 
@@ -457,12 +457,12 @@ static void __init init_hwif_pdc202new (
 #endif /* PDC202_DEBUG_CABLE */
 }
 
-static void __init init_setup_pdcnew (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdcnew (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc20270 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc20270 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	struct pci_dev *findev = NULL;
 
@@ -488,7 +488,7 @@ static void __init init_setup_pdc20270 (
 	ide_setup_pci_device(dev, d);
 }
 
-static void __init init_setup_pdc20276 (struct pci_dev *dev, ide_pci_device_t *d)
+static void __devinit init_setup_pdc20276 (struct pci_dev *dev, ide_pci_device_t *d)
 {
 	if ((dev->bus->self) &&
 	    (dev->bus->self->vendor == PCI_VENDOR_ID_INTEL) &&

_
