Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030544AbWBHGNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030544AbWBHGNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWBHGNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:13:47 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:59264 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030544AbWBHGNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:13:47 -0500
Message-ID: <43E98C73.2050903@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:15:15 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: matthew@wil.cx, grundler@parisc-linux.org
Subject: [PATCH] unify pfn_to_page take 2 [16/25] parisc funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parisc can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-parisc/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-parisc/mmzone.h
+++ test-layout-free-zone/include/asm-parisc/mmzone.h
@@ -25,23 +25,7 @@ extern struct node_map_data node_data[];
  	pg_data_t *__pgdat = NODE_DATA(nid);				\
  	__pgdat->node_start_pfn + __pgdat->node_spanned_pages;		\
  })
-#define node_localnr(pfn, nid)		((pfn) - node_start_pfn(nid))

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

  /* We have these possible memory map layouts:
   * Astro: 0-3.75, 67.75-68, 4-64
Index: test-layout-free-zone/include/asm-parisc/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-parisc/page.h
+++ test-layout-free-zone/include/asm-parisc/page.h
@@ -130,8 +130,6 @@ extern int npmem_ranges;
  #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))

  #ifndef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif /* CONFIG_DISCONTIGMEM */


