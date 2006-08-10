Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWHJUWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWHJUWb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbWHJUPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:15:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:29328 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932401AbWHJTf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:56 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [41/145] x86_64: Add proper alignment to ENTRY
Message-Id: <20060810193555.61BAE13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:55 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Previously it didn't align. Use the same one as the C compiler
in blended mode, which is good for K8 and Core2 and doesn't hurt
on P4.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S   |    3 +--
 include/asm-x86_64/linkage.h |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -617,8 +617,7 @@ retint_signal:
 #ifdef CONFIG_PREEMPT
 	/* Returning to kernel space. Check if we need preemption */
 	/* rcx:	 threadinfo. interrupts off. */
-	.p2align
-retint_kernel:	
+ENTRY(retint_kernel)
 	cmpl $0,threadinfo_preempt_count(%rcx)
 	jnz  retint_restore_args
 	bt  $TIF_NEED_RESCHED,threadinfo_flags(%rcx)
Index: linux/include/asm-x86_64/linkage.h
===================================================================
--- linux.orig/include/asm-x86_64/linkage.h
+++ linux/include/asm-x86_64/linkage.h
@@ -1,6 +1,6 @@
 #ifndef __ASM_LINKAGE_H
 #define __ASM_LINKAGE_H
 
-/* Nothing to see here... */
+#define __ALIGN .p2align 4,,15
 
 #endif
