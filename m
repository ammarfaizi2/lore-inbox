Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbUKJOEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbUKJOEj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbUKJOCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:02:48 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:64944 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261933AbUKJNvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 08:51:10 -0500
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm3-V0.7.23
Date: Wed, 10 Nov 2004 14:52:35 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Gunther Persoons <gunther_persoons@spymac.com>, emann@mrv.com,
       Shane Shrybman <shrybman@aei.ca>, Amit Shah <amit.shah@codito.com>
References: <20041021132717.GA29153@elte.hu> <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu>
In-Reply-To: <20041109160544.GA28242@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411101452.36007.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag 09 November 2004 17:05 schrieb Ingo Molnar:
> 
> i have released the -V0.7.23 Real-Time Preemption patch, which can be
> downloaded from the usual place:
> 
>     http://redhat.com/~mingo/realtime-preempt/

Hi

On SMP/HT/P4 I get:
 BUG: lock held at task exit time!

This was captured via netconsole:
<NETCONSOLELOG>
apm: disabled - APM is not SMP safe.
sh:5429 BUG: lock held at task exit time!
 [c03af1c4] {kernel_sem.lock}
.. held by:                sh/ 5429 [f4d2c420, 117]
... acquired at:  __reacquire_kernel_lock+0x2e/0x60
sh/5429: BUG in __up_mutex at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1064
BUG: sleeping function called from invalid context sh(5429) at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1314
in_atomic():1 [00000003], irqs_disabled():0
 [<c010704e>] dump_stack+0x23/0x25 (20)
 [<c011d10b>] __might_sleep+0xbc/0xcf (36)
 [<c013a136>] __spin_lock+0x34/0x50 (24)
 [<c013a16f>] _spin_lock+0x1d/0x1f (16)
 [<c014e36b>] kmem_cache_alloc+0x37/0xf1 (32)
 [<c02c95d4>] alloc_skb+0x28/0xe6 (32)
 [<c02da818>] find_skb+0x31/0x9b (24)
 [<c02da97a>] netpoll_send_udp+0x40/0x25a (48)
 [<c028f246>] write_msg+0x56/0xfa (52)
 [<c0120e06>] __call_console_drivers+0x56/0x65 (32)
 [<c0120f49>] call_console_drivers+0xac/0x163 (36)
 [<c0121326>] release_console_sem+0x33/0xde (32)
 [<c012122c>] vprintk+0x134/0x16d (36)
 [<c01210f6>] printk+0x1d/0x1f (16)
 [<c01390ee>] __up_mutex+0x270/0x443 (68)
 [<c0139fc2>] up+0xe0/0xec (36)
 [<c0342e95>] __schedule+0x985/0xdb4 (124)
 [<c0123afc>] do_exit+0x331/0x59f (48)
 [<c0123e81>] do_group_exit+0x39/0xd1 (40)
 [<c01061a1>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c0142848>] ..   ( <= __do_IRQ+0xf6/0x16e)
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c010b340>] ..   ( <= timer_interrupt+0xd3/0x10f)
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c013b1c9>] ..   ( <= trace_start_sched_wakeup+0x22/0x7e)
.. [<c013b764>] .... print_traces+0x1b/0x52
.....[<c010704e>] ..   ( <= dump_stack+0x23/0x25)

 [<c010704e>] dump_stack+0x23/0x25 (20)
 [<c01390f3>] __up_mutex+0x275/0x443 (68)
 [<c0139fc2>] up+0xe0/0xec (36)
 [<c0342e95>] __schedule+0x985/0xdb4 (124)
 [<c0123afc>] do_exit+0x331/0x59f (48)
 [<c0123e81>] do_group_exit+0x39/0xd1 (40)
 [<c01061a1>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000004 ]
| 4-level deep critical section nesting:
----------------------------------------
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c0142848>] ..   ( <= __do_IRQ+0xf6/0x16e)
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c010b340>] ..   ( <= timer_interrupt+0xd3/0x10f)
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c013b1c9>] ..   ( <= trace_start_sched_wakeup+0x22/0x7e)
.. [<c013b764>] .... print_traces+0x1b/0x52
.....[<c010704e>] ..   ( <= dump_stack+0x23/0x25)

autom4te/5419: BUG in lock_new_owner at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:651
 [<c010704e>] dump_stack+0x23/0x25 (20)
