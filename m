Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVAJBSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVAJBSl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVAJBSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:18:41 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61072
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262038AbVAJBSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:18:37 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3] Resend
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110010613.A5825@flint.arm.linux.org.uk>
References: <20050110013508.1.patchmail@tglx>
	 <1105318406.17853.2.camel@tglx.tec.linutronix.de>
	 <20050110010613.A5825@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 02:18:35 +0100
Message-Id: <1105319915.17853.8.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 01:06 +0000, Russell King wrote:
> On Mon, Jan 10, 2005 at 01:53:26AM +0100, Thomas Gleixner wrote:
> > This patch adjusts the ARM entry code to use the fixed up
> > preempt_schedule() handling in 2.6.10-mm2
> 
> Looks PPCish to me.

Sorry I messed that up. Call me the idiot of today.

This patch adjusts the ARM entry code to use the fixed up
preempt_schedule() handling in 2.6.10-mm2

Signed-off-by: Benedikt Spranger <bene@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 entry-armv.S |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)
---
Index: 2.6.10-mm1/arch/arm/kernel/entry.S
===================================================================
--- 2.6.10-mm1/arch/arm/kernel/entry.S  (revision 141)
+++ 2.6.10-mm1/arch/arm/kernel/entry.S  (working copy)
@@ -136,10 +136,8 @@
                ldr     r1, [r6, #8]                    @ local_bh_count
                adds    r0, r0, r1
                movne   pc, lr
-               mov     r7, #PREEMPT_ACTIVE
-               str     r7, [r8, #TI_PREEMPT]           @ set PREEMPT_ACTIVE
 1:             enable_irq r2                           @ enable IRQs
-               bl      schedule
+               bl      entry_preempt_schedule
                disable_irq r0                          @ disable IRQs
                ldr     r0, [r8, #TI_FLAGS]             @ get new tasks TI_FLAGS
                tst     r0, #_TIF_NEED_RESCHED


