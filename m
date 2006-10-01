Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWJAXLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWJAXLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 19:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWJAXHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 19:07:31 -0400
Received: from www.osadl.org ([213.239.205.134]:24499 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932489AbWJAXG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 19:06:59 -0400
Message-Id: <20061001225725.213599000@cruncher.tec.linutronix.de>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
Date: Sun, 01 Oct 2006 23:01:06 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 19/21] dynticks: i386 arch code
Content-Disposition: inline; filename=i368-prepare-no-hz.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

Prepare i386 for dyntick: idle handler callbacks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
----
 arch/i386/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.18-mm2/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/process.c	2006-10-02 00:55:45.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/process.c	2006-10-02 00:55:55.000000000 +0200
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

