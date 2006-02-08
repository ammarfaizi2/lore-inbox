Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWBHFnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWBHFnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWBHFnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:43:46 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36332 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030536AbWBHFnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:43:45 -0500
Message-ID: <43E98566.9020100@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:45:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] unify pfn_to_page take 2 [1/25] i386 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

386 can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-i386/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-i386/mmzone.h
+++ test-layout-free-zone/include/asm-i386/mmzone.h
@@ -86,21 +86,6 @@ static inline int pfn_to_nid(unsigned lo
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
-
  #ifdef CONFIG_X86_NUMAQ            /* we have contiguous memory on NUMA-Q */
  #define pfn_valid(pfn)          ((pfn) < num_physpages)
  #else
Index: test-layout-free-zone/include/asm-i386/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-i386/page.h
+++ test-layout-free-zone/include/asm-i386/page.h
@@ -126,8 +126,6 @@ extern int page_is_ram(unsigned long pag
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
  #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
  #ifdef CONFIG_FLATMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif /* CONFIG_FLATMEM */
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

