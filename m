Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVAJAxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVAJAxc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 19:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVAJAxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 19:53:32 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57488
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261839AbVAJAx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 19:53:27 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [2/3]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110013508.1.patchmail@tglx>
References: <20050110013508.1.patchmail@tglx>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 01:53:26 +0100
Message-Id: <1105318406.17853.2.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts the ARM entry code to use the fixed up
preempt_schedule() handling in 2.6.10-mm2

Signed-off-by: Benedikt Spranger <bene@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 entry-armv.S |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)
---
Index: 2.6.10-mm1/arch/ppc/kernel/entry.S
===================================================================
--- 2.6.10-mm1/arch/ppc/kernel/entry.S	(revision 141)
+++ 2.6.10-mm1/arch/ppc/kernel/entry.S	(working copy)
@@ -624,12 +624,12 @@
 	beq+	restore
 	andi.	r0,r3,MSR_EE	/* interrupts off? */
 	beq	restore		/* don't schedule if so */
-1:	lis	r0,PREEMPT_ACTIVE@h
+1:	li	r0,1
 	stw	r0,TI_PREEMPT(r9)
 	ori	r10,r10,MSR_EE
 	SYNC
 	MTMSRD(r10)		/* hard-enable interrupts */
-	bl	schedule
+	bl	entry_preempt_schedule
 	LOAD_MSR_KERNEL(r10,MSR_KERNEL)
 	SYNC
 	MTMSRD(r10)		/* disable interrupts */


