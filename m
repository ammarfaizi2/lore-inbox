Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263020AbUCXEmb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 23:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUCXEmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 23:42:31 -0500
Received: from willow.seitz.com ([146.145.147.180]:21518 "EHLO
	willow.seitz.com") by vger.kernel.org with ESMTP id S263003AbUCXEmT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 23:42:19 -0500
From: Ross Vandegrift <ross@willow.seitz.com>
Date: Tue, 23 Mar 2004 23:42:18 -0500
To: linux-kernel@vger.kernel.org
Subject: via-rhine crashes, 2.6.5-rc2-mm1
Message-ID: <20040324044218.GB13477@willow.seitz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

	I'm using kernel 2.6.5-rc2-mm1 on a motherboard with a VIA Rhine
network adaptor and am getting crashes at boot.  The chipset is KT400,
with VT6102 [Rhine-II] (rev 74) network adaptor.  I'm booting the
kernel with parameters "noapic" and "acpi=off".  Preemption is disabled.

	I get stack dumps when traffic is sent out, and every few
minutes "Disabline IRQ #11" messages.  2.4.23+lowlatency works without a
hitch.


	Call traces follow:

eth0: VIA VT6102 Rhine-II at 0xcc00, 00:0a:e6:d1:b8:9f, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c011eeb0>] __do_softirq+0x30/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0256bc1>] fib_magic+0xf1/0x100
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108d6f>] setup_irq+0x6f/0xa0
 [<e09d7cc0>] via_rhine_interrupt+0x0/0x1b0 [via_rhine]
 [<c0108a3d>] request_irq+0x9d/0xd0
 [<e09d76c9>] via_rhine_open+0x49/0x150 [via_rhine]
 [<c021cc58>] dev_open+0xc8/0x100
 [<c021dfe1>] dev_change_flags+0x101/0x120
 [<c02503d7>] devinet_ioctl+0x2b7/0x690
 [<c0252543>] inet_ioctl+0xa3/0xe0
 [<c0215fda>] sock_ioctl+0xaa/0x220
 [<c015a76f>] sys_ioctl+0xcf/0x220
 [<c026028b>] syscall_call+0x7/0xb

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01e0500>] vt_console_print+0x0/0x2e0
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c011bcc8>] __call_console_drivers+0x48/0x50
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108767>] enable_irq+0x37/0xc0
 [<e09d756b>] init_registers+0xeb/0x100 [via_rhine]
 [<e09d7a53>] via_rhine_tx_timeout+0xa3/0x100 [via_rhine]
 [<c0225c60>] dev_watchdog+0x0/0xa0
 [<c0225ced>] dev_watchdog+0x8d/0xa0
 [<c0122a2e>] run_timer_softirq+0xae/0x160
 [<c011eefc>] __do_softirq+0x7c/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0105030>] default_idle+0x0/0x30
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0105030>] default_idle+0x0/0x30
 [<c0105054>] default_idle+0x24/0x30
 [<c01050d0>] cpu_idle+0x30/0x40
 [<c02e0717>] start_kernel+0x137/0x160
 [<c02e0470>] unknown_bootoption+0x0/0x130

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c01189f1>] __wake_up_common+0x31/0x60
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108767>] enable_irq+0x37/0xc0
 [<e09d756b>] init_registers+0xeb/0x100 [via_rhine]
 [<e09d7a53>] via_rhine_tx_timeout+0xa3/0x100 [via_rhine]
 [<c0225c60>] dev_watchdog+0x0/0xa0
 [<c0225ced>] dev_watchdog+0x8d/0xa0
 [<c0122a2e>] run_timer_softirq+0xae/0x160
 [<c011eefc>] __do_softirq+0x7c/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0105030>] default_idle+0x0/0x30
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0105030>] default_idle+0x0/0x30
 [<c0105054>] default_idle+0x24/0x30
 [<c01050d0>] cpu_idle+0x30/0x40
 [<c02e0717>] start_kernel+0x137/0x160
 [<c02e0470>] unknown_bootoption+0x0/0x130

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c01189f1>] __wake_up_common+0x31/0x60
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108767>] enable_irq+0x37/0xc0
 [<e09d756b>] init_registers+0xeb/0x100 [via_rhine]
 [<e09d7a53>] via_rhine_tx_timeout+0xa3/0x100 [via_rhine]
 [<c0225c60>] dev_watchdog+0x0/0xa0
 [<c0225ced>] dev_watchdog+0x8d/0xa0
 [<c0122a2e>] run_timer_softirq+0xae/0x160
 [<c011eefc>] __do_softirq+0x7c/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0105030>] default_idle+0x0/0x30
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0105030>] default_idle+0x0/0x30
 [<c0105054>] default_idle+0x24/0x30
 [<c01050d0>] cpu_idle+0x30/0x40
 [<c02e0717>] start_kernel+0x137/0x160
 [<c02e0470>] unknown_bootoption+0x0/0x130

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c01189f1>] __wake_up_common+0x31/0x60
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108767>] enable_irq+0x37/0xc0
 [<e09d756b>] init_registers+0xeb/0x100 [via_rhine]
 [<e09d7a53>] via_rhine_tx_timeout+0xa3/0x100 [via_rhine]
 [<c0225c60>] dev_watchdog+0x0/0xa0
 [<c0225ced>] dev_watchdog+0x8d/0xa0
 [<c0122a2e>] run_timer_softirq+0xae/0x160
 [<c011eefc>] __do_softirq+0x7c/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0105030>] default_idle+0x0/0x30
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0105030>] default_idle+0x0/0x30
 [<c0105054>] default_idle+0x24/0x30
 [<c01050d0>] cpu_idle+0x30/0x40
 [<c02e0717>] start_kernel+0x137/0x160
 [<c02e0470>] unknown_bootoption+0x0/0x130

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.
irq 11: nobody cared!
Call Trace:
 [<c01085d4>] __report_bad_irq+0x24/0x80
 [<c01086b1>] note_interrupt+0x61/0x90
 [<c0108580>] handle_IRQ_event+0x30/0x60
 [<c0108939>] do_IRQ+0x149/0x170
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108570>] handle_IRQ_event+0x20/0x60
 [<c01088ba>] do_IRQ+0xca/0x170
 =======================
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0108767>] enable_irq+0x37/0xc0
 [<e09d756b>] init_registers+0xeb/0x100 [via_rhine]
 [<e09d7a53>] via_rhine_tx_timeout+0xa3/0x100 [via_rhine]
 [<c0225c60>] dev_watchdog+0x0/0xa0
 [<c0225ced>] dev_watchdog+0x8d/0xa0
 [<c0122a2e>] run_timer_softirq+0xae/0x160
 [<c011eefc>] __do_softirq+0x7c/0x80
 [<c010901f>] do_softirq+0x4f/0x60
 =======================
 [<c0108921>] do_IRQ+0x131/0x170
 [<c0105030>] default_idle+0x0/0x30
 [<c0260c70>] common_interrupt+0x18/0x20
 [<c0105030>] default_idle+0x0/0x30
 [<c0105054>] default_idle+0x24/0x30
 [<c01050d0>] cpu_idle+0x30/0x40
 [<c02e0717>] start_kernel+0x137/0x160
 [<c02e0470>] unknown_bootoption+0x0/0x130

handlers:
[<e09d7cc0>] (via_rhine_interrupt+0x0/0x1b0 [via_rhine])
Disabling IRQ #11

-- 
Ross Vandegrift
ross@willow.seitz.com

A Pope has a Water Cannon.                               It is a Water Cannon.
He fires Holy-Water from it.                        It is a Holy-Water Cannon.
He Blesses it.                                 It is a Holy Holy-Water Cannon.
He Blesses the Hell out of it.          It is a Wholly Holy Holy-Water Cannon.
He has it pierced.                It is a Holey Wholly Holy Holy-Water Cannon.
He makes it official.       It is a Canon Holey Wholly Holy Holy-Water Cannon.
Batman and Robin arrive.                                       He shoots them.
