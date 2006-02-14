Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030549AbWBNKWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030549AbWBNKWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWBNKWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:22:33 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44987 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030549AbWBNKWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:22:32 -0500
Message-ID: <43F1AFAD.6000708@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:23:41 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, mikael.starvik@axis.com
Subject: [PATCH] unify pfn_to_page take3 [8/23] cris pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cris can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-cris/page.h
===================================================================
--- testtree.orig/include/asm-cris/page.h
+++ testtree/include/asm-cris/page.h
@@ -43,8 +43,7 @@ typedef struct { unsigned long pgprot; }

  /* On CRIS the PFN numbers doesn't start at 0 so we have to compensate */
  /* for that before indexing into the page table starting at mem_map    */
-#define pfn_to_page(pfn)	(mem_map + ((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + (PAGE_OFFSET >> PAGE_SHIFT))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)		(((pfn) - (PAGE_OFFSET >> PAGE_SHIFT)) < max_mapnr)

  /* to index into the page map. our pages all start at physical addr PAGE_OFFSET so
@@ -77,6 +76,7 @@ typedef struct { unsigned long pgprot; }

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _CRIS_PAGE_H */

