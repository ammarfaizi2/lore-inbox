Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWBNKwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWBNKwu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbWBNKwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:52:49 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:28851 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030565AbWBNKws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:52:48 -0500
Message-ID: <43F1B6D0.9010201@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:54:08 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, sparclinux@vger.kernel.org
Subject: [PATCH] unify pfn_to_page take3 [18/23] sparc pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-sparc/page.h
===================================================================
--- testtree.orig/include/asm-sparc/page.h
+++ testtree/include/asm-sparc/page.h
@@ -9,6 +9,7 @@
  #define _SPARC_PAGE_H

  #include <linux/config.h>
+
  #ifdef CONFIG_SUN4
  #define PAGE_SHIFT   13
  #else
@@ -152,8 +153,7 @@ extern unsigned long pfn_base;
  #define virt_to_phys		__pa
  #define phys_to_virt		__va

-#define pfn_to_page(pfn)	(mem_map + ((pfn)-(pfn_base)))
-#define page_to_pfn(page)	((unsigned long)(((page) - mem_map) + pfn_base))
+#define ARCH_PFN_OFFSET		(pfn_base)
  #define virt_to_page(kaddr)	(mem_map + ((((unsigned long)(kaddr)-PAGE_OFFSET)>>PAGE_SHIFT)))

  #define pfn_valid(pfn)		(((pfn) >= (pfn_base)) && (((pfn)-(pfn_base)) < max_mapnr))
@@ -164,6 +164,7 @@ extern unsigned long pfn_base;

  #endif /* __KERNEL__ */

+#include <asm-generic/memory_model.h>
  #include <asm-generic/page.h>

  #endif /* _SPARC_PAGE_H */


