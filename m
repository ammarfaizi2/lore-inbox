Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030542AbWFVCvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030542AbWFVCvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 22:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030543AbWFVCvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 22:51:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39142 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030542AbWFVCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 22:51:04 -0400
Subject: More weird latency trace output (was Re: 2.6.17-rt1)
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <1150937848.2754.379.camel@mindpipe>
References: <20060618070641.GA6759@elte.hu>
	 <1150937848.2754.379.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 22:51:03 -0400
Message-Id: <1150944663.2754.416.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 20:57 -0400, Lee Revell wrote:
> I'm getting some strange latency tracer output on a dual core AMD box.
> Why does it start at 404us?
> 

After setting trace_all_cpus to 1, I get the following:

( posix_cpu_timer-15   |#1): new 8 us maximum-latency wakeup.
(         IRQ 233-2446 |#1): new 14 us maximum-latency wakeup.
( posix_cpu_timer-15   |#1): new 19 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 861 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 862 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 862 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 868 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 876 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 879 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 880 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 882 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 884 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 884 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 885 us maximum-latency wakeup.

[ max latencies continue to creep up by 1-2 us at a time ]

(          IRQ 14-1783 |#0): new 1826 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1827 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1828 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1831 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1832 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1834 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1836 us maximum-latency wakeup.
(         IRQ 233-2446 |#0): new 1838 us maximum-latency wakeup.

Here is a typical trace:

preemption latency trace v1.1.5 on 2.6.17-rt1-smp-latency-trace
--------------------------------------------------------------------
 latency: 1898 us, #78/78, CPU#1 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 233-2446 (uid:0 nice:-5 policy:1 rt_prio:40)
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
softirq--5     0....    0us : __wake_up (ksoftirqd)
softirq--5     0....    0us : __lock_text_start (__wake_up)
softirq--5     0....    0us : __wake_up_common (__wake_up)
softirq--5     0....    0us : rt_unlock (__wake_up)
softirq--5     0....    0us : kthread_should_stop (ksoftirqd)
softirq--5     0....    0us : schedule (ksoftirqd)
softirq--5     0....    1us : __schedule (schedule)
softirq--5     0....    1us : profile_hit (__schedule)
softirq--5     0...1    1us : sched_clock (__schedule)
softirq--5     0...1    1us : _raw_spin_lock_irq (__schedule)
softirq--5     0D..2    2us : touch_softlockup_watchdog (__schedule)
softirq--5     0D..2    2us : deactivate_task (__schedule)
softirq--5     0D..2    2us : deactivate_task <softirq--5> (101 1)
softirq--5     0D..2    2us : dequeue_task (deactivate_task)
softirq--5     0D..2    3us : __first_cpu (__schedule)
softirq--5     0D..2    3us : __next_cpu (__schedule)
softirq--5     0D..2    3us : double_lock_balance (__schedule)
softirq--5     0D..2    3us : _raw_spin_trylock (double_lock_balance)
softirq--5     0D..3    4us : trace_change_sched_cpu (__schedule)
softirq--5     0D..3    5us : trace_change_sched_cpu (1 1 0)
softirq--5     0D..3    5us : _raw_spin_lock (trace_change_sched_cpu)
softirq--5     0D..4    5us : trace_change_sched_cpu (1 0 0)
softirq--5     0D..4    6us : _raw_spin_unlock (trace_change_sched_cpu)
softirq--5     0D..3    6us : constant_test_bit (_raw_spin_unlock)
softirq--5     0D..3    6us : deactivate_task (__schedule)
softirq--5     0D..3    6us : deactivate_task <<...>-2446> (140 3)
softirq--5     0D..3    7us : dequeue_task (deactivate_task)
softirq--5     0D..3    7us : activate_task (__schedule)
softirq--5     0D..3    7us : sched_clock (activate_task)
softirq--5     0D..3    7us : __activate_task (activate_task)
softirq--5     0D..3    8us : __activate_task <<...>-2446> (59 0)
softirq--5     0D..3    8us : enqueue_task (__activate_task)
softirq--5     0D..3    8us : _raw_spin_unlock (__schedule)
softirq--5     0D..2    8us : constant_test_bit (_raw_spin_unlock)
softirq--5     0D..2    8us : __next_cpu (__schedule)
softirq--5     0D..2    9us : __switch_to (thread_return)
   <...>-2446  0D..2   10us : thread_return <softirq--5> (101 140)
   <...>-2446  0D..2   10us : _raw_spin_unlock_irq (thread_return)
   <...>-2446  0...1   10us : constant_test_bit (_raw_spin_unlock_irq)
   <...>-2446  0...1   11us : trace_stop_sched_switched (thread_return)
   <...>-2446  0D..1   11us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-2446  0D..2   11us : trace_stop_sched_switched <<...>-2446> (59 0)
   <...>-2446  0D..3   11us : _raw_spin_unlock (trace_stop_sched_switched)
   <...>-2446  0D..2   12us : constant_test_bit (_raw_spin_unlock)
   <...>-2446  0D..2   12us : report_latency (trace_stop_sched_switched)
   <...>-2446  0D..2   12us!: thread_return (thread_return)

How can the latency tracer be reporting 1898us max latency while the
trace is of a 12us latency?  This must be a bug, correct?

Lee


