Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbWBNK4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWBNK4W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWBNK4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:56:22 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:38888 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030568AbWBNK4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:56:21 -0500
Message-ID: <43F1B762.9080303@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:56:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, davem@davemloft.net
Subject: [PATCH] unify pfn_to_page take3 [19/23] sparc64 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 can use generic funcs.
CONFIG_OUT_OF_LINE_PFN_TO_PAGE is selected.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: testtree/arch/sparc64/Kconfig
===================================================================
--- testtree.orig/arch/sparc64/Kconfig
+++ testtree/arch/sparc64/Kconfig
@@ -34,6 +34,10 @@ config ARCH_MAY_HAVE_PC_FDC
  	bool
  	default y

+config OUT_OF_LINE_PFN_TO_PAGE
+	bool
+	default y
+
  choice
  	prompt "Kernel page size"
  	default SPARC64_PAGE_SIZE_8KB
Index: testtree/arch/sparc64/mm/init.c
===================================================================
--- testtree.orig/arch/sparc64/mm/init.c
+++ testtree/arch/sparc64/mm/init.c
@@ -320,16 +320,6 @@ void __kprobes flush_icache_range(unsign
  	}
  }

-unsigned long page_to_pfn(struct page *page)
-{
-	return (unsigned long) ((page - mem_map) + pfn_base);
-}
-
-struct page *pfn_to_page(unsigned long pfn)
-{
-	return (mem_map + (pfn - pfn_base));
-}
-
  void show_mem(void)
  {
  	printk("Mem-info:\n");
Index: testtree/include/asm-sparc64/page.h
===================================================================
--- testtree.orig/include/asm-sparc64/page.h
+++ testtree/include/asm-sparc64/page.h
@@ -129,8 +129,8 @@ typedef unsigned long pgprot_t;
   * the first physical page in the machine is at some huge physical address,
   * such as 4GB.   This is common on a partitioned E10000, for example.
   */
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *);
+/* pfn_base is declared in pgtable.h */
+#define ARCH_PFN_OFFSET		(pfn_base)

  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr)>>PAGE_SHIFT)

@@ -147,6 +147,7 @@ extern unsigned long page_to_pfn(struct

  #endif /* !(__KERNEL__) */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* !(_SPARC64_PAGE_H) */

