Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161300AbWBUDsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161300AbWBUDsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 22:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWBUDsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 22:48:09 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:3005 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1161300AbWBUDsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 22:48:06 -0500
Message-Id: <20060221034749.246541000@localhost.localdomain>
References: <20060221034628.799606000@localhost.localdomain>
Date: Tue, 21 Feb 2006 12:46:31 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>,
       David Howells <dhowells@redhat.com>
Subject: [-mm patch 3/8] frv: remove unnesesary "&"
Content-Disposition: inline; filename=frv-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix warning messages triggered by bitops code consolidation patches.
cxn_bitmap is the array of unsigned long.
'&' is unnesesary for the argument of *_bit() routins.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
Cc: David Howells <dhowells@redhat.com>

 arch/frv/mm/mmu-context.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: 2.6-mm/arch/frv/mm/mmu-context.c
===================================================================
--- 2.6-mm.orig/arch/frv/mm/mmu-context.c
+++ 2.6-mm/arch/frv/mm/mmu-context.c
@@ -54,9 +54,9 @@ static unsigned get_cxn(mm_context_t *ct
 		/* find the first unallocated context number
 		 * - 0 is reserved for the kernel
 		 */
-		cxn = find_next_zero_bit(&cxn_bitmap, NR_CXN, 1);
+		cxn = find_next_zero_bit(cxn_bitmap, NR_CXN, 1);
 		if (cxn < NR_CXN) {
-			set_bit(cxn, &cxn_bitmap);
+			set_bit(cxn, cxn_bitmap);
 		}
 		else {
 			/* none remaining - need to steal someone else's cxn */
@@ -138,7 +138,7 @@ void destroy_context(struct mm_struct *m
 			cxn_pinned = -1;
 
 		list_del_init(&ctx->id_link);
-		clear_bit(ctx->id, &cxn_bitmap);
+		clear_bit(ctx->id, cxn_bitmap);
 		__flush_tlb_mm(ctx->id);
 		ctx->id = 0;
 	}

--
