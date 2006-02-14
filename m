Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWBNKuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWBNKuF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWBNKuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:50:04 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32173 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030564AbWBNKuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:50:02 -0500
Message-ID: <43F1B618.6080109@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:51:04 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, lethal@linux-sh.org
Subject: [PATCH] unify pfn_to_page take3 [17/23] sh64 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh64 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-sh64/page.h
===================================================================
--- testtree.orig/include/asm-sh64/page.h
+++ testtree/include/asm-sh64/page.h
@@ -105,9 +105,7 @@ typedef struct { unsigned long pgprot; }

  /* PFN start number, because of __MEMORY_START */
  #define PFN_START		(__MEMORY_START >> PAGE_SHIFT)
-
-#define pfn_to_page(pfn)	(mem_map + (pfn) - PFN_START)
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PFN_START)
+#define ARCH_PFN_OFFSET		(PFN_START)
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - PFN_START) < max_mapnr)
  #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
@@ -117,6 +115,7 @@ typedef struct { unsigned long pgprot; }

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* __ASM_SH64_PAGE_H */

