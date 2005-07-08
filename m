Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262682AbVGHPDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262682AbVGHPDT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 11:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVGHPDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 11:03:19 -0400
Received: from ns2.suse.de ([195.135.220.15]:64436 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262682AbVGHPDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 11:03:15 -0400
Date: Fri, 8 Jul 2005 17:03:13 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH]  implicit declaration of function `page_cache_release'
Message-ID: <20050708150313.GA30373@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In file included from include2/asm/tlb.h:31,
                 from linux-2.6.13-rc2-olh/arch/ppc64/kernel/pSeries_lpar.c:37:
linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_flush_mmu':
linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:77: warning: implicit declaration of function `release_pages'
linux-2.6.13-rc2-olh/include/asm-generic/tlb.h: In function `tlb_remove_page':
linux-2.6.13-rc2-olh/include/asm-generic/tlb.h:117: warning: implicit declaration of function `page_cache_release'

Signed-off-by: Olaf Hering <olh@suse.de>

 include/linux/pagemap.h |    2 +-
 include/linux/swap.h    |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc2-olh/include/linux/pagemap.h
===================================================================
--- linux-2.6.13-rc2-olh.orig/include/linux/pagemap.h
+++ linux-2.6.13-rc2-olh/include/linux/pagemap.h
@@ -48,7 +48,7 @@ static inline void mapping_set_gfp_mask(
 
 #define page_cache_get(page)		get_page(page)
 #define page_cache_release(page)	put_page(page)
-void release_pages(struct page **pages, int nr, int cold);
+extern void release_pages(struct page **pages, int nr, int cold);
 
 static inline struct page *page_cache_alloc(struct address_space *x)
 {
Index: linux-2.6.13-rc2-olh/include/linux/swap.h
===================================================================
--- linux-2.6.13-rc2-olh.orig/include/linux/swap.h
+++ linux-2.6.13-rc2-olh/include/linux/swap.h
@@ -7,6 +7,7 @@
 #include <linux/mmzone.h>
 #include <linux/list.h>
 #include <linux/sched.h>
+#include <linux/pagemap.h>
 #include <asm/atomic.h>
 #include <asm/page.h>
 
