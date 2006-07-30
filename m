Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWG3Jky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWG3Jky (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWG3Jky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:40:54 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:10884 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932155AbWG3Jkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:40:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Subject: ACPI-related problem with resuming from RAM
Date: Sun, 30 Jul 2006 11:40:09 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301140.09836.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To make my box (Asus L5D, x86_64) resume from RAM, I have to unload all of the
ACPI-related modules and the ohci_hcd module before the suspend.

Also, I can't reload the ohci_hcd module after the resume, because if I try,
the system crashes with the appended trace.

Greetings,
Rafael


irq 11: nobody cared (try booting with the "irqpoll" option)

Call Trace:
 [<ffffffff8020b145>] show_trace+0xa5/0x330
 [<ffffffff8020b6b5>] dump_stack+0x15/0x20
 [<ffffffff80263b48>] __report_bad_irq+0x38/0x90
 [<ffffffff80263dca>] note_interrupt+0x22a/0x280
 [<ffffffff80264a00>] handle_level_irq+0xf0/0x140
 [<ffffffff8020ccdd>] do_IRQ+0x11d/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
Leftover inexact backtrace:
 <IRQ> [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8023389a>] __do_softirq+0x5a/0xf0
 [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8020cb4d>] do_softirq+0x3d/0xb0
 [<ffffffff8023370e>] irq_exit+0x4e/0x60
 [<ffffffff8020ccf5>] do_IRQ+0x135/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
 <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
 [<ffffffff8020b362>] show_trace+0x2c2/0x330
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [1] PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:02.0/usb2/serial
CPU 0
Modules linked in: ohci_hcd ehci_hcd usbserial snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device af_packet ip6t_REJECT xt_tcpudp bcm43xx ieee8
0211softmac pcmcia firmware_class ieee80211 ipt_REJECT ieee80211_crypt xt_state ohci1394 ieee1394 iptable_mangle iptable_nat ip_nat yenta_soc
ket iptable_filter rsrc_nonstatic pcmcia_core ip6table_mangle ip_conntrack ip_tables skge ip6table_filter ip6_tables x_tables snd_intel8x0 sn
d_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_nforce2 i2c_core parport_pc ipv6 lp parport dm_mod
Pid: 4908, comm: modprobe Tainted: G   M  2.6.18-rc2-mm1 #20
RIP: 0010:[<ffffffff8020b362>]  [<ffffffff8020b362>] show_trace+0x2c2/0x330
RSP: 0018:ffffffff8061ecb0  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8061ed90 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff827ffffd
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00002b41c0925b00(0000) GS:ffffffff808c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000056fc0000 CR4: 00000000000006e0
Process modprobe (pid: 4908, threadinfo ffff810056a46000, task ffff81005b88f040)
Stack:  0000000000000000 ffffffff880a6580 000000000000000a ffffffff8066a240
 ffffffff8061eeb0 0000000000000022 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8020b6b5>] dump_stack+0x15/0x20
 [<ffffffff80263b48>] __report_bad_irq+0x38/0x90
 [<ffffffff80263dca>] note_interrupt+0x22a/0x280
 [<ffffffff80264a00>] handle_level_irq+0xf0/0x140
 [<ffffffff8020ccdd>] do_IRQ+0x11d/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
DWARF2 unwinder stuck at ret_from_intr+0x0/0xf
Leftover inexact backtrace:
 <IRQ> [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8023389a>] __do_softirq+0x5a/0xf0
 [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8020cb4d>] do_softirq+0x3d/0xb0
 [<ffffffff8023370e>] irq_exit+0x4e/0x60
 [<ffffffff8020ccf5>] do_IRQ+0x135/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
 <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
 [<ffffffff8020b362>] show_trace+0x2c2/0x330
PGD 203027 PUD 205027 PMD 0
Oops: 0000 [2] PREEMPT
last sysfs file: /devices/pci0000:00/0000:00:02.0/usb2/serial
CPU 0
Modules linked in: ohci_hcd ehci_hcd usbserial snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device af_packet ip6t_REJECT xt_tcpudp bcm43xx ieee8
0211softmac pcmcia firmware_class ieee80211 ipt_REJECT ieee80211_crypt xt_state ohci1394 ieee1394 iptable_mangle iptable_nat ip_nat yenta_soc
ket iptable_filter rsrc_nonstatic pcmcia_core ip6table_mangle ip_conntrack ip_tables skge ip6table_filter ip6_tables x_tables snd_intel8x0 sn
d_ac97_codec snd_ac97_bus snd_pcm snd_timer snd soundcore snd_page_alloc i2c_nforce2 i2c_core parport_pc ipv6 lp parport dm_mod
Pid: 4908, comm: modprobe Tainted: G   M  2.6.18-rc2-mm1 #20
RIP: 0010:[<ffffffff8020b362>]  [<ffffffff8020b362>] show_trace+0x2c2/0x330
RSP: 0018:ffffffff8061e958  EFLAGS: 00010002
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffffff8061ea38 R08: 0000000000000002 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff827ffffd
R13: 0000000000000000 R14: ffffffff8061ec08 R15: 0000000000000000
FS:  00002b41c0925b00(0000) GS:ffffffff808c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: ffffffff82800000 CR3: 0000000056fc0000 CR4: 00000000000006e0
Process modprobe (pid: 4908, threadinfo ffff810056a46000, task ffff81005b88f040)
Stack:  0000000000000000 ffffffff880a6580 000000000000000a ffffffff8066a240
 ffffffff8061eeb0 0000000000000022 0000000000000000 0000000000000000
 0000000000000001 0000000000000002 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8020b4be>] _show_stack+0xee/0x100
 [<ffffffff8020b55a>] show_registers+0x8a/0x110
 [<ffffffff8020b75f>] __die+0x9f/0xf0
 [<ffffffff8021db61>] do_page_fault+0x7c1/0x8f0
 [<ffffffff8020a659>] error_exit+0x0/0x96
DWARF2 unwinder stuck at error_exit+0x0/0x96
Leftover inexact backtrace:
 <IRQ> [<ffffffff8020b362>] show_trace+0x2c2/0x330
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
 [<ffffffff8020b6b5>] dump_stack+0x15/0x20
 [<ffffffff80263b48>] __report_bad_irq+0x38/0x90
 [<ffffffff80263dca>] note_interrupt+0x22a/0x280
 [<ffffffff80262c28>] handle_IRQ_event+0x58/0x70
 [<ffffffff80264a00>] handle_level_irq+0xf0/0x140
 [<ffffffff8020ccdd>] do_IRQ+0x11d/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
 [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8023389a>] __do_softirq+0x5a/0xf0
 [<ffffffff8020ab82>] call_softirq+0x1e/0x28
 [<ffffffff8020cb4d>] do_softirq+0x3d/0xb0
 [<ffffffff8023370e>] irq_exit+0x4e/0x60
 [<ffffffff8020ccf5>] do_IRQ+0x135/0x140
 [<ffffffff8020a23d>] ret_from_intr+0x0/0xf
 <EOI><1>Unable to handle kernel paging request at ffffffff82800000 RIP:
 [<ffffffff8020b362>] show_trace+0x2c2/0x330
PGD 203027 PUD 205027 PMD 0
