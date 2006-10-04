Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161919AbWJDRkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161919AbWJDRkV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161929AbWJDRiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 13:38:14 -0400
Received: from www.osadl.org ([213.239.205.134]:45797 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161919AbWJDRiI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 13:38:08 -0400
Message-Id: <20061004172224.149262000@cruncher.tec.linutronix.de>
References: <20061004172217.092570000@cruncher.tec.linutronix.de>
Date: Wed, 04 Oct 2006 17:31:51 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       John Stultz <johnstul@us.ibm.com>,
       Valdis Kletnieks <valdis.kletnieks@vt.edu>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>,
       David Woodhouse <dwmw2@infradead.org>, Jim Gettys <jg@laptop.org>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 20/22] dynticks: i386 arch code
Content-Disposition: inline; filename=dynticks-i386-arch-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Prepare i386 for dyntick: idle handler callbacks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
 arch/i386/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm3/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.18-mm3.orig/arch/i386/kernel/process.c	2006-10-04 18:13:48.000000000 +0200
+++ linux-2.6.18-mm3/arch/i386/kernel/process.c	2006-10-04 18:13:58.000000000 +0200
@@ -178,6 +178,7 @@ void cpu_idle(void)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		hrtimer_stop_sched_tick();
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -196,6 +197,7 @@ void cpu_idle(void)
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
+		hrtimer_restart_sched_tick();
 		preempt_enable_no_resched();
 		schedule();
 		preempt_disable();

--

