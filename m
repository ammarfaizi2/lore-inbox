Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUJVWlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUJVWlO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268239AbUJVWke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:40:34 -0400
Received: from relay02.pair.com ([209.68.5.16]:46340 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S268265AbUJVWiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:38:16 -0400
X-pair-Authenticated: 66.190.53.4
Message-ID: <41798BD6.6060207@cybsft.com>
Date: Fri, 22 Oct 2004 17:38:14 -0500
From: "K.R. Foley" <kr@cybsft.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
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
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
References: <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu>
In-Reply-To: <20041022175633.GA1864@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030401030806050206050001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030401030806050206050001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i have released the -U10.2 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
>  
> this is a fixes-only release.
> 

I got quite a few BUG traces this afternoon running this one on my 
workstation. I am just attaching the relevant chunk of the log because 
there are 7 or 8 of them.

kr

--------------030401030806050206050001
Content-Type: text/plain;
 name="dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dump.txt"

Oct 22 14:11:29 swdev14 kernel: NET: Registered protocol family 4
Oct 22 14:13:11 swdev14 ntpd[2865]: synchronized to 151.131.44.70, stratum=4
Oct 22 14:13:11 swdev14 ntpd[2865]: kernel time sync disabled 0041
Oct 22 14:26:00 swdev14 ntpd[2865]: kernel time sync enabled 0001
Oct 22 14:37:14 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 14:37:14 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 14:37:14 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 14:37:14 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 14:37:14 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 14:37:14 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 14:37:14 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 14:37:14 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 14:37:14 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 14:37:14 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 14:37:14 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 14:37:14 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 14:37:14 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 14:37:14 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 14:37:14 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 14:37:14 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 14:37:14 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 14:37:14 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 14:37:14 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 14:37:14 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 14:37:14 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 14:37:14 swdev14 kernel: preempt count: 00000002
Oct 22 14:37:14 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 14:37:14 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 14:37:14 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 14:37:14 swdev14 kernel: 
Oct 22 14:37:16 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 14:37:16 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 14:37:16 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 14:37:16 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 14:37:16 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 14:37:16 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 14:37:16 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 14:37:16 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 14:37:16 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 14:37:16 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 14:37:16 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 14:37:16 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 14:37:16 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 14:37:16 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 14:37:16 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 14:37:16 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 14:37:16 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 14:37:16 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 14:37:16 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 14:37:16 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 14:37:16 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 14:37:16 swdev14 kernel: preempt count: 00000002
Oct 22 14:37:16 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 14:37:16 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 14:37:16 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 14:37:16 swdev14 kernel: 
Oct 22 14:37:17 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 14:37:17 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 14:37:17 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 14:37:17 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 14:37:17 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 14:37:17 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 14:37:17 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 14:37:17 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 14:37:17 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 14:37:17 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 14:37:17 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 14:37:17 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 14:37:17 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 14:37:17 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 14:37:17 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 14:37:17 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 14:37:17 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 14:37:17 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 14:37:17 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 14:37:17 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 14:37:17 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 14:37:17 swdev14 kernel: preempt count: 00000002
Oct 22 14:37:17 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 14:37:17 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 14:37:17 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 14:37:17 swdev14 kernel: 
Oct 22 14:37:17 swdev14 kernel: BUG: scheduling while atomic: ksoftirqd/0/0x10000001/3
Oct 22 14:37:17 swdev14 kernel: caller is cond_resched+0x64/0x78
Oct 22 14:37:17 swdev14 kernel:  [<c029dd88>] __sched_text_start+0xbdc/0xc2c (12)
Oct 22 14:37:17 swdev14 kernel:  [<c029e6da>] cond_resched+0x64/0x78 (8)
Oct 22 14:37:17 swdev14 kernel:  [<c01338ce>] check_preempt_timing+0x5d/0x289 (12)
Oct 22 14:37:17 swdev14 kernel:  [<c0133b40>] touch_preempt_timing+0x46/0x4a (4)
Oct 22 14:37:17 swdev14 kernel:  [<c029e69c>] cond_resched+0x26/0x78 (4)
Oct 22 14:37:17 swdev14 kernel:  [<c029deab>] preempt_schedule+0x11/0x6f (4)
Oct 22 14:37:17 swdev14 kernel:  [<c01070c3>] dump_stack+0x23/0x27 (4)
Oct 22 14:37:17 swdev14 kernel:  [<c0112038>] mcount+0x14/0x18 (8)
Oct 22 14:37:17 swdev14 kernel:  [<c0132aed>] _mutex_lock+0x43/0x63 (60)
Oct 22 14:37:17 swdev14 kernel:  [<c029e6da>] cond_resched+0x64/0x78 (20)
Oct 22 14:37:17 swdev14 kernel:  [<c0132aed>] _mutex_lock+0x43/0x63 (16)
Oct 22 14:37:17 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 14:37:17 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 14:37:17 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 14:37:17 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 14:37:17 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 14:37:17 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 14:37:17 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 14:37:17 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 14:37:17 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 14:37:17 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 14:37:17 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 14:37:18 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 14:37:18 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 14:37:18 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 14:37:18 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 14:37:18 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 14:37:18 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 14:37:18 swdev14 kernel: preempt count: 10000002
Oct 22 14:37:18 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 14:37:18 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 14:37:18 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 14:37:18 swdev14 kernel: 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_0 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_1 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_0 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_1 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_0 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_1 
Oct 22 15:22:47 swdev14 modprobe: FATAL: Error running install command for sound_slot_0 
Oct 22 15:22:47 swdev14 last message repeated 2 times
Oct 22 15:25:07 swdev14 su(pam_unix)[15830]: session opened for user root by aaektkf(uid=19990)
Oct 22 15:30:34 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 15:30:34 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 15:30:34 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 15:30:34 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 15:30:34 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 15:30:34 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 15:30:34 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 15:30:34 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 15:30:34 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 15:30:34 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 15:30:34 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 15:30:34 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 15:30:34 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 15:30:34 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 15:30:34 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 15:30:34 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 15:30:34 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 15:30:34 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 15:30:34 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 15:30:34 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 15:30:34 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 15:30:34 swdev14 kernel: preempt count: 00000002
Oct 22 15:30:34 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 15:30:34 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 15:30:34 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 15:30:34 swdev14 kernel: 
Oct 22 15:30:35 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 15:30:35 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 15:30:35 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 15:30:35 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 15:30:35 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 15:30:35 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 15:30:35 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 15:30:35 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 15:30:35 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 15:30:35 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 15:30:35 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 15:30:35 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 15:30:35 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 15:30:35 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 15:30:35 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 15:30:35 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 15:30:35 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 15:30:35 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 15:30:35 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 15:30:35 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 15:30:35 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 15:30:35 swdev14 kernel: preempt count: 00000002
Oct 22 15:30:35 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 15:30:35 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 15:30:35 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 15:30:35 swdev14 kernel: 
Oct 22 15:30:37 swdev14 kernel: BUG: sleeping function called from invalid context ksoftirqd/0(3) at kernel/mutex.c:37
Oct 22 15:30:37 swdev14 kernel: in_atomic():1 [00000001], irqs_disabled():0
Oct 22 15:30:37 swdev14 kernel:  [<c011ac3d>] __might_sleep+0xc4/0xd6 (12)
Oct 22 15:30:37 swdev14 kernel:  [<c0132ae8>] _mutex_lock+0x3e/0x63 (36)
Oct 22 15:30:37 swdev14 kernel:  [<e0a8b297>] ipxitf_find_using_phys+0x1e/0x4c [ipx] (28)
Oct 22 15:30:37 swdev14 kernel:  [<e0a8d5a6>] ipx_rcv+0xdc/0x1dd [ipx] (20)
Oct 22 15:30:37 swdev14 kernel:  [<c024050b>] snap_rcv+0x5f/0xe0 (32)
Oct 22 15:30:37 swdev14 kernel:  [<c023fadc>] llc_rcv+0x19b/0x2a3 (24)
Oct 22 15:30:37 swdev14 kernel:  [<c02325df>] netif_receive_skb+0x201/0x30c (32)
Oct 22 15:30:37 swdev14 kernel:  [<c0130400>] remove_from_abslist+0x6/0x64 (20)
Oct 22 15:30:37 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (8)
Oct 22 15:30:37 swdev14 kernel:  [<c0232780>] process_backlog+0x96/0x164 (28)
Oct 22 15:30:37 swdev14 kernel:  [<c02328ef>] net_rx_action+0xa1/0x178 (40)
Oct 22 15:30:37 swdev14 kernel:  [<c012299c>] ___do_softirq+0xb8/0x107 (40)
Oct 22 15:30:37 swdev14 kernel:  [<c013317c>] __mcount+0x1d/0x21 (12)
Oct 22 15:30:37 swdev14 kernel:  [<c0122a9b>] _do_softirq+0x20/0x22 (36)
Oct 22 15:30:37 swdev14 kernel:  [<c0122f85>] ksoftirqd+0xcd/0x105 (8)
Oct 22 15:30:37 swdev14 kernel:  [<c0132227>] kthread+0xbc/0xc1 (32)
Oct 22 15:30:37 swdev14 kernel:  [<c0122eb8>] ksoftirqd+0x0/0x105 (20)
Oct 22 15:30:37 swdev14 kernel:  [<c013216b>] kthread+0x0/0xc1 (12)
Oct 22 15:30:37 swdev14 kernel:  [<c01043b1>] kernel_thread_helper+0x5/0xb (16)
Oct 22 15:30:37 swdev14 kernel: preempt count: 00000002
Oct 22 15:30:37 swdev14 kernel: . 2-level deep critical section nesting:
Oct 22 15:30:37 swdev14 kernel: .. entry 1: snap_rcv+0x1b/0xe0 [<c023fadc>] / (llc_rcv+0x19b/0x2a3 [<c023fadc>])
Oct 22 15:30:37 swdev14 kernel: .. entry 2: print_traces+0x1d/0x59 [<c01070c3>] / (dump_stack+0x23/0x27 [<c01070c3>])
Oct 22 15:30:37 swdev14 kernel: 

--------------030401030806050206050001--
