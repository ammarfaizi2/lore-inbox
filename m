Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbUJZBom@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbUJZBom (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUJZBod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:44:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8918 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262028AbUJZBVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:21:40 -0400
Message-ID: <417D8666.8070702@free.fr>
Date: Tue, 26 Oct 2004 01:04:06 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
In-Reply-To: <20041025104023.GA1960@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>i have released the -V0 Real-Time Preemption patch, which can be
>downloaded from:
>
>  http://redhat.com/~mingo/realtime-preempt/
>  
>

I'am facing three different BUG messages :


Oct 26 01:32:46 tigre02 kernel: BUG: sleeping function called from 
invalid context kpnpbiosd(229) at kernel/mutex.c:28
Oct 26 01:32:46 tigre02 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 26 01:32:46 tigre02 kernel:  [<c0121c4a>] __might_sleep+0xca/0xe0 (12)
Oct 26 01:32:46 tigre02 kernel:  [<c013e268>] _mutex_lock+0x38/0x50 (36)
Oct 26 01:32:46 tigre02 kernel:  [<c013e2d6>] 
_mutex_lock_irqsave+0x16/0x20 (24)
Oct 26 01:32:46 tigre02 kernel:  [<c02e5237>] 
pnp_bios_dock_station_info+0x97/0x1f0 (12)
Oct 26 01:32:46 tigre02 kernel:  [<c02e4371>] pnp_dock_thread+0x81/0x100 
(48)
Oct 26 01:32:46 tigre02 kernel:  [<c02e42f0>] pnp_dock_thread+0x0/0x100 (16)
Oct 26 01:32:46 tigre02 kernel:  [<c01033f9>] 
kernel_thread_helper+0x5/0xc (16)
Oct 26 01:32:46 tigre02 kernel: preempt count: 00000002
Oct 26 01:32:46 tigre02 kernel: . 2-level deep critical section nesting:
Oct 26 01:32:46 tigre02 kernel: .. entry 1: 
pnp_bios_dock_station_info+0x4f/0x1f0 [<c02e51ef>] / 
(pnp_dock_thread+0x81/0x100 [<c02e4371>])
Oct 26 01:32:46 tigre02 kernel: .. entry 2: print_traces+0x1d/0x60 
[<c013fa7d>] / (dump_stack+0x23/0x30 [<c01064d3>])
Oct 26 01:32:46 tigre02 kernel:


Oct 26 01:32:45 tigre02 kernel: BUG: using smp_processor_id() in 
preemptible [00000001] code: usb.agent/1479
Oct 26 01:32:45 tigre02 kernel: caller is store_stackinfo+0x5d/0xb0
Oct 26 01:32:45 tigre02 kernel:  [<c011f0d7>] smp_processor_id+0xb7/0xc0 
(12)
Oct 26 01:32:45 tigre02 kernel:  [<c0158fcd>] store_stackinfo+0x5d/0xb0 (8)
Oct 26 01:32:45 tigre02 kernel:  [<c0158fcd>] store_stackinfo+0x5d/0xb0 (24)
Oct 26 01:32:45 tigre02 kernel:  [<c015ac1a>] 
cache_free_debugcheck+0x1aa/0x390 (28)
Oct 26 01:32:45 tigre02 kernel:  [<c018446e>] __user_walk+0x5e/0x80 (12)
Oct 26 01:32:45 tigre02 kernel:  [<c015bba3>] kmem_cache_free+0x33/0xf0 (4)
Oct 26 01:32:45 tigre02 kernel:  [<c0116454>] mcount+0x14/0x18 (8)
Oct 26 01:32:45 tigre02 kernel:  [<c015bbb6>] kmem_cache_free+0x46/0xf0 (28)
Oct 26 01:32:45 tigre02 kernel:  [<c018446e>] __user_walk+0x5e/0x80 (12)
Oct 26 01:32:45 tigre02 kernel:  [<c018446e>] __user_walk+0x5e/0x80 (20)
Oct 26 01:32:45 tigre02 kernel:  [<c017e323>] vfs_stat+0x23/0x60 (32)
Oct 26 01:32:45 tigre02 kernel:  [<c013e8cd>] __mcount+0x1d/0x30 (56)
Oct 26 01:32:45 tigre02 kernel:  [<c017eaae>] sys_stat64+0xe/0x50 (4)
Oct 26 01:32:45 tigre02 kernel:  [<c0105541>] 
sysenter_past_esp+0x52/0x71 (4)
Oct 26 01:32:45 tigre02 kernel:  [<c0116454>] mcount+0x14/0x18 (8)
Oct 26 01:32:45 tigre02 kernel:  [<c017eac0>] sys_stat64+0x20/0x50 (20)
Oct 26 01:32:45 tigre02 kernel:  [<c0291659>] copy_to_user+0x69/0x80 (24)
Oct 26 01:32:45 tigre02 kernel:  [<c01339eb>] 
sys_rt_sigprocmask+0x9b/0xf0 (28)
Oct 26 01:32:45 tigre02 kernel:  [<c0105541>] 
sysenter_past_esp+0x52/0x71 (48)
Oct 26 01:32:45 tigre02 kernel: preempt count: 00000002
Oct 26 01:32:45 tigre02 kernel: . 2-level deep critical section nesting:
Oct 26 01:32:45 tigre02 kernel: .. entry 1: smp_processor_id+0x5f/0xc0 
[<c011f07f>] / (store_stackinfo+0x5d/0xb0 [<c0158fcd>])
Oct 26 01:32:46 tigre02 kernel: .. entry 2: print_traces+0x1d/0x60 
[<c013fa7d>] / (dump_stack+0x23/0x30 [<c01064d3>])
Oct 26 01:32:46 tigre02 kernel:


Oct 26 01:32:46 tigre02 kernel: BUG: using smp_processor_id() in 
preemptible [00000001] code: rc.sysinit/1628
Oct 26 01:32:46 tigre02 kernel: caller is store_stackinfo+0x5d/0xb0
Oct 26 01:32:46 tigre02 kernel:  [<c011f0d7>] smp_processor_id+0xb7/0xc0 
(12)
Oct 26 01:32:46 tigre02 kernel:  [<c0158fcd>] store_stackinfo+0x5d/0xb0 (8)
Oct 26 01:32:46 tigre02 kernel:  [<c0158fcd>] store_stackinfo+0x5d/0xb0 (24)
Oct 26 01:32:46 tigre02 kernel:  [<c015ac1a>] 
cache_free_debugcheck+0x1aa/0x390 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c0121d4c>] free_task+0x1c/0x40 (12)
Oct 26 01:32:46 tigre02 kernel:  [<c015bd2e>] kfree+0x5e/0x120 (4)
Oct 26 01:32:46 tigre02 kernel:  [<c0116454>] mcount+0x14/0x18 (8)
Oct 26 01:32:46 tigre02 kernel:  [<c015bd41>] kfree+0x71/0x120 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c0121d4c>] free_task+0x1c/0x40 (12)
Oct 26 01:32:46 tigre02 kernel:  [<c0121d4c>] free_task+0x1c/0x40 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c0126f9c>] release_task+0xec/0x1a0 (20)
Oct 26 01:32:46 tigre02 kernel:  [<c0129617>] 
wait_task_zombie+0x4b7/0x5d0 (40)
Oct 26 01:32:46 tigre02 kernel:  [<c013e8cd>] __mcount+0x1d/0x30 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c0271ed8>] dummy_task_wait+0x8/0x10 (4)
Oct 26 01:32:46 tigre02 kernel:  [<c0128ed1>] eligible_child+0x71/0xf0 (4)
Oct 26 01:32:46 tigre02 kernel:  [<c0116454>] mcount+0x14/0x18 (8)
Oct 26 01:32:46 tigre02 kernel:  [<c0271ed8>] dummy_task_wait+0x8/0x10 (20)
Oct 26 01:32:46 tigre02 kernel:  [<c012a1ce>] do_wait+0x4ae/0x590 (24)
Oct 26 01:32:46 tigre02 kernel:  [<c0291501>] 
__copy_to_user_ll+0x11/0x80 (40)
Oct 26 01:32:46 tigre02 kernel:  [<c011f1b0>] 
default_wake_function+0x0/0x20 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c011f1b0>] 
default_wake_function+0x0/0x20 (32)
Oct 26 01:32:46 tigre02 kernel:  [<c012a3bc>] sys_waitpid+0x2c/0x30 (12)
Oct 26 01:32:46 tigre02 kernel:  [<c0116454>] mcount+0x14/0x18 (8)
Oct 26 01:32:46 tigre02 kernel:  [<c012a388>] sys_wait4+0x48/0x50 (20)
Oct 26 01:32:46 tigre02 kernel:  [<c012a3bc>] sys_waitpid+0x2c/0x30 (28)
Oct 26 01:32:46 tigre02 kernel:  [<c0105541>] 
sysenter_past_esp+0x52/0x71 (24)
Oct 26 01:32:46 tigre02 kernel: preempt count: 00000002
Oct 26 01:32:46 tigre02 kernel: . 2-level deep critical section nesting:
Oct 26 01:32:47 tigre02 kernel: .. entry 1: smp_processor_id+0x5f/0xc0 
[<c011f07f>] / (store_stackinfo+0x5d/0xb0 [<c0158fcd>])
Oct 26 01:32:47 tigre02 kernel: .. entry 2: print_traces+0x1d/0x60 
[<c013fa7d>] / (dump_stack+0x23/0x30 [<c01064d3>])
Oct 26 01:32:47 tigre02 kernel:

The kernel is stable (X started).

Remi
