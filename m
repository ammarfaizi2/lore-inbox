Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVALMIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVALMIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVALMIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:08:45 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27027
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261167AbVALMIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:08:19 -0500
Subject: Re: [PATCH 2.6.10-mm2 Resend] Make use of preempt_schedule_irq
	[3/3] (ARM)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050112124910.1.patchmail@tglx>
References: <20050112124910.1.patchmail@tglx>
Content-Type: multipart/mixed; boundary="=-e8uI1c5Hg6KDadqVMbMR"
Date: Wed, 12 Jan 2005 13:08:15 +0100
Message-Id: <1105531695.17853.232.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-e8uI1c5Hg6KDadqVMbMR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Make use of the new preempt_schedule_irq function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>



--=-e8uI1c5Hg6KDadqVMbMR
Content-Disposition: attachment; filename=entry-armv.S.diff
Content-Type: text/x-patch; name=entry-armv.S.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: 2.6.10-mm2-lockinit/arch/arm/kernel/entry-armv.S
===================================================================
--- 2.6.10-mm2-lockinit/arch/arm/kernel/entry-armv.S	(revision 148)
+++ 2.6.10-mm2-lockinit/arch/arm/kernel/entry-armv.S	(working copy)
@@ -136,11 +136,9 @@
 		ldr	r1, [r6, #8]			@ local_bh_count
 		adds	r0, r0, r1
 		movne	pc, lr
-		mov	r7, #PREEMPT_ACTIVE
-		str	r7, [r8, #TI_PREEMPT]		@ set PREEMPT_ACTIVE
-1:		enable_irq r2				@ enable IRQs
-		bl	schedule
-		disable_irq r0				@ disable IRQs
+		mov	r7, #0				@ preempt_schedule_irq 
+		str	r7, [r8, #TI_PREEMPT]		@ expects preempt_count == 0
+1:		bl	preempt_schedule_irq		@ irq en/disable is done inside
 		ldr	r0, [r8, #TI_FLAGS]		@ get new tasks TI_FLAGS
 		tst	r0, #_TIF_NEED_RESCHED
 		beq	preempt_return			@ go again

--=-e8uI1c5Hg6KDadqVMbMR--

