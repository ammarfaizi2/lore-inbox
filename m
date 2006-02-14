Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030552AbWBNKSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030552AbWBNKSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030550AbWBNKSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:18:00 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:15030 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030549AbWBNKR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:17:59 -0500
Message-ID: <43F1AEA7.4010800@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 19:19:19 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] unify pfn_to_page take3 [6/23]  arm pfn_to_page
References: <43F1A753.2020003@jp.fujitsu.com>
In-Reply-To: <43F1A753.2020003@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ARM can use generic funcs.
PFN_TO_NID, LOCAL_MAP_NR are defined by sub-archs.

Signed-Off-By: KAMEZAWA Hirotuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: testtree/include/asm-arm/memory.h
===================================================================
--- testtree.orig/include/asm-arm/memory.h
+++ testtree/include/asm-arm/memory.h
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
+#define arch_pfn_to_nid(pfn)	(PFN_TO_NID(pfn))
+#define arch_local_page_offset(pfn, nid) (LOCAL_MAP_NR((pfn) << PAGE_OFFSET))

  #define pfn_valid(pfn)						\
  	({							\
@@ -222,6 +215,7 @@ static inline __deprecated void *bus_to_

  #endif /* !CONFIG_DISCONTIGMEM */

+
  /*
   * For BIO.  "will die".  Kill me when bio_to_phys() and bvec_to_phys() die.
   */
@@ -243,4 +237,6 @@ static inline __deprecated void *bus_to_

  #endif

+#include <asm-generic/memory_model.h>
+
  #endif

