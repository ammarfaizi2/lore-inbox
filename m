Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVAJHeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVAJHeX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 02:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbVAJHeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 02:34:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:43174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262133AbVAJHeV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 02:34:21 -0500
Date: Sun, 9 Jan 2005 23:32:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: rmk+lkml@arm.linux.org.uk, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
Message-Id: <20050109233253.42318137.akpm@osdl.org>
In-Reply-To: <1105319915.17853.8.camel@tglx.tec.linutronix.de>
References: <20050110013508.1.patchmail@tglx>
	<1105318406.17853.2.camel@tglx.tec.linutronix.de>
	<20050110010613.A5825@flint.arm.linux.org.uk>
	<1105319915.17853.8.camel@tglx.tec.linutronix.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> wrote:
>
> This patch adjusts the ARM entry code to use the fixed up
>  preempt_schedule() handling in 2.6.10-mm2
> 
> ...
>  Index: 2.6.10-mm1/arch/arm/kernel/entry.S

There's no such file.  I assumed you meant entry-armv.S and ended up with
the below.

--- 25/arch/arm/kernel/entry-armv.S~use-the-new-preemption-code-arm	2005-01-09 23:30:34.794573320 -0800
+++ 25-akpm/arch/arm/kernel/entry-armv.S	2005-01-09 23:30:34.797572864 -0800
@@ -136,10 +136,8 @@ svc_preempt:	teq	r9, #0				@ was preempt
 		ldr	r1, [r6, #8]			@ local_bh_count
 		adds	r0, r0, r1
 		movne	pc, lr
-		mov	r7, #PREEMPT_ACTIVE
-		str	r7, [r8, #TI_PREEMPT]		@ set PREEMPT_ACTIVE
 1:		enable_irq r2				@ enable IRQs
-		bl	schedule
+               bl      entry_preempt_schedule
 		disable_irq r0				@ disable IRQs
 		ldr	r0, [r8, #TI_FLAGS]		@ get new tasks TI_FLAGS
 		tst	r0, #_TIF_NEED_RESCHED
_

