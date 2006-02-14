Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbWBNKfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbWBNKfA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030556AbWBNKfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:35:00 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:44952 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030551AbWBNKe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:34:59 -0500
Message-ID: <43F1B29B.3030909@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:36:11 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: [PATCH] unify pfn_to_page take3 [12/23] mips pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-mips/mmzone.h
===================================================================
--- testtree.orig/include/asm-mips/mmzone.h
+++ testtree/include/asm-mips/mmzone.h
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

Index: testtree/include/asm-mips/page.h
===================================================================
--- testtree.orig/include/asm-mips/page.h
+++ testtree/include/asm-mips/page.h
@@ -17,6 +17,7 @@

  #endif

+
  /*
   * PAGE_SHIFT determines the page size
   */
@@ -140,8 +141,6 @@ typedef struct { unsigned long pgprot; }
  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

  #ifndef CONFIG_NEED_MULTIPLE_NODES
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif

@@ -160,6 +159,7 @@ typedef struct { unsigned long pgprot; }
  #define WANT_PAGE_VIRTUAL
  #endif

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _ASM_PAGE_H */

