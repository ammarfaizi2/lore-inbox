Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWGCAvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWGCAvV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWGCAuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:50:54 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:23260 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750790AbWGCAuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:50:24 -0400
Message-Id: <20060703004056.386067000@myri.com>
References: <20060703003959.942374000@myri.com>
User-Agent: quilt/0.45-1
Date: Sun, 02 Jul 2006 20:40:05 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: [patch 6/7] Drop pci_msi_quirk
Content-Disposition: inline; filename=06-drop_pci_msi_quirk.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_msi_quirk is not used anymore, the no_msi flag in the pci_dev
structure of the chipset should be preferred.
Drop pci_msi_quirk completely.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/msi.c    |    7 -------
 drivers/pci/pci.h    |    6 ------
 drivers/pci/quirks.c |    2 --
 3 files changed, 15 deletions(-)

Index: linux-git/drivers/pci/msi.c
===================================================================
--- linux-git.orig/drivers/pci/msi.c	2006-07-02 11:39:56.000000000 -0400
+++ linux-git/drivers/pci/msi.c	2006-07-02 11:56:48.000000000 -0400
@@ -351,13 +351,6 @@
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
Index: linux-git/drivers/pci/pci.h
===================================================================
--- linux-git.orig/drivers/pci/pci.h	2006-07-02 11:16:08.000000000 -0400
+++ linux-git/drivers/pci/pci.h	2006-07-02 11:56:48.000000000 -0400
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
Index: linux-git/drivers/pci/quirks.c
===================================================================
--- linux-git.orig/drivers/pci/quirks.c	2006-07-02 11:54:01.000000000 -0400
+++ linux-git/drivers/pci/quirks.c	2006-07-02 11:56:48.000000000 -0400
@@ -575,8 +575,6 @@
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SI,	PCI_ANY_ID,			quirk_ioapic_rmw );
 
-int pci_msi_quirk;
-
 #define AMD8131_revA0        0x01
 #define AMD8131_revB0        0x11
 #define AMD8131_MISC         0x40

