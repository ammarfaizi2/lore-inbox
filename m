Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbVHXSnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbVHXSnl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVHXSnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:43:41 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:2823 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751389AbVHXSnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:43:41 -0400
Date: Wed, 24 Aug 2005 11:43:12 -0700
Message-Id: <200508241843.j7OIhC7a001888@zach-dev.vmware.com>
Subject: [PATCH 3/5] Make set_wrprotect() value safe
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:43:13.0203 (UTC) FILETIME=[AEB07030:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The macro set_wrprotect() should not be defined to have a value.  Make it
a do {} while(0) instead of ({}).
Noticed by Chris Wright.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Patch-subject: Make set_wrprotect() value safe
Index: linux-2.6.13/include/asm-generic/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-generic/pgtable.h	2005-08-15 13:54:42.000000000 -0700
+++ linux-2.6.13/include/asm-generic/pgtable.h	2005-08-22 14:21:05.000000000 -0700
@@ -314,11 +314,11 @@ do {									\
 
 #ifndef __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect(__mm, __address, __ptep)			\
-({									\
+do {									\
 	pte_t __old_pte = *(__ptep);					\
 	set_pte_at((__mm), (__address), (__ptep),			\
 			pte_wrprotect(__old_pte));			\
-})
+} while (0)
 #endif
 
 #ifndef __HAVE_ARCH_PTE_SAME
