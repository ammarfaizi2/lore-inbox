Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJVSqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJVSqe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJVSnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 14:43:18 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:9880 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S266864AbUJVSlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 14:41:47 -0400
Message-ID: <41795467.7070003@ru.mvista.com>
Date: Fri, 22 Oct 2004 22:41:43 +0400
From: Alexander Batyrshin <abatyrshin@ru.mvista.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>,
       "Ext-Rt-Dev@Mvista. Com" <ext-rt-dev@mvista.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U9.3
References: <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu> <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu> <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu>
In-Reply-To: <20041022133551.GA6954@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi Ingo,
U9.3 (defconfig) died with trace:

------------[ cut here ]------------
kernel BUG at kernel/sched.c:784!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c011873d>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-RT-U9.3)
EIP is at resched_task+0x80/0x8a
eax: 00000001   ebx: c1674000   ecx: dfb578f0   edx: 00000000
esi: c16712c0   edi: 00000000   ebp: c167bc48   esp: c167bc3c
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process ksoftirqd/0 (pid: 3, threadinfo=c167a000 task=c1670660)
Stack: c1403820 c1403820 00000000 c167bc94 c0118b78 c16712c0 c1433820 
00000000
        00000000 00000000 00000001 00000100 c1433820 c1433820 00000001 
00000000
        00000000 00000001 00000082 00000001 de9d3e60 00000001 c167bcd8 
c0133c7b
Call Trace:
  [<c0118b78>] try_to_wake_up+0x1f3/0x26b (20)
  [<c0133c7b>] autoremove_wake_function+0x2f/0x57 (76)
  [<c011a766>] __wake_up_common+0x3f/0x5e (28)
  [<c011a7d0>] __wake_up+0x4b/0x62 (40)
  [<c034e08c>] sock_def_readable+0x8e/0x90 (52)
  [<c0388dbe>] tcp_child_process+0xe6/0xec (28)
  [<c0384df7>] tcp_v4_do_rcv+0x123/0x162 (36)
  [<c0134079>] _mutex_lock+0x2c/0x3b (16)
  [<c0385513>] tcp_v4_rcv+0x6dd/0x92c (16)
  [<c03c0e30>] svc_revisit+0x27/0x154 (48)
  [<c0368553>] ip_local_deliver_finish+0x0/0x1b2 (40)
  [<c0368609>] ip_local_deliver_finish+0xb6/0x1b2 (4)
  [<c0368553>] ip_local_deliver_finish+0x0/0x1b2 (12)
  [<c035f607>] nf_hook_slow+0xdc/0x12e (20)
  [<c0368553>] ip_local_deliver_finish+0x0/0x1b2 (28)
  [<c0368705>] ip_rcv_finish+0x0/0x2b3 (28)
  [<c0367fcb>] ip_local_deliver+0x208/0x226 (4)
  [<c0368553>] ip_local_deliver_finish+0x0/0x1b2 (24)
  [<c0368828>] ip_rcv_finish+0x123/0x2b3 (20)
  [<c0368705>] ip_rcv_finish+0x0/0x2b3 (32)
  [<c035f607>] nf_hook_slow+0xdc/0x12e (20)
  [<c0368705>] ip_rcv_finish+0x0/0x2b3 (28)
  [<c036846a>] ip_rcv+0x481/0x56a (32)
  [<c0368705>] ip_rcv_finish+0x0/0x2b3 (24)
  [<c0354e68>] netif_receive_skb+0x117/0x1dd (28)
  [<c0354ff7>] process_backlog+0xc9/0x1cb (36)
  [<c03551b2>] net_rx_action+0xb9/0x1ed (48)
  [<c01242d9>] ___do_softirq+0xe1/0x130 (36)
  [<c0124923>] ksoftirqd+0x0/0xda (40)
  [<c01243fb>] _do_softirq+0x4b/0x4d (4)
  [<c01249c5>] ksoftirqd+0xa2/0xda (16)
  [<c013376d>] kthread+0xb7/0xbd (24)
  [<c01336b6>] kthread+0x0/0xbd (28)
  [<c0103375>] kernel_thread_helper+0x5/0xb (16)
preempt count: 00000004
. 4-level deep critical section nesting:
.. entry 1: _spin_lock_irqsave+0x1d/0xa5 [<00000000>] / (0x0 [<00000000>])
.. entry 2: _spin_lock+0x19/0x6d [<00000000>] / (0x0 [<00000000>])
.. entry 3: _spin_lock_irqsave+0x1d/0xa5 [<00000000>] / (0x0 [<00000000>])
.. entry 4: print_traces+0x17/0x4e [<00000000>] / (0x0 [<00000000>])

