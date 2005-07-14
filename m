Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVGNWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGNWNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVGNWN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:13:27 -0400
Received: from coderock.org ([193.77.147.115]:13217 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263150AbVGNVoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 17:44:24 -0400
Message-Id: <20050714214402.975215000@homer>
Date: Thu, 14 Jul 2005 23:44:01 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Victor Fusco <victor@cetuc.puc-rio.br>,
       domen@coderock.org
Subject: [patch 3/5] dmapool: Fix "nocast type" warnings
Content-Disposition: inline; filename=sparse-drivers_base_dmapool
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Fusco <victor@cetuc.puc-rio.br>


Fix the sparse warning "implicit cast to nocast type"

File/Subsystem:drivers/base/dmapool

Signed-off-by: Victor Fusco <victor@cetuc.puc-rio.br>
Signed-off-by: Domen Puncer <domen@coderock.org>

--

---
 drivers/base/dmapool.c  |    3 ++-
 include/linux/dmapool.h |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: quilt/drivers/base/dmapool.c
===================================================================
--- quilt.orig/drivers/base/dmapool.c
+++ quilt/drivers/base/dmapool.c
@@ -262,7 +262,8 @@ dma_pool_destroy (struct dma_pool *pool)
  * If such a memory block can't be allocated, null is returned.
  */
 void *
-dma_pool_alloc (struct dma_pool *pool, int mem_flags, dma_addr_t *handle)
+dma_pool_alloc (struct dma_pool *pool, unsigned int __nocast mem_flags,
+		dma_addr_t *handle)
 {
 	unsigned long		flags;
 	struct dma_page		*page;
Index: quilt/include/linux/dmapool.h
===================================================================
--- quilt.orig/include/linux/dmapool.h
+++ quilt/include/linux/dmapool.h
@@ -19,7 +19,8 @@ struct dma_pool *dma_pool_create(const c
 
 void dma_pool_destroy(struct dma_pool *pool);
 
-void *dma_pool_alloc(struct dma_pool *pool, int mem_flags, dma_addr_t *handle);
+void *dma_pool_alloc(struct dma_pool *pool, unsigned int __nocast mem_flags,
+		     dma_addr_t *handle);
 
 void dma_pool_free(struct dma_pool *pool, void *vaddr, dma_addr_t addr);
 

--
