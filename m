Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030550AbWBNKZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030550AbWBNKZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030553AbWBNKZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:25:11 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17639 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030550AbWBNKZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:25:09 -0500
Message-ID: <43F1B028.9020604@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:25:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, dhowells@redhat.com
Subject: [PATCH] unify pfn_to_page take3 [9/23]  frv pfn_tp_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FRV can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-frv/page.h
===================================================================
--- testtree.orig/include/asm-frv/page.h
+++ testtree/include/asm-frv/page.h
@@ -57,13 +57,9 @@ extern unsigned long min_low_pfn;
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

  #endif
@@ -87,6 +83,7 @@ extern unsigned long max_pfn;
  #define WANT_PAGE_VIRTUAL	1
  #endif

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _ASM_PAGE_H */

