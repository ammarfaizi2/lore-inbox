Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWBHGAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWBHGAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWBHGAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:00:49 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:55186 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S964851AbWBHGAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:00:48 -0500
Message-ID: <43E98966.4080500@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 15:02:14 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: tony.luck@intel.com
Subject: [PATCH] unify pfn_to_page take 2 [11/25] ia64 funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DISCONTIGMEM==y, VIRTUAL_MEM_MAP is selecetd.
In this case, we cannot use generic one.

Signed-Off-By: KAMEZAWA Hiruyoki <kamezawa.hiroyu@jp.fujitsu.com>

Index: test-layout-free-zone/arch/ia64/Kconfig
===================================================================
--- test-layout-free-zone.orig/arch/ia64/Kconfig
+++ test-layout-free-zone/arch/ia64/Kconfig
@@ -334,6 +334,10 @@ config HOLES_IN_ZONE
  	bool
  	default y if VIRTUAL_MEM_MAP

+config ARCH_HAS_PFN_TO_PAGE
+	bool
+	default y if VIRTUAL_MEM_MAP
+
  config HAVE_ARCH_EARLY_PFN_TO_NID
  	def_bool y
  	depends on NEED_MULTIPLE_NODES
Index: test-layout-free-zone/include/asm-ia64/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-ia64/page.h
+++ test-layout-free-zone/include/asm-ia64/page.h
@@ -106,9 +106,8 @@ extern int ia64_pfn_valid (unsigned long

  #ifdef CONFIG_FLATMEM
  # define pfn_valid(pfn)		(((pfn) < max_mapnr) && ia64_pfn_valid(pfn))
-# define page_to_pfn(page)	((unsigned long) (page - mem_map))
-# define pfn_to_page(pfn)	(mem_map + (pfn))
  #elif defined(CONFIG_DISCONTIGMEM)
+/* we already selected CONFIG_ARCH_HASH_PFN_TO_PAGE here */
  extern struct page *vmem_map;
  extern unsigned long min_low_pfn;
  extern unsigned long max_low_pfn;

