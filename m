Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbUJ0Rhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbUJ0Rhk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUJ0Rgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 13:36:42 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:32271 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262573AbUJ0Raa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 13:30:30 -0400
Message-ID: <417FD9F2.8060002@stud.feec.vutbr.cz>
Date: Wed, 27 Oct 2004 19:25:06 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.3
References: <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu>
In-Reply-To: <20041027134822.GA7980@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:
> 
>>OK, re-reporting a network deadlock. It happens a few seconds after 
>>starting Firefox. This is with -V0.3.2:
> 
> i've uploaded -V0.4.1 with a fix that could fix this networking
> deadlock. Does it work any better?
> 
> 	Ingo

Unfortunately, no. It's only slightly different:

BUG: semaphore recursion deadlock detected!
.. current task ksoftirqd/0/2 [f7c24020] is already holding c0438ec0 
[w:f7c24020, d:0].
  [<c01c7a08>] __rwsem_deadlock+0x188/0x1a0 (12)
  [<c01c78ec>] __rwsem_deadlock+0x6c/0x1a0 (52)
  [<c0134ac0>] _mutex_lock+0x40/0x50 (28)
  [<c02cc153>] down_write_mutex+0x113/0x220 (24)
  [<c01c8228>] down_mutex+0x8/0x10 (12)
  [<c0134ac0>] _mutex_lock+0x40/0x50 (40)
  [<c0281a16>] qdisc_restart+0x236/0x250 (24)
  [<c0281d2e>] pfifo_fast_enqueue+0xe/0xc0 (8)
  [<c02727dd>] dev_queue_xmit+0x1ad/0x260 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02727ef>] dev_queue_xmit+0x1bf/0x260 (36)
  [<c0278b2e>] neigh_resolve_output+0xfe/0x240 (32)
  [<c029383e>] ip_finish_output2+0xbe/0x240 (56)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (12)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (24)
  [<c0293780>] ip_finish_output2+0x0/0x240 (28)
  [<c029104b>] ip_finish_output+0x26b/0x270 (32)
  [<c0293780>] ip_finish_output2+0x0/0x240 (24)
  [<c029376a>] dst_output+0x1a/0x30 (32)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (12)
  [<c0293750>] dst_output+0x0/0x30 (28)
  [<c029170a>] ip_queue_xmit+0x45a/0x570 (32)
  [<c0293750>] dst_output+0x0/0x30 (24)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (24)
  [<c01c7f1e>] __up_write+0x10e/0x220 (12)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c0135958>] check_preempt_timing+0x58/0x2f0 (8)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c01c7f1e>] __up_write+0x10e/0x220 (4)
  [<c013514d>] __mcount+0x1d/0x20 (32)
  [<c01c775e>] rwsem_owner_del+0xe/0xf0 (4)
  [<c013514d>] __mcount+0x1d/0x20 (40)
  [<c02a8d1e>] tcp_v4_send_check+0xe/0xf0 (4)
  [<c02a2819>] tcp_transmit_skb+0x439/0x880 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02a8d5f>] tcp_v4_send_check+0x4f/0xf0 (20)
  [<c02a28c2>] tcp_transmit_skb+0x4e2/0x880 (32)
  [<c0114310>] mcount+0x14/0x18 (28)
  [<c02a5556>] tcp_send_ack+0xa6/0xf0 (52)
  [<c02a0527>] __tcp_ack_snd_check+0x87/0xa0 (12)
  [<c02a0f65>] tcp_rcv_established+0x6e5/0x920 (24)
  [<c02aa20e>] tcp_v4_do_rcv+0x13e/0x150 (56)
  [<c02aa8e0>] tcp_v4_rcv+0x6c0/0x8d0 (32)
  [<c02cc11f>] down_write_mutex+0xdf/0x220 (28)
  [<c028e09d>] ip_local_deliver_finish+0xbd/0x1a0 (52)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (12)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (24)
  [<c028dfe0>] ip_local_deliver_finish+0x0/0x1a0 (28)
  [<c028da76>] ip_local_deliver+0x1f6/0x220 (32)
  [<c028dfe0>] ip_local_deliver_finish+0x0/0x1a0 (24)
  [<c028e2c9>] ip_rcv_finish+0x149/0x300 (24)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (36)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (24)
  [<c028e180>] ip_rcv_finish+0x0/0x300 (28)
  [<c028df00>] ip_rcv+0x460/0x540 (32)
  [<c028e180>] ip_rcv_finish+0x0/0x300 (24)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c0272d0d>] netif_receive_skb+0x12d/0x240 (28)
  [<c0270008>] __scm_send+0x78/0x1e0 (20)
  [<c027303f>] net_rx_action+0x7f/0x1a0 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c0272ea8>] process_backlog+0x88/0x1a0 (20)
  [<c027303f>] net_rx_action+0x7f/0x1a0 (40)
  [<c0123887>] ___do_softirq+0x87/0xd0 (36)
  [<c0123958>] _do_softirq+0x8/0x30 (8)
  [<c0123d44>] ksoftirqd+0xb4/0x100 (4)
  [<c0123970>] _do_softirq+0x20/0x30 (28)
  [<c0123d44>] ksoftirqd+0xb4/0x100 (8)
  [<c013406a>] kthread+0xaa/0xb0 (24)
  [<c0123c90>] ksoftirqd+0x0/0x100 (20)
  [<c0133fc0>] kthread+0x0/0xb0 (12)
  [<c0103319>] kernel_thread_helper+0x5/0xc (16)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: down_write_mutex+0x214/0x220 [<c02cc254>] / 
