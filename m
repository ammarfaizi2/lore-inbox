Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWHJT6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWHJT6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWHJThL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:37:11 -0400
Received: from mail.suse.de ([195.135.220.2]:12177 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932659AbWHJThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:05 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [106/145] x86_64: remove tce_cache_blast_stress()
Message-Id: <20060810193704.7164713C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:04 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

tce_cache_blast_stress was useful during bringup to stress the IOMMU's
cache flushing. Now that we quiesce DMAs on every cache flush, using
_stress() brings the machine down to its knees once you put it under
load. Remove this debug / bringup code that isn't useful anymore
completely.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   11 -----------
 1 files changed, 11 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -129,11 +129,6 @@ static void tce_cache_blast(struct iommu
 #ifdef CONFIG_IOMMU_DEBUG
 int debugging __read_mostly = 1;
 
-static inline void tce_cache_blast_stress(struct iommu_table *tbl)
-{
-	tce_cache_blast(tbl);
-}
-
 static inline unsigned long verify_bit_range(unsigned long* bitmap,
 	int expected, unsigned long start, unsigned long end)
 {
@@ -153,10 +148,6 @@ static inline unsigned long verify_bit_r
 #else /* debugging is disabled */
 int debugging __read_mostly = 0;
 
-static inline void tce_cache_blast_stress(struct iommu_table *tbl)
-{
-}
-
 static inline unsigned long verify_bit_range(unsigned long* bitmap,
 	int expected, unsigned long start, unsigned long end)
 {
@@ -289,8 +280,6 @@ static void __iommu_free(struct iommu_ta
 	}
 
 	__clear_bit_string(tbl->it_map, entry, npages);
-
-	tce_cache_blast_stress(tbl);
 }
 
 static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
