Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbUKVTSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUKVTSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKVTRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:17:09 -0500
Received: from [199.46.245.231] ([199.46.245.231]:56243 "EHLO
	tus-gate2.ext.ray.com") by vger.kernel.org with ESMTP
	id S262355AbUKVTOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:14:31 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.30-2
Date: Mon, 22 Nov 2004 13:12:32 -0600
Message-ID: <OF824686D8.38949A05-ON86256F54.00698454-86256F54.00698486@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/22/2004 01:12:40 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a few ideas to simplify the set up to see if I can get some
>useful data out of the system.

It appears the lockup only occurs after I do
  echo 0 > /proc/sys/kernel/preempt_wakeup_latency

I did manage to get a few messages out of the system before the lockup
this time and here is what was on the serial console.

[I didn't do "dmesg -n 1" like I usually do...]

  --Mark
--------

[starts with a couple of the wakeup latency messages, then the
messages from changing the tracing type]
(X/2869/CPU#1): new 76 us maximum-latency wakeup.
(ksoftirqd/1/7/CPU#1): new 110 us maximum-latency wakeup.
(X/2869/CPU#0): new 825 us maximum-latency critical section.
 => started at timestamp 4156290879: <try_to_wake_up+0x379/0x3e0>
 =>   ended at timestamp 4156291705: <__up_mutex+0x469/0x4d0>
 [<c0104e83>] dump_stack+0x23/0x30 (20)
 [<c013d107>] check_critical_timing+0x1d7/0x390 (88)
 [<c013d58d>] trace_irqs_on+0x7d/0x90 (24)
 [<c013ad19>] __up_mutex+0x469/0x4d0 (60)
 [<c013b4c6>] up_mutex+0xb6/0x110 (40)
 [<c016e234>] fget+0x54/0x70 (28)
 [<c0182c37>] do_select+0x207/0x2b0 (120)
 [<c0182fee>] sys_select+0x2be/0x580 (92)
 [<c0103f8d>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013e32d>] .... print_traces+0x1d/0x60
.....[<c0104e83>] ..   ( <= dump_stack+0x23/0x30)

 =>   dump-end timestamp 4156528745

(IRQ 0/2/CPU#0): new 51 us maximum-latency critical section.
 => started at timestamp 4208681904: <__up_mutex+0x9c/0x4d0>
 =>   ended at timestamp 4208681955: <schedule+0x4c/0x140>
 [<c0104e83>] dump_stack+0x23/0x30 (20)
 [<c013d107>] check_critical_timing+0x1d7/0x390 (88)
 [<c013d58d>] trace_irqs_on+0x7d/0x90 (24)
 [<c032ad7c>] schedule+0x4c/0x140 (36)
 [<c032c386>] __down_mutex+0x2a6/0x310 (84)
 [<c013bccb>] __spin_lock+0x4b/0x60 (24)
 [<c013bcfd>] _spin_lock+0x1d/0x30 (16)
 [<c0109260>] timer_interrupt+0x20/0x110 (32)
 [<c0147b63>] handle_IRQ_event+0x53/0xa0 (40)
 [<c01483d5>] do_hardirq+0xa5/0x100 (40)
 [<c0148571>] do_irqd+0x141/0x210 (48)
 [<c0138b6b>] kthread+0xbb/0xc0 (48)
 [<c0102019>] kernel_thread_helper+0x5/0xc (536952852)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013e32d>] .... print_traces+0x1d/0x60
.....[<c0104e83>] ..   ( <= dump_stack+0x23/0x30)

 =>   dump-end timestamp 4208969387

(get_ltrace.sh/6305/CPU#1): new 64 us maximum-latency critical section.
 => started at timestamp 4209005150: <do_exit+0x32c/0x5e0>
 =>   ended at timestamp 4209005214: <try_to_wake_up+0x23d/0x3e0>
 [<c0104e83>] dump_stack+0x23/0x30 (20)
 [<c013d107>] check_critical_timing+0x1d7/0x390 (88)
 [<c013d320>] touch_critical_timing+0x60/0x90 (24)
 [<c0118c5d>] try_to_wake_up+0x23d/0x3e0 (72)
 [<c0118e2b>] wake_up_process+0x2b/0x40 (28)
 [<c01201c7>] __mmdrop_delayed+0x67/0xa0 (20)
 [<c01192f7>] finish_task_switch+0x97/0xc0 (24)
 [<c032a857>] __sched_text_start+0x457/0x930 (112)
 [<c032ad70>] schedule+0x40/0x140 (36)
 [<c01257c6>] do_wait+0x1d6/0x540 (140)
 [<c0125c01>] sys_wait4+0x41/0x50 (28)
 [<c0125c3a>] sys_waitpid+0x2a/0x30 (24)
 [<c0103f8d>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c032a44f>] .... __sched_text_start+0x4f/0x930
.....[<c032ad70>] ..   ( <= schedule+0x40/0x140)
.. [<c012017f>] .... __mmdrop_delayed+0x1f/0xa0
.....[<c01192f7>] ..   ( <= finish_task_switch+0x97/0xc0)
.. [<c032ca3f>] .... _raw_spin_lock+0x1f/0x70
.....[<c0117f62>] ..   ( <= task_rq_lock+0x42/0x80)
.. [<c013e32d>] .... print_traces+0x1d/0x60
.....[<c0104e83>] ..   ( <= dump_stack+0x23/0x30)

 =>   dump-end timestamp 4209394021

(get_ltrace.sh/6305/CPU#1): new 77 us maximum-latency critical section.
 => started at timestamp 4209417650: <__sched_text_start+0x4f/0x930>
 =>   ended at timestamp 4209417728: <preempt_schedule+0x6e/0x80>
 [<c0104e83>] dump_stack+0x23/0x30 (20)
 [<c013d107>] check_critical_timing+0x1d7/0x390 (88)
 [<c013d58d>] trace_irqs_on+0x7d/0x90 (24)
 [<c032aede>] preempt_schedule+0x6e/0x80 (20)
 [<c01190fb>] wake_up_new_task+0x16b/0x240 (44)
 [<c011fce9>] do_fork+0x129/0x1d0 (132)
 [<c01029be>] sys_clone+0x3e/0x50 (32)
 [<c0103f8d>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c013e32d>] .... print_traces+0x1d/0x60
.....[<c0104e83>] ..   ( <= dump_stack+0x23/0x30)

 =>   dump-end timestamp 4209652960

