Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262026AbVAJBAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262026AbVAJBAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 20:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbVAJBAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 20:00:11 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:59536
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262026AbVAJBAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 20:00:05 -0500
Subject: Re: [PATCH 2.6.10-mm2] Use the new preemption code [3/3]
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Tom Rini <trini@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110013508.1.patchmail@tglx>
References: <20050110013508.1.patchmail@tglx>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 02:00:04 +0100
Message-Id: <1105318804.17853.5.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adjusts the PPC entry code to use the fixed up
preempt_schedule() handling in 2.6.10-mm2

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 entry.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
---
Index: 2.6.10-mm1/arch/ppc/kernel/entry.S
===================================================================
--- 2.6.10-mm1/arch/ppc/kernel/entry.S  (revision 141)
+++ 2.6.10-mm1/arch/ppc/kernel/entry.S  (working copy)
@@ -624,12 +624,12 @@
        beq+    restore
        andi.   r0,r3,MSR_EE    /* interrupts off? */
        beq     restore         /* don't schedule if so */
-1:     lis     r0,PREEMPT_ACTIVE@h
+1:     li      r0,1
        stw     r0,TI_PREEMPT(r9)
        ori     r10,r10,MSR_EE
        SYNC
        MTMSRD(r10)             /* hard-enable interrupts */
-       bl      schedule
+       bl      entry_preempt_schedule
        LOAD_MSR_KERNEL(r10,MSR_KERNEL)
        SYNC
        MTMSRD(r10)             /* disable interrupts */


