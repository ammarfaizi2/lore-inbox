Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbVHLSRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbVHLSRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbVHLSQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:16:53 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:33683 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1750841AbVHLSQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:16:28 -0400
Subject: [patch 04/39] remove implied vm_ops check
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:21:04 +0200
Message-Id: <20050812182105.28FD924E7CA@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

If !vma->vm-ops we already BUG above, so retesting it is useless. The compiler
cannot optimize this because BUG is a macro and is not thus marked noreturn;
that should possibly be fixed.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/memory.c~remove-implied-vm_ops-check mm/memory.c
--- linux-2.6.git/mm/memory.c~remove-implied-vm_ops-check	2005-08-11 11:05:20.000000000 +0200
+++ linux-2.6.git-paolo/mm/memory.c	2005-08-11 11:05:47.000000000 +0200
@@ -1933,7 +1933,7 @@ static int do_file_page(struct mm_struct
 	 * Fall back to the linear mapping if the fs does not support
 	 * ->populate:
 	 */
-	if (!vma->vm_ops || !vma->vm_ops->populate || 
+	if (!vma->vm_ops->populate ||
 			(write_access && !(vma->vm_flags & VM_SHARED))) {
 		pte_clear(mm, address, pte);
 		return do_no_page(mm, vma, address, write_access, pte, pmd);
_
