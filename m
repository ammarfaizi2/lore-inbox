Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269692AbUICNnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269692AbUICNnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 09:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269693AbUICNnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 09:43:35 -0400
Received: from lax-gate2.raytheon.com ([199.46.200.231]:26331 "EHLO
	lax-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S269692AbUICNnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 09:43:10 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
From: Mark_H_Johnson@Raytheon.com
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q9
Date: Fri, 3 Sep 2004 08:42:30 -0500
Message-ID: <OF2638C6DC.7CC7594C-ON86256F04.004B4D5E-86256F04.004B4D82@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/03/2004 08:42:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> this is as if the CPU executed everything in 'slow motion'. E.g. the
>> cache being disabled could be one such reason - or some severe DMA or
>> other bus traffic.
>
>another thing: could you try maxcpus=1 again and see whether 1 CPU
>produces similar 'slow motion' traces?

OK. Second try to send this message. I've had two complete system lockups
now with -Q9. The first doing a kernel build, the second while trying
to send a message explaining that plus the results I saw when trying
to test with maxcpus=1.

Booted w/ maxcpus=1 nmi_watchdog=1. Saw information messages confirming
both were set and acted on.

First major problem was the audio came out "too fast". The test repeats
a pattern and you could hear it repeating faster than it should have.
Needless to say - this meant that there was no time available to run
any non real time tasks so the application timing results were worthless
and the latency traces were separated by several minutes in some cases.
[before I could force a SIGINT to the real time task]

I don't know if the traces I did get are helpful or not, but here is a
summary.... The numbers after each title refer to the trace file number
so if you count them, you get an idea how frequent each symptom was.
I will send the full traces only if you ask for them.

Slow getting to "switch_tasks" (00, 01, 10, 12, 13, 16)

00000002 0.002ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.303ms): schedule (io_schedule)
00010002 0.306ms (+0.016ms): do_nmi (schedule)
00010002 0.323ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010002 0.323ms (+0.000ms): profile_hook (profile_tick)
00010002 0.323ms (+0.100ms): read_lock (profile_hook)
00010003 0.424ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.424ms (+0.070ms): profile_hit (nmi_watchdog_tick)
00000002 0.494ms (+0.000ms): dummy_switch_tasks (schedule)

Slow getting to "__switch_to" (02, 03, 05, 09)

00000002 0.003ms (+0.000ms): dummy_switch_tasks (schedule)
00000002 0.003ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.327ms): schedule (io_schedule)
00000002 0.331ms (+0.000ms): schedule (io_schedule)
00000002 0.331ms (+0.000ms): schedule (io_schedule)
00000002 0.331ms (+0.000ms): schedule (io_schedule)
00000002 0.332ms (+0.236ms): schedule (io_schedule)
00010002 0.568ms (+0.001ms): do_nmi (mcount)
00010002 0.570ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010002 0.570ms (+0.000ms): profile_hook (profile_tick)
00010002 0.570ms (+0.000ms): read_lock (profile_hook)
00010003 0.571ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.571ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00000002 0.572ms (+0.000ms): __switch_to (schedule)

Slow to both switch_tasks and __switch_to (04, 06)

00000002 0.002ms (+0.000ms): dequeue_task (deactivate_task)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.002ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.000ms): schedule (io_schedule)
00000002 0.003ms (+0.131ms): schedule (io_schedule)
00000002 0.134ms (+0.000ms): dummy_switch_tasks (schedule)
00000002 0.134ms (+0.000ms): schedule (io_schedule)
00000002 0.134ms (+0.000ms): schedule (io_schedule)
00000002 0.134ms (+0.000ms): schedule (io_schedule)
00000002 0.135ms (+0.000ms): schedule (io_schedule)
00000002 0.135ms (+0.000ms): schedule (io_schedule)
00000002 0.135ms (+0.139ms): schedule (io_schedule)
00010002 0.275ms (+0.279ms): do_nmi (schedule)
00010002 0.554ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010002 0.554ms (+0.000ms): profile_hook (profile_tick)
00010002 0.554ms (+0.000ms): read_lock (profile_hook)
00010003 0.555ms (+0.000ms): notifier_call_chain (profile_hook)
00010002 0.555ms (+0.001ms): profile_hit (nmi_watchdog_tick)
00000002 0.557ms (+0.000ms): __switch_to (schedule)

sched_clock (08, 11, 14)

00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.000ms): schedule (worker_thread)
00000001 0.000ms (+0.553ms): sched_clock (schedule)
00010001 0.554ms (+0.001ms): do_nmi (sched_clock)
00010001 0.556ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.556ms (+0.000ms): profile_hook (profile_tick)
00010001 0.556ms (+0.000ms): read_lock (profile_hook)
00010002 0.556ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.557ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00010001 0.557ms (+0.000ms): do_IRQ (sched_clock)
00010001 0.558ms (+0.000ms): do_IRQ (<00000000>)
00010001 0.558ms (+0.000ms): spin_lock (do_IRQ)

__modify_IO_APIC_irq (15)

00000001 0.000ms (+0.000ms): __spin_lock_irqsave (spin_lock_irq)
00000001 0.000ms (+0.000ms): generic_enable_irq (ide_do_request)
00000001 0.000ms (+0.000ms): __spin_lock_irqsave (generic_enable_irq)
00000002 0.001ms (+0.000ms): unmask_IO_APIC_irq (generic_enable_irq)
00000002 0.001ms (+0.000ms): __spin_lock_irqsave (unmask_IO_APIC_irq)
00000003 0.002ms (+0.000ms): __unmask_IO_APIC_irq (unmask_IO_APIC_irq)
00000003 0.002ms (+0.565ms): __modify_IO_APIC_irq (__unmask_IO_APIC_irq)
00010001 0.567ms (+0.001ms): do_nmi (apic_timer_interrupt)
00010001 0.569ms (+0.000ms): profile_tick (nmi_watchdog_tick)
00010001 0.569ms (+0.000ms): profile_hook (profile_tick)
00010001 0.569ms (+0.000ms): read_lock (profile_hook)
00010002 0.570ms (+0.000ms): notifier_call_chain (profile_hook)
00010001 0.570ms (+0.000ms): profile_hit (nmi_watchdog_tick)
00000001 0.571ms (+0.000ms): smp_apic_timer_interrupt (as_work_handler)

In the meantime, I will build a kernel with -R1 and leave the latency trace
on (now running a -Q7 kernel with both CPUs active) to see if it shows
anything interesting before attempting any more tests.

  --Mark

