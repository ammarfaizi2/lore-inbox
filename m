Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbULHEba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbULHEba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 23:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbULHEba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 23:31:30 -0500
Received: from relay03.pair.com ([209.68.5.17]:11788 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S261922AbULHEbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 23:31:25 -0500
X-pair-Authenticated: 24.241.238.70
Message-ID: <41B6839B.4090403@cybsft.com>
Date: Tue, 07 Dec 2004 22:31:23 -0600
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
References: <20041116130946.GA11053@elte.hu> <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> <20041118123521.GA29091@elte.hu> <20041118164612.GA17040@elte.hu> <20041122005411.GA19363@elte.hu> <20041123175823.GA8803@elte.hu> <20041124101626.GA31788@elte.hu> <20041203205807.GA25578@elte.hu> <20041207132927.GA4846@elte.hu> <20041207141123.GA12025@elte.hu>
In-Reply-To: <20041207141123.GA12025@elte.hu>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080807080300050200040204"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080807080300050200040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -V0.7.32-6 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 

Ingo,

Could you explain what the attached trace means. It looks to me like the 
trace starts in try_to_wake_up when we are trying to wake amlat, but 
then before we finish we get a hit on IRQ 8 and run the IRQ handler??? 
Or do I somehow have it backwards? :)

kr

--------------080807080300050200040204
Content-Type: text/plain;
 name="trace"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="trace"

preemption latency trace v1.1.3 on 2.6.10-rc2-mm3-V0.7.32-9
--------------------------------------------------------------------
 latency: 39 us, #42/42 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:2)
    -----------------
    | task: IRQ 8-677 (uid:0 nice:-5 policy:1 rt_prio:99)
    -----------------

                 _------=> CPU#            
                / _-----=> irqs-off        
               | / _----=> hardirq         
               || / _---=> softirq         
               ||| / _--=> preempt-depth   
               |||| /                      
               |||||     delay             
   cmd     pid ||||| time  |   caller      
      \   /    |||||   \   |   /           
   amlat-4973  0-h.3    0탎 : __trace_start_sched_wakeup (try_to_wake_up)
   amlat-4973  0-h.3    1탎 : _raw_spin_unlock (try_to_wake_up)
   amlat-4973  0-h.2    1탎 : preempt_schedule (try_to_wake_up)
   amlat-4973  0        2탎 : wake_up_process <IRQ 8-677> (0 1): 
   amlat-4973  0-h.2    2탎 : try_to_wake_up (wake_up_process)
   amlat-4973  0-h.2    2탎 : _raw_spin_unlock (try_to_wake_up)
   amlat-4973  0-h.1    3탎 : preempt_schedule (try_to_wake_up)
   amlat-4973  0-h.1    3탎 : wake_up_process (redirect_hardirq)
   amlat-4973  0-h.1    4탎 : _raw_spin_unlock (__do_IRQ)
   amlat-4973  0-h..    4탎 : preempt_schedule (__do_IRQ)
   amlat-4973  0-h..    4탎 : irq_exit (do_IRQ)
   amlat-4973  0-h.1    5탎 : do_softirq (irq_exit)
   amlat-4973  0-h.1    5탎 : __do_softirq (do_softirq)
   amlat-4973  0-h..    6탎 : preempt_schedule_irq (need_resched)
   amlat-4973  0-h..    6탎 : __schedule (preempt_schedule_irq)
   amlat-4973  0-h.1    7탎 : sched_clock (__schedule)
   amlat-4973  0-h.1    8탎 : _raw_spin_lock_irq (__schedule)
   amlat-4973  0-h.1    8탎 : _raw_spin_lock_irqsave (__schedule)
   amlat-4973  0-h.2   10탎 : pull_rt_tasks (__schedule)
   amlat-4973  0-h.2   10탎 : find_next_bit (pull_rt_tasks)
   amlat-4973  0-h.2   11탎+: find_next_bit (pull_rt_tasks)
   amlat-4973  0-..2   13탎 : trace_array (__schedule)
   amlat-4973  0       14탎 : __schedule <IRQ 8-677> (0 1): 
   amlat-4973  0       14탎+: __schedule <amlat-4973> (1 2): 
   amlat-4973  0       18탎+: __schedule <<unknown-792> (39 3a): 
   amlat-4973  0       21탎 : __schedule <<unknown-4> (69 6e): 
   amlat-4973  0       21탎 : __schedule <<unknown-4854> (73 78): 
   amlat-4973  0-..2   22탎+: trace_array (__schedule)
   IRQ 8-677   0-..2   31탎 : __switch_to (__schedule)
   IRQ 8-677   0       32탎 : schedule <amlat-4973> (1 0): 
   IRQ 8-677   0-..2   32탎 : finish_task_switch (__schedule)
   IRQ 8-677   0-..2   33탎 : smp_send_reschedule_allbutself (finish_task_switch)
   IRQ 8-677   0-..2   33탎 : __bitmap_weight (smp_send_reschedule_allbutself)
   IRQ 8-677   0-..2   34탎 : __send_IPI_shortcut (smp_send_reschedule_allbutself)
   IRQ 8-677   0-..2   35탎 : _raw_spin_unlock (finish_task_switch)
   IRQ 8-677   0-..1   35탎 : trace_stop_sched_switched (finish_task_switch)
   IRQ 8-677   0       36탎 : finish_task_switch <IRQ 8-677> (0 0): 
   IRQ 8-677   0-..1   36탎+: _raw_spin_lock_irqsave (trace_stop_sched_switched)
   IRQ 8-677   0-..1   43탎 : trace_stop_sched_switched (finish_task_switch)


vim:ft=help

--------------080807080300050200040204--
