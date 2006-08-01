Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHAM7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHAM7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 08:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWHAM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 08:59:37 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:51804 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750720AbWHAM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 08:59:36 -0400
Date: Tue, 1 Aug 2006 15:59:32 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       "discuss@x86-64.org" <discuss@x86-64.org>
Subject: [PATCH x86-64]: remove superflous BUG_ON's in nommu and gart
Message-ID: <20060801125932.GF3436@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to check for invalid DMA data direction in nommu and
gart since we do it in dma-mapping.h anyway before calling the
individual dma-ops.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r b90678f884c4 arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Mon Jul 31 21:01:32 2006 +0000
+++ b/arch/x86_64/kernel/pci-gart.c	Tue Aug 01 15:52:52 2006 +0300
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
 
diff -r b90678f884c4 arch/x86_64/kernel/pci-nommu.c
--- a/arch/x86_64/kernel/pci-nommu.c	Mon Jul 31 21:01:32 2006 +0000
+++ b/arch/x86_64/kernel/pci-nommu.c	Tue Aug 01 15:52:58 2006 +0300
@@ -59,7 +59,6 @@ int nommu_map_sg(struct device *hwdev, s
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
  	for (i = 0; i < nents; i++ ) {
 		struct scatterlist *s = &sg[i];
 		BUG_ON(!s->page);


