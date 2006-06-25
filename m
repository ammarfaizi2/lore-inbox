Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWFYNHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWFYNHR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWFYNHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:07:16 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:39857 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750710AbWFYNHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:07:15 -0400
Date: Sun, 25 Jun 2006 09:06:57 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Thomas Gleixner <tglx@timesys.com>
cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and
 dynamic HZ
In-Reply-To: <1150746705.29299.57.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606250904530.5324@gandalf.stny.rr.com>
References: <1150643426.27073.17.camel@localhost.localdomain> 
 <449580CA.2060704@gmail.com> <20060618182820.GA32765@elte.hu> 
 <4496D24F.80003@gmail.com> <1150746705.29299.57.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

I finally was able to try -V5. And hit the following:

WARNING: "hrtimer_stop_sched_tick" [drivers/acpi/processor.ko] undefined!
WARNING: "hrtimer_restart_sched_tick" [drivers/acpi/processor.ko] undefined!


Here's the patch.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17/kernel/hrtimer.c
===================================================================
--- linux-2.6.17.orig/kernel/hrtimer.c	2006-06-24 18:47:22.000000000 -0400
+++ linux-2.6.17/kernel/hrtimer.c	2006-06-24 18:48:03.000000000 -0400
@@ -550,6 +550,7 @@ int hrtimer_stop_sched_tick(void)

 	return need_resched();
 }
+EXPORT_SYMBOL_GPL(hrtimer_stop_sched_tick);

 void hrtimer_restart_sched_tick(void)
 {
@@ -584,6 +585,7 @@ void hrtimer_restart_sched_tick(void)
 		      HRTIMER_ABS);
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(hrtimer_restart_sched_tick);

 void show_no_hz_stats(struct seq_file *p)
 {
