Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWDUGnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWDUGnd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWDUGnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:43:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:6851 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751216AbWDUGnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:43:32 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>
Message-Id: <20060301045921.12434.16382.sendpatchset@linux.site>
In-Reply-To: <20060301045901.12434.54077.sendpatchset@linux.site>
References: <20060301045901.12434.54077.sendpatchset@linux.site>
Subject: [patch 2/5] mm: remove vmalloc_to_pfn
Date: Fri, 21 Apr 2006 08:43:28 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -1002,7 +1002,6 @@ static inline unsigned long vma_pages(st
 
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 struct page *vmalloc_to_page(void *addr);
-unsigned long vmalloc_to_pfn(void *addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
Index: linux-2.6/mm/memory.c
===================================================================
--- linux-2.6.orig/mm/memory.c
+++ linux-2.6/mm/memory.c
@@ -2394,16 +2394,6 @@ struct page * vmalloc_to_page(void * vma
 
 EXPORT_SYMBOL(vmalloc_to_page);
 
-/*
- * Map a vmalloc()-space virtual address to the physical page frame number.
- */
-unsigned long vmalloc_to_pfn(void * vmalloc_addr)
-{
-	return page_to_pfn(vmalloc_to_page(vmalloc_addr));
-}
-
-EXPORT_SYMBOL(vmalloc_to_pfn);
-
 #if !defined(__HAVE_ARCH_GATE_AREA)
 
 #if defined(AT_SYSINFO_EHDR)
