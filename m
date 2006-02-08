Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030557AbWBHGMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030557AbWBHGMO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030558AbWBHGMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:12:14 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:9896 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030557AbWBHGMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:12:14 -0500
Message-ID: <43E98C09.508@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:13:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: ralf@linux-mips.org
Subject: [PATCH] unify pfn_to_page take 2 [15/25] mips funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-mips/mmzone.h
===================================================================
--- test-layout-free-zone.orig/include/asm-mips/mmzone.h
+++ test-layout-free-zone/include/asm-mips/mmzone.h
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

Index: test-layout-free-zone/include/asm-mips/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-mips/page.h
+++ test-layout-free-zone/include/asm-mips/page.h
@@ -140,8 +140,6 @@ typedef struct { unsigned long pgprot; }
  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)

  #ifndef CONFIG_NEED_MULTIPLE_NODES
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
  #endif


