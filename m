Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUGRUb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUGRUb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 16:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGRUb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 16:31:26 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:33959 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S264503AbUGRUbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 16:31:24 -0400
Date: Sun, 18 Jul 2004 22:29:30 +0200
To: akpm@osdl.org
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: Use include/asm-generic/dma-mapping-broken.h
Message-ID: <20040718202930.GA9542@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ChangeSet 1.1371.413.23 [1] introduced the file
include/asm-generic/dma-mapping-broken.h for architectures that don't
support the new DMA API. I don't know if this is the case with s390,
however, ChangeSet 1.1371.445.6 [2] introduced a set of changes that
duplicate those in include/asm-generic/dma-mapping-broken.h.

This patch squishes that duplication by simply including
include/asm-generic/dma-mapping-broken.h in
include/asm-s390/dma-mapping.h.

Against 2.6.7, but applies cleanly against 2.6.8-rc2. Thanks.

[1] http://tinyurl.com/7y2d9
[2] http://tinyurl.com/5qybl

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>


 dma-mapping.h |   13 +------------
 1 files changed, 1 insertion(+), 12 deletions(-)

--- a/include/asm-s390/dma-mapping.h	2004-04-11 14:05:20.000000000 +0200
+++ b/include/asm-s390/dma-mapping.h	2004-05-03 00:36:56.000000000 +0200
@@ -9,17 +9,6 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *dma_handle, int flag)
-{
-	BUG();
-	return 0;
-}
-
-static inline void dma_free_coherent(struct device *dev, size_t size,
-		       void *vaddr, dma_addr_t dma_handle)
-{
-	BUG();
-}
+#include <asm-generic/dma-mapping-broken.h>
 
 #endif /* _ASM_DMA_MAPPING_H */
