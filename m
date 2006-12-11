Return-Path: <linux-kernel-owner+w=401wt.eu-S1762902AbWLKNIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762902AbWLKNIG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762900AbWLKNIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:08:06 -0500
Received: from cust200-138.dsl.versadsl.be ([62.166.200.138]:44792 "HELO
	trinityhome.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762902AbWLKNIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:08:04 -0500
Message-ID: <43294.212.166.5.178.1165842550.squirrel@trinityhome.org>
In-Reply-To: <55427.212.166.5.178.1165835168.squirrel@trinityhome.org>
References: <55427.212.166.5.178.1165835168.squirrel@trinityhome.org>
Date: Mon, 11 Dec 2006 14:09:10 +0100 (CET)
Subject: Kernel 2.6.19: panic in modprobe pata_qdi
From: "Tom Kerremans" <harakiri@trinityhome.org>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6-1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I 'm the maintainer of Trinity Rescue Kit and I try to make kernels as
generic as possible, supporting the most possible hardware. So I compile
about any disk and nic driver. Processor arch is generic 586.

Here 's the command with which I made 2.6.19 crash.

'for i in *; do i=`echo $i | cut -d . -f 1`; echo $i; modprobe $i; rmmod
$i; done'

< all sata is static in the kernel, all pata as module. Old IDE drivers
are static in the kernel, maybe a conflict there.

Upon pata_qdi my machine crashed in a kernel panic. Here 's what I found
relevant in /var/log/messages

Dec 11 13:44:55 localhost kernel:  <6>ata3: PATA max PIO4 cmd 0x170 ctl
0x376 bmdma 0x0 irq 14
Dec 11 13:44:55 localhost kernel: IRQ handler type mismatch for IRQ 14
Dec 11 13:44:55 localhost kernel: current handler: ide0
Dec 11 13:44:55 localhost kernel:  [<c010317a>] show_trace_log_lvl+0x26/0x3c
Dec 11 13:44:55 localhost kernel:  [<c0103276>] show_trace+0x1b/0x1d
Dec 11 13:44:55 localhost kernel:  [<c01039ce>] dump_stack+0x26/0x28
Dec 11 13:44:55 localhost kernel:  [<c01340af>] setup_irq+0x19f/0x1b7
Dec 11 13:44:55 localhost kernel:  [<c0134149>] request_irq+0x82/0xa0
Dec 11 13:44:55 localhost kernel:  [<c03a6613>] ata_device_add+0x2af/0x4e0
Dec 11 13:44:55 localhost kernel:  [<f8acf4ca>] legacy_init+0x4ca/0x5a6
[pata_legacy]
Dec 11 13:44:55 localhost kernel:  [<c012be5a>] sys_init_module+0x1332/0x14b9
Dec 11 13:44:55 localhost kernel:  [<c0102c9d>] sysenter_past_esp+0x56/0x79
Dec 11 13:44:55 localhost kernel:  =======================
Dec 11 13:44:55 localhost kernel: platform pata_legacy.0: irq 14 request
failed: -16

I tried 'modprobe pata_qdi' after reboot and my system just froze, no more
output afterwards to /var/log/messages. Had to hard reset the machine.

The system I tried it on is an out-of-the-box Mandriva 2007.
.config can be supplied on demand.

KR

Tom


