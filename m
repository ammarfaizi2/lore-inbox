Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbWBNK1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbWBNK1P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWBNK1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:27:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48361 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030554AbWBNK1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:27:14 -0500
Message-ID: <43F1B0D6.2010905@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:28:38 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [10/23] h8300 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H8300 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-h8300/page.h
===================================================================
--- testtree.orig/include/asm-h8300/page.h
+++ testtree/include/asm-h8300/page.h
@@ -71,8 +71,7 @@ extern unsigned long memory_end;
  #define page_to_virt(page)	((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET)
  #define pfn_valid(page)	        (page < max_mapnr)

-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
+#define ARCH_PFH_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)

  #define	virt_addr_valid(kaddr)	(((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
  				((void *)(kaddr) < (void *)memory_end))
@@ -81,6 +80,7 @@ extern unsigned long memory_end;

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _H8300_PAGE_H */

