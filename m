Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268164AbUJSLhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268164AbUJSLhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 07:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268136AbUJSLhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 07:37:38 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.9.16]:57099 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S269395AbUJSKe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 06:34:26 -0400
Message-ID: <4174EDB3.1030007@stud.feec.vutbr.cz>
Date: Tue, 19 Oct 2004 12:34:27 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
In-Reply-To: <20041018145008.GA25707@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------020807070201040603010507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020807070201040603010507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> there are two big changes:
> 
>  - debug feature: automatic semaphore/rwsem deadlock detection, based on
>    the code from Igor Manyilov and Bill Huey.
> 
> this is a very nice feature that should help in debugging the remaining
> deadlocks. The deadlock detection feature has already helped me fix a
> bug that was causing hangs in the VFS, so it's really useful.

I can trigger the deadlock detection when I try to ping my default 
gateway. I'm attaching the log from dmesg.

Michal

--------------020807070201040603010507
Content-Type: text/plain;
 name="ping-deadlock.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ping-deadlock.txt"

BUG: semaphore deadlock detected!
.. task ksoftirqd/0/2 is holding c04019c4.
0000012c 00000001 c14f4000 00000000 c14f5f9c c011e713 c03a36b8 c011e7d9 
       c011eb18 0000000a c03a36b8 c14f4000 c14f4000 00000000 c14f5fa4 c011e7f1 
       c14f5fbc c011eb18 00000001 fffffff6 c14f4000 c14e3f70 c14f5fec c012d333 
Call Trace:
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: print_traces+0x1d/0x56 / (show_stack+0x85/0x9b)

