Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWHJUPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWHJUPE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWHJUO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:14:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36075 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932343AbWHJTgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:07 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [50/145] i386: Minor fixes & cleanup to tlb flush 
Message-Id: <20060810193604.E0B0213C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:04 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

(based on x86-64 changes)
- Add a proper memory clobber to invlpg
- Remove an unused extern

Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-i386/tlbflush.h |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

Index: linux/include/asm-i386/tlbflush.h
===================================================================
--- linux.orig/include/asm-i386/tlbflush.h
+++ linux/include/asm-i386/tlbflush.h
@@ -36,8 +36,6 @@
 			: "memory");					\
 	} while (0)
 
-extern unsigned long pgkern_mask;
-
 # define __flush_tlb_all()						\
 	do {								\
 		if (cpu_has_pge)					\
@@ -49,7 +47,7 @@ extern unsigned long pgkern_mask;
 #define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
 
 #define __flush_tlb_single(addr) \
-	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+	__asm__ __volatile__("invlpg (%0)" ::"r" (addr) : "memory")
 
 #ifdef CONFIG_X86_INVLPG
 # define __flush_tlb_one(addr) __flush_tlb_single(addr)
