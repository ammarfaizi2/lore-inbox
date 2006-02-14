Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbWBNKUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbWBNKUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030549AbWBNKUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:20:19 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2530 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030540AbWBNKUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:20:17 -0500
Message-ID: <43F1AF22.3060505@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:21:22 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] unify pfn_to_page take3 [7/23]  arm26 pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm26 can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: testtree/include/asm-arm26/memory.h
===================================================================
--- testtree.orig/include/asm-arm26/memory.h
+++ testtree/include/asm-arm26/memory.h
@@ -11,7 +11,6 @@
   */
  #ifndef __ASM_ARM_MEMORY_H
  #define __ASM_ARM_MEMORY_H
-
  /*
   * User space: 26MB
   */
@@ -81,8 +80,7 @@ static inline void *phys_to_virt(unsigne
   *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
   *  virt_addr_valid(k)	indicates whether a virtual address is valid
   */
-#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
-#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
+#define ARCH_PFN_OFFSET		(PHYS_PFN_OFFSET)
  #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))

  #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
@@ -98,4 +96,5 @@ static inline void *phys_to_virt(unsigne
   */
  #define page_to_bus(page)	(page_address(page))

+#include <asm-generic/memory_model.h>
  #endif

