Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424262AbWKIXln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424262AbWKIXln (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:41:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424261AbWKIXjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:49 -0500
Received: from www.osadl.org ([213.239.205.134]:6301 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161877AbWKIXjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:17 -0500
Message-Id: <20061109233035.912069000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:33 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 16/19] dynticks: i386 arch code
Content-Disposition: inline; filename=dynticks-i386-arch-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Prepare i386 for dyntick: idle handler callbacks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff -puN arch/i386/kernel/process.c~dynticks-i386-arch-code arch/i386/kernel/process.c
--- a/arch/i386/kernel/process.c~dynticks-i386-arch-code
+++ a/arch/i386/kernel/process.c
@@ -168,6 +168,7 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		hrtimer_stop_sched_tick();
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -186,6 +187,7 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
+		hrtimer_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();
_

--

