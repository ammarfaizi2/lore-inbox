Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVATNUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVATNUg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 08:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVATNUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 08:20:36 -0500
Received: from main.uucpssh.org ([212.27.33.224]:51357 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262144AbVATNU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 08:20:26 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.10-ac8 - kernel BUG at net/ipv4/tcp_output.c:922!
References: <41DFEDA8.7030805@wasp.net.au>
From: syrius.ml@no-log.org
Message-ID: <87vf9stfi5.87u0pctfi5@87sm4wtfi5.message.id>
Date: Thu, 20 Jan 2005 14:16:42 +0100
In-Reply-To: <41DFEDA8.7030805@wasp.net.au> (Brad Campbell's message of
 "Sat, 08 Jan 2005 18:26:48 +0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just experienced this oops too.
The kernel is a 2.6.10-ac8 and it doesn't seem this issue has been
fixed in 2.6.10-ac10 nor in 2.6.11-rc1 (sure I'd love to be wrong
here ;-) )


kernel BUG at net/ipv4/tcp_output.c:922!
invalid operand: 0000 [#1]
PREEMPT SMP
Modules linked in: nfsd exportfs parport_pc lp parport nfs lockd
sunrpc ipt_TCPMSS iptable_mangle ipt_owner iptable_nat ip_conntrack
ip_tables uhci_hcd usbcore intel_agp evdev raid5 xor md dm_mod md5
ipv6 adm1021 eeprom i2c_piix4 i2c_isa lm75 lm78 w83781d i2c_sensor
i2c_core agpgart scsi_mod 3c59x
CPU:    0
EIP:    0060:[<c0282671>]    Not tainted VLI
EFLAGS: 00010202   (2.6.10-ac8)
EIP is at tcp_retrans_try_collapse+0x321/0x340
eax: e2868c80   ebx: c6060e20   ecx: 00000394   edx: 000005ac
esi: c9aaa2e8   edi: 00000000   ebp: f39d7ae0   esp: c036de90
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c036c000 task=c02f7b40)
Stack: c03a287c 00000002 00000002 00000394 00000218 00000010 00000218
d664acd4
       d664aae0 0000ffff d664acd4 c6060e20 d664aae0 c0282b0c d664aae0
       c6060e20
       000005ac c027a447 000005ac d664aae0 d664acd4 d664ab44 00000000
       c0284a57
Call Trace:
 [<c0282b0c>] tcp_retransmit_skb+0x2ec/0x360
 [<c027a447>] tcp_enter_loss+0x67/0x230
 [<c0284a57>] tcp_retransmit_timer+0x107/0x470
 [<c011841f>] rebalance_tick+0xbf/0xd0
 [<c0284e6e>] tcp_write_timer+0xae/0xf0
 [<c0118553>] scheduler_tick+0x123/0x480
 [<c0284dc0>] tcp_write_timer+0x0/0xf0
 [<c0125efa>] run_timer_softirq+0xda/0x1a0
 [<c0121b3a>] __do_softirq+0xba/0xd0
 [<c0121b7d>] do_softirq+0x2d/0x30
 [<c0138f39>] irq_exit+0x39/0x40
 [<c0103b8c>] apic_timer_interrupt+0x1c/0x24
 [<c0101030>] default_idle+0x0/0x40
 [<c010105c>] default_idle+0x2c/0x40
 [<c01010f2>] cpu_idle+0x42/0x60
 [<c036e984>] start_kernel+0x154/0x170
 [<c036e3a0>] unknown_bootoption+0x0/0x1e0
Code: e9 7f fe ff ff c7 44 24 08 53 26 28 c0 89 54 24 04 89 1c 24 e8
d1 9c fc ff e9 3a fe ff ff 0f 0b c9 02 cc 1d 2d c0 e9 0a fe ff ff <0f>
0b 9a 03 1a 15 2e c0 e9 c2 fd ff ff 89 f6 31 c0 e9 7f fd ff
 <0>Kernel panic - not syncing: Fatal exception in interrupt
 
most of the netfilter modules reported above were in used.
I can provide more informations if needed.

-- 
