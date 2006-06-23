Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWFWSnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWFWSnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWFWSmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:17871 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751919AbWFWSl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:41:58 -0400
Message-Id: <20060623183911.037826000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:02 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Richard Hirst <rhirst@levanta.com>
Subject: [PATCH 06/21] dma API addition
Content-Disposition: inline; filename=0006-M68K-dma-API-addition.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Additions to dma API with some small cleanups.

Signed-off-by: Richard Hirst <rhirst@levanta.com>
Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/asm-m68k/dma-mapping.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

917fa3653132a17ee8b8ad27e906683cabe3dce1
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index 4f8575e..cebbb03 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -1,6 +1,8 @@
 #ifndef _M68K_DMA_MAPPING_H
 #define _M68K_DMA_MAPPING_H
 
+#include <asm/cache.h>
+
 struct scatterlist;
 
 static inline int dma_supported(struct device *dev, u64 mask)
@@ -13,11 +15,37 @@ static inline int dma_set_mask(struct de
 	return 0;
 }
 
+static inline int dma_get_cache_alignment(void)
+{
+	return 1 << L1_CACHE_SHIFT;
+}
+
+static inline int dma_is_consistent(dma_addr_t dma_addr)
+{
+	return 0;
+}
+
 extern void *dma_alloc_coherent(struct device *, size_t,
 				dma_addr_t *, int);
 extern void dma_free_coherent(struct device *, size_t,
 			      void *, dma_addr_t);
 
+static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
+					  dma_addr_t *handle, int flag)
+{
+	return dma_alloc_coherent(dev, size, handle, flag);
+}
+static inline void dma_free_noncoherent(struct device *dev, size_t size,
+					void *addr, dma_addr_t handle)
+{
+	dma_free_coherent(dev, size, addr, handle);
+}
+static inline void dma_cache_sync(void *vaddr, size_t size,
+				  enum dma_data_direction dir)
+{
+	/* we use coherent allocation, so not much to do here. */
+}
+
 extern dma_addr_t dma_map_single(struct device *, void *, size_t,
 				 enum dma_data_direction);
 static inline void dma_unmap_single(struct device *dev, dma_addr_t addr,
-- 
1.3.3

--

