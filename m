Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751614AbWCNByr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbWCNByr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 20:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWCNByq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 20:54:46 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:23242 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751614AbWCNByq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 20:54:46 -0500
Subject: Re: 2.6.16-rc6-rt1
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060312220218.GA3469@elte.hu>
References: <20060312220218.GA3469@elte.hu>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 20:54:37 -0500
Message-Id: <1142301277.27125.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I couldn't compile it on x86_64 (and I believe PPC has the same
problem). I guess the function propagate_preempt_locks_value
disappeared.

This patch removes the references from ppc and x86_64.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-rc6-rt2/arch/ppc/kernel/idle.c
===================================================================
--- linux-2.6.16-rc6-rt2.orig/arch/ppc/kernel/idle.c	2006-03-13 16:44:49.000000000 -0500
+++ linux-2.6.16-rc6-rt2/arch/ppc/kernel/idle.c	2006-03-13 20:11:05.000000000 -0500
@@ -66,7 +66,6 @@
 		while (!need_resched()) {
 			BUG_ON(raw_irqs_disabled());
 			stop_critical_timing();
-			propagate_preempt_locks_value();
 
 			if (ppc_md.idle != NULL)
 				ppc_md.idle();
Index: linux-2.6.16-rc6-rt2/arch/x86_64/kernel/process.c
===================================================================
--- linux-2.6.16-rc6-rt2.orig/arch/x86_64/kernel/process.c	2006-03-13 16:44:49.000000000 -0500
+++ linux-2.6.16-rc6-rt2/arch/x86_64/kernel/process.c	2006-03-13 20:10:28.000000000 -0500
@@ -229,7 +229,6 @@
 			if (cpu_is_offline(smp_processor_id()))
 				play_dead();
 			stop_critical_timing();
-			propagate_preempt_locks_value();
 			enter_idle();
 			idle();
 			__exit_idle();


