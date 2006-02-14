Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWBNKms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWBNKms (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030560AbWBNKms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:42:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:7587 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030558AbWBNKmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:42:47 -0500
Message-ID: <43F1B458.9040201@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:43:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] unify pfn_to_page take3 [14/23] ppc pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-ppc/page.h
===================================================================
--- testtree.orig/include/asm-ppc/page.h
+++ testtree/include/asm-ppc/page.h
@@ -149,8 +149,7 @@ extern int page_is_ram(unsigned long pfn
  #define __pa(x) ___pa((unsigned long)(x))
  #define __va(x) ((void *)(___va((unsigned long)(x))))

-#define pfn_to_page(pfn)	(mem_map + ((pfn) - PPC_PGSTART))
-#define page_to_pfn(page)	((unsigned long)((page) - mem_map) + PPC_PGSTART)
+#define ARCH_PFN_OFFSET		(PPC_PGSTART)
  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
  #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)

@@ -175,5 +174,6 @@ extern __inline__ int get_order(unsigned
  /* We do define AT_SYSINFO_EHDR but don't use the gate mecanism */
  #define __HAVE_ARCH_GATE_AREA		1

+#include <asm-generic/memory_model.h>
  #endif /* __KERNEL__ */
  #endif /* _PPC_PAGE_H */

