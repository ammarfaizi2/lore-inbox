Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWBFLWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWBFLWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWBFLWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:22:42 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58807 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751087AbWBFLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:22:41 -0500
Message-ID: <43E731B5.9050407@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:23:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [25/25]  sparc64  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 can use generic ones by defining ARCH_PFN_OFFSET as pfn_base.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitu.com>

Index: cleanup_pfn_page/include/asm-sparc64/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-sparc64/page.h
+++ cleanup_pfn_page/include/asm-sparc64/page.h
@@ -129,8 +129,7 @@ typedef unsigned long pgprot_t;
   * the first physical page in the machine is at some huge physical address,
   * such as 4GB.   This is common on a partitioned E10000, for example.
   */
-extern struct page *pfn_to_page(unsigned long pfn);
-extern unsigned long page_to_pfn(struct page *);
+#define ARCH_PFN_OFFSET		(pfn_base)

  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr)>>PAGE_SHIFT)

Index: cleanup_pfn_page/arch/sparc64/mm/init.c
===================================================================
--- cleanup_pfn_page.orig/arch/sparc64/mm/init.c
+++ cleanup_pfn_page/arch/sparc64/mm/init.c
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

