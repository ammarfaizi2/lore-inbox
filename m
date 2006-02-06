Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbWBFLA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWBFLA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbWBFLA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:00:59 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:58831 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932067AbWBFLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:00:58 -0500
Message-ID: <43E72CBC.8050006@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:02:20 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [10/25] m32r pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m32r can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-m32r/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-m32r/mmzone.h
+++ cleanup_pfn_page/include/asm-m32r/mmzone.h
@@ -21,20 +21,6 @@ extern struct pglist_data *node_data[];
  	__pgdat->node_start_pfn + __pgdat->node_spanned_pages - 1;	\
  })

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
  #define pmd_page(pmd)		(pfn_to_page(pmd_val(pmd) >> PAGE_SHIFT))
  /*
   * pfn_valid should be made as fast as possible, and the current definition
Index: cleanup_pfn_page/include/asm-m32r/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-m32r/page.h
+++ cleanup_pfn_page/include/asm-m32r/page.h
@@ -76,9 +76,7 @@ typedef struct { unsigned long pgprot; }

  #ifndef CONFIG_DISCONTIGMEM
  #define PFN_BASE		(CONFIG_MEMORY_START >> PAGE_SHIFT)
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PFN_BASE))
-#define page_to_pfn(page)	\
-	((unsigned long)((page) - mem_map) + PFN_BASE)
+#define ARCH_PFN_OFFSET		PFN_BASE
  #define pfn_valid(pfn)		(((pfn) - PFN_BASE) < max_mapnr)
  #endif  /* !CONFIG_DISCONTIGMEM */