(_mutex_lock+0x40/0x50 [<c0134ac0>])
.. entry 2: print_traces+0x1d/0x60 [<c013663d>] / (dump_stack+0x23/0x30 
[<c01060b3>])

BUG: circular semaphore deadlock: firefox-bin/4792 is blocked on 
c0438ec0, deadlocking ksoftirqd/0/2
f18119bc 00200086 f1fbe810 c03c1ca0 f1810000 0000196c f1810000 f1fbe810
        00000000 f18119a8 00000167 4344b736 00000023 f1fbe810 f1fbeaa4 
f1810000
        f1fbe810 00000000 f18119e0 c02cae1f 00000054 00000008 f18119e0 
00200046
Call Trace:
  [<c02cae1f>] schedule+0x2f/0xe0 (80)
  [<c02cc1a0>] down_write_mutex+0x160/0x220 (36)
  [<c02cc268>] down_read_mutex+0x8/0x30 (12)
  [<c0272251>] dev_queue_xmit_nit+0x41/0x130 (40)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (12)
  [<c0281a03>] qdisc_restart+0x223/0x250 (24)
  [<c02727dd>] dev_queue_xmit+0x1ad/0x260 (12)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02727ef>] dev_queue_xmit+0x1bf/0x260 (36)
  [<c0278b2e>] neigh_resolve_output+0xfe/0x240 (32)
  [<c029383e>] ip_finish_output2+0xbe/0x240 (56)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (12)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (24)
  [<c0293780>] ip_finish_output2+0x0/0x240 (28)
  [<c029104b>] ip_finish_output+0x26b/0x270 (32)
  [<c0293780>] ip_finish_output2+0x0/0x240 (24)
  [<c029376a>] dst_output+0x1a/0x30 (32)
  [<c027e211>] nf_hook_slow+0xe1/0x130 (12)
  [<c0293750>] dst_output+0x0/0x30 (28)
  [<c029170a>] ip_queue_xmit+0x45a/0x570 (32)
  [<c0293750>] dst_output+0x0/0x30 (24)
  [<c02cc11f>] down_write_mutex+0xdf/0x220 (24)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c01c7f1e>] __up_write+0x10e/0x220 (12)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c0135958>] check_preempt_timing+0x58/0x2f0 (8)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c01c7f1e>] __up_write+0x10e/0x220 (4)
  [<c013514d>] __mcount+0x1d/0x20 (32)
  [<c01c775e>] rwsem_owner_del+0xe/0xf0 (4)
  [<c013514d>] __mcount+0x1d/0x20 (36)
  [<c02a8d1e>] tcp_v4_send_check+0xe/0xf0 (4)
  [<c02a2819>] tcp_transmit_skb+0x439/0x880 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c02a8d5f>] tcp_v4_send_check+0x4f/0xf0 (20)
  [<c02a28c2>] tcp_transmit_skb+0x4e2/0x880 (32)
  [<c01c9f52>] memcpy+0x12/0x40 (36)
  [<c02a37f4>] tcp_write_xmit+0x154/0x2d0 (44)
  [<c0296eea>] tcp_sendmsg+0x50a/0x1130 (12)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c0296ebe>] tcp_sendmsg+0x4de/0x1130 (32)
  [<c0268254>] sock_sendmsg+0xc4/0xe0 (84)
  [<c02b9af0>] inet_sendmsg+0x50/0x60 (28)
  [<c0268254>] sock_sendmsg+0xc4/0xe0 (28)
  [<c0135958>] check_preempt_timing+0x58/0x2f0 (24)
  [<c0135ef0>] sub_preempt_count+0x60/0xd0 (4)
  [<c013514d>] __mcount+0x1d/0x20 (36)
  [<c01c775e>] rwsem_owner_del+0xe/0xf0 (4)
  [<c015ff59>] fget+0x59/0x70 (72)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (28)
  [<c0134620>] autoremove_wake_function+0x0/0x60 (24)
  [<c0267f8f>] sockfd_lookup+0x1f/0x80 (28)
  [<c0114310>] mcount+0x14/0x18 (4)
  [<c026990d>] sys_sendto+0xed/0x110 (20)
  [<c01c80be>] up_write_mutex+0x2e/0x60 (72)
  [<c0142cf2>] free_pages_bulk+0x1d2/0x2e0 (24)
  [<c013514d>] __mcount+0x1d/0x20 (72)
  [<c026993b>] sys_send+0xb/0x40 (4)
  [<c026a1c3>] sys_socketcall+0x133/0x240 (4)
  [<c0114310>] mcount+0x14/0x18 (8)
  [<c026996b>] sys_send+0x3b/0x40 (20)
  [<c026a1c3>] sys_socketcall+0x133/0x240 (32)
  [<c010527b>] syscall_call+0x7/0xb (68)
preempt count: 00000002
. 2-level deep critical section nesting:
.. entry 1: __schedule+0x4e/0x6b0 [<c02ca78e>] / (schedule+0x2f/0xe0 
[<c02cae1f>])
.. entry 2: __schedule+0xdd/0x6b0 [<c02ca81d>] / (schedule+0x2f/0xe0 
[<c02cae1f>])


Michal
