Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbULCTbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbULCTbC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262472AbULCTaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:30:22 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:12548
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262465AbULCT1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:27:39 -0500
Message-Id: <200412032143.iB3LhdZW004678@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - fix __pgd_alloc declaration
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:43:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Bodo Stroesser:

__pgd_alloc is defined differently. In include/linux/mm.h it's defined
   extern pgd_t fastcall *__pgd_alloc( ...
In arch/um/kernel/mem.c it's defined
   pgd_t *__pgd_alloc( ...
Thus, I unified this. Hope, it's correct now.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/mem.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/mem.c	2004-12-01 23:46:07.000000000 -0500
+++ 2.6.9/arch/um/kernel/mem.c	2004-12-01 23:49:39.000000000 -0500
@@ -309,7 +309,7 @@
  * Allocate and free page tables.
  */
 
-pgd_t *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
+pgd_t fastcall *__pgd_alloc(struct mm_struct *mm, pml4_t *pml4, unsigned long address)
 {
 	pgd_t *pgd = (pgd_t *)__get_free_page(GFP_KERNEL);
 

