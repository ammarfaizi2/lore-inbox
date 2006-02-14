Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030566AbWBNK47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030566AbWBNK47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWBNK46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:56:58 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59558 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030566AbWBNK45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:56:57 -0500
Message-ID: <43F1B7BF.80509@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:58:07 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [20/23] UML pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-um/page.h
===================================================================
--- testtree.orig/include/asm-um/page.h
+++ testtree/include/asm-um/page.h
@@ -106,9 +106,6 @@ extern unsigned long uml_physmem;
  #define __pa(virt) to_phys((void *) (unsigned long) (virt))
  #define __va(phys) to_virt((unsigned long) (phys))

-#define page_to_pfn(page) ((page) - mem_map)
-#define pfn_to_page(pfn) (mem_map + (pfn))
-
  #define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
  #define pfn_to_phys(pfn) ((pfn) << PAGE_SHIFT)

@@ -121,6 +118,7 @@ extern struct page *arch_validate(struct
  extern void arch_free_page(struct page *page, int order);
  #define HAVE_ARCH_FREE_PAGE

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif


