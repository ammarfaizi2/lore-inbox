Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWKFHYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWKFHYu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 02:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWKFHYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 02:24:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:53421 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161023AbWKFHYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 02:24:48 -0500
X-Authenticated: #14349625
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
From: Mike Galbraith <efault@gmx.de>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       Karsten Wiese <fzu@wemgehoertderstaat.de>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <454E2FC1.4040700@rncbc.org>
References: <42997.194.65.103.1.1162464204.squirrel@www.rncbc.org>
	 <200611031230.24983.fzu@wemgehoertderstaat.de> <454BC8D1.1020001@rncbc.org>
	 <454BF608.20803@rncbc.org> <454C714B.8030403@rncbc.org>
	 <454E0976.8030303@rncbc.org> <454E15B0.2050008@rncbc.org>
	 <1162742535.2750.23.camel@localhost.localdomain>
	 <454E2FC1.4040700@rncbc.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 08:24:56 +0100
Message-Id: <1162797896.6126.5.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just reproduced it running glibc make check.  I had just enabled
kprobes and recompiled with the stock SuSE-10.1 compiler while waiting
for you to send me your .config (nevermind that request) so I could try
to reproduce it here.

BUG: scheduling while atomic: swapper/0x00000001/0, CPU#0
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
b101995a
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: xt_pkttype ipt_LOG xt_limit snd_pcm_oss snd_mixer_oss eeprom snd_seq_midi snd_seq_midi_event snd_seq edd ip6t_REJECT xt_tcpudp ipt_REJECT xt_state iptable_mangle iptable_nat ip_nat iptable_filter ip6table_mangle ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables x_tables nls_iso8859_1 nls_cp437 nls_utf8 tuner saa7134 sd_mod bt878 snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm ir_kbd_i2c ohci1394 bttv video_buf ir_common i2c_i801 ieee1394 prism54 btcx_risc tveeprom snd_timer snd_page_alloc firmware_class snd_mpu401 snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore
CPU:    1
EIP:    0060:[<b101995a>]    Not tainted VLI
EFLAGS: 00210046   (2.6.18-rt7-smp #186) 
EIP is at enqueue_task+0x2e/0x83
eax: b2459208   ebx: b2458d8c   ecx: 00000000   edx: b146bf68
esi: b146bf40   edi: b24588c0   ebp: b9e06d5c   esp: b9e06d54
ds: 007b   es: 007b   ss: 0068   preempt: 00000004
Process ld-linux.so.2 (pid: 16981, ti=b9e06000 task=eec9d300 task.ti=b9e06000)
Stack: b24588c0 b146bf40 b9e06d6c b10199c8 00000001 b146bf40 b9e06dd0 b101bae4 
       b24d9300 b9e06dac 00000002 00000000 0000001f b9e06000 00000000 00000001 
       00000004 b1022cfb 00000068 00200002 b9e06de4 00000001 00000008 b9e06dc0 
 [<b10199c8>] __activate_task+0x19/0x2c
 [<b101bae4>] try_to_wake_up+0x32a/0x447
 [<b101bc6b>] wake_up_process_mutex+0x19/0x1b
 [<b103cc33>] wakeup_next_waiter+0xd3/0x158
 [<b13afb87>] rt_spin_lock_slowunlock+0x36/0x51
 [<b13b0403>] rt_spin_unlock+0x29/0x2b
 [<b13b2a72>] kprobe_flush_task+0x38/0x48
 [<b13aeb0e>] __schedule+0xb77/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b13afe61>] rt_mutex_slowlock+0xbd/0x27d
 [<b13afc28>] rt_mutex_lock+0x38/0x3a
 [<b103d605>] rt_down_read+0x2e/0x41
 [<b10235c5>] exit_mm+0x2a/0x11c
 [<b1024bf4>] do_exit+0x11d/0x96e
 [<b10254da>] complete_and_exit+0x0/0x16
 [<b9e06000>] 0xb9e06000
DWARF2 unwinder stuck at 0xb9e06000
 [<b10042b7>] show_stack_log_lvl+0xa6/0xcb
 [<b1004493>] show_registers+0x1b7/0x23c
 [<b100464f>] die+0x137/0x2a8
 [<b13b1c4d>] do_page_fault+0x1ed/0x590
 [<b1003c51>] error_code+0x39/0x40
 [<b10199c8>] __activate_task+0x19/0x2c
 [<b101bae4>] try_to_wake_up+0x32a/0x447
 [<b101bc6b>] wake_up_process_mutex+0x19/0x1b
 [<b103cc33>] wakeup_next_waiter+0xd3/0x158
 [<b13afb87>] rt_spin_lock_slowunlock+0x36/0x51
 [<b13b0403>] rt_spin_unlock+0x29/0x2b
 [<b13b2a72>] kprobe_flush_task+0x38/0x48
 [<b13aeb0e>] __schedule+0xb77/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b13afe61>] rt_mutex_slowlock+0xbd/0x27d
 [<b13afc28>] rt_mutex_lock+0x38/0x3a
 [<b103d605>] rt_down_read+0x2e/0x41
 [<b10235c5>] exit_mm+0x2a/0x11c
 [<b1024bf4>] do_exit+0x11d/0x96e
 [<b10254da>] complete_and_exit+0x0/0x16
 [<b100317f>] syscall_call+0x7/0xb
