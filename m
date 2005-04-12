Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVDMDLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVDMDLy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 23:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVDLTez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:34:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:3529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262171AbVDLKcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:07 -0400
Message-Id: <200504121032.j3CAW0M0005471@shell0.pdx.osdl.net>
Subject: [patch 086/198] x86_64: Make kernel math errors a die() now
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

There were no reports about the previous warning for FPU exceptions in the
kernel, so make it a die() now.

Also improve the error messages slightly.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/traps.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff -puN arch/x86_64/kernel/traps.c~x86_64-make-kernel-math-errors-a-die-now arch/x86_64/kernel/traps.c
--- 25/arch/x86_64/kernel/traps.c~x86_64-make-kernel-math-errors-a-die-now	2005-04-12 03:21:23.706532960 -0700
+++ 25-akpm/arch/x86_64/kernel/traps.c	2005-04-12 03:21:23.709532504 -0700
@@ -733,14 +733,8 @@ static int kernel_math_error(struct pt_r
 		return 1;
 	}
 	notify_die(DIE_GPF, str, regs, 0, 16, SIGFPE);
-#if 0
-	/* This should be a die, but warn only for now */
+	/* Illegal floating point operation in the kernel */
 	die(str, regs, 0);
-#else
-	printk(KERN_DEBUG "%s: %s at ", current->comm, str);
-	printk_address(regs->rip);
-	printk("\n");
-#endif
 	return 0;
 }
 
@@ -824,7 +818,7 @@ asmlinkage void do_simd_coprocessor_erro
 
 	conditional_sti(regs);
 	if ((regs->cs & 3) == 0 &&
-        	kernel_math_error(regs, "simd math error"))
+        	kernel_math_error(regs, "kernel simd math error"))
 		return;
 
 	/*
_
