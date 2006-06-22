Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWFVA5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWFVA5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 20:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030471AbWFVA5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 20:57:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:24533 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030464AbWFVA5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 20:57:21 -0400
Subject: Re: 2.6.17-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20060618070641.GA6759@elte.hu>
References: <20060618070641.GA6759@elte.hu>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 20:57:27 -0400
Message-Id: <1150937848.2754.379.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 09:06 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rt1 tree, which can be downloaded from the 
> usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this is a fixes-only release: merged to 2.6.17-final and smaller fixes.
> 
> to build a 2.6.17-rc6-rt1 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.17.tar.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rt1

I'm getting some strange latency tracer output on a dual core AMD box.
Why does it start at 404us?

Lee

preemption latency trace v1.1.5 on 2.6.17-rt1-smp-latency-trace
--------------------------------------------------------------------
 latency: 415 us, #26/26, CPU#1 | (M:rt VP:0, KP:0, SP:1 HP:1 #P:2)
    -----------------
    | task: kjournald-2043 (uid:0 nice:-5 policy:0 rt_prio:0)
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
  <idle>-0     1Dn.1  404us : smp_reschedule_interrupt (reschedule_interrupt)
  <idle>-0     1.n.1  405us : __exit_idle (cpu_idle)
  <idle>-0     1.n.1  405us : atomic_notifier_call_chain (__exit_idle)
  <idle>-0     1.n.1  406us : rcu_read_lock (atomic_notifier_call_chain)
  <idle>-0     1Dn.1  406us : rcu_read_lock (0 0 badc)
  <idle>-0     1Dn.1  406us : rcu_read_lock (ffff810002eb7228 0 badc)
  <idle>-0     1.n.1  406us : rcu_read_unlock (atomic_notifier_call_chain)
  <idle>-0     1Dn.1  407us : rcu_read_unlock (ffff810002eb7228 0 1)
  <idle>-0     1Dn.1  407us : rcu_read_unlock (0 0 0)
  <idle>-0     1Dn..  407us : __schedule (cpu_idle)
  <idle>-0     1Dn..  407us : profile_hit (__schedule)
  <idle>-0     1Dn.1  408us : sched_clock (__schedule)
  <idle>-0     1Dn.1  408us : _raw_spin_lock_irq (__schedule)
  <idle>-0     1Dn.2  409us : recalc_task_prio (__schedule)
  <idle>-0     1Dn.2  410us : effective_prio (recalc_task_prio)
  <idle>-0     1Dn.2  410us : effective_prio <<...>-2043> (-10 -10)
  <idle>-0     1D..2  412us : __switch_to (thread_return)
   <...>-2043  1D..2  413us : thread_return <<idle>-0> (20 -10)
   <...>-2043  1D..2  413us : _raw_spin_unlock_irq (thread_return)
   <...>-2043  1...1  413us : constant_test_bit (_raw_spin_unlock_irq)
   <...>-2043  1...1  413us : trace_stop_sched_switched (thread_return)
   <...>-2043  1D..1  414us : _raw_spin_lock (trace_stop_sched_switched)
   <...>-2043  1D..2  414us : trace_stop_sched_switched <<...>-2043> (110 1)
   <...>-2043  1D..2  415us : thread_return (thread_return)