Code: 56 53 89 c6 89 d3 f6 40 0c 08 74 09 a1 20 f4 46 b1 85 c0 75 4b 8b 46 1c 8d 44 c3 1c 8b 48 04 8d 56 28 89 50 04 89 46 28 89 4a 04 <89> 11 8b 46 1c 0f ab 43 08 83 43 04 01 89 5e 30 8b 13 83 7e 1c 
EIP: [<b101995a>] enqueue_task+0x2e/0x83 SS:ESP 0068:b9e06d54
BUG: scheduling with irqs disabled: ld-linux.so.2/0x00000003/16981
caller is do_exit+0x843/0x96e
 [<b10041fb>] show_trace_log_lvl+0x179/0x18f
 [<b1004803>] show_trace+0x12/0x14
 [<b1004924>] dump_stack+0x19/0x1b
 [<b13af03a>] schedule+0xf4/0xf9
 [<b102531a>] do_exit+0x843/0x96e
 [<b10047c0>] show_stack+0x0/0x31
 [<b13f038f>] 0xb13f038f
DWARF2 unwinder stuck at 0xb13f038f
 [<b1004803>] show_trace+0x12/0x14
 [<b1004924>] dump_stack+0x19/0x1b
 [<b13af03a>] schedule+0xf4/0xf9
 [<b102531a>] do_exit+0x843/0x96e
 [<b10047c0>] show_stack+0x0/0x31
 [<b13b1c4d>] do_page_fault+0x1ed/0x590
 [<b1003c51>] error_code+0x39/0x40
 [<b10199c8>] __activate_task+0x19/0x2c
 [<b101bae4>] try_to_wake_up+0x32a/0x447
 [<b101bc6b>] wake_up_process_mutex+0x19/0x1b
 [<b103cc33>] wakeup_next_waiter+0xd3/0x158
 [<b13afb87>] rt_spin_lock_slowunlock+0x36/0x51
 [<b13b0403>] rt_spin_unlock+0x29/0x2b
 [<b13b2a72>] kprobe_flush_task+0x38/0x48
 [<b13aeb0e>] __schedule+0xb77/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b13afe61>] rt_mutex_slowlock+0xbd/0x27d
 [<b13afc28>] rt_mutex_lock+0x38/0x3a
 [<b103d605>] rt_down_read+0x2e/0x41
 [<b10235c5>] exit_mm+0x2a/0x11c
 [<b1024bf4>] do_exit+0x11d/0x96e
 [<b10254da>] complete_and_exit+0x0/0x16
 [<b100317f>] syscall_call+0x7/0xb
BUG: scheduling while atomic: ld-linux.so.2/0x00000003/16981, CPU#1
 [<b10041fb>] show_trace_log_lvl+0x179/0x18f
 [<b1004803>] show_trace+0x12/0x14
 [<b1004924>] dump_stack+0x19/0x1b
 [<b13ae5d2>] __schedule+0x63b/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b102531a>] do_exit+0x843/0x96e
 [<b10047c0>] show_stack+0x0/0x31
 [<b13f038f>] 0xb13f038f
DWARF2 unwinder stuck at 0xb13f038f
 [<b1004803>] show_trace+0x12/0x14
 [<b1004924>] dump_stack+0x19/0x1b
 [<b13ae5d2>] __schedule+0x63b/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b102531a>] do_exit+0x843/0x96e
 [<b10047c0>] show_stack+0x0/0x31
 [<b13b1c4d>] do_page_fault+0x1ed/0x590
 [<b1003c51>] error_code+0x39/0x40
 [<b10199c8>] __activate_task+0x19/0x2c
 [<b101bae4>] try_to_wake_up+0x32a/0x447
 [<b101bc6b>] wake_up_process_mutex+0x19/0x1b
 [<b103cc33>] wakeup_next_waiter+0xd3/0x158
 [<b13afb87>] rt_spin_lock_slowunlock+0x36/0x51
 [<b13b0403>] rt_spin_unlock+0x29/0x2b
 [<b13b2a72>] kprobe_flush_task+0x38/0x48
 [<b13aeb0e>] __schedule+0xb77/0xea5
 [<b13aef76>] schedule+0x30/0xf9
 [<b13afe61>] rt_mutex_slowlock+0xbd/0x27d
 [<b13afc28>] rt_mutex_lock+0x38/0x3a
 [<b103d605>] rt_down_read+0x2e/0x41
 [<b10235c5>] exit_mm+0x2a/0x11c
 [<b1024bf4>] do_exit+0x11d/0x96e
 [<b10254da>] complete_and_exit+0x0/0x16
 [<b100317f>] syscall_call+0x7/0xb


