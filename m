Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932346AbWFSBKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932346AbWFSBKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWFSBKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:10:19 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:19614 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932344AbWFSBKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:10:16 -0400
Date: Sun, 18 Jun 2006 21:10:13 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 8/8] Drop pci_msi_quirk
Message-ID: <20060619011013.GI29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 8/8] Drop pci_msi_quirk

pci_msi_quirk is not used anymore and using bus_flags should be preferred.
Drop pci_msi_quirk completely.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c    |    7 -------
 drivers/pci/pci.h    |    6 ------
 drivers/pci/quirks.c |    2 --
 3 files changed, 15 deletions(-)

Index: linux-mm/drivers/pci/msi.c
===================================================================
--- linux-mm.orig/drivers/pci/msi.c	2006-06-17 23:07:43.000000000 -0400
+++ linux-mm/drivers/pci/msi.c	2006-06-17 23:07:45.000000000 -0400
@@ -352,13 +352,6 @@
 	if (!status)
 		return status;
 
-	if (pci_msi_quirk) {
-		pci_msi_enable = 0;
-		printk(KERN_WARNING "PCI: MSI quirk detected. MSI disabled.\n");
-		status = -EINVAL;
-		return status;
-	}
-
 	status = msi_arch_init();
 	if (status < 0) {
 		pci_msi_enable = 0;
Index: linux-mm/drivers/pci/pci.h
===================================================================
--- linux-mm.orig/drivers/pci/pci.h	2006-06-17 22:08:57.000000000 -0400
+++ linux-mm/drivers/pci/pci.h	2006-06-17 23:07:45.000000000 -0400
@@ -42,12 +42,6 @@
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
 
-#ifdef CONFIG_X86_IO_APIC
-extern int pci_msi_quirk;
-#else
-#define pci_msi_quirk 0
-#endif
-
 #ifdef CONFIG_PCI_MSI
 void disable_msi_mode(struct pci_dev *dev, int pos, int type);
 void pci_no_msi(void);
Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-17 23:07:44.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-17 23:07:45.000000000 -0400
@@ -576,8 +576,6 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw );
 
-int pci_msi_quirk;
-
 #define AMD8131_revA0        0x01
 #define AMD8131_revB0        0x11
 #define AMD8131_MISC         0x40
