Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBFK5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBFK5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBFK5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:57:01 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:53705 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751082AbWBFK5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:57:00 -0500
Message-ID: <43E72BC8.2010000@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:58:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [8/25] i386 pfn_to_page/ page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386 can use generic ones.
Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-i386/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-i386/mmzone.h
+++ cleanup_pfn_page/include/asm-i386/mmzone.h
@@ -86,20 +86,7 @@ static inline int pfn_to_nid(unsigned lo
  /* XXX: FIXME -- wli */
  #define kern_addr_valid(kaddr)	(0)

-#define pfn_to_page(pfn)						\
-({									\
-	unsigned long __pfn = pfn;					\
-	int __node  = pfn_to_nid(__pfn);				\
-	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
-})
-
-#define page_to_pfn(pg)							\
-({									\
-	struct page *__page = pg;					\
-	struct zone *__zone = page_zone(__page);			\
-	(unsigned long)(__page - __zone->zone_mem_map)			\
-		+ __zone->zone_start_pfn;				\
-})
+#define arch_pfn_to_nid		pfn_to_nid(pfn)

  #ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
  #define pfn_valid(pfn)          ((pfn) < num_physpages)
Index: cleanup_pfn_page/include/asm-i386/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-i386/page.h
+++ cleanup_pfn_page/include/asm-i386/page.h
@@ -126,8 +126,6 @@ extern int page_is_ram(unsigned long pag
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif /* CONFIG_FLATMEM */
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

