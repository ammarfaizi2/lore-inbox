Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVLPLqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVLPLqB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 06:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVLPLqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 06:46:00 -0500
Received: from main.gmane.org ([80.91.229.2]:51354 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932213AbVLPLp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 06:45:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>
Subject: Re: 2.6.15-rc5-rt2 slowness
Date: Fri, 16 Dec 2005 12:42:04 +0100
Message-ID: <dnu9ak$k5o$1@sea.gmane.org>
References: <dnu8ku$ie4$1@sea.gmane.org>
Reply-To: G.Ohrner@post.rwth-aachen.de
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3851426.gDpjL2pUc4"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 134.130.238.18
User-Agent: KNode/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3851426.gDpjL2pUc4
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

Gunter Ohrner wrote:
> the other is a high system load and bad responsiveness of the system as a
> whole. I didn't even bother to measure timer/sleep jitters as the system
> was dog slow and the fans started to run a full speed nearly immediately.

Ok, I recompiled the kernel with some debug options and attached
a /proc/latency_trace output, hoping it will be helpful to track down the
problem...

Please tell me if there's anything else I should do.

Greetings,

  Gunter
--nextPart3851426.gDpjL2pUc4
Content-Type: text/plain; name="lat_trace.log"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="lat_trace.log"

preemption latency trace v1.1.5 on 2.6.15-rc5-rt2.zb.20051216.1
--------------------------------------------------------------------
 latency: 45 us, #94/94, CPU#0 | (M:rt VP:0, KP:0, SP:1 HP:1)
    -----------------
    | task: IRQ 12-733 (uid:0 nice:-5 policy:1 rt_prio:47)
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
konquero-4635  0D.h3    0us : __trace_start_sched_wakeup (try_to_wake_up)
konquero-4635  0D.h3    1us : __trace_start_sched_wakeup <<...>-733> (34 0)
konquero-4635  0Dnh2    1us : try_to_wake_up <<...>-733> (34 74)
konquero-4635  0Dnh2    1us : check_raw_flags (try_to_wake_up)
konquero-4635  0Dnh1    1us : preempt_schedule (try_to_wake_up)
konquero-4635  0Dnh1    1us : wake_up_process (redirect_hardirq)
konquero-4635  0Dnh.    2us : preempt_schedule (__do_IRQ)
konquero-4635  0Dnh.    2us : irq_exit (do_IRQ)
konquero-4635  0Dn..    2us : __schedule (work_resched)
konquero-4635  0Dn..    3us : profile_hit (__schedule)
konquero-4635  0Dn.1    3us : sched_clock (__schedule)
konquero-4635  0D..2    5us : trace_array (__schedule)
konquero-4635  0D..2    6us : trace_array <<...>-733> (34 34)
konquero-4635  0D..2    6us : trace_array <konquero-4635> (74 78)
konquero-4635  0D..2    7us : trace_array <<...>-4458> (74 78)
konquero-4635  0D..2    7us : trace_array <<...>-4621> (75 78)
konquero-4635  0D..2    7us : trace_array <<...>-5894> (76 78)
konquero-4635  0D..2    8us : trace_array <<...>-5892> (77 78)
konquero-4635  0D..2    8us+: trace_array (__schedule)
   <...>-733   0D..2   11us : __switch_to (__schedule)
   <...>-733   0D..2   11us : __schedule <konquero-4635> (74 34)
   <...>-733   0D.h2   13us : do_IRQ (c030af09 0 0)
   <...>-733   0D.h3   13us+: mask_and_ack_8259A (__do_IRQ)
   <...>-733   0D.h4   16us : check_raw_flags (mask_and_ack_8259A)
   <...>-733   0D.h3   16us : redirect_hardirq (__do_IRQ)
   <...>-733   0D.h2   16us : handle_IRQ_event (__do_IRQ)
   <...>-733   0D.h2   17us : timer_interrupt (handle_IRQ_event)
   <...>-733   0D.h2   18us : handle_nextevent_tick_update (timer_interrupt)
   <...>-733   0D.h2   18us : hrtimer_interrupt (handle_nextevent_tick_update)
   <...>-733   0D.h2   19us : get_monotonic_clock (hrtimer_interrupt)
   <...>-733   0D.h2   19us : acpi_pm_read (get_monotonic_clock)
   <...>-733   0D.h2   20us : get_check_value (get_monotonic_clock)
   <...>-733   0D.h3   21us : check_raw_flags (get_check_value)
   <...>-733   0D.h2   21us : check_monotonic_clock (get_monotonic_clock)
   <...>-733   0D.h3   21us : check_raw_flags (check_monotonic_clock)
   <...>-733   0D.h2   22us : clockevents_set_next_event (hrtimer_interrupt)
   <...>-733   0D.h2   22us : get_monotonic_clock (clockevents_set_next_event)
   <...>-733   0D.h2   23us : acpi_pm_read (get_monotonic_clock)
   <...>-733   0D.h2   23us : get_check_value (get_monotonic_clock)
   <...>-733   0D.h3   24us : check_raw_flags (get_check_value)
   <...>-733   0D.h2   24us : check_monotonic_clock (get_monotonic_clock)
   <...>-733   0D.h3   24us : check_raw_flags (check_monotonic_clock)
   <...>-733   0D.h2   25us+: pit_next_event (clockevents_set_next_event)
   <...>-733   0D.h3   29us : check_raw_flags (pit_next_event)
   <...>-733   0D.h2   29us : handle_tick (handle_nextevent_tick_update)
   <...>-733   0D.h3   29us : do_timer (handle_tick)
   <...>-733   0D.h2   30us : handle_update (handle_nextevent_tick_update)
   <...>-733   0D.h2   30us : update_process_times (handle_update)
   <...>-733   0D.h2   31us : account_system_time (update_process_times)
   <...>-733   0D.h2   31us : run_local_timers (update_process_times)
   <...>-733   0D.h2   31us : raise_softirq (run_local_timers)
   <...>-733   0D.h2   32us : wakeup_softirqd (raise_softirq)
   <...>-733   0D.h2   32us : wake_up_process (wakeup_softirqd)
   <...>-733   0D.h2   32us : check_preempt_wakeup (wake_up_process)
   <...>-733   0D.h2   33us : try_to_wake_up (wake_up_process)
   <...>-733   0D.h3   33us : activate_task (try_to_wake_up)
   <...>-733   0D.h3   33us : sched_clock (activate_task)
   <...>-733   0D.h3   33us : activate_task <<...>-3> (62 6)
   <...>-733   0D.h3   33us : enqueue_task (activate_task)
   <...>-733   0D.h3   34us : check_raw_flags (try_to_wake_up)
   <...>-733   0D.h2   34us : wake_up_process (wakeup_softirqd)
   <...>-733   0D.h2   34us : check_raw_flags (raise_softirq)
   <...>-733   0D.h2   34us : rcu_pending (update_process_times)
   <...>-733   0D.h2   35us : rcu_check_callbacks (update_process_times)
   <...>-733   0D.h2   35us : rcu_try_flip (rcu_check_callbacks)
   <...>-733   0D.h3   36us : check_raw_flags (rcu_try_flip)
   <...>-733   0D.h3   36us : __rcu_advance_callbacks (rcu_check_callbacks)
   <...>-733   0D.h3   36us : check_raw_flags (rcu_check_callbacks)
   <...>-733   0D.h2   36us : __tasklet_schedule (rcu_check_callbacks)
   <...>-733   0D.h2   37us : wakeup_softirqd (__tasklet_schedule)
   <...>-733   0D.h2   37us : wake_up_process (wakeup_softirqd)
   <...>-733   0D.h2   37us : check_preempt_wakeup (wake_up_process)
   <...>-733   0D.h2   38us : try_to_wake_up (wake_up_process)
   <...>-733   0D.h3   38us : activate_task (try_to_wake_up)
   <...>-733   0D.h3   38us : sched_clock (activate_task)
   <...>-733   0D.h3   38us : activate_task <<...>-7> (62 7)
   <...>-733   0D.h3   38us : enqueue_task (activate_task)
   <...>-733   0D.h3   39us : check_raw_flags (try_to_wake_up)
   <...>-733   0D.h2   39us : wake_up_process (wakeup_softirqd)
   <...>-733   0D.h2   39us : check_raw_flags (__tasklet_schedule)
   <...>-733   0D.h2   39us : scheduler_tick (update_process_times)
   <...>-733   0D.h2   39us : sched_clock (scheduler_tick)
   <...>-733   0D.h2   40us : softlockup_tick (update_process_times)
   <...>-733   0D.h2   40us : touch_light_softlockup_watchdog (softlockup_tick)
   <...>-733   0D.h3   41us : note_interrupt (__do_IRQ)
   <...>-733   0D.h3   41us : enable_8259A_irq (__do_IRQ)
   <...>-733   0D.h4   42us : check_raw_flags (enable_8259A_irq)
   <...>-733   0D.h2   43us : irq_exit (do_IRQ)
   <...>-733   0D..2   43us < (608)
   <...>-733   0...1   43us : trace_stop_sched_switched (__schedule)
   <...>-733   0D..2   44us : trace_stop_sched_switched <<...>-733> (34 0)
   <...>-733   0D..2   45us : trace_stop_sched_switched (__schedule)


vim:ft=help

--nextPart3851426.gDpjL2pUc4--

