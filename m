Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932343AbWFSBJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWFSBJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 21:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWFSBJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 21:09:55 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:18590 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932342AbWFSBJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 21:09:53 -0400
Date: Sun, 18 Jun 2006 21:09:51 -0400
From: Brice Goglin <brice@myri.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/8] Drop existing quirks that disable MSI on some non PCI-E chipsets
Message-ID: <20060619010950.GH29950@myri.com>
References: <20060619010544.GA29950@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619010544.GA29950@myri.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 7/8] Drop existing quirks that disable MSI on some non PCI-E chipsets

Since MSI are now disabled on non-PCI-E chipset by default, we don't
need the AMD 8131 and ServerWorks GC quirks anymore.

Signed-off-by: Brice Goglin <brice@myri.com>
---
 drivers/pci/quirks.c |   13 -------------
 1 file changed, 13 deletions(-)

Index: linux-mm/drivers/pci/quirks.c
===================================================================
--- linux-mm.orig/drivers/pci/quirks.c	2006-06-17 23:07:42.000000000 -0400
+++ linux-mm/drivers/pci/quirks.c	2006-06-17 23:10:32.000000000 -0400
@@ -586,12 +586,6 @@
 { 
         unsigned char revid, tmp;
         
-	if (dev->subordinate) {
-		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
-		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-	}
-
         if (nr_ioapics == 0) 
                 return;
 
@@ -604,13 +598,6 @@
         }
 } 
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8131_BRIDGE, quirk_amd_8131_ioapic);
-
-static void __init quirk_svw_msi(struct pci_dev *dev)
-{
-	pci_msi_quirk = 1;
-	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
-}
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_GCNB_LE, quirk_svw_msi );
 #endif /* CONFIG_X86_IO_APIC */
 
 
