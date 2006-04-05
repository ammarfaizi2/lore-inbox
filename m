Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWDEXwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWDEXwY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDEXwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:52:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14541 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932110AbWDEXwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:52:23 -0400
Message-ID: <44345830.4060400@redhat.com>
Date: Wed, 05 Apr 2006 19:52:16 -0400
From: Hideo AOKI <haoki@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: A patch for test_overcommit module
References: <4434570F.9030507@redhat.com>
In-Reply-To: <4434570F.9030507@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------070305040306070101000408"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070305040306070101000408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The test module needs this kernel patch.
I don't intend to propose to apply this patch to kernel tree.

---
Hideo Aoki, Hitachi Computer Products (America) Inc.

--------------070305040306070101000408
Content-Type: text/x-patch;
 name="mm-debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mm-debug.patch"

This patch exports the symbols which a kernel module has to refer.

 include/linux/mman.h |    1 +
 mm/page_alloc.c      |    1 +
 mm/slab.c            |    1 +
 mm/swap.c            |    1 +
 4 files changed, 4 insertions(+)

diff -pruN linux-2.6.17-rc1-mm1/include/linux/mman.h linux-2.6.17-rc1-mm1-test1/include/linux/mman.h
--- linux-2.6.17-rc1-mm1/include/linux/mman.h	2006-03-24 12:40:19.000000000 -0500
+++ linux-2.6.17-rc1-mm1-test1/include/linux/mman.h	2006-04-04 12:53:52.000000000 -0400
@@ -24,6 +24,7 @@ static inline void vm_acct_memory(long p
 {
 	atomic_add(pages, &vm_committed_space);
 }
+EXPORT_SYMBOL(vm_acct_memory);
 #endif
 
 static inline void vm_unacct_memory(long pages)
diff -pruN linux-2.6.17-rc1-mm1/mm/page_alloc.c linux-2.6.17-rc1-mm1-test1/mm/page_alloc.c
--- linux-2.6.17-rc1-mm1/mm/page_alloc.c	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-test1/mm/page_alloc.c	2006-04-04 12:53:52.000000000 -0400
@@ -52,6 +52,7 @@ EXPORT_SYMBOL(node_possible_map);
 unsigned long totalram_pages __read_mostly;
 unsigned long totalhigh_pages __read_mostly;
 long nr_swap_pages;
+EXPORT_SYMBOL(nr_swap_pages);
 int percpu_pagelist_fraction;
 
 static void __free_pages_ok(struct page *page, unsigned int order);
diff -pruN linux-2.6.17-rc1-mm1/mm/slab.c linux-2.6.17-rc1-mm1-test1/mm/slab.c
--- linux-2.6.17-rc1-mm1/mm/slab.c	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-test1/mm/slab.c	2006-04-04 12:53:52.000000000 -0400
@@ -692,6 +692,7 @@ static struct list_head cache_chain;
  * SLAB_RECLAIM_ACCOUNT turns this on per-slab
  */
 atomic_t slab_reclaim_pages;
+EXPORT_SYMBOL(slab_reclaim_pages);
 
 /*
  * chicken and egg problem: delay the per-cpu array allocation
diff -pruN linux-2.6.17-rc1-mm1/mm/swap.c linux-2.6.17-rc1-mm1-test1/mm/swap.c
--- linux-2.6.17-rc1-mm1/mm/swap.c	2006-04-04 10:43:57.000000000 -0400
+++ linux-2.6.17-rc1-mm1-test1/mm/swap.c	2006-04-04 12:53:52.000000000 -0400
@@ -499,6 +499,7 @@ void vm_acct_memory(long pages)
 	}
 	preempt_enable();
 }
+EXPORT_SYMBOL(vm_acct_memory);
 
 #ifdef CONFIG_HOTPLUG_CPU
 

--------------070305040306070101000408--
