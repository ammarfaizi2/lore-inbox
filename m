Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWHBPWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWHBPWH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHBPWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:22:07 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:58583 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751192AbWHBPWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:22:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: [PATCH] Use valid_dma_direction() in include/asm-i386/dma-mapping.h
Date: Wed, 2 Aug 2006 17:22:35 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728174449.GA11046@rhun.ibm.com>
In-Reply-To: <20060728174449.GA11046@rhun.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608021722.35797.eike-kernel@sf-tec.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the generic DMA code has a function to decide if a given DMA
mapping is valid use it. This will catch cases where direction is not any
of the defined enum values but some random number outside the valid range.
The current implementation will only catch the defined but invalid case
DMA_NONE.

Signed-off-by: Rolf Eike Beer

---
commit 61f76f37d18da432ea1b55b92c98dd39388077f0
tree e8c5d79bdb2e2b786b4d5c719d64f28dfc54c4fb
parent 9f990495512e3f106ce56f885a675636b47ff421
author Rolf Eike Beer <eike-kernel@sf-tec.de> Wed, 02 Aug 2006 17:11:04 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Wed, 02 Aug 2006 17:11:04 +0200

 include/asm-i386/dma-mapping.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
index 576ae01..81999a3 100644
--- a/include/asm-i386/dma-mapping.h
+++ b/include/asm-i386/dma-mapping.h
@@ -21,7 +21,7 @@ static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 	WARN_ON(size == 0);
 	flush_write_buffers();
 	return virt_to_phys(ptr);
@@ -31,7 +31,7 @@ static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		 enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 }
 
 static inline int
@@ -40,7 +40,7 @@ dma_map_sg(struct device *dev, struct sc
 {
 	int i;
 
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 	WARN_ON(nents == 0 || sg[0].length == 0);
 
 	for (i = 0; i < nents; i++ ) {
@@ -57,7 +57,7 @@ static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page, unsigned long offset,
 	     size_t size, enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 	return page_to_phys(page) + offset;
 }
 
@@ -65,7 +65,7 @@ static inline void
 dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
 	       enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 }
 
 
@@ -73,7 +73,7 @@ static inline void
 dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
 	     enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!valid_dma_direction(direction));
 }
 
 static inline void
