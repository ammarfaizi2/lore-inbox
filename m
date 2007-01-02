Return-Path: <linux-kernel-owner+w=401wt.eu-S932663AbXABHBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbXABHBr (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 02:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbXABHBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 02:01:47 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:39802 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbXABHBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 02:01:46 -0500
Date: Tue, 2 Jan 2007 08:01:45 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: problem with pata_hpt37x ...
Message-ID: <20070102070144.GA11270@MAIL.13thfloor.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-ide@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jeff! Alan!

today I decided to put a (granted somewhat older)
RocketRAID 454 card (hpt374 as it seems) into an
Asus P5B (which already has some controllers using
libata quite happily), and it seems that the driver
support is not perfect yet :)

note: the older hpt366 (ide) driver works quite
fine with the hpt374 controller, even under heavy
load (as I figured an hour ago) and I remembered
that there was some efford to get away from the
'old' ide drivers ...

here are the details:

[    0.000000] Linux version 2.6.19.1 (gcc version 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #10 SMP Tue Jan 2 15:13:40 CET 2007
[    0.000000] Command line: root=/dev/sda1 panic=20 console=ttyS0,115200n8

[  552.115825] irq 23: nobody cared (try booting with the "irqpoll" option)
[  552.122730] 
[  552.122731] Call Trace:
[  552.126795]  [<ffffffff8026403e>] dump_trace+0xaa/0x403
[  552.132169]  [<ffffffff802643d3>] show_trace+0x3c/0x52
[  552.137488]  [<ffffffff802643fe>] dump_stack+0x15/0x17
[  552.142748]  [<ffffffff802a4ddb>] __report_bad_irq+0x38/0x87
[  552.148589]  [<ffffffff802a4ff3>] note_interrupt+0x1c9/0x20f
[  552.154383]  [<ffffffff802a5868>] handle_fasteoi_irq+0xa7/0xd0
[  552.160321]  [<ffffffff80265cc3>] do_IRQ+0x105/0x158
[  552.165416]  [<ffffffff80258641>] ret_from_intr+0x0/0xa
[  552.170771]  [<ffffffff80263840>] mwait_idle_with_hints+0x48/0x4a
[  552.177035]  [<ffffffff80251ce1>] mwait_idle+0x10/0x25
[  552.182303]  [<ffffffff80244586>] cpu_idle+0x58/0x77
[  552.187433]  [<ffffffff80263079>] rest_init+0x26/0x28
[  552.192640]  [<ffffffff80620725>] start_kernel+0x213/0x215
[  552.198256]  [<ffffffff80620156>] _sinittext+0x156/0x15d
[  552.203730] 
[  552.205263] handlers:
[  552.207611] [<ffffffff803e5469>] (usb_hcd_irq+0x0/0x58)
[  552.213027] [<ffffffff803e5469>] (usb_hcd_irq+0x0/0x58)
[  552.218451] [<ffffffff8803ba13>] (ata_interrupt+0x0/0x1a0 [libata])
[  552.224915] [<ffffffff8803ba13>] (ata_interrupt+0x0/0x1a0 [libata])
[  552.231387] Disabling IRQ #23

after that, the system is basically dead, as the
irq is shared with the USB controller, where it
booted from ...

shufflings cards around (i.e. giving the hpt374 a
separate, non shared IRQ line) doesn't help there,
the result is the same once the devices are accessed
(only IRQ changes from #23 to #21)

if you are interested in investigating this, please
let me know what kind of data you would like to see
and/or what kind of tests would be appreciated.

TIA,
Herbert

