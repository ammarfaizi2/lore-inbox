Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbUJYVvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbUJYVvk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 17:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbUJYVsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 17:48:53 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:7945 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S261261AbUJYVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 17:46:50 -0400
Message-ID: <417D7454.5070302@stud.feec.vutbr.cz>
Date: Mon, 25 Oct 2004 23:47:00 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041005)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
References: <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu>
In-Reply-To: <20041025104023.GA1960@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0001]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0 Real-Time Preemption patch, which can be
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/

I'm testing -V0.2. I'm getting reproducible deadlocks very soon after I 
start anything talking to network (firefox, links, licq).
Example with links:

BUG: semaphore recursion deadlock detected!
.. current task links/4724 is already holding c0430840.
  [<c01c7546>] __rwsem_deadlock+0x176/0x190 (12)
  [<c02cb966>] down_write+0x116/0x250 (20)
  [<c01c743c>] __rwsem_deadlock+0x6c/0x190 (28)
  [<c02cb839>] down_read+0x39/0x50 (20)
  [<c02cb8b2>] down_write+0x62/0x250 (4)
  [<c02cb966>] down_write+0x116/0x250 (24)
  [<c02cb839>] down_read+0x39/0x50 (48)
  [<c0114310>] mcount+0x14/0x18 (12)
  [<c0271c91>] dev_queue_xmit_nit+0x41/0x130 (28)
  [<c01c7bf6>] up_write+0x26/0x60 (12)
  [<c0281443>] qdisc_restart+0x223/0x250 (24)
  [<c027221d>] dev_queue_xmit+0x1ad/0x260 (12)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c027222f>] dev_queue_xmit+0x1bf/0x260 (36)
  [<c027856e>] neigh_resolve_output+0xfe/0x240 (32)
  [<c029327e>] ip_finish_output2+0xbe/0x240 (56)
  [<c027dc45>] nf_hook_slow+0xd5/0x130 (36)
  [<c02931c0>] ip_finish_output2+0x0/0x240 (28)
  [<c0290a8b>] ip_finish_output+0x26b/0x270 (32)
  [<c02931c0>] ip_finish_output2+0x0/0x240 (24)
  [<c02931aa>] dst_output+0x1a/0x30 (32)
  [<c027dc45>] nf_hook_slow+0xd5/0x130 (12)
  [<c0293190>] dst_output+0x0/0x30 (28)
  [<c029114a>] ip_queue_xmit+0x45a/0x570 (32)
  [<c0293190>] dst_output+0x0/0x30 (24)
  [<c0135c75>] sub_preempt_count+0x65/0xd0 (24)
  [<c01c79f8>] __up_write+0x148/0x320 (8)
  [<c0135708>] check_preempt_timing+0x58/0x2e0 (8)
  [<c0135c75>] sub_preempt_count+0x65/0xd0 (4)
  [<c01c79f8>] __up_write+0x148/0x320 (4)
  [<c0134f9d>] __mcount+0x1d/0x20 (28)
  [<c01c727e>] rwsem_owner_del+0xe/0x120 (4)
  [<c0134f9d>] __mcount+0x1d/0x20 (52)
  [<c02a875e>] tcp_v4_send_check+0xe/0xf0 (4)
  [<c02a2259>] tcp_transmit_skb+0x439/0x880 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02a879f>] tcp_v4_send_check+0x4f/0xf0 (20)
  [<c02a2302>] tcp_transmit_skb+0x4e2/0x880 (32)
  [<c0114310>] mcount+0x14/0x18 (28)
  [<c02a4f96>] tcp_send_ack+0xa6/0xf0 (52)
  [<c0297ccc>] tcp_recvmsg+0x2ec/0x750 (36)
  [<c0134f9d>] __mcount+0x1d/0x20 (20)
  [<c0114310>] mcount+0x14/0x18 (44)
  [<c026bb59>] sock_common_recvmsg+0x59/0x70 (20)
  [<c0267f78>] sock_aio_read+0xf8/0x110 (48)
  [<c0114310>] mcount+0x14/0x18 (100)
  [<c015e7fa>] do_sync_read+0xaa/0xe0 (20)
  [<c01344a0>] autoremove_wake_function+0x0/0x60 (116)
  [<c01c11b8>] dummy_file_permission+0x8/0x10 (12)
  [<c015e8d6>] vfs_read+0xa6/0x140 (4)
  [<c015e933>] vfs_read+0x103/0x140 (36)
  [<c0114310>] mcount+0x14/0x18 (24)
  [<c015ebe0>] sys_read+0x50/0x80 (20)
  [<c010527b>] syscall_call+0x7/0xb (44)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: down_write+0x249/0x250 [<c02cba99>] / (down_read+0x39/0x50 
[<c02cb839>])
.. entry 2: print_traces+0x1d/0x90 [<c0135fcd>] / (dump_stack+0x23/0x30 
[<c01060b3>])

BUG: circular semaphore deadlock: ksoftirqd/0/2 is blocked on c0430840, 
deadlocking links/4724
f7c2be00 00000046 f7c24020 c03bfd60 00000202 00001db4 f7c2a000 f7c24020
        f7c24020 f7c2bdec 00000227 e443e1ce 0000001d f7c24020 f7c242b4 
f7c2a000
        f7c24020 f7c24020 f7c2be24 c02ca79f f7c2be24 00000086 c03e3b00 
c02cb9d0
Call Trace:
  [<c02ca79f>] schedule+0x2f/0xe0 (80)
  [<c02cb9d0>] down_write+0x180/0x250 (16)
  [<c02cb9b1>] down_write+0x161/0x250 (20)
  [<c02cb839>] down_read+0x39/0x50 (48)
  [<c0114310>] mcount+0x14/0x18 (12)
  [<c027db97>] nf_hook_slow+0x27/0x130 (28)
  [<c0134f9d>] __mcount+0x1d/0x20 (24)
  [<c028d4ee>] ip_rcv+0xe/0x540 (4)
  [<c027274d>] netif_receive_skb+0x12d/0x240 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c028d940>] ip_rcv+0x460/0x540 (20)
  [<c028dbc0>] ip_rcv_finish+0x0/0x300 (24)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c027274d>] netif_receive_skb+0x12d/0x240 (28)
  [<c0270008>] gnet_stats_start_copy+0x18/0x40 (20)
  [<c0272a7f>] net_rx_action+0x7f/0x1a0 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02728e8>] process_backlog+0x88/0x1a0 (20)
  [<c0272a7f>] net_rx_action+0x7f/0x1a0 (40)
  [<c01237c7>] ___do_softirq+0x87/0xd0 (36)
  [<c0123898>] _do_softirq+0x8/0x30 (8)
  [<c0123c84>] ksoftirqd+0xb4/0x100 (4)
  [<c01238b0>] _do_softirq+0x20/0x30 (28)
  [<c0123c84>] ksoftirqd+0xb4/0x100 (8)
  [<c0133eea>] kthread+0xaa/0xb0 (24)
  [<c0123bd0>] ksoftirqd+0x0/0x100 (20)
  [<c0133e40>] kthread+0x0/0xb0 (12)
  [<c0103319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __schedule+0x4e/0x5f0 [<c02ca1ce>] / (schedule+0x2f/0xe0 
[<c02ca79f>])
.. entry 2: __schedule+0xdd/0x5f0 [<c02ca25d>] / (schedule+0x2f/0xe0 
[<c02ca79f>])


Michal
