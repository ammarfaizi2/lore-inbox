Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWBNKoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWBNKoO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030562AbWBNKoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:44:14 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:30166 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030561AbWBNKoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:44:13 -0500
Message-ID: <43F1B4AC.4070109@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:45:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [15/23] s390 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s390 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-s390/page.h
===================================================================
--- testtree.orig/include/asm-s390/page.h
+++ testtree/include/asm-s390/page.h
@@ -181,8 +181,6 @@ page_get_storage_key(unsigned long addr)
  #define PAGE_OFFSET             0x0UL
  #define __pa(x)                 (unsigned long)(x)
  #define __va(x)                 (void *)(unsigned long)(x)
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)

  #define pfn_valid(pfn)		((pfn) < max_mapnr)
@@ -193,6 +191,7 @@ page_get_storage_key(unsigned long addr)

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _S390_PAGE_H */

