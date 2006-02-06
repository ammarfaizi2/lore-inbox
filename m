Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWBFLGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWBFLGT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932068AbWBFLGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:06:19 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:18849 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932072AbWBFLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:06:18 -0500
Message-ID: <43E72E04.5020204@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:07:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [13/25]  mips  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mips can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: cleanup_pfn_page/include/asm-mips/mmzone.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-mips/mmzone.h
+++ cleanup_pfn_page/include/asm-mips/mmzone.h
@@ -22,20 +22,6 @@
  		       NODE_DATA(__n)->node_spanned_pages) : 0);\
  })

-#define pfn_to_page(pfn)					\
-({								\
- 	unsigned long __pfn = (pfn);				\
-	pg_data_t *__pg = NODE_DATA(pfn_to_nid(__pfn));		\
-	__pg->node_mem_map + (__pfn - __pg->node_start_pfn);	\
-})
-
-#define page_to_pfn(p)						\
-({								\
-	struct page *__p = (p);					\
-	struct zone *__z = page_zone(__p);			\
-	((__p - __z->zone_mem_map) + __z->zone_start_pfn);	\
-})
-
  /* XXX: FIXME -- wli */
  #define kern_addr_valid(addr)	(0)

Index: cleanup_pfn_page/include/asm-mips/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-mips/page.h
+++ cleanup_pfn_page/include/asm-mips/page.h
@@ -140,8 +140,6 @@ typedef struct { unsigned long pgprot; }
  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

  #ifndef CONFIG_NEED_MULTIPLE_NODES
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif


