Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWBHGbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWBHGbZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbWBHGbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:31:25 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:26007 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030561AbWBHGbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:31:24 -0500
Message-ID: <43E9905E.7060609@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:31:58 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: davem@davemloft.net
Subject: [PATCH] unify pfn_to_page take 2 [22/25] sparc64 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Select CONFIG_DONT_INLINE_PFN_TO_PAGE=y
sparc64 can use generic funcs by defining ARCH_PFN_OFFSET as pfn_base.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>


Index: test-layout-free-zone/arch/sparc64/Kconfig
===================================================================
--- test-layout-free-zone.orig/arch/sparc64/Kconfig
+++ test-layout-free-zone/arch/sparc64/Kconfig
@@ -34,6 +34,10 @@ config ARCH_MAY_HAVE_PC_FDC
  	bool
  	default y

+config ARCH_DONT_INLINE_PFN_TO_PAGE
+	bool
+	default y
+
  choice
  	prompt "Kernel page size"
  	default SPARC64_PAGE_SIZE_8KB
Index: test-layout-free-zone/arch/sparc64/mm/init.c
===================================================================
--- test-layout-free-zone.orig/arch/sparc64/mm/init.c
+++ test-layout-free-zone/arch/sparc64/mm/init.c
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
Index: test-layout-free-zone/include/asm-sparc64/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-sparc64/page.h
+++ test-layout-free-zone/include/asm-sparc64/page.h
@@ -129,8 +129,7 @@ typedef unsigned long pgprot_t;
   * the first physical page in the machine is at some huge physical address,
   * such as 4GB.   This is common on a partitioned E10000, for example.
   */
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *);
+#define ARCH_PFN_OFFSET		(pfn_base)

  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr)>>PAGE_SHIFT)