...#0 task ksoftirqd/0/2 is holding c04019c4.
------------[ cut here ]------------
kernel BUG at lib/rwsem-generic.c:416!
invalid operand: 0000 [#1]
PREEMPT 
Modules linked in: ipt_REJECT ipt_pkttype ipt_LOG ipt_state ipt_multiport ipt_conntrack iptable_mangle ip_nat_irc ip_nat_tftp ip_nat_ftp iptable_nat ip_conntrack_irc ip_conntrack_tftp ip_conntrack_ftp ip_conntrack iptable_filter ip_tables af_packet 8139too 8139cp mii crc32 e1000 snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc ehci_hcd usbhid uhci_hcd usbcore intel_mch_agp intel_agp evdev nls_iso8859_1 nls_cp437 vfat fat dm_mod floppy ide_cd cdrom psmouse unix
CPU:    0
EIP:    0060:[<c0289aca>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc4-mm1-RT-U5) 
EIP is at __down_write+0xad/0x190
eax: 00000001   ebx: c14e0d20   ecx: 00000000   edx: c14f4000
esi: c04019c4   edi: dff1b080   ebp: c14f5d64   esp: c14f5d48
ds: 007b   es: 007b   ss: 0068   preempt: 00000003
Process ksoftirqd/0 (pid: 2, threadinfo=c14f4000 task=c14e0d20)
Stack: c04019c4 c04019c8 c04019c8 c14e0d20 00000002 c14f4000 c04019c4 c14f5d7c 
       c01b33c8 c04019c4 c14e0d20 dec0f000 df59a000 c14f5da0 c02364c5 c04019c0 
       00000202 c14f5da0 df59a000 dec0f000 df59a000 df59a358 c14f5dc4 c02420cd 
Call Trace:
 [<c01b33c8>] down_write+0x52/0x97
 [<c02364c5>] dev_queue_xmit_nit+0x41/0x127
 [<c02420cd>] qdisc_restart+0x182/0x1ac
 [<c0236964>] dev_queue_xmit+0x194/0x230
 [<c023c3e3>] neigh_resolve_output+0xf1/0x1e5
 [<c023bf8d>] neigh_update+0x2c3/0x368
 [<c0272642>] arp_process+0x1f8/0x5ac
 [<c01132d0>] mcount+0x14/0x18
 [<c0272a0a>] arp_rcv+0x14/0x155
 [<c0236e14>] netif_receive_skb+0x10f/0x1ab
 [<c0241c7e>] eth_type_trans+0xe/0xc8
 [<e097582f>] rtl8139_rx+0x185/0x326 [8139too]
 [<e0975bbb>] rtl8139_poll+0x5d/0xfe [8139too]
 [<c023707b>] net_rx_action+0x7c/0x143
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 00000004
. 4-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: die+0x3f/0x196 / (do_invalid_op+0x106/0x108)
.. entry 4: print_traces+0x1d/0x56 / (show_stack+0x85/0x9b)

Code: 10 89 45 ec 89 34 24 e8 47 90 f2 ff 89 34 24 e8 04 91 f2 ff 85 c0 74 1b a1 58 36 2d c0 85 c0 74 12 c7 05 58 36 2d c0 00 00 00 00 <0f> 0b a0 01 2f 32 2a c0 89 b3 70 06 00 00 9c 58 c1 e8 09 83 f0 
 <3>BUG: sleeping function called from invalid context ksoftirqd/0(2) at lib/rwsem-generic.c:593
in_atomic():1 [00000002], irqs_disabled():0
 [<c0116e6c>] __might_sleep+0xc4/0xd6
 [<c01b3275>] down_read+0x27/0x96
 [<c011a353>] profile_task_exit+0x1b/0x43
 [<c01132d0>] mcount+0x14/0x18
 [<c011bfbf>] do_exit+0x1f/0x4a3
 [<c0105e9a>] do_invalid_op+0x0/0x108
 [<c0105af8>] do_divide_error+0x0/0x132
 [<c0114a1c>] fixup_exception+0x1c/0x38
 [<c0105fa0>] do_invalid_op+0x106/0x108
 [<c01132d0>] mcount+0x14/0x18
 [<c0289aca>] __down_write+0xad/0x190
 [<c0119e3b>] release_console_sem+0xa7/0xfe
 [<c0119ce2>] vprintk+0x116/0x179
 [<c0105309>] error_code+0x2d/0x38
 [<c0289aca>] __down_write+0xad/0x190
 [<c01b33c8>] down_write+0x52/0x97
 [<c02364c5>] dev_queue_xmit_nit+0x41/0x127
 [<c02420cd>] qdisc_restart+0x182/0x1ac
 [<c0236964>] dev_queue_xmit+0x194/0x230
 [<c023c3e3>] neigh_resolve_output+0xf1/0x1e5
 [<c023bf8d>] neigh_update+0x2c3/0x368
 [<c0272642>] arp_process+0x1f8/0x5ac
 [<c01132d0>] mcount+0x14/0x18
 [<c0272a0a>] arp_rcv+0x14/0x155
 [<c0236e14>] netif_receive_skb+0x10f/0x1ab
 [<c0241c7e>] eth_type_trans+0xe/0xc8
 [<e097582f>] rtl8139_rx+0x185/0x326 [8139too]
 [<e0975bbb>] rtl8139_poll+0x5d/0xfe [8139too]
 [<c023707b>] net_rx_action+0x7c/0x143
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: print_traces+0x1d/0x56 / (dump_stack+0x23/0x27)

BUG: scheduling while atomic: ksoftirqd/0/0x04000002/2
caller is cond_resched+0x62/0x82
 [<c0288df2>] __sched_text_start+0x53e/0x571
 [<c02894c4>] cond_resched+0x62/0x82
 [<c01132d0>] mcount+0x14/0x18
 [<c02894c4>] cond_resched+0x62/0x82
 [<c01b327a>] down_read+0x2c/0x96
 [<c011a353>] profile_task_exit+0x1b/0x43
 [<c01132d0>] mcount+0x14/0x18
 [<c011bfbf>] do_exit+0x1f/0x4a3
 [<c0105e9a>] do_invalid_op+0x0/0x108
 [<c0105af8>] do_divide_error+0x0/0x132
 [<c0114a1c>] fixup_exception+0x1c/0x38
 [<c0105fa0>] do_invalid_op+0x106/0x108
 [<c01132d0>] mcount+0x14/0x18
 [<c0289aca>] __down_write+0xad/0x190
(ksoftirqd/0/2/CPU#0): new 856 us maximum-latency critical section.
 => started at timestamp 144481672: <__call_console_drivers+0x19/0x65>
 =>   ended at timestamp 144482528: <call_console_drivers+0x9e/0x13f>
 [<c012ec10>] touch_preempt_timing+0x3d/0x41
 [<c012eb37>] check_preempt_timing+0x1b2/0x24e
 [<c0119a54>] call_console_drivers+0x9e/0x13f
 [<c012ec10>] touch_preempt_timing+0x3d/0x41
 [<c0119a54>] call_console_drivers+0x9e/0x13f
 [<c0119a54>] call_console_drivers+0x9e/0x13f
 [<c0288edb>] preempt_schedule+0x11/0x7a
 [<c0119e04>] release_console_sem+0x70/0xfe
 [<c0119ce2>] vprintk+0x116/0x179
 [<c0289aca>] __down_write+0xad/0x190
 [<c0119bc8>] printk+0x1d/0x21
 [<c01055f8>] show_trace+0x78/0xb2
 [<c0289aca>] __down_write+0xad/0x190
 [<c01056f0>] dump_stack+0x23/0x27
 [<c0288df2>] __sched_text_start+0x53e/0x571
 [<c02894c4>] cond_resched+0x62/0x82
 [<c01132d0>] mcount+0x14/0x18
 [<c02894c4>] cond_resched+0x62/0x82
 [<c01b327a>] down_read+0x2c/0x96
 [<c011a353>] profile_task_exit+0x1b/0x43
 [<c01132d0>] mcount+0x14/0x18
 [<c011bfbf>] do_exit+0x1f/0x4a3
 [<c0105e9a>] do_invalid_op+0x0/0x108
 [<c0105af8>] do_divide_error+0x0/0x132
 [<c0114a1c>] fixup_exception+0x1c/0x38
 [<c0105fa0>] do_invalid_op+0x106/0x108
 [<c01132d0>] mcount+0x14/0x18
 [<c0289aca>] __down_write+0xad/0x190
 [<c0119e3b>] release_console_sem+0xa7/0xfe
 [<c0119ce2>] vprintk+0x116/0x179
 [<c0105309>] error_code+0x2d/0x38
 [<c0289aca>] __down_write+0xad/0x190
 [<c01b33c8>] down_write+0x52/0x97
 [<c02364c5>] dev_queue_xmit_nit+0x41/0x127
 [<c02420cd>] qdisc_restart+0x182/0x1ac
 [<c0236964>] dev_queue_xmit+0x194/0x230
 [<c023c3e3>] neigh_resolve_output+0xf1/0x1e5
 [<c023bf8d>] neigh_update+0x2c3/0x368
 [<c0272642>] arp_process+0x1f8/0x5ac
 [<c01132d0>] mcount+0x14/0x18
 [<c0272a0a>] arp_rcv+0x14/0x155
 [<c0236e14>] netif_receive_skb+0x10f/0x1ab
 [<c0241c7e>] eth_type_trans+0xe/0xc8
 [<e097582f>] rtl8139_rx+0x185/0x326 [8139too]
 [<e0975bbb>] rtl8139_poll+0x5d/0xfe [8139too]
 [<c023707b>] net_rx_action+0x7c/0x143
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 04000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: print_traces+0x1d/0x56 / (dump_stack+0x23/0x27)

 =>   dump-end timestamp 144483248

 [<c0119e3b>] release_console_sem+0xa7/0xfe
 [<c0119ce2>] vprintk+0x116/0x179
 [<c0105309>] error_code+0x2d/0x38
 [<c0289aca>] __down_write+0xad/0x190
 [<c01b33c8>] down_write+0x52/0x97
 [<c02364c5>] dev_queue_xmit_nit+0x41/0x127
 [<c02420cd>] qdisc_restart+0x182/0x1ac
 [<c0236964>] dev_queue_xmit+0x194/0x230
 [<c023c3e3>] neigh_resolve_output+0xf1/0x1e5
 [<c023bf8d>] neigh_update+0x2c3/0x368
 [<c0272642>] arp_process+0x1f8/0x5ac
 [<c01132d0>] mcount+0x14/0x18
 [<c0272a0a>] arp_rcv+0x14/0x155
 [<c0236e14>] netif_receive_skb+0x10f/0x1ab
 [<c0241c7e>] eth_type_trans+0xe/0xc8
 [<e097582f>] rtl8139_rx+0x185/0x326 [8139too]
 [<e0975bbb>] rtl8139_poll+0x5d/0xfe [8139too]
 [<c023707b>] net_rx_action+0x7c/0x143
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 04000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: print_traces+0x1d/0x56 / (dump_stack+0x23/0x27)

note: ksoftirqd/0[2] exited with preempt_count 2
BUG: scheduling while atomic: ksoftirqd/0/0x00000002/2
caller is do_exit+0x2a7/0x4a3
 [<c0288df2>] __sched_text_start+0x53e/0x571
 [<c011c247>] do_exit+0x2a7/0x4a3
 [<c01132d0>] mcount+0x14/0x18
 [<c011c247>] do_exit+0x2a7/0x4a3
 [<c0105e9a>] do_invalid_op+0x0/0x108
 [<c0105af8>] do_divide_error+0x0/0x132
 [<c0114a1c>] fixup_exception+0x1c/0x38
 [<c0105fa0>] do_invalid_op+0x106/0x108
 [<c01132d0>] mcount+0x14/0x18
 [<c0289aca>] __down_write+0xad/0x190
 [<c0119e3b>] release_console_sem+0xa7/0xfe
 [<c0119ce2>] vprintk+0x116/0x179
 [<c0105309>] error_code+0x2d/0x38
 [<c0289aca>] __down_write+0xad/0x190
 [<c01b33c8>] down_write+0x52/0x97
 [<c02364c5>] dev_queue_xmit_nit+0x41/0x127
 [<c02420cd>] qdisc_restart+0x182/0x1ac
 [<c0236964>] dev_queue_xmit+0x194/0x230
 [<c023c3e3>] neigh_resolve_output+0xf1/0x1e5
 [<c023bf8d>] neigh_update+0x2c3/0x368
 [<c0272642>] arp_process+0x1f8/0x5ac
 [<c01132d0>] mcount+0x14/0x18
 [<c0272a0a>] arp_rcv+0x14/0x155
 [<c0236e14>] netif_receive_skb+0x10f/0x1ab
 [<c0241c7e>] eth_type_trans+0xe/0xc8
 [<e097582f>] rtl8139_rx+0x185/0x326 [8139too]
 [<e0975bbb>] rtl8139_poll+0x5d/0xfe [8139too]
 [<c023707b>] net_rx_action+0x7c/0x143
 [<c011e713>] ___do_softirq+0x83/0xc8
 [<c011e7d9>] _do_softirq+0x8/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c011e7f1>] _do_softirq+0x20/0x22
 [<c011eb18>] ksoftirqd+0x93/0xd1
 [<c012d333>] kthread+0xaa/0xaf
 [<c011ea85>] ksoftirqd+0x0/0xd1
 [<c012d289>] kthread+0x0/0xaf
 [<c01032f1>] kernel_thread_helper+0x5/0xb
preempt count: 00000003
. 3-level deep critical section nesting:
.. entry 1: down_write+0x95/0x97 / (dev_queue_xmit_nit+0x41/0x127)
.. entry 2: __down_write+0x43/0x190 / (down_write+0x52/0x97)
.. entry 3: print_traces+0x1d/0x56 / (dump_stack+0x23/0x27)


--------------020807070201040603010507--
