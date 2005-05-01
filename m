Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVEANxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVEANxU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 09:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVEANxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 09:53:20 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13319 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261622AbVEANxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 09:53:10 -0400
Date: Sun, 1 May 2005 15:53:08 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [RFC: 2.6 patch] drivers/pci/pci.c: remove pci_dac_set_dma_mask
Message-ID: <20050501135308.GC3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_dac_set_dma_mask is currently completely unused.

Is any usage planned in the forseeable future or is this patch to remove 
it OK?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/mach-ixp4xx/common-pci.c |   10 ----------
 drivers/pci/pci.c                 |   12 ------------
 include/linux/pci.h               |    2 --
 3 files changed, 24 deletions(-)

--- linux-2.6.12-rc3-mm1-full/include/linux/pci.h.old	2005-04-30 22:56:24.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/include/linux/pci.h	2005-04-30 22:56:31.000000000 +0200
@@ -815,7 +815,6 @@
 int pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
-int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
@@ -946,7 +945,6 @@
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
-static inline int pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
--- linux-2.6.12-rc3-mm1-full/drivers/pci/pci.c.old	2005-04-30 22:56:39.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/drivers/pci/pci.c	2005-04-30 22:57:07.000000000 +0200
@@ -806,17 +806,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (!pci_dac_dma_supported(dev, mask))
-		return -EIO;
-
-	dev->dma_mask = mask;
-
-	return 0;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (!pci_dma_supported(dev, mask))
@@ -878,7 +867,6 @@
 EXPORT_SYMBOL(pci_set_mwi);
 EXPORT_SYMBOL(pci_clear_mwi);
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_find_parent_resource);
--- linux-2.6.12-rc3-mm1-full/arch/arm/mach-ixp4xx/common-pci.c.old	2005-04-30 22:57:22.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/arch/arm/mach-ixp4xx/common-pci.c	2005-04-30 22:57:29.000000000 +0200
@@ -502,15 +502,6 @@
 }
     
 int
-pci_dac_set_dma_mask(struct pci_dev *dev, u64 mask)
-{
-	if (mask >= SZ_64M - 1 )
-		return 0;
-
-	return -EIO;
-}
-
-int
 pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
 {
 	if (mask >= SZ_64M - 1 )
@@ -520,7 +511,6 @@
 }
 
 EXPORT_SYMBOL(pci_set_dma_mask);
-EXPORT_SYMBOL(pci_dac_set_dma_mask);
 EXPORT_SYMBOL(pci_set_consistent_dma_mask);
 EXPORT_SYMBOL(ixp4xx_pci_read);
 EXPORT_SYMBOL(ixp4xx_pci_write);

