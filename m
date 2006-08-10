Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWHJUJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWHJUJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbWHJUEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:59371 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932640AbWHJTgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:44 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [86/145] x86_64: remove superflous BUG_ON's in nommu and gart
Message-Id: <20060810193643.455CC13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:43 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

There's no need to check for invalid DMA data direction in nommu and
gart since we do it in dma-mapping.h anyway before calling the
individual dma-ops.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-gart.c  |    3 ---
 arch/x86_64/kernel/pci-nommu.c |    1 -
 2 files changed, 4 deletions(-)

Index: linux/arch/x86_64/kernel/pci-gart.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-gart.c
+++ linux/arch/x86_64/kernel/pci-gart.c
@@ -239,8 +239,6 @@ dma_addr_t gart_map_single(struct device
 {
 	unsigned long phys_mem, bus;
 
-	BUG_ON(dir == DMA_NONE);
-
 	if (!dev)
 		dev = &fallback_dev;
 
@@ -383,7 +381,6 @@ int gart_map_sg(struct device *dev, stru
 	unsigned long pages = 0;
 	int need = 0, nextneed;
 
-	BUG_ON(dir == DMA_NONE);
 	if (nents == 0) 
 		return 0;
 
Index: linux/arch/x86_64/kernel/pci-nommu.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-nommu.c
+++ linux/arch/x86_64/kernel/pci-nommu.c
@@ -59,7 +59,6 @@ int nommu_map_sg(struct device *hwdev, s
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
  	for (i = 0; i < nents; i++ ) {
 		struct scatterlist *s = &sg[i];
 		BUG_ON(!s->page);