BUG: scheduling while atomic: autom4te/0x00000001/5419
caller is schedule+0x38/0x12e
 [<c010704e>] dump_stack+0x23/0x25 (20)
 [<c0342f06>] __schedule+0x9f6/0xdb4 (124)
 [<c03432fc>] schedule+0x38/0x12e (36)
 [<c0344758>] __down_mutex+0x225/0x30f (84)
 [<c013a148>] __spin_lock+0x46/0x50 (24)
 [<c013a1cc>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c028b31e>] e100_xmit_frame+0x13f/0x2d8 (60)
 [<c02da8a5>] netpoll_send_skb+0x23/0xb8 (28)
 [<c028f246>] write_msg+0x56/0xfa (52)
 [<c0120e06>] __call_console_drivers+0x56/0x65 (32)
 [<c0120f49>] call_console_drivers+0xac/0x163 (36)
 [<c0121326>] release_console_sem+0x33/0xde (32)
 [<c012122c>] vprintk+0x134/0x16d (36)
 [<c01210f6>] printk+0x1d/0x1f (16)
 [<c0106f4c>] show_trace+0x89/0xcd (36)
 [<c010704e>] dump_stack+0x23/0x25 (20)
 [<c0138be0>] lock_new_owner+0xbe/0xe2 (40)
 [<c034462e>] __down_mutex+0xfb/0x30f (84)
 [<c013a148>] __spin_lock+0x46/0x50 (24)
 [<c013a1cc>] _spin_lock_irqsave+0x1d/0x21 (16)
 [<c012a6d8>] del_timer+0x2c/0xe4 (32)
 [<c012a7e1>] del_timer_sync+0x51/0x14b (104)
 [<c0330469>] __rpc_execute+0x8d/0x3db (112)
 [<c032bd4e>] rpc_call_sync+0x9b/0xc8 (40)
 [<c01b7b4d>] nfs3_rpc_wrapper+0x3d/0x82 (40)
 [<c01b7d31>] nfs3_proc_getattr+0x50/0x81 (40)
 [<c01aeeec>] __nfs_revalidate_inode+0xf3/0x3b7 (192)
 [<c01aac1c>] nfs_lookup_revalidate+0x37e/0x54c (352)
 [<c0173220>] do_lookup+0x53/0x8d (32)
 [<c01733da>] link_path_walk+0x180/0x1071 (108)
 [<c01745f2>] path_lookup+0xa5/0x1b0 (32)
 [<c017489f>] __user_walk+0x30/0x4d (32)
 [<c016ed2b>] vfs_stat+0x1f/0x5a (92)
 [<c016f3c4>] sys_stat64+0x1e/0x3d (100)
 [<c01061a1>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0344e5b>] .... _raw_spin_lock+0x1c/0x73
.....[<c0118894>] ..   ( <= task_rq_lock+0x32/0x5b)
.. [<c013b764>] .... print_traces+0x1b/0x52
.....[<c010704e>] ..   ( <= dump_stack+0x23/0x25)
</NETCONSOLELOG>

The "lock_new_owner" BUGs then repeated until the machine was restarted.

With HIGHMEM enabled, there were really weired things happening.
<HIGHMEMENABLEDLOG>
BUG at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/mm/highmem.c:191!
------------[ cut here ]------------
BUG: sleeping function called from invalid context init(1) at /home/ka/kernel/2.6/linux-2.6.9-rc1-mm3-RT/kernel/rt.c:1314
in_atomic():1 [00000001], irqs_disabled():0
 [<c010704e>] dump_stack+0x23/0x25 (20)
 [<c011d3db>] __might_sleep+0xbc/0xcf (36)
 [<c013a3e6>] __spin_lock+0x34/0x50 (24)
 [<c013a41f>] _spin_lock+0x1d/0x1f (16)
 [<c014e632>] kmem_cache_alloc+0x37/0xf1 (32)
 [<c02ca4f4>] alloc_skb+0x28/0xe6 (32)
 [<c02db938>] find_skb+0x31/0x9b (24)
 [<c02dba9a>] netpoll_send_udp+0x40/0x25a (48)
 [<c02900c6>] write_msg+0x56/0xfa (52)
 [<c01210d6>] __call_console_drivers+0x56/0x65 (32)
 [<c0121219>] call_console_drivers+0xac/0x163 (36)
 [<c01215f6>] release_console_sem+0x33/0xde (32)
 [<c01214fc>] vprintk+0x134/0x16d (36)
 [<c01213c6>] printk+0x1d/0x1f (16)
 [<c0107299>] handle_BUG+0x63/0x9e (28)
 [<c0107356>] die+0x82/0x195 (64)
 [<c01079ac>] do_invalid_op+0x127/0x129 (192)
 [<c0106c73>] error_code+0x2b/0x30 (76)
 [<c01541dc>] copy_pte_range+0xd8/0x1e3 (48)
 [<c015439b>] copy_pmd_range+0xb4/0xca (52)
 [<c015441e>] copy_pgd_range+0x6d/0x8c (48)
 [<c0154483>] copy_page_range+0x46/0x4e (48)
 [<c011e76c>] copy_mm+0x28a/0x3ac (76)
 [<c011f352>] copy_process+0x54a/0xf1b (76)
 [<c011fe2c>] do_fork+0x6e/0x1ce (132)
 [<c0104d08>] sys_fork+0x3d/0x3f (32)
 [<c01061a1>] sysenter_past_esp+0x52/0x71 (-4028)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0345fad>] .... _raw_spin_lock_irqsave+0x1b/0x70
.....[<c0107318>] ..   ( <= die+0x44/0x195)
.. [<c013ba14>] .... print_traces+0x1b/0x52
.....[<c010704e>] ..   ( <= dump_stack+0x23/0x25)

</HIGHMEMENABLEDLOG>

looks like some machinecode was undigestible for the cpu, no?

Best regards,
Karsten
