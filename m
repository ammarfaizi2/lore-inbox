Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVALL5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVALL5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 06:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVALL5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 06:57:43 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25235
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261161AbVALL5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 06:57:40 -0500
Subject: Re: [PATCH 2.6.10-mm2 Resend] Make use of preempt_schedule_irq
	[2/3] (PPC)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050112124910.1.patchmail@tglx>
References: <20050112124910.1.patchmail@tglx>
Content-Type: text/plain
Date: Wed, 12 Jan 2005 12:57:38 +0100
Message-Id: <1105531058.17853.223.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the new preempt_schedule_irq function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
entry.S |   12 +-----------
1 files changed, 1 insertion(+), 11 deletions(-)
---

Index: 2.6.10-mm2/arch/ppc/kernel/entry.S
===================================================================
--- 2.6.10-mm2/arch/ppc/kernel/entry.S	(revision 148)
+++ 2.6.10-mm2/arch/ppc/kernel/entry.S	(working copy)
@@ -624,18 +624,8 @@
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
-1:	lis	r0,PREEMPT_ACTIVE@h
-	stw	r0,TI_PREEMPT(r9)
-	ori	r10,r10,MSR_EE
-	SYNC
-	MTMSRD(r10)		/* hard-enable interrupts */
-	bl	schedule
-	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
-	SYNC
-	MTMSRD(r10)		/* disable interrupts */
+1:	bl	preempt_schedule_irq
 	rlwinm	r9,r1,0,0,18
-	li	r0,0
-	stw	r0,TI_PREEMPT(r9)
 	lwz	r3,TI_FLAGS(r9)
 	andi.	r0,r3,_TIF_NEED_RESCHED
 	bne-	1b


