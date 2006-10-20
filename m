Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946737AbWJTAJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946737AbWJTAJu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946733AbWJTAJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:09:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32189 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946739AbWJTAJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:09:25 -0400
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-Id: <200610200009.k9K09MvZ027576@zach-dev.vmware.com>
Subject: [PATCH 4/5] Fix bad mmu names.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 20 Oct 2006 00:09:22.0179 (UTC) FILETIME=[FE9DF530:01C6F3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make parameter names match function argument names for the yet
to be defined pte_update_defer accessor.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r c7f79c35c160 include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	Thu Oct 19 03:03:24 2006 -0700
+++ b/include/asm-i386/pgtable.h	Thu Oct 19 03:11:31 2006 -0700
@@ -275,7 +275,7 @@ do {									\
 do {									\
 	if (dirty) {							\
 		(ptep)->pte_low = (entry).pte_low;			\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 } while (0)
@@ -305,7 +305,7 @@ do {									\
 	__dirty = pte_dirty(*(ptep));					\
 	if (__dirty) {							\
 		clear_bit(_PAGE_BIT_DIRTY, &(ptep)->pte_low);		\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__dirty;							\
@@ -318,7 +318,7 @@ do {									\
 	__young = pte_young(*(ptep));					\
 	if (__young) {							\
 		clear_bit(_PAGE_BIT_ACCESSED, &(ptep)->pte_low);	\
-		pte_update_defer((vma)->vm_mm, (addr), (ptep));		\
+		pte_update_defer((vma)->vm_mm, (address), (ptep));	\
 		flush_tlb_page(vma, address);				\
 	}								\
 	__young;							\
