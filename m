Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbWJDN0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbWJDN0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWJDN0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:26:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:2528 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932415AbWJDN0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:26:35 -0400
Date: Wed, 4 Oct 2006 14:26:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: zippel@linux-m68k.org, akpm@osdl.org
Subject: [PATCH] m68k dma_alloc_coherent() has gfp_t as the last argument
Message-ID: <20061004132634.GK29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

annotate, fix the bogus argument of vmap() in it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/kernel/dma.c         |    4 ++--
 include/asm-m68k/dma-mapping.h |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index fc449f8..9d4e4b5 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -15,7 +15,7 @@ #include <asm/pgalloc.h>
 #include <asm/scatterlist.h>
 
 void *dma_alloc_coherent(struct device *dev, size_t size,
-			 dma_addr_t *handle, int flag)
+			 dma_addr_t *handle, gfp_t flag)
 {
 	struct page *page, **map;
 	pgprot_t pgprot;
@@ -51,7 +51,7 @@ void *dma_alloc_coherent(struct device *
 		pgprot_val(pgprot) |= _PAGE_GLOBAL040 | _PAGE_NOCACHE_S;
 	else
 		pgprot_val(pgprot) |= _PAGE_NOCACHE030;
-	addr = vmap(map, size, flag, pgprot);
+	addr = vmap(map, size, VM_MAP, pgprot);
 	kfree(map);
 
 	return addr;
diff --git a/include/asm-m68k/dma-mapping.h b/include/asm-m68k/dma-mapping.h
index cebbb03..c1299c3 100644
--- a/include/asm-m68k/dma-mapping.h
+++ b/include/asm-m68k/dma-mapping.h
@@ -26,7 +26,7 @@ static inline int dma_is_consistent(dma_
 }
 
 extern void *dma_alloc_coherent(struct device *, size_t,
-				dma_addr_t *, int);
+				dma_addr_t *, gfp_t);
 extern void dma_free_coherent(struct device *, size_t,
 			      void *, dma_addr_t);
 
-- 
1.4.2.GIT

