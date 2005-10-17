Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbVJQPyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbVJQPyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVJQPyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:54:19 -0400
Received: from agmk.net ([217.73.31.34]:31504 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751408AbVJQPyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:54:18 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-rt1 / oops in ip_nat_cleanup_conntrack / softirq-net-rx
Date: Mon, 17 Oct 2005 17:54:06 +0200
User-Agent: KMail/1.8.3
Cc: Ingo Molnar <mingo@elte.hu>, netfilter-devel@lists.netfilter.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171754.07186.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

With -rt1 I get this oops.

(...)
BUG: Unable to handle kernel paging request at virtual address 00100104
 printing eip:
e13fa10c
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
Modules linked in: ipt_state iptable_filter ipt_TTL iptable_mangle iptable_nat 
ip_nat ip_conntrack nfnetlink ip_tables ip6table_filter ip6_tables ipv6 
ohci_hcd ehci_hcd snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_ens1371 gameport snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_page_alloc snd_ac97_bus tsdev snd_rtctimer 
snd_timer snd soundcore psmouse evdev usbhid 8139too via_rhine mii processor 
msr cpuid ide_cd cdrom ide_disk usbkbd uhci_hcd usbcore jfs via82cxxx 
ide_core
CPU:    0
EIP:    0060:[<e13fa10c>]    Not tainted VLI
EFLAGS: 00010246   (2.6.14-0.5) 
EIP is at ip_nat_cleanup_conntrack+0x2c/0x50 [ip_nat]
eax: 00100100   ebx: ddc67c54   ecx: ddc67cf4   edx: 00200200
esi: 80000000   edi: ddebc5e0   ebp: dff45e98   esp: dff45e94
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process softirq-net-rx/ (pid: 5, threadinfo=dff44000 task=dffe8030 
stack_left=7776 worst_left=-1)
Stack: ddc67c54 dff45eb4 e140b557 ddc67c54 c0403168 c028c0d0 00000014 80000000 
       dff45ee4 c028bb36 ddc67c54 00000001 dff45eec c1759000 00000000 c028c0d0 
       80000000 00000000 ddebc5e0 ccb2581e dff45f1c c028be40 ddebc5e0 9134b33e 
Call Trace:
 [<c010401f>] show_stack+0x7f/0xa0 (28)
 [<c01041f7>] show_registers+0x197/0x220 (56)
 [<c0104418>] die+0xe8/0x190 (68)
 [<c02d58f9>] do_page_fault+0x2d9/0x574 (96)
 [<c0103cb3>] error_code+0x4f/0x54 (64)
 [<e140b557>] destroy_conntrack+0x117/0x150 [ip_conntrack] (28)
 [<c028bb36>] ip_local_deliver+0x1e6/0x290 (48)
 [<c028be40>] ip_rcv+0x260/0x4f0 (56)
 [<c026c748>] netif_receive_skb+0x248/0x2d0 (52)
 [<c026c858>] process_backlog+0x88/0x100 (28)
 [<c026c964>] net_rx_action+0x94/0x1b0 (32)
 [<c0122f16>] ksoftirqd+0xc6/0x130 (40)
 [<c0131eaa>] kthread+0xaa/0xb0 (48)
 [<c0101429>] kernel_thread_helper+0x5/0xc (537632796)
Code: 89 e5 53 8b 5d 08 f7 43 08 80 01 00 00 75 03 5b 5d c3 b8 c0 da 3f e1 e8 
93 ae ed de 8d 8b a0 00 00 00 8b 83 a0 00 00 00 8b 51 04 <89> 50 04 89 02 b8 
00 01 10 00 89 83 a0 00 00 00 b8 c0 da 3f e1 

I've also observed "probe-failed" with 2.6.14-rc4-rt1:

Probing IDE interface ide0...
hda: ST3160023A, ATA DISK drive
hda: IRQ probe failed (0xfffffcf8)
hdb: IRQ probe failed (0xfffffcf8)
hdb: IRQ probe failed (0xfffffcf8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
hdd: TEAC CD-552E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15

... with 2.6.11.10 it works fine.

Probing IDE interface ide0...
hda: ST3160023A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-3540A, ATAPI CD/DVD-ROM drive
hdd: TEAC CD-552E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15


Moreover -rt6 slows down my system dramatically :|

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
