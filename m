Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030548AbWBHF5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030548AbWBHF5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 00:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030551AbWBHF5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 00:57:39 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24206 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030548AbWBHF5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 00:57:38 -0500
Message-ID: <43E98868.8000205@jp.fujitsu.com>
Date: Wed, 08 Feb 2006 14:58:00 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: dhowells@redhat.com
Subject: [PATCH] unify pfn_to_page take 2 [9/25] frv funcs
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FRV can use generic funcs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Index: test-layout-free-zone/include/asm-frv/page.h
===================================================================
--- test-layout-free-zone.orig/include/asm-frv/page.h
+++ test-layout-free-zone/include/asm-frv/page.h
@@ -57,13 +57,10 @@ extern unsigned long min_low_pfn;
  extern unsigned long max_pfn;

  #ifdef CONFIG_MMU
-#define pfn_to_page(pfn)	(mem_map + (pfn))
-#define page_to_pfn(page)	((unsigned long) ((page) - mem_map))
  #define pfn_valid(pfn)		((pfn) < max_mapnr)

  #else
-#define pfn_to_page(pfn)	(&mem_map[(pfn) - (PAGE_OFFSET >> PAGE_SHIFT)])
-#define page_to_pfn(page)	((PAGE_OFFSET >> PAGE_SHIFT) + (unsigned long) ((page) - mem_map))
+#define ARCH_PFN_OFFSET		(PAGE_OFFSET >> PAGE_SHIFT)
  #define pfn_valid(pfn)		((pfn) >= min_low_pfn && (pfn) < max_low_pfn)

  #endif

