Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWBFLAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWBFLAG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbWBFLAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:00:06 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:27342 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751078AbWBFLAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:00:02 -0500
Message-ID: <43E72C6F.7080009@jp.fujitsu.com>
Date: Mon, 06 Feb 2006 20:01:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC][PATCH] unify pfn_to_page [9/25] ia64  pfn_to_page/page_to_pfn
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In CONFIG_DISCONTIGMEM case, CONFIG_VIRTUAL_MEM_MAP is selected.(looks always...)
ia64 uses private page_to_pfn() func when CONFIG_VIRTUAL_MEM_MAP.
Replacing only FLATMEM case.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: cleanup_pfn_page/include/asm-ia64/page.h
===================================================================
--- cleanup_pfn_page.orig/include/asm-ia64/page.h
+++ cleanup_pfn_page/include/asm-ia64/page.h
@@ -106,9 +106,8 @@ extern int ia64_pfn_valid (unsigned long

  #ifdef CONFIG_FLATMEM
  # define pfn_valid(pfn)		(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
-# define page_to_pfn(page)	((unsigned long) (page - mem_map))
-# define pfn_to_page(pfn)	(mem_map + (pfn))
  #elif defined(CONFIG_DISCONTIGMEM)
+#define ARCH_HAS_PFN_PAGE
  extern struct page *vmem_map;
  extern unsigned long min_low_pfn;
  extern unsigned long max_low_pfn;

