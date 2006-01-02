Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWABH5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWABH5j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 02:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWABH5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 02:57:39 -0500
Received: from general.keba.co.at ([193.154.24.243]:24942 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S932332AbWABH5j convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 02:57:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Mon, 2 Jan 2006 08:57:27 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F36732330E@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYNRe7wT1G214tfQ2+JhP4GqFsbKACJhoYQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> 
> It looks like in ARM the cpu_idle() (and default_idle) get traced . So
> for instance you'll get a situation when preemption is off, interrupts
> are off, and then the cpu runs something like halt on x86. Then an
> interrupt wakes up the cpu. 
> 
> I attached a patch that might fix the tracing. I tried to prevent the
> tracing around when the cpu halts.

I tried your patch. I makes the idle traces look quite different, 
but each cpu_idle still causes a latency trace.

preemption latency trace v1.1.5 on 2.6.15-rc7-rt1
--------------------------------------------------------------------
 latency: 8964 us, #67/67, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
    -----------------
    | task: IRQ 45-18 (uid:0 nice:-5 policy:1 rt_prio:48)
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
  <idle>-0     0D...    1us+: preempt_schedule_irq (svc_preempt)
  <idle>-0     0....    5us!: default_idle (cpu_idle)
  <idle>-0     0D..1 8700us+: asm_do_IRQ (c021da48 1a 0)
  <idle>-0     0D.h2 8708us+: default_mask_ack (handle_level_irq)
  <idle>-0     0D.h2 8712us+: sa1100_mask_irq (default_mask_ack)
  <idle>-0     0D.h2 8715us+: sa1100_mask_irq (default_mask_ack)
  <idle>-0     0D.h2 8719us+: redirect_hardirq (handle_level_irq)
  <idle>-0     0D.h1 8724us+: handle_IRQ_event (handle_level_irq)
  <idle>-0     0D.h1 8727us+: sa1100_timer_interrupt (handle_IRQ_event)
  <idle>-0     0D.h2 8730us+: timer_tick (sa1100_timer_interrupt)
  <idle>-0     0D.h2 8733us+: profile_tick (timer_tick)
  <idle>-0     0D.h2 8737us+: profile_hit (profile_tick)
  <idle>-0     0D.h2 8740us+: do_timer (timer_tick)
  <idle>-0     0D.h2 8743us+: update_process_times (timer_tick)
  <idle>-0     0D.h2 8746us+: account_system_time (update_process_times)
  <idle>-0     0D.h2 8750us+: run_local_timers (update_process_times)
  <idle>-0     0D.h2 8752us+: raise_softirq (run_local_timers)
  <idle>-0     0D.h2 8757us+: wakeup_softirqd (raise_softirq)
  <idle>-0     0D.h2 8760us+: wake_up_process (wakeup_softirqd)
  <idle>-0     0D.h2 8763us+: check_preempt_wakeup (wake_up_process)
  <idle>-0     0D.h2 8767us+: try_to_wake_up (wake_up_process)
  <idle>-0     0D.h3 8772us+: activate_task (try_to_wake_up)
  <idle>-0     0D.h3 8775us+: sched_clock (activate_task)
  <idle>-0     0D.h3 8780us+: activate_task <<...>-3> (62 0)
  <idle>-0     0D.h3 8784us+: enqueue_task (activate_task)
  <idle>-0     0Dnh3 8788us+: try_to_wake_up <<...>-3> (62 8c)
  <idle>-0     0Dnh3 8792us+: check_raw_flags (try_to_wake_up)
  <idle>-0     0Dnh2 8795us+: preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh2 8799us+: wake_up_process (wakeup_softirqd)
  <idle>-0     0Dnh2 8801us+: check_raw_flags (raise_softirq)
  <idle>-0     0Dnh2 8804us+: rcu_pending (update_process_times)
  <idle>-0     0Dnh2 8808us+: scheduler_tick (update_process_times)
  <idle>-0     0Dnh2 8810us+: sched_clock (scheduler_tick)
  <idle>-0     0Dnh1 8817us+: preempt_schedule (sa1100_timer_interrupt)
  <idle>-0     0Dnh1 8822us+: note_interrupt (handle_level_irq)
  <idle>-0     0Dnh2 8827us+: default_end (handle_level_irq)
  <idle>-0     0Dnh2 8830us+: sa1100_unmask_irq (default_end)
  <idle>-0     0Dnh1 8835us+: preempt_schedule (asm_do_IRQ)
  <idle>-0     0Dnh1 8837us+: irq_exit (asm_do_IRQ)
  <idle>-0     0Dn.1 8841us+: asm_do_IRQ (c021da48 b 0)
  <idle>-0     0Dnh2 8847us+: sa1100_high_gpio_handler (asm_do_IRQ)
  <idle>-0     0Dnh3 8856us+: default_ack (handle_edge_irq)
  <idle>-0     0Dnh3 8861us+: sa1100_high_gpio_ack (default_ack)
  <idle>-0     0Dnh3 8865us+: redirect_hardirq (handle_edge_irq)
  <idle>-0     0Dnh3 8868us+: wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh3 8870us+: check_preempt_wakeup (wake_up_process)
  <idle>-0     0Dnh3 8873us+: try_to_wake_up (wake_up_process)
  <idle>-0     0Dnh4 8877us+: activate_task (try_to_wake_up)
  <idle>-0     0Dnh4 8880us+: sched_clock (activate_task)
  <idle>-0     0Dnh4 8885us+: activate_task <<...>-18> (33 1)
  <idle>-0     0Dnh4 8888us+: enqueue_task (activate_task)
  <idle>-0     0Dnh4 8892us+: try_to_wake_up <<...>-18> (33 8c)
  <idle>-0     0Dnh4 8895us+: check_raw_flags (try_to_wake_up)
  <idle>-0     0Dnh3 8899us+: preempt_schedule (try_to_wake_up)
  <idle>-0     0Dnh3 8901us+: wake_up_process (redirect_hardirq)
  <idle>-0     0Dnh2 8905us+: preempt_schedule
(sa1100_high_gpio_handler)
  <idle>-0     0Dnh1 8907us+: preempt_schedule (asm_do_IRQ)
  <idle>-0     0Dnh1 8910us+: irq_exit (asm_do_IRQ)
  <idle>-0     0Dn.. 8914us+: preempt_schedule_irq (svc_preempt)
  <idle>-0     0Dn.. 8918us+: __schedule (preempt_schedule_irq)
  <idle>-0     0Dn.. 8921us+: profile_hit (__schedule)
  <idle>-0     0Dn.1 8927us+: sched_clock (__schedule)
   <...>-18    0...1 8947us+: __schedule <<idle>-0> (8c 33)
   <...>-18    0...1 8955us+: sub_preempt_count (__schedule)
   <...>-18    0...1 8962us : sub_preempt_count_ti (sub_preempt_count)


In general, I still have the problem that the latencies observed
by my test program (jitter of my sysclock-triggered usermode code
running with high rt priority) does not agree *at all* with
the output of the latency tracer (i.e. the latency tracer provides
no help for finding the real reasons for latencies).

1.) Many of the latencies shown by the latency tracer do not cause
any noticeable latency in my test program. This category includes 
all these idle latencies, the rt_up latency in the latency tracer
itself (see previous mail), and the fpu emulation related latency
(trace 3 in my original mail): No matter how much fpu load I
generate, latency traces go up, but my test programm still doesn't
suffer from any latency or jitter.

2.) Flash writing activity causes latency traces around 10 ms (see
trace 5 in my original mail). It also causes frequent latency in my
test program, but only around 0.1 ms. I can't correlate the trace
output with the observed latencies, and a can't find the reason for
the 0.1 ms observed latency in the trace output.

3.) Even more strange is the situation w.r.t. console output:
There are "active" latency traces around 10 ms 
(where console-related code is executed all the time), e.g. trace 4
in my original mail, and there are "idle" latency traces (with
multi-millisecond holes without any traced activity), also around
10 ms and most likely also console-related (traces 1, 6, 7 in my
original mail).

Console output also causes massive latency in my test program, but 
it is not related to the around-10-ms latencies in the trace: The
observed latencies caused by console output range from 
sub-millisecond to multi-second (!).


So I still believe something is confusing the latency tracer, not
only for the idle case, but in general.

It is also strange that most of the latencies reported by the tracer
(the idle latency, the fpu latency, the flash write latency, and
some of the console latencies) are mostly around 10 ms, i.e. the
system clock tick period. The tracer seems to mis-consider 
everything from a certain point in time to the next system clock 
interrupt (but no further) as a latency, even if it is not.


Next thing to try?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
