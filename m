Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWBNKqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWBNKqR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWBNKqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:46:17 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:51672 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030562AbWBNKqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:46:17 -0500
Message-ID: <43F1B52B.8050707@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:47:07 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, lethal@linux-sh.org
Subject: Re: [PATCH] unify pfn_to_page take3 [16/23] sh pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sh can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-sh/page.h
===================================================================
--- testtree.orig/include/asm-sh/page.h
+++ testtree/include/asm-sh/page.h
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

  #endif /* __ASM_SH_PAGE_H */

