Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVAEOaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVAEOaO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:30:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVAEOaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:30:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13446 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262447AbVAEO35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:29:57 -0500
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV: remove excess argument passed to expand_stack()
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 05 Jan 2005 14:29:53 +0000
Message-ID: <28512.1104935393@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch removes the excess argument being passed to expand_stack()
as it isn't needed in -bk8.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-expstack-2610bk8.diff 
 fault.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff -uNrp /warthog/kernels/linux-2.6.10-bk8/arch/frv/mm/fault.c linux-2.6.10-bk8-frv/arch/frv/mm/fault.c
--- /warthog/kernels/linux-2.6.10-bk8/arch/frv/mm/fault.c	2005-01-05 13:21:26.000000000 +0000
+++ linux-2.6.10-bk8-frv/arch/frv/mm/fault.c	2005-01-05 13:30:50.667294388 +0000
@@ -32,7 +32,7 @@
  */
 asmlinkage void do_page_fault(int datammu, unsigned long esr0, unsigned long ear0)
 {
-	struct vm_area_struct *vma, *prev_vma;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	unsigned long _pme, lrai, lrad, fixup;
 	siginfo_t info;
@@ -120,12 +120,7 @@ asmlinkage void do_page_fault(int datamm
 		}
 	}
 
-	/* find_vma_prev is just a bit slower, because it cannot use
-	 * the mmap_cache, so we run it only in the growsdown slow
-	 * path and we leave find_vma in the fast path.
-	 */
-	find_vma_prev(current->mm, ear0, &prev_vma);
-	if (expand_stack(vma, ear0, prev_vma))
+	if (expand_stack(vma, ear0))
 		goto bad_area;
 
 /*
