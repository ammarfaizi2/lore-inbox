Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWBFKxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWBFKxg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWBFKxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:53:36 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:63372 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751074AbWBFKxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:53:35 -0500
Message-ID: <43E72AFE.10709@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:54:54 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [6/25] frv pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

frv can use generic ones.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: cleanup_pfn_page/include/asm-frv/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-frv/page.h
+++ cleanup_pfn_page/include/asm-frv/page.h
@@ -57,15 +57,10 @@ extern unsigned long min_low_pfn;
  extern unsigned long max_pfn;

  #ifdef CONFIG_MMU
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long) ((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)
-
  #else
-#define pfn_to_page(pfn)	(&mem_map[(pfn) - (PAGE_OFFSET >> PAGE_SHIFT)])
-#define page_to_pfn(page)	((PAGE_OFFSET >> PAGE_SHIFT) + (unsigned long) ((page) - mem_map))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)		((pfn) >= min_low_pfn && (pfn) < max_low_pfn)
-
  #endif

  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

