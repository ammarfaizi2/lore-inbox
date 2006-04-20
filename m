Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbWDTRGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbWDTRGf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDTRGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:06:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:47841 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751164AbWDTRGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:06:34 -0400
From: Nick Piggin <npiggin@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Message-Id: <20060228202223.14172.21110.sendpatchset@linux.site>
In-Reply-To: <20060228202202.14172.60409.sendpatchset@linux.site>
References: <20060228202202.14172.60409.sendpatchset@linux.site>
Subject: [patch 2/5] mm: deprecate vmalloc_to_pfn
Date: Thu, 20 Apr 2006 19:06:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecate vmalloc_to_pfn.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/Documentation/feature-removal-schedule.txt
===================================================================
--- linux-2.6.orig/Documentation/feature-removal-schedule.txt
+++ linux-2.6/Documentation/feature-removal-schedule.txt
@@ -238,3 +238,12 @@ Why:	The interface no longer has any cal
 Who:	Nick Piggin <npiggin@suse.de>
 
 ---------------------------
+
+What:	vmalloc_to_pfn
+When:	April 2007
+Why:	The interface no longer has any callers left in the kernel. It
+	was previously used so remap_pfn_range can be used on vmalloc memory,
+	but is deprecated with the introduction of remap_vmalloc_range.
+Who:	Nick Piggin <npiggin@suse.de>
+
+---------------------------
Index: linux-2.6/include/linux/mm.h
===================================================================
--- linux-2.6.orig/include/linux/mm.h
+++ linux-2.6/include/linux/mm.h
@@ -1002,7 +1002,7 @@ static inline unsigned long vma_pages(st
 
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 struct page *vmalloc_to_page(void *addr);
-unsigned long vmalloc_to_pfn(void *addr);
+__deprecated_for_modules unsigned long vmalloc_to_pfn(void *addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
