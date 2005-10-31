Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVJaDrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVJaDrs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVJaDrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:47:14 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:34310 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751314AbVJaDqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:51 -0500
Message-Id: <200510310439.j9V4des7000867@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       bcrl@linux.intel.com
Subject: [PATCH 7/10] UML - switch_mm fix
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Lahaise <bcrl@linux.intel.com>
Not quite, something along the lines of the patch below works correctly
(and makes aio performance not suffer from multiple second delays), as
skas0 mode correctly switches mm contexts, unlike TT (which should
probably get nuked from the kernel now that skas0 seems to be working).

                -ben

Signed-off-by: Benjamin LaHaise <bcrl@linux.intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-mm1/include/asm-um/mmu_context.h
===================================================================
--- linux-2.6.13-mm1.orig/include/asm-um/mmu_context.h	2005-09-01 16:03:21.000000000 -0400
+++ linux-2.6.13-mm1/include/asm-um/mmu_context.h	2005-09-07 12:21:22.000000000 -0400
@@ -29,7 +29,8 @@
 	 * possible.
 	 */
 	if (old != new && (current->flags & PF_BORROWED_MM))
-		force_flush_all();
+		CHOOSE_MODE(force_flush_all(),
+			    switch_mm_skas(&new->context.skas.id));
 }
 
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next, 

