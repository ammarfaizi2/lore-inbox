Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030540AbWBHFwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030540AbWBHFwA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWBHFwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:52:00 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:65159 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030540AbWBHFwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:52:00 -0500
Message-ID: <43E98724.60906@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:52:36 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: rmk@arm.linux.org.uk
Subject: [PATCH] unify pfn_to_page take 2 [6/25]  arm funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arm can use generic funcs.
PFN_TO_NID, LOCAL_MAP_NR are defined by sub-archs.

Signed-Off-By: KAMEZAWA Hirotuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/include/asm-arm/memory.h
===================================================================
--- test-layout-free-zone.orig/include/asm-arm/memory.h
+++ test-layout-free-zone/include/asm-arm/memory.h
@@ -172,9 +172,7 @@ static inline __deprecated void *bus_to_
   *  virt_addr_valid(k)	indicates whether a virtual address is valid
   */
  #ifndef CONFIG_DISCONTIGMEM
-
-#define page_to_pfn(page)	(((page) - mem_map) + PHYS_PFN_OFFSET)
-#define pfn_to_page(pfn)	((mem_map + (pfn)) - PHYS_PFN_OFFSET)
+#define ARCH_PFH_OFFSET		PHYS_PFN_OFFSET
  #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))

  #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
@@ -189,13 +187,8 @@ static inline __deprecated void *bus_to_
   * around in memory.
   */
  #include <linux/numa.h>
-
-#define page_to_pfn(page)					\
-	(( (page) - page_zone(page)->zone_mem_map)		\
-	  + page_zone(page)->zone_start_pfn)
-
-#define pfn_to_page(pfn)					\
-	(PFN_TO_MAPBASE(pfn) + LOCAL_MAP_NR((pfn) << PAGE_SHIFT))
+#define arch_pfn_to_nid(pfn)			(PFN_TO_NID(pfn))
+#define arch_local_page_offset(pfn, nid)	(LOCAL_MAP_NR((pfn) << PAGE_SHIFT))

  #define pfn_valid(pfn)						\
  	({							\

