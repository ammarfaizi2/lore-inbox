Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946740AbWJTAJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946740AbWJTAJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 20:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946737AbWJTAJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 20:09:32 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30909 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1946733AbWJTAJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 20:09:25 -0400
Date: Thu, 19 Oct 2006 17:09:22 -0700
Message-Id: <200610200009.k9K09M29027582@zach-dev.vmware.com>
Subject: [PATCH 5/5] Mmu header movement.patch
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 20 Oct 2006 00:09:22.0272 (UTC) FILETIME=[FEAC2600:01C6F3DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move header includes for the nopud / nopmd types to the location of the
actual pte / pgd type definitions.  This allows generic 4-level page
type code to be written before the split 2/3 level page table headers are
included.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 8233e2c507d3 include/asm-i386/page.h
--- a/include/asm-i386/page.h	Thu Oct 19 03:11:37 2006 -0700
+++ b/include/asm-i386/page.h	Thu Oct 19 03:16:36 2006 -0700
@@ -52,6 +52,7 @@ typedef struct { unsigned long long pgpr
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define __pmd(x) ((pmd_t) { (x) } )
 #define HPAGE_SHIFT	21
+#include <asm-generic/pgtable-nopud.h>
 #else
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pgd; } pgd_t;
@@ -59,6 +60,7 @@ typedef struct { unsigned long pgprot; }
 #define boot_pte_t pte_t /* or would you rather have a typedef */
 #define pte_val(x)	((x).pte_low)
 #define HPAGE_SHIFT	22
+#include <asm-generic/pgtable-nopmd.h>
 #endif
 #define PTE_MASK	PAGE_MASK
 
diff -r 8233e2c507d3 include/asm-i386/pgtable-2level.h
--- a/include/asm-i386/pgtable-2level.h	Thu Oct 19 03:11:37 2006 -0700
+++ b/include/asm-i386/pgtable-2level.h	Thu Oct 19 03:16:36 2006 -0700
@@ -1,7 +1,5 @@
 #ifndef _I386_PGTABLE_2LEVEL_H
 #define _I386_PGTABLE_2LEVEL_H
-
-#include <asm-generic/pgtable-nopmd.h>
 
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
diff -r 8233e2c507d3 include/asm-i386/pgtable-3level.h
--- a/include/asm-i386/pgtable-3level.h	Thu Oct 19 03:11:37 2006 -0700
+++ b/include/asm-i386/pgtable-3level.h	Thu Oct 19 03:16:36 2006 -0700
@@ -1,7 +1,5 @@
 #ifndef _I386_PGTABLE_3LEVEL_H
 #define _I386_PGTABLE_3LEVEL_H
-
-#include <asm-generic/pgtable-nopud.h>
 
 /*
  * Intel Physical Address Extension (PAE) Mode - three-level page
