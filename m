Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbWBFKtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbWBFKtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWBFKtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:49:15 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:39302 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751065AbWBFKtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:49:13 -0500
Message-ID: <43E72A03.5080605@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 19:50:43 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [3/25]  arm pfn_toPage/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PFN_TO_NID()/ LOCAL_MAP_NR() is defined by each subarch.

arm can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: cleanup_pfn_page/include/asm-arm/memory.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-arm/memory.h
+++ cleanup_pfn_page/include/asm-arm/memory.h
@@ -172,9 +172,7 @@ static inline __deprecated void *bus_to_
   *  virt_addr_valid(k)	indicates whether a virtual address is valid
   */
  #ifndef CONFIG_DISCONTIGMEM
-
-#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
-#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
+#define ARCH_PFN_OFFSET		(PHYS_PFN_OFFSET)
  #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))

  #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
@@ -190,12 +188,8 @@ static inline __deprecated void *bus_to_
   */
  #include <linux/numa.h>

-#define page_to_pfn(page)					\
-	(( (page) - page_zone(page)->zone_mem_map)		\
-	  + page_zone(page)->zone_start_pfn)
-
-#define pfn_to_page(pfn)					\
-	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
+#define arch_pfn_to_nid(pfn) 		(PFN_TO_NID(pfn))
+#define arch_local_map_nr(pfn, nid)	(LOCAL_MAP_NR((pfn) << PAGE_SHIFT))

  #define pfn_valid(pfn)						\
  	({							\

