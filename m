Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVCQR7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVCQR7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVCQR7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:59:31 -0500
Received: from IRC.13thfloor.at ([212.16.62.51]:49282 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261312AbVCQR6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:58:53 -0500
Date: Thu, 17 Mar 2005 18:58:52 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] include cleanup in pgalloc.h
Message-ID: <20050317175852.GC28633@mail.13thfloor.at>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Linux Memory Management <linux-mm@kvack.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

this patch cleans up asm-*/pgalloc.h by removing the
generous includes which are obsoleted (duplicated) by 
including linux/mm.h (and friends)

they are double checked and verified by the PLM
cross compiling service (the patched kernel gives
the same warnings/errors as the unpatched)

http://osdl.org/plm-cgi/plm?module=patch_info&patch_id=4313

best,
Herbert


Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

diff -NurpP --minimal linux-2.6.11.4/include/asm-cris/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-cris/pgalloc.h
--- linux-2.6.11.4/include/asm-cris/pgalloc.h	Sun Mar  6 20:05:43 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-cris/pgalloc.h	Thu Mar 17 01:48:31 2005
@@ -1,7 +1,6 @@
 #ifndef _CRIS_PGALLOC_H
 #define _CRIS_PGALLOC_H
 
-#include <asm/page.h>
 #include <linux/threads.h>
 #include <linux/mm.h>
 
diff -NurpP --minimal linux-2.6.11.4/include/asm-i386/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-i386/pgalloc.h
--- linux-2.6.11.4/include/asm-i386/pgalloc.h	Sun Mar  6 20:05:43 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-i386/pgalloc.h	Thu Mar 17 01:48:06 2005
@@ -2,7 +2,6 @@
 #define _I386_PGALLOC_H
 
 #include <linux/config.h>
-#include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <linux/threads.h>
 #include <linux/mm.h>		/* for struct page */
diff -NurpP --minimal linux-2.6.11.4/include/asm-ia64/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-ia64/pgalloc.h
--- linux-2.6.11.4/include/asm-ia64/pgalloc.h	Sun Mar  6 20:05:43 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-ia64/pgalloc.h	Thu Mar 17 01:47:50 2005
@@ -21,7 +21,6 @@
 #include <linux/threads.h>
 
 #include <asm/mmu_context.h>
-#include <asm/processor.h>
 
 /*
  * Very stupidly, we used to get new pgd's and pmd's, init their contents
diff -NurpP --minimal linux-2.6.11.4/include/asm-m32r/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-m32r/pgalloc.h
--- linux-2.6.11.4/include/asm-m32r/pgalloc.h	Sun Mar  6 20:05:43 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-m32r/pgalloc.h	Thu Mar 17 01:47:35 2005
@@ -7,7 +7,6 @@
 #include <linux/mm.h>
 
 #include <asm/io.h>
-#include <asm/pgtable.h>
 
 #define pmd_populate_kernel(mm, pmd, pte)	\
 	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(pte)))
diff -NurpP --minimal linux-2.6.11.4/include/asm-parisc/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-parisc/pgalloc.h
--- linux-2.6.11.4/include/asm-parisc/pgalloc.h	Sun Mar  6 20:05:44 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-parisc/pgalloc.h	Thu Mar 17 01:46:49 2005
@@ -7,7 +7,6 @@
 #include <asm/processor.h>
 #include <asm/fixmap.h>
 
-#include <asm/pgtable.h>
 #include <asm/cache.h>
 
 /* Allocate the top level pgd (page directory)
diff -NurpP --minimal linux-2.6.11.4/include/asm-ppc64/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-ppc64/pgalloc.h
--- linux-2.6.11.4/include/asm-ppc64/pgalloc.h	Mon Oct 18 23:53:07 2004
+++ linux-2.6.11.4-pgalloc-01/include/asm-ppc64/pgalloc.h	Thu Mar 17 01:46:11 2005
@@ -5,9 +5,6 @@
 #include <linux/slab.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
-#include <asm/processor.h>
-#include <asm/tlb.h>
-#include <asm/page.h>
 
 extern kmem_cache_t *zero_cache;
 
diff -NurpP --minimal linux-2.6.11.4/include/asm-s390/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-s390/pgalloc.h
--- linux-2.6.11.4/include/asm-s390/pgalloc.h	Mon Oct 18 23:54:37 2004
+++ linux-2.6.11.4-pgalloc-01/include/asm-s390/pgalloc.h	Thu Mar 17 01:49:11 2005
@@ -14,7 +14,6 @@
 #define _S390_PGALLOC_H
 
 #include <linux/config.h>
-#include <asm/processor.h>
 #include <linux/threads.h>
 #include <linux/gfp.h>
 #include <linux/mm.h>
diff -NurpP --minimal linux-2.6.11.4/include/asm-sh/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-sh/pgalloc.h
--- linux-2.6.11.4/include/asm-sh/pgalloc.h	Sun Mar  6 20:05:44 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-sh/pgalloc.h	Thu Mar 17 01:49:20 2005
@@ -1,7 +1,6 @@
 #ifndef __ASM_SH_PGALLOC_H
 #define __ASM_SH_PGALLOC_H
 
-#include <asm/processor.h>
 #include <linux/threads.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
diff -NurpP --minimal linux-2.6.11.4/include/asm-sh64/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-sh64/pgalloc.h
--- linux-2.6.11.4/include/asm-sh64/pgalloc.h	Sun Mar  6 20:05:44 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-sh64/pgalloc.h	Thu Mar 17 01:49:27 2005
@@ -14,7 +14,6 @@
  *
  */
 
-#include <asm/processor.h>
 #include <linux/threads.h>
 #include <linux/mm.h>
 
diff -NurpP --minimal linux-2.6.11.4/include/asm-sparc64/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-sparc64/pgalloc.h
--- linux-2.6.11.4/include/asm-sparc64/pgalloc.h	Sun Mar  6 20:05:44 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-sparc64/pgalloc.h	Thu Mar 17 01:49:53 2005
@@ -7,9 +7,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 
-#include <asm/page.h>
 #include <asm/spitfire.h>
-#include <asm/pgtable.h>
 #include <asm/cpudata.h>
 
 /* Page table allocation/freeing. */
diff -NurpP --minimal linux-2.6.11.4/include/asm-x86_64/pgalloc.h linux-2.6.11.4-pgalloc-01/include/asm-x86_64/pgalloc.h
--- linux-2.6.11.4/include/asm-x86_64/pgalloc.h	Sun Mar  6 20:05:45 2005
+++ linux-2.6.11.4-pgalloc-01/include/asm-x86_64/pgalloc.h	Thu Mar 17 01:50:13 2005
@@ -1,7 +1,6 @@
 #ifndef _X86_64_PGALLOC_H
 #define _X86_64_PGALLOC_H
 
-#include <asm/processor.h>
 #include <asm/fixmap.h>
 #include <asm/pda.h>
 #include <linux/threads.h>
