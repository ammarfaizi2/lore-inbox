Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWHJTxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWHJTxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbWHJThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:16 -0400
Received: from mx1.suse.de ([195.135.220.2]:11409 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932657AbWHJThE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:04 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [104/145] x86_64: print whether CONFIG_IOMMU_DEBUG is enabled
Message-Id: <20060810193702.5334E13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:02 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -127,15 +127,19 @@ static void tce_cache_blast(struct iommu
 
 /* enable this to stress test the chip's TCE cache */
 #ifdef CONFIG_IOMMU_DEBUG
+int debugging __read_mostly = 1;
+
 static inline void tce_cache_blast_stress(struct iommu_table *tbl)
 {
 	tce_cache_blast(tbl);
 }
-#else
+#else /* debugging is disabled */
+int debugging __read_mostly = 0;
+
 static inline void tce_cache_blast_stress(struct iommu_table *tbl)
 {
 }
-#endif /* BLAST_TCE_CACHE_ON_UNMAP */
+#endif /* CONFIG_IOMMU_DEBUG */
 
 static inline unsigned int num_dma_pages(unsigned long dma, unsigned int dmalen)
 {
@@ -944,8 +948,10 @@ void __init detect_calgary(void)
 	if (calgary_found) {
 		iommu_detected = 1;
 		calgary_detected = 1;
-		printk(KERN_INFO "PCI-DMA: Calgary IOMMU detected. "
-		       "TCE table spec is %d.\n", specified_table_size);
+		printk(KERN_INFO "PCI-DMA: Calgary IOMMU detected.\n");
+		printk(KERN_INFO "PCI-DMA: Calgary TCE table spec is %d, "
+		       "CONFIG_IOMMU_DEBUG is %s.\n", specified_table_size,
+		       debugging ? "enabled" : "disabled");
 	}
 	return;
 
