Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVCZFOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVCZFOp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 00:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbVCZFOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 00:14:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56213 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261800AbVCZFO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 00:14:28 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050325223959.GA24800@elte.hu>
References: <20050325145908.GA7146@elte.hu>
	 <1111790009.23430.19.camel@mindpipe>  <20050325223959.GA24800@elte.hu>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 00:14:25 -0500
Message-Id: <1111814065.24049.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 23:39 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Fri, 2005-03-25 at 15:59 +0100, Ingo Molnar wrote:
> > > i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
> > > downloaded from the usual place:
> > > 
> > >    http://redhat.com/~mingo/realtime-preempt/
> > 
> > I get zillions of "return type defaults to int" warnings trying to
> > compile this with PREEMPT_DESKTOP.
> 
> i've uploaded -41-11 which should fix it.
> 

OK.  Any idea about those get_swap_page latencies?  I set the swappiness
to 100 on both machines, but I only see those on the slower machine.

Running for several days with PREEMPT_DESKTOP, on the Athlon XP the
worst latency I am seeing is ~150 usecs!  But on the C3 its about 4ms:

(     ksoftirqd/0-2    |#0): new 16 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 32 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 77 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 86 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 110 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 121 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 131 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 136 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 143 us maximum-latency wakeup.
(          IRQ 11-1445 |#0): new 172 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 594 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1164 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1255 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1429 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1557 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1680 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1722 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 1944 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2027 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2082 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2107 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2112 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2322 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2339 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2426 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2517 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2707 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2817 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 2874 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3053 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3149 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3225 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3250 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3316 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3636 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3668 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3819 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3953 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 3964 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 4104 us maximum-latency wakeup.

The traces look like this:

preemption latency trace v1.1.4 on 2.6.12-rc1-RT-V0.7.41-08
--------------------------------------------------------------------
 latency: 4104 us, #124/124, CPU#0 | (M:preempt VP:0, KP:1, SP:1 HP:1 #P:1)
    -----------------
    | task: ksoftirqd/0-2 (uid:0 nice:-10 policy:0 rt_prio:0)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> need-resched    
               || / _---=> hardirq/softirq 
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
(T1/#0)          kswapd0    66 0 9 00000002 00000000 [0061867425992692] 0.000ms (+914240.345ms): <6177736b> (<00306470>)
(T1/#2)          kswapd0    66 0 9 00000002 00000002 [0061867425993150] 0.000ms (+0.000ms): __trace_start_sched_wakeup+0x96/0xc0 <c012f806> (try_to_wake_up+0x84/0x140 <c010f9e4>)
(T1/#3)          kswapd0    66 0 9 00000000 00000003 [0061867425993646] 0.001ms (+0.001ms): wake_up_process+0x1c/0x30 <c010fabc> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#4)  kswapd0-66    0dn.2    2us!< (1)
(T2/#5)  kswapd0-66    0dnh2  975us : do_IRQ+0x2d/0x80 <c010467d> (c014e3c6 0 0)
(T1/#6)          kswapd0    66 0 5 00000001 00000006 [0061867426579669] 0.976ms (+0.003ms): mask_and_ack_8259A+0xb/0x110 <c010818b> (__do_IRQ+0x8b/0x160 <c01364ab>)
(T1/#7)          kswapd0    66 0 5 00000001 00000007 [0061867426581623] 0.979ms (+0.000ms): redirect_hardirq+0x8/0x90 <c0136288> (__do_IRQ+0xbc/0x160 <c01364dc>)
(T1/#8)          kswapd0    66 0 5 00000000 00000008 [0061867426582099] 0.980ms (+0.000ms): handle_IRQ_event+0xe/0xf0 <c013631e> (__do_IRQ+0xea/0x160 <c013650a>)
(T1/#9)          kswapd0    66 0 5 00000000 00000009 [0061867426582486] 0.981ms (+0.000ms): timer_interrupt+0xb/0x100 <c0106fcb> (handle_IRQ_event+0x61/0xf0 <c0136371>)
(T1/#10)          kswapd0    66 0 5 00000001 0000000a [0061867426583035] 0.982ms (+0.004ms): mark_offset_tsc+0xe/0x370 <c010c81e> (timer_interrupt+0x24/0x100 <c0106fe4>)
(T1/#11)          kswapd0    66 0 5 00000001 0000000b [0061867426585820] 0.986ms (+0.000ms): do_timer+0x8/0x20 <c011e718> (timer_interrupt+0x2a/0x100 <c0106fea>)
(T1/#12)          kswapd0    66 0 5 00000001 0000000c [0061867426586179] 0.987ms (+0.000ms): update_process_times+0xa/0x100 <c011e17a> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#13)          kswapd0    66 0 5 00000001 0000000d [0061867426586521] 0.988ms (+0.000ms): account_system_time+0xa/0xb0 <c011013a> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#14)          kswapd0    66 0 5 00000001 0000000e [0061867426586854] 0.988ms (+0.000ms): acct_update_integrals+0xa/0x60 <c013609a> (account_system_time+0x40/0xb0 <c0110170>)
(T1/#15)          kswapd0    66 0 5 00000001 0000000f [0061867426587131] 0.989ms (+0.000ms): update_mem_hiwater+0x8/0x50 <c0147b68> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#16)          kswapd0    66 0 5 00000001 00000010 [0061867426587472] 0.989ms (+0.000ms): run_local_timers+0x8/0x20 <c011e298> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#17)          kswapd0    66 0 5 00000001 00000011 [0061867426587879] 0.990ms (+0.000ms): raise_softirq+0xa/0x70 <c011a21a> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#18)          kswapd0    66 0 5 00000001 00000012 [0061867426588355] 0.991ms (+0.000ms): rcu_check_callbacks+0x8/0xc0 <c0126e18> (update_process_times+0x68/0x100 <c011e1d8>)
(T1/#19)          kswapd0    66 0 5 00000001 00000013 [0061867426588691] 0.991ms (+0.000ms): idle_cpu+0x8/0x20 <c0110c28> (rcu_check_callbacks+0x66/0xc0 <c0126e76>)
(T1/#20)          kswapd0    66 0 5 00000001 00000014 [0061867426589168] 0.992ms (+0.000ms): scheduler_tick+0xc/0x3e0 <c011024c> (update_process_times+0x6f/0x100 <c011e1df>)
(T1/#21)          kswapd0    66 0 5 00000001 00000015 [0061867426589501] 0.993ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (scheduler_tick+0x1d/0x3e0 <c011025d>)
(T1/#22)          kswapd0    66 0 5 00000001 00000016 [0061867426590397] 0.994ms (+0.000ms): run_posix_cpu_timers+0xe/0x1b0 <c012d04e> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#23)          kswapd0    66 0 5 00000001 00000017 [0061867426590838] 0.995ms (+0.001ms): profile_hit+0x9/0x50 <c0115a79> (timer_interrupt+0x4e/0x100 <c010700e>)
(T1/#24)          kswapd0    66 0 5 00000001 00000018 [0061867426591522] 0.996ms (+0.000ms): note_interrupt+0xb/0x90 <c0136e0b> (__do_IRQ+0x148/0x160 <c0136568>)
(T1/#25)          kswapd0    66 0 5 00000001 00000019 [0061867426591895] 0.997ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107f58> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#26)          kswapd0    66 0 5 00000001 0000001a [0061867426592237] 0.997ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c010803b> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#27)          kswapd0    66 0 7 00000002 0000001b [0061867426593509] 0.999ms (+0.000ms): irq_exit+0x8/0x50 <c011a1c8> (do_IRQ+0x60/0x80 <c01046b0>)
(T1/#28)          kswapd0    66 0 3 00000003 0000001c [0061867426593976] 1.000ms (+0.000ms): do_softirq+0xb/0x60 <c010477b> (irq_exit+0x45/0x50 <c011a205>)
(T1/#29)          kswapd0    66 0 9 00000000 0000001d [0061867426594452] 1.001ms (+0.001ms): __do_softirq+0xa/0x90 <c011a05a> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#30)  kswapd0-66    0dn.2 1002us!< (1)
(T2/#31)  kswapd0-66    0dnh2 1973us : do_IRQ+0x2d/0x80 <c010467d> (c014e3cc 0 0)
(T1/#32)          kswapd0    66 0 5 00000001 00000020 [0061867427179407] 1.974ms (+0.002ms): mask_and_ack_8259A+0xb/0x110 <c010818b> (__do_IRQ+0x8b/0x160 <c01364ab>)
(T1/#33)          kswapd0    66 0 5 00000001 00000021 [0061867427181188] 1.977ms (+0.000ms): redirect_hardirq+0x8/0x90 <c0136288> (__do_IRQ+0xbc/0x160 <c01364dc>)
(T1/#34)          kswapd0    66 0 5 00000000 00000022 [0061867427181652] 1.978ms (+0.000ms): handle_IRQ_event+0xe/0xf0 <c013631e> (__do_IRQ+0xea/0x160 <c013650a>)
(T1/#35)          kswapd0    66 0 5 00000000 00000023 [0061867427182012] 1.978ms (+0.000ms): timer_interrupt+0xb/0x100 <c0106fcb> (handle_IRQ_event+0x61/0xf0 <c0136371>)
(T1/#36)          kswapd0    66 0 5 00000001 00000024 [0061867427182448] 1.979ms (+0.004ms): mark_offset_tsc+0xe/0x370 <c010c81e> (timer_interrupt+0x24/0x100 <c0106fe4>)
(T1/#37)          kswapd0    66 0 5 00000001 00000025 [0061867427185275] 1.984ms (+0.000ms): do_timer+0x8/0x20 <c011e718> (timer_interrupt+0x2a/0x100 <c0106fea>)
(T1/#38)          kswapd0    66 0 5 00000001 00000026 [0061867427185625] 1.984ms (+0.000ms): update_process_times+0xa/0x100 <c011e17a> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#39)          kswapd0    66 0 5 00000001 00000027 [0061867427185972] 1.985ms (+0.000ms): account_system_time+0xa/0xb0 <c011013a> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#40)          kswapd0    66 0 5 00000001 00000028 [0061867427186355] 1.986ms (+0.000ms): acct_update_integrals+0xa/0x60 <c013609a> (account_system_time+0x40/0xb0 <c0110170>)
(T1/#41)          kswapd0    66 0 5 00000001 00000029 [0061867427186720] 1.986ms (+0.000ms): update_mem_hiwater+0x8/0x50 <c0147b68> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#42)          kswapd0    66 0 5 00000001 0000002a [0061867427187061] 1.987ms (+0.000ms): run_local_timers+0x8/0x20 <c011e298> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#43)          kswapd0    66 0 5 00000001 0000002b [0061867427187394] 1.987ms (+0.000ms): raise_softirq+0xa/0x70 <c011a21a> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#44)          kswapd0    66 0 5 00000001 0000002c [0061867427187844] 1.988ms (+0.000ms): rcu_check_callbacks+0x8/0xc0 <c0126e18> (update_process_times+0x68/0x100 <c011e1d8>)
(T1/#45)          kswapd0    66 0 5 00000001 0000002d [0061867427188177] 1.989ms (+0.000ms): idle_cpu+0x8/0x20 <c0110c28> (rcu_check_callbacks+0x66/0xc0 <c0126e76>)
(T1/#46)          kswapd0    66 0 5 00000001 0000002e [0061867427188595] 1.989ms (+0.000ms): scheduler_tick+0xc/0x3e0 <c011024c> (update_process_times+0x6f/0x100 <c011e1df>)
(T1/#47)          kswapd0    66 0 5 00000001 0000002f [0061867427189086] 1.990ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (scheduler_tick+0x1d/0x3e0 <c011025d>)
(T1/#48)          kswapd0    66 0 5 00000001 00000030 [0061867427189936] 1.992ms (+0.000ms): run_posix_cpu_timers+0xe/0x1b0 <c012d04e> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#49)          kswapd0    66 0 5 00000001 00000031 [0061867427190359] 1.992ms (+0.001ms): profile_hit+0x9/0x50 <c0115a79> (timer_interrupt+0x4e/0x100 <c010700e>)
(T1/#50)          kswapd0    66 0 5 00000001 00000032 [0061867427191007] 1.993ms (+0.000ms): note_interrupt+0xb/0x90 <c0136e0b> (__do_IRQ+0x148/0x160 <c0136568>)
(T1/#51)          kswapd0    66 0 5 00000001 00000033 [0061867427191376] 1.994ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107f58> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#52)          kswapd0    66 0 5 00000001 00000034 [0061867427191718] 1.995ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c010803b> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#53)          kswapd0    66 0 7 00000002 00000035 [0061867427192985] 1.997ms (+0.000ms): irq_exit+0x8/0x50 <c011a1c8> (do_IRQ+0x60/0x80 <c01046b0>)
(T1/#55)          kswapd0    66 0 9 00000000 00000037 [0061867427194001] 1.998ms (+0.000ms): __do_softirq+0xa/0x90 <c011a05a> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#56)  kswapd0-66    0dn.2 1999us!< (1)
(T2/#57)  kswapd0-66    0dnh2 2971us : do_IRQ+0x2d/0x80 <c010467d> (c014e3cf 0 0)
(T1/#58)          kswapd0    66 0 5 00000001 0000003a [0061867427779204] 2.972ms (+0.002ms): mask_and_ack_8259A+0xb/0x110 <c010818b> (__do_IRQ+0x8b/0x160 <c01364ab>)
(T1/#59)          kswapd0    66 0 5 00000001 0000003b [0061867427780963] 2.975ms (+0.000ms): redirect_hardirq+0x8/0x90 <c0136288> (__do_IRQ+0xbc/0x160 <c01364dc>)
(T1/#60)          kswapd0    66 0 5 00000000 0000003c [0061867427781443] 2.976ms (+0.000ms): handle_IRQ_event+0xe/0xf0 <c013631e> (__do_IRQ+0xea/0x160 <c013650a>)
(T1/#61)          kswapd0    66 0 5 00000000 0000003d [0061867427781830] 2.976ms (+0.000ms): timer_interrupt+0xb/0x100 <c0106fcb> (handle_IRQ_event+0x61/0xf0 <c0136371>)
(T1/#62)          kswapd0    66 0 5 00000001 0000003e [0061867427782271] 2.977ms (+0.004ms): mark_offset_tsc+0xe/0x370 <c010c81e> (timer_interrupt+0x24/0x100 <c0106fe4>)
(T1/#63)          kswapd0    66 0 5 00000001 0000003f [0061867427785062] 2.982ms (+0.000ms): do_timer+0x8/0x20 <c011e718> (timer_interrupt+0x2a/0x100 <c0106fea>)
(T1/#64)          kswapd0    66 0 5 00000001 00000040 [0061867427785408] 2.982ms (+0.000ms): update_process_times+0xa/0x100 <c011e17a> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#65)          kswapd0    66 0 5 00000001 00000041 [0061867427785750] 2.983ms (+0.000ms): account_system_time+0xa/0xb0 <c011013a> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#66)          kswapd0    66 0 5 00000001 00000042 [0061867427786129] 2.984ms (+0.000ms): acct_update_integrals+0xa/0x60 <c013609a> (account_system_time+0x40/0xb0 <c0110170>)
(T1/#67)          kswapd0    66 0 5 00000001 00000043 [0061867427786489] 2.984ms (+0.000ms): update_mem_hiwater+0x8/0x50 <c0147b68> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#68)          kswapd0    66 0 5 00000001 00000044 [0061867427786839] 2.985ms (+0.000ms): run_local_timers+0x8/0x20 <c011e298> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#69)          kswapd0    66 0 5 00000001 00000045 [0061867427787172] 2.985ms (+0.000ms): raise_softirq+0xa/0x70 <c011a21a> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#70)          kswapd0    66 0 5 00000001 00000046 [0061867427787626] 2.986ms (+0.000ms): rcu_check_callbacks+0x8/0xc0 <c0126e18> (update_process_times+0x68/0x100 <c011e1d8>)
(T1/#71)          kswapd0    66 0 5 00000001 00000047 [0061867427787964] 2.987ms (+0.000ms): idle_cpu+0x8/0x20 <c0110c28> (rcu_check_callbacks+0x66/0xc0 <c0126e76>)
(T1/#72)          kswapd0    66 0 5 00000001 00000048 [0061867427788378] 2.987ms (+0.000ms): scheduler_tick+0xc/0x3e0 <c011024c> (update_process_times+0x6f/0x100 <c011e1df>)
(T1/#73)          kswapd0    66 0 5 00000001 00000049 [0061867427788711] 2.988ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (scheduler_tick+0x1d/0x3e0 <c011025d>)
(T1/#74)          kswapd0    66 0 5 00000001 0000004a [0061867427789557] 2.989ms (+0.000ms): run_posix_cpu_timers+0xe/0x1b0 <c012d04e> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#75)          kswapd0    66 0 5 00000001 0000004b [0061867427789989] 2.990ms (+0.001ms): profile_hit+0x9/0x50 <c0115a79> (timer_interrupt+0x4e/0x100 <c010700e>)
(T1/#76)          kswapd0    66 0 5 00000001 0000004c [0061867427790659] 2.991ms (+0.000ms): note_interrupt+0xb/0x90 <c0136e0b> (__do_IRQ+0x148/0x160 <c0136568>)
(T1/#77)          kswapd0    66 0 5 00000001 0000004d [0061867427791033] 2.992ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107f58> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#78)          kswapd0    66 0 5 00000001 0000004e [0061867427791433] 2.992ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c010803b> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#79)          kswapd0    66 0 7 00000002 0000004f [0061867427792705] 2.995ms (+0.000ms): irq_exit+0x8/0x50 <c011a1c8> (do_IRQ+0x60/0x80 <c01046b0>)
(T1/#80)          kswapd0    66 0 3 00000003 00000050 [0061867427793238] 2.995ms (+0.000ms): do_softirq+0xb/0x60 <c010477b> (irq_exit+0x45/0x50 <c011a205>)
(T1/#81)          kswapd0    66 0 9 00000000 00000051 [0061867427793742] 2.996ms (+0.000ms): __do_softirq+0xa/0x90 <c011a05a> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#82)  kswapd0-66    0dn.2 2997us!< (1)
(T2/#83)  kswapd0-66    0dnh2 3969us : do_IRQ+0x2d/0x80 <c010467d> (c014e3c6 0 0)
(T1/#84)          kswapd0    66 0 5 00000001 00000054 [0061867428379021] 3.970ms (+0.003ms): mask_and_ack_8259A+0xb/0x110 <c010818b> (__do_IRQ+0x8b/0x160 <c01364ab>)
(T1/#85)          kswapd0    66 0 5 00000001 00000055 [0061867428380861] 3.973ms (+0.000ms): redirect_hardirq+0x8/0x90 <c0136288> (__do_IRQ+0xbc/0x160 <c01364dc>)
(T1/#86)          kswapd0    66 0 5 00000000 00000056 [0061867428381320] 3.974ms (+0.000ms): handle_IRQ_event+0xe/0xf0 <c013631e> (__do_IRQ+0xea/0x160 <c013650a>)
(T1/#87)          kswapd0    66 0 5 00000000 00000057 [0061867428381680] 3.975ms (+0.000ms): timer_interrupt+0xb/0x100 <c0106fcb> (handle_IRQ_event+0x61/0xf0 <c0136371>)
(T1/#88)          kswapd0    66 0 5 00000001 00000058 [0061867428382121] 3.975ms (+0.004ms): mark_offset_tsc+0xe/0x370 <c010c81e> (timer_interrupt+0x24/0x100 <c0106fe4>)
(T1/#89)          kswapd0    66 0 5 00000001 00000059 [0061867428385025] 3.980ms (+0.000ms): do_timer+0x8/0x20 <c011e718> (timer_interrupt+0x2a/0x100 <c0106fea>)
(T1/#90)          kswapd0    66 0 5 00000001 0000005a [0061867428385375] 3.981ms (+0.000ms): update_process_times+0xa/0x100 <c011e17a> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#91)          kswapd0    66 0 5 00000001 0000005b [0061867428385721] 3.981ms (+0.000ms): account_system_time+0xa/0xb0 <c011013a> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#92)          kswapd0    66 0 5 00000001 0000005c [0061867428386105] 3.982ms (+0.000ms): acct_update_integrals+0xa/0x60 <c013609a> (account_system_time+0x40/0xb0 <c0110170>)
(T1/#93)          kswapd0    66 0 5 00000001 0000005d [0061867428386469] 3.982ms (+0.000ms): update_mem_hiwater+0x8/0x50 <c0147b68> (update_process_times+0xed/0x100 <c011e25d>)
(T1/#94)          kswapd0    66 0 5 00000001 0000005e [0061867428386810] 3.983ms (+0.000ms): run_local_timers+0x8/0x20 <c011e298> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#95)          kswapd0    66 0 5 00000001 0000005f [0061867428387139] 3.984ms (+0.000ms): raise_softirq+0xa/0x70 <c011a21a> (update_process_times+0x2d/0x100 <c011e19d>)
(T1/#96)          kswapd0    66 0 5 00000001 00000060 [0061867428387622] 3.984ms (+0.000ms): rcu_check_callbacks+0x8/0xc0 <c0126e18> (update_process_times+0x68/0x100 <c011e1d8>)
(T1/#97)          kswapd0    66 0 5 00000001 00000061 [0061867428387958] 3.985ms (+0.000ms): idle_cpu+0x8/0x20 <c0110c28> (rcu_check_callbacks+0x66/0xc0 <c0126e76>)
(T1/#98)          kswapd0    66 0 5 00000001 00000062 [0061867428388453] 3.986ms (+0.000ms): scheduler_tick+0xc/0x3e0 <c011024c> (update_process_times+0x6f/0x100 <c011e1df>)
(T1/#99)          kswapd0    66 0 5 00000001 00000063 [0061867428388781] 3.986ms (+0.001ms): sched_clock+0xe/0xe0 <c010c57e> (scheduler_tick+0x1d/0x3e0 <c011025d>)
(T1/#100)          kswapd0    66 0 5 00000001 00000064 [0061867428389637] 3.988ms (+0.000ms): run_posix_cpu_timers+0xe/0x1b0 <c012d04e> (timer_interrupt+0x44/0x100 <c0107004>)
(T1/#101)          kswapd0    66 0 5 00000001 00000065 [0061867428390064] 3.988ms (+0.001ms): profile_hit+0x9/0x50 <c0115a79> (timer_interrupt+0x4e/0x100 <c010700e>)
(T1/#102)          kswapd0    66 0 5 00000001 00000066 [0061867428390703] 3.990ms (+0.000ms): note_interrupt+0xb/0x90 <c0136e0b> (__do_IRQ+0x148/0x160 <c0136568>)
(T1/#103)          kswapd0    66 0 5 00000001 00000067 [0061867428391076] 3.990ms (+0.000ms): end_8259A_irq+0x8/0x40 <c0107f58> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#104)          kswapd0    66 0 5 00000001 00000068 [0061867428391423] 3.991ms (+0.002ms): enable_8259A_irq+0xb/0x80 <c010803b> (__do_IRQ+0x110/0x160 <c0136530>)
(T1/#105)          kswapd0    66 0 7 00000002 00000069 [0061867428392667] 3.993ms (+0.000ms): irq_exit+0x8/0x50 <c011a1c8> (do_IRQ+0x60/0x80 <c01046b0>)
(T1/#106)          kswapd0    66 0 3 00000003 0000006a [0061867428393139] 3.994ms (+0.000ms): do_softirq+0xb/0x60 <c010477b> (irq_exit+0x45/0x50 <c011a205>)
(T1/#107)          kswapd0    66 0 9 00000000 0000006b [0061867428393628] 3.994ms (+0.000ms): __do_softirq+0xa/0x90 <c011a05a> (do_softirq+0x4b/0x60 <c01047bb>)
(T6/#108)  kswapd0-66    0dn.2 3995us+< (1)
(T1/#109)          kswapd0    66 0 2 00000001 0000006d [0061867428448564] 4.086ms (+0.001ms): preempt_schedule+0xa/0x70 <c02a837a> (get_swap_page+0x208/0x290 <c014e488>)
(T1/#110)          kswapd0    66 0 2 00000000 0000006e [0061867428449351] 4.087ms (+0.000ms): preempt_schedule+0xa/0x70 <c02a837a> (get_swap_page+0xc4/0x290 <c014e344>)
(T1/#111)          kswapd0    66 0 3 00000000 0000006f [0061867428449864] 4.088ms (+0.000ms): __schedule+0xe/0x710 <c02a7b5e> (preempt_schedule+0x4f/0x70 <c02a83bf>)
(T1/#112)          kswapd0    66 0 3 00000000 00000070 [0061867428450437] 4.089ms (+0.000ms): profile_hit+0x9/0x50 <c0115a79> (__schedule+0x3a/0x710 <c02a7b8a>)
(T1/#113)          kswapd0    66 0 3 00000001 00000071 [0061867428450904] 4.090ms (+0.002ms): sched_clock+0xe/0xe0 <c010c57e> (__schedule+0x68/0x710 <c02a7bb8>)
(T1/#114)          kswapd0    66 0 3 00000002 00000072 [0061867428452321] 4.092ms (+0.000ms): dequeue_task+0xa/0x50 <c010f5ba> (__schedule+0x1ca/0x710 <c02a7d1a>)
(T1/#115)          kswapd0    66 0 3 00000002 00000073 [0061867428452788] 4.093ms (+0.000ms): recalc_task_prio+0xc/0x1a0 <c010f71c> (__schedule+0x1e4/0x710 <c02a7d34>)
(T1/#116)          kswapd0    66 0 3 00000002 00000074 [0061867428453289] 4.094ms (+0.000ms): effective_prio+0x8/0x50 <c010f6c8> (recalc_task_prio+0xa6/0x1a0 <c010f7b6>)
(T1/#117)          kswapd0    66 0 3 00000002 00000075 [0061867428453667] 4.094ms (+0.001ms): enqueue_task+0xa/0x80 <c010f60a> (__schedule+0x1eb/0x710 <c02a7d3b>)
(T4/#118) [ =>          kswapd0 ] 4.095ms (+0.002ms)
(T1/#119)            <...>     2 0 1 00000002 00000077 [0061867428455634] 4.098ms (+0.001ms): __switch_to+0xb/0x1a0 <c01013bb> (__schedule+0x329/0x710 <c02a7e79>)
(T3/#120)    <...>-2     0d..2 4100us : __schedule+0x356/0x710 <c02a7ea6> <kswapd0-66> (74 69): 
(T1/#121)            <...>     2 0 1 00000001 00000079 [0061867428457287] 4.100ms (+0.000ms): trace_stop_sched_switched+0xa/0x150 <c012f83a> (__schedule+0x38d/0x710 <c02a7edd>)
(T3/#122)    <...>-2     0d..1 4101us : trace_stop_sched_switched+0x42/0x150 <c012f872> <<...>-2> (69 0):
(T1/#123)            <...>     2 0 1 00000001 0000007b [0061867428458566] 4.102ms (+0.000ms): trace_stop_sched_switched+0xfe/0x150 <c012f92e> (__schedule+0x38d/0x710 <c02a7edd>)


vim:ft=help

Lee

