Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVHOXDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVHOXDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVHOXDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 19:03:14 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:46861 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932338AbVHOXDN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 19:03:13 -0400
Date: Mon, 15 Aug 2005 16:00:39 -0700
From: zach@vmware.com
Message-Id: <200508152300.j7FN0dD7005336@zach-dev.vmware.com>
To: akpm@osdl.org, chrisl@vmware.com, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, mbligh@mbligh.org, pratap@vmware.com,
       virtualization@lists.osdl.org, zach@vmware.com
Subject: [PATCH 5/6] i386 virtualization - Make generic set wrprotect a macro
X-OriginalArrivalTime: 15 Aug 2005 23:00:19.0242 (UTC) FILETIME=[1B9B70A0:01C5A1ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the generic version of ptep_set_wrprotect a macro.  This is good for
code uniformity, and fixes the build for architectures which include pgtable.h
through headers into assembly code, but do not define a ptep_set_wrprotect
function.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-generic/pgtable.h	2005-08-12 12:12:55.000000000 -0700
+++ linux-2.6.13/include/asm-generic/pgtable.h	2005-08-15 13:54:42.000000000 -0700
@@ -313,11 +313,12 @@
 #endif
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long address, pte_t *ptep)
-{
-	pte_t old_pte = *ptep;
-	set_pte_at(mm, address, ptep, pte_wrprotect(old_pte));
-}
+#define ptep_set_wrprotect(__mm, __address, __ptep)			\
+({									\
+	pte_t __old_pte = *(__ptep);					\
+	set_pte_at((__mm), (__address), (__ptep),			\
+			pte_wrprotect(__old_pte));			\
+})
 #endif
 
 #ifndef __HAVE_ARCH_PTE_SAME
