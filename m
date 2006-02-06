Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWBFLH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWBFLH4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWBFLH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:07:56 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48089 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932068AbWBFLHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:07:55 -0500
Message-ID: <43E72E42.4020600@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:08:50 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [14/25]  parisc pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PA-RISC can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-parisc/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-parisc/mmzone.h
+++ cleanup_pfn_page/include/asm-parisc/mmzone.h
@@ -26,22 +26,7 @@ extern struct node_map_data node_data[];
  	__pgdat->node_start_pfn + __pgdat->node_spanned_pages;		\
  })
  #define node_localnr(pfn, nid)		((pfn) - node_start_pfn(nid))
-
-#define pfn_to_page(pfn)						\
-({									\
-	unsigned long __pfn = (pfn);					\
-	int __node  = pfn_to_nid(__pfn);				\
-	&NODE_DATA(__node)->node_mem_map[node_localnr(__pfn,__node)];	\
-})
-
-#define page_to_pfn(pg)							\
-({									\
-	struct page *__page = pg;					\
-	struct zone *__zone = page_zone(__page);			\
-	BUG_ON(__zone == NULL);						\
-	(unsigned long)(__page - __zone->zone_mem_map)			\
-		+ __zone->zone_start_pfn;				\
-})
+#define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)

  /* We have these possible memory map layouts:
   * Astro: 0-3.75, 67.75-68, 4-64
Index: cleanup_pfn_page/include/asm-parisc/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-parisc/page.h
+++ cleanup_pfn_page/include/asm-parisc/page.h
@@ -130,8 +130,6 @@ extern int npmem_ranges;
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))

  #ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif /* CONFIG_DISCONTIGMEM */


