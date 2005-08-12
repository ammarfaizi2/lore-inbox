Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbVHLOrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbVHLOrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVHLOrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:55783 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750782AbVHLOrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:18 -0400
Subject: [RFC][PATCH 01/12] memory hotplug prep: kill local_mapnr
To: linux-kernel@vger.kernel.org
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 12 Aug 2005 07:47:14 -0700
Message-Id: <20050812144714.805F4B48@kernel.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is unused, except for in an alpha header.  Keep the alpha
one, kill the rest.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 memhotplug-dave/include/asm-i386/mmzone.h   |    6 ------
 memhotplug-dave/include/asm-m32r/mmzone.h   |    6 ------
 memhotplug-dave/include/asm-parisc/mmzone.h |    6 ------
 memhotplug-dave/include/asm-ppc64/mmzone.h  |    3 ---
 memhotplug-dave/include/asm-x86_64/mmzone.h |    2 --
 5 files changed, 23 deletions(-)

diff -puN include/asm-x86_64/mmzone.h~C0-kill-local_mapnr include/asm-x86_64/mmzone.h
--- memhotplug/include/asm-x86_64/mmzone.h~C0-kill-local_mapnr	2005-08-12 07:43:43.000000000 -0700
+++ memhotplug-dave/include/asm-x86_64/mmzone.h	2005-08-12 07:43:43.000000000 -0700
@@ -38,8 +38,6 @@ static inline __attribute__((pure)) int 
 
 #ifdef CONFIG_DISCONTIGMEM
 
-#define pfn_to_nid(pfn) phys_to_nid((unsigned long)(pfn) << PAGE_SHIFT)
-#define kvaddr_to_nid(kaddr)	phys_to_nid(__pa(kaddr))
 
 /* AK: this currently doesn't deal with invalid addresses. We'll see 
    if the 2.5 kernel doesn't pass them
diff -puN include/asm-parisc/mmzone.h~C0-kill-local_mapnr include/asm-parisc/mmzone.h
--- memhotplug/include/asm-parisc/mmzone.h~C0-kill-local_mapnr	2005-08-12 07:43:43.000000000 -0700
+++ memhotplug-dave/include/asm-parisc/mmzone.h	2005-08-12 07:43:43.000000000 -0700
@@ -27,12 +27,6 @@ extern struct node_map_data node_data[];
 })
 #define node_localnr(pfn, nid)		((pfn) - node_start_pfn(nid))
 
-#define local_mapnr(kvaddr)						\
-({									\
-	unsigned long __pfn = __pa(kvaddr) >> PAGE_SHIFT;		\
-	(__pfn - node_start_pfn(pfn_to_nid(__pfn)));			\
-})
-
 #define pfn_to_page(pfn)						\
 ({									\
 	unsigned long __pfn = (pfn);					\
diff -puN include/asm-ppc64/mmzone.h~C0-kill-local_mapnr include/asm-ppc64/mmzone.h
--- memhotplug/include/asm-ppc64/mmzone.h~C0-kill-local_mapnr	2005-08-12 07:43:43.000000000 -0700
+++ memhotplug-dave/include/asm-ppc64/mmzone.h	2005-08-12 07:43:43.000000000 -0700
@@ -67,9 +67,6 @@ static inline int pa_to_nid(unsigned lon
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)	(NODE_DATA(nid)->node_end_pfn)
 
-#define local_mapnr(kvaddr) \
-	( (__pa(kvaddr) >> PAGE_SHIFT) - node_start_pfn(kvaddr_to_nid(kvaddr)) 
-
 #ifdef CONFIG_DISCONTIGMEM
 
 /*
diff -puN include/asm-alpha/mmzone.h~C0-kill-local_mapnr include/asm-alpha/mmzone.h
diff -puN include/asm-i386/mmzone.h~C0-kill-local_mapnr include/asm-i386/mmzone.h
--- memhotplug/include/asm-i386/mmzone.h~C0-kill-local_mapnr	2005-08-12 07:43:43.000000000 -0700
+++ memhotplug-dave/include/asm-i386/mmzone.h	2005-08-12 07:43:43.000000000 -0700
@@ -88,12 +88,6 @@ static inline int pfn_to_nid(unsigned lo
 	__pgdat->node_start_pfn + __pgdat->node_spanned_pages;		\
 })
 
-#define local_mapnr(kvaddr)						\
-({									\
-	unsigned long __pfn = __pa(kvaddr) >> PAGE_SHIFT;		\
-	(__pfn - node_start_pfn(pfn_to_nid(__pfn)));			\
-})
-
 /* XXX: FIXME -- wli */
 #define kern_addr_valid(kaddr)	(0)
 
diff -puN include/asm-m32r/mmzone.h~C0-kill-local_mapnr include/asm-m32r/mmzone.h
--- memhotplug/include/asm-m32r/mmzone.h~C0-kill-local_mapnr	2005-08-12 07:43:43.000000000 -0700
+++ memhotplug-dave/include/asm-m32r/mmzone.h	2005-08-12 07:43:43.000000000 -0700
@@ -21,12 +21,6 @@ extern struct pglist_data *node_data[];
 	__pgdat->node_start_pfn + __pgdat->node_spanned_pages - 1;	\
 })
 
-#define local_mapnr(kvaddr)						\
-({									\
-	unsigned long __pfn = __pa(kvaddr) >> PAGE_SHIFT;		\
-	(__pfn - node_start_pfn(pfn_to_nid(__pfn)));			\
-})
-
 #define pfn_to_page(pfn)						\
 ({									\
 	unsigned long __pfn = pfn;					\
_
