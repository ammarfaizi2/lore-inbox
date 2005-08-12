Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbVHLSxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbVHLSxI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVHLStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:49:19 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39339 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S1751017AbVHLStD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:49:03 -0400
Subject: [patch 32/39] remap_file_pages protection support: fix i386 handler
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:36:19 +0200
Message-Id: <20050812183619.CA89224E7E1@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Actually, with the current model, we should get a failure with VMA's mapped
with only PROT_WRITE (even if I wasn't able to verify that in UML, which has
similar code).

To test!

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/i386/mm/fault.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN arch/i386/mm/fault.c~rfp-fault-sigsegv-3-i386 arch/i386/mm/fault.c
--- linux-2.6.git/arch/i386/mm/fault.c~rfp-fault-sigsegv-3-i386	2005-08-12 17:12:51.000000000 +0200
+++ linux-2.6.git-paolo/arch/i386/mm/fault.c	2005-08-12 17:12:51.000000000 +0200
@@ -381,7 +381,8 @@ bad_area_prot:
 		 * requirements... we should always test just
 		 * pte_read/write/exec, on vma->vm_page_prot! This way is
 		 * cumbersome. However, for now things should work for i386. */
-		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC : VM_READ;
+		access_mask |= vma->vm_flags & VM_EXEC ? VM_EXEC :
+			(vma->vm_flags & VM_READ ? VM_READ : VM_WRITE );
 		goto handle_fault;
 	}
 /*
_
