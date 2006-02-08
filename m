Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWBHGEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWBHGEZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWBHGEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:04:25 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:48347 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965171AbWBHGEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:04:24 -0500
Message-ID: <43E98A01.70608@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:04:49 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: takata@linux-m32r.org
Subject: [PATCH] unify pfn_to_page take 2 [12/25] m32r funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

m32r can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-m32r/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-m32r/mmzone.h
+++ test-layout-free-zone/include/asm-m32r/mmzone.h
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
Index: test-layout-free-zone/include/asm-m32r/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-m32r/page.h
+++ test-layout-free-zone/include/asm-m32r/page.h
@@ -76,9 +76,7 @@ typedef struct { unsigned long pgprot; }

  #ifndef CONFIG_DISCONTIGMEM
  #define PFN_BASE		(CONFIG_MEMORY_START >> PAGE_SHIFT)
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PFN_BASE))
-#define page_to_pfn(page)	\
-	((unsigned long)((page) - mem_map) + PFN_BASE)
+#define ARCH_PFN_OFFSET		PFN_BASE
  #define pfn_valid(pfn)		(((pfn) - PFN_BASE) < max_mapnr)
  #endif  /* !CONFIG_DISCONTIGMEM */


