Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbUKLX62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbUKLX62 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbUKLX5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:57:07 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:23556
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262712AbUKLXrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:47:55 -0500
Message-Id: <200411130201.iAD212pT005901@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] - UML - fix definitions of pte_unmap_*
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:01:02 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some definitions of pte_unmap_* macros were written for HIGHPTE, which UML
doesn't support.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/include/asm-um/pgtable.h
===================================================================
--- 2.6.9.orig/include/asm-um/pgtable.h	2004-11-12 13:26:04.000000000 -0500
+++ 2.6.9/include/asm-um/pgtable.h	2004-11-12 17:01:05.000000000 -0500
@@ -393,11 +393,10 @@
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
 #define pte_offset_map(dir, address) \
-        ((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
-#define pte_offset_map_nested(dir, address) \
-	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
-#define pte_unmap(pte) kunmap_atomic((pte), KM_PTE0)
-#define pte_unmap_nested(pte) kunmap_atomic((pte), KM_PTE1)
+	((pte_t *)page_address(pmd_page(*(dir))) + pte_index(address))
+#define pte_offset_map_nested(dir, address) pte_offset_map(dir, address)
+#define pte_unmap(pte) do { } while (0)
+#define pte_unmap_nested(pte) do { } while (0)
 
 #define update_mmu_cache(vma,address,pte) do ; while (0)
 

