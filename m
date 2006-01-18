Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbWARUmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbWARUmt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030431AbWARUms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:42:48 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:1132 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030435AbWARUmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:42:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=emFWLuJHGvZ+f/NzzCwDTyDOIm9AFHTwkCH7CurM3MFQg7T9BdsetZEuSjliDJI64VRY/Q/XUwRqtl+TgX/RsW/FiNvkWNsFuoAe4TZ5FN4AsO4Nmh9gphCVJvrZlC5UudBqU4OlG7xjubHGMWD0iPFE4kYx5jt74YZRIYzY4Bg=
Date: Thu, 19 Jan 2006 00:00:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ian Molton <spyro@f2s.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm26: fixup asm statement in kernel/fiq.c
Message-ID: <20060118210010.GF12771@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm26/kernel/fiq.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

--- a/arch/arm26/kernel/fiq.c
+++ b/arch/arm26/kernel/fiq.c
@@ -104,14 +104,14 @@ void set_fiq_regs(struct pt_regs *regs)
 {
 	register unsigned long tmp, tmp2;
 	__asm__ volatile (
-	"mov	%0, pc
-	bic	%1, %0, #0x3
-	orr	%1, %1, %3
-	teqp	%1, #0		@ select FIQ mode
-	mov	r0, r0
-	ldmia	%2, {r8 - r14}
-	teqp	%0, #0		@ return to SVC mode
-	mov	r0, r0"
+	"mov	%0, pc					\n"
+	"bic	%1, %0, #0x3				\n"
+	"orr	%1, %1, %3				\n"
+	"teqp	%1, #0		@ select FIQ mode	\n"
+	"mov	r0, r0					\n"
+	"ldmia	%2, {r8 - r14}				\n"
+	"teqp	%0, #0		@ return to SVC mode	\n"
+	"mov	r0, r0					"
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | MODE_FIQ26)
 	/* These registers aren't modified by the above code in a way
@@ -125,14 +125,14 @@ void get_fiq_regs(struct pt_regs *regs)
 {
 	register unsigned long tmp, tmp2;
 	__asm__ volatile (
-	"mov	%0, pc
-	bic	%1, %0, #0x3
-	orr	%1, %1, %3
-	teqp	%1, #0		@ select FIQ mode
-	mov	r0, r0
-	stmia	%2, {r8 - r14}
-	teqp	%0, #0		@ return to SVC mode
-	mov	r0, r0"
+	"mov	%0, pc					\n"
+	"bic	%1, %0, #0x3				\n"
+	"orr	%1, %1, %3				\n"
+	"teqp	%1, #0		@ select FIQ mode	\n"
+	"mov	r0, r0					\n"
+	"stmia	%2, {r8 - r14}				\n"
+	"teqp	%0, #0		@ return to SVC mode	\n"
+	"mov	r0, r0					"
 	: "=&r" (tmp), "=&r" (tmp2)
 	: "r" (&regs->ARM_r8), "I" (PSR_I_BIT | PSR_F_BIT | MODE_FIQ26)
 	/* These registers aren't modified by the above code in a way

