Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161001AbWBNLAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbWBNLAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 06:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161004AbWBNLAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 06:00:25 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:50108 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161001AbWBNLAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 06:00:24 -0500
Message-ID: <43F1B894.2090808@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 20:01:40 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [22/23] xtensa pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-xtensa/page.h
===================================================================
--- testtree.orig/include/asm-xtensa/page.h
+++ testtree/include/asm-xtensa/page.h
@@ -109,10 +109,7 @@ void copy_user_page(void *to,void* from,
  #define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
  #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
  #define pfn_valid(pfn)		((unsigned long)pfn < max_mapnr)
-#ifndef CONFIG_DISCONTIGMEM
-# define pfn_to_page(pfn)	(mem_map + (pfn))
-# define page_to_pfn(page)	((unsigned long)((page) - mem_map))
-#else
+#ifdef CONFIG_DISCONTIGMEM
  # error CONFIG_DISCONTIGMEM not supported
  #endif

@@ -130,4 +127,5 @@ void copy_user_page(void *to,void* from,
  				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)

  #endif /* __KERNEL__ */
+#include <asm-generic/memory_model.h>
  #endif /* _XTENSA_PAGE_H */

