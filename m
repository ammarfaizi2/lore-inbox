Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161002AbWBNK60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161002AbWBNK60 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161001AbWBNK60
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:58:26 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40378 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161000AbWBNK6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:58:25 -0500
Message-ID: <43F1B81F.2090806@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:59:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [21/23] v850 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v850 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-v850/page.h
===================================================================
--- testtree.orig/include/asm-v850/page.h
+++ testtree/include/asm-v850/page.h
@@ -111,8 +111,7 @@ typedef unsigned long pgprot_t;
  #define page_to_virt(page) \
    ((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)

-#define pfn_to_page(pfn)	virt_to_page (pfn_to_virt (pfn))
-#define page_to_pfn(page)	virt_to_pfn (page_to_virt (page))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)	        ((pfn) < max_mapnr)

  #define	virt_addr_valid(kaddr)						\
@@ -125,6 +124,7 @@ typedef unsigned long pgprot_t;

  #endif /* KERNEL */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* __V850_PAGE_H__ */


