Return-Path: <linux-kernel-owner+w=401wt.eu-S964990AbXABWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbXABWvP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbXABWvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:51:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:28851 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964990AbXABWvO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:51:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="32346009:sNHT21841461"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Date: Tue, 2 Jan 2007 14:51:05 -0800
Message-ID: <9D2C22909C6E774EBFB8B5583AE5291C019FA2B5@fmsmsx414.amr.corp.intel.com>
In-Reply-To: <20061229232618.GA11239@gnuppy.monkey.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] lock stat for -rt 2.6.20-rc2-rt2 [was Re: 2.6.19-rt14 slowdown compared to 2.6.19]
Thread-Index: AccroMK8wP2RUfgRQSWGfTyVHJqQqADH0Y+A
From: "Chen, Tim C" <tim.c.chen@intel.com>
To: "Bill Huey \(hui\)" <billh@gnuppy.monkey.org>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
       "Steven Rostedt" <rostedt@goodmis.org>,
       "Thomas Gleixner" <tglx@linutronix.de>
X-OriginalArrivalTime: 02 Jan 2007 22:51:07.0524 (UTC) FILETIME=[7D5DB440:01C72EC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (hui) wrote:
> On Tue, Dec 26, 2006 at 04:51:21PM -0800, Chen, Tim C wrote:
>> Ingo Molnar wrote:
>>> If you'd like to profile this yourself then the lowest-cost way of
>>> profiling lock contention on -rt is to use the yum kernel and run
>>> the attached trace-it-lock-prof.c code on the box while your
>>> workload is in 'steady state' (and is showing those extended idle
>>> times): 
>>> 
>>>   ./trace-it-lock-prof > trace.txt
>> 
>> Thanks for the pointer.  Will let you know of any relevant traces.
> 
> Tim,
>
http://mmlinux.sourceforge.net/public/patch-2.6.20-rc2-rt2.lock_stat.pat
ch
> 
> You can also apply this patch to get more precise statistics down to
> the lock. For example:
> 
Bill,

I'm having some problem getting this patch to run stablely.  I'm
encoutering errors like that in the trace that follow:

Thanks.
Tim



Unable to handle kernel NULL pointer dereference at 0000000000000008
RIP:
 [<ffffffff802cd6e4>] lock_stat_note_contention+0x12d/0x1c3
PGD 0
Oops: 0000 [1] PREEMPT SMP
CPU 1
Modules linked in: autofs4 sunrpc dm_mirror dm_mod video sbs i2c_ec dock
button battery ac uhci_hcd ehci_hcd i2dPid: 0, comm: swapper Not tainted
2.6.20-rc2-rt2 #4

RIP: 0010:[<ffffffff802cd6e4>]  [<ffffffff802cd6e4>]
lock_stat_note_contention+0x12d/0x1c3
RSP: 0018:ffff81013fdb3d28  EFLAGS: 00010097
RAX: ffff81013fd68018 RBX: ffff81013fd68000 RCX: 0000000000000000
RDX: ffffffff8026762e RSI: 0000000000000000 RDI: ffffffff8026762e
RBP: ffff81013fdb3df8 R08: ffff8100092bab60 R09: ffff8100092aafc8
R10: 0000000000000001 R11: 0000000000000000 R12: ffff81013fd68030
R13: 0000000000000000 R14: 0000000000000046 R15: 0000002728d5ecd0
FS:  0000000000000000(0000) GS:ffff81013fd078c0(0000)
knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 0000000000201000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81013fdb2000, task
ffff81013fdb14e0)
Stack:  0000000000000000 0000000200000001 0000000000000000
0000000000000000
 0000000000000000 0000000000000000 0000000000000100 000000000000000e
 000000000000000e 0000000000000000 0000000000000000 ffff8100092bc440
Call Trace:
 [<ffffffff802af471>] rt_mutex_slowtrylock+0x84/0x9b
 [<ffffffff80266909>] rt_mutex_trylock+0x2e/0x30
 [<ffffffff8026762e>] rt_spin_trylock+0x9/0xb
 [<ffffffff8029beef>] get_next_timer_interrupt+0x34/0x226
 [<ffffffff802a8b4d>] hrtimer_stop_sched_tick+0xb6/0x138
 [<ffffffff8024b1ce>] cpu_idle+0x1b/0xdd
 [<ffffffff80278edd>] start_secondary+0x2ed/0x2f9

---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8024b28a>] .... cpu_idle+0xd7/0xdd
.....[<ffffffff80278edd>] ..   ( <= start_secondary+0x2ed/0x2f9)
.. [<ffffffff80267837>] .... __spin_lock_irqsave+0x18/0x42
.....[<ffffffff802af406>] ..   ( <= rt_mutex_slowtrylock+0x19/0x9b)
.. [<ffffffff802678db>] .... __spin_trylock+0x14/0x4c
.....[<ffffffff80268540>] ..   ( <= oops_begin+0x23/0x6f)

skipping trace printing on CPU#1 != -1

Code: 49 8b 45 08 8b 78 18 75 0d 49 8b 04 24 f0 ff 80 94 00 00 00
RIP  [<ffffffff802cd6e4>] lock_stat_note_contention+0x12d/0x1c3
 RSP <ffff81013fdb3d28>
CR2: 0000000000000008
 <3>BUG: sleeping function called from invalid context swapper(0) at
kernel/rtmutex.c:1312
in_atomic():1 [00000002], irqs_disabled():1

Call Trace:
 [<ffffffff8026ec53>] dump_trace+0xbe/0x3cd
 [<ffffffff8026eff3>] show_trace+0x3a/0x58
 [<ffffffff8026f026>] dump_stack+0x15/0x17
 [<ffffffff8020b75e>] __might_sleep+0x103/0x10a
 [<ffffffff80266e44>] rt_mutex_lock_with_ip+0x1e/0xac
 [<ffffffff802aff07>] __rt_down_read+0x49/0x4d
 [<ffffffff802aff16>] rt_down_read+0xb/0xd
 [<ffffffff8029fc96>] blocking_notifier_call_chain+0x19/0x3f
 [<ffffffff80296301>] profile_task_exit+0x15/0x17
 [<ffffffff80215572>] do_exit+0x25/0x8de
 [<ffffffff8026a2c1>] do_page_fault+0x7d4/0x856
 [<ffffffff802681ad>] error_exit+0x0/0x84
 [<ffffffff802cd6e4>] lock_stat_note_contention+0x12d/0x1c3
 [<ffffffff802af471>] rt_mutex_slowtrylock+0x84/0x9b
 [<ffffffff80266909>] rt_mutex_trylock+0x2e/0x30
 [<ffffffff8026762e>] rt_spin_trylock+0x9/0xb
 [<ffffffff8029beef>] get_next_timer_interrupt+0x34/0x226
 [<ffffffff802a8b4d>] hrtimer_stop_sched_tick+0xb6/0x138
 [<ffffffff8024b1ce>] cpu_idle+0x1b/0xdd
 [<ffffffff80278edd>] start_secondary+0x2ed/0x2f9

