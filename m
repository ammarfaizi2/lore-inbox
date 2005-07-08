Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVGHNCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVGHNCl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbVGHNCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:02:41 -0400
Received: from odin2.bull.net ([192.90.70.84]:36606 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S262643AbVGHNCk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:02:40 -0400
Subject: PREEMPT_RT and latency_trace
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Organization: BTS
Message-Id: <1120826951.6225.167.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Fri, 08 Jul 2005 14:49:14 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a big dilemna on one machine :
I run a task with RT priority which make a loop to mesure the system
perturbation.
It works well except on  one machine.
On a multi-cpu, If I run the program on cpu 1, I get 23us. It's OK.
If I run the same program on cpu 0, I get 17373us !
If I do :
# echo 0 >/proc/sys/kernel/preempt_max_latency
# ./tsc 0
 temps deb 60229d5e6ee 
cptr mlockall 0
 temps fin 6c386df6612 
 temps max 1  6472c52d682 
 temps max 2  6472fa35c26 
duree du test 259.450819 s max detecte 17373 µs
#cat /proc/latency_trace 
preemption latency trace v1.1.4 on 2.6.12-RT-V0.7.51-13-DAV06
--------------------------------------------------------------------
 latency: 33 us, #48/48, CPU#1 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
   -----------------
   | task: softirq-timer/1-12 (uid:0 nice:-10 policy:0 rt_prio:0)
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
 <idle>-0     1Dnh3    0us!: <70617773> (<00726570>)
 <idle>-0     1Dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
 <idle>-0     1Dnh3    0us : __trace_start_sched_wakeup <<...>-12>(69 1)
 <idle>-0     1Dnh3    0us : _raw_spin_unlock (try_to_wake_up)
 <idle>-0     1Dnh2    0us : resched_task (try_to_wake_up)
 <idle>-0     1Dnh2    0us+: try_to_wake_up <<...>-12> (69 8c)
 <idle>-0     1Dnh2   22us : _raw_spin_unlock_irqrestore
(try_to_wake_up)
 <idle>-0     1Dnh1   22us : preempt_schedule (try_to_wake_up)
 <idle>-0     1Dnh1   22us : wake_up_process (trigger_softirqs)
 <idle>-0     1Dnh.   23us : preempt_schedule_irq (need_resched)
 <idle>-0     1Dnh.   23us : __schedule (preempt_schedule_irq)
 <idle>-0     1Dnh.   23us : profile_hit (__schedule)
 <idle>-0     1Dnh1   23us : sched_clock (__schedule)
 <idle>-0     1Dnh1   23us : _raw_spin_lock_irq (__schedule)
 <idle>-0     1Dnh1   24us : _raw_spin_lock_irqsave (__schedule)
 <idle>-0     1Dnh2   24us : pull_rt_tasks (__schedule)
 <idle>-0     1Dnh2   24us : double_lock_balance (pull_rt_tasks)
 <idle>-0     1Dnh2   24us : _raw_spin_trylock (double_lock_balance)
 <idle>-0     1Dnh3   25us : pick_rt_task (pull_rt_tasks)
 <idle>-0     1Dnh3   25us : find_next_bit (pick_rt_task)
 <idle>-0     1Dnh3   25us : find_next_bit (pick_rt_task)
 <idle>-0     1Dnh3   25us : find_next_bit (pick_rt_task)
 <idle>-0     1Dnh3   25us : _raw_spin_unlock (pull_rt_tasks)
 <idle>-0     1Dnh2   26us : preempt_schedule (pull_rt_tasks)
 <idle>-0     1Dnh2   26us : find_next_bit (pull_rt_tasks)
 <idle>-0     1Dnh2   26us : find_next_bit (pull_rt_tasks)
 <idle>-0     1Dnh2   26us : dependent_sleeper (__schedule)
 <idle>-0     1Dnh2   26us : _raw_spin_unlock (dependent_sleeper)
 <idle>-0     1Dnh1   27us : preempt_schedule (dependent_sleeper)
 <idle>-0     1Dnh1   27us : _raw_spin_lock (dependent_sleeper)
 <idle>-0     1Dnh2   27us : find_next_bit (dependent_sleeper)
 <idle>-0     1Dnh2   27us : dequeue_task (__schedule)
 <idle>-0     1Dnh2   27us : recalc_task_prio (__schedule)
 <idle>-0     1Dnh2   28us : effective_prio (recalc_task_prio)
 <idle>-0     1Dnh2   28us : enqueue_task (__schedule)
 <idle>-0     1Dnh2   28us : trace_array (__schedule)
 <idle>-0     1Dnh2   29us : trace_array <<...>-12> (69 6e)
 <idle>-0     1Dnh2   29us : trace_array (__schedule)
  <...>-12    1Dnh2   31us : __switch_to (__schedule)
  <...>-12    1Dnh2   31us : __schedule <<idle>-0> (8c 69)
  <...>-12    1Dnh2   31us : finish_task_switch (__schedule)
  <...>-12    1Dnh2   31us : _raw_spin_unlock (finish_task_switch)
  <...>-12    1Dnh1   32us : trace_stop_sched_switched
(finish_task_switch)
  <...>-12    1Dnh1   32us : _raw_spin_lock (trace_stop_sched_switched)
  <...>-12    1Dnh2   32us : trace_stop_sched_switched <<...>-12>(69 1)
  <...>-12    1Dnh2   32us : trace_stop_sched_switched
(finish_task_switch)


vim:ft=help


My Question is : where is the time missing ?

