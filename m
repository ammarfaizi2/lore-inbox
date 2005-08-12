Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbVHLSss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVHLSss (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbVHLSss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 14:48:48 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:51660 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S1750932AbVHLSsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 14:48:47 -0400
Subject: [patch 21/39] remap_file_pages protection support: use EOVERFLOW ret code
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 12 Aug 2005 20:35:48 +0200
Message-Id: <20050812183549.160DD24B4FD@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Use -EOVERFLOW ("Value too large for defined data type") rather than -EINVAL
when we cannot store the file offset in the PTE.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/mm/fremap.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/fremap.c~rfp-ef2big-ret-code mm/fremap.c
--- linux-2.6.git/mm/fremap.c~rfp-ef2big-ret-code	2005-08-11 23:04:59.000000000 +0200
+++ linux-2.6.git-paolo/mm/fremap.c	2005-08-11 23:04:59.000000000 +0200
@@ -213,7 +213,7 @@ asmlinkage long sys_remap_file_pages(uns
 	/* Can we represent this offset inside this architecture's pte's? */
 #if PTE_FILE_MAX_BITS < BITS_PER_LONG
 	if (pgoff + (size >> PAGE_SHIFT) >= (1UL << PTE_FILE_MAX_BITS))
-		return err;
+		return -EOVERFLOW;
 #endif
 
 	/* We need down_write() to change vma->vm_flags. */
_
