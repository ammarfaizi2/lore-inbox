Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266438AbUAIIfZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 03:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUAIIfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 03:35:24 -0500
Received: from fire.hoosac.com ([65.246.191.2]:61913 "EHLO fire.hoosac.com")
	by vger.kernel.org with ESMTP id S266438AbUAIIfQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 03:35:16 -0500
Date: Fri, 9 Jan 2004 03:35:15 -0500
From: Patrick Cole <z@amused.net>
To: Markus Kossmann <markus.kossmann@inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0:  Disabling IRQ #9 - 2nd
Message-ID: <20040109083515.GA5599@fire.hoosac.com>
References: <200401090839.38733.markus.kossmann@inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <200401090839.38733.markus.kossmann@inka.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar thing on our Tyan Opteron board.  It seems to be
right after the initialisation of the AMD 8111 IDE controller:

AMD8111: IDE controller at PCI slot 0000:00:07.1                                                         AMD8111: chipset revision 3                                                                              AMD8111: not 100% native mode: will probe irqs later                                                     ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx                              AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller                                                            ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio                                           ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA                                       irq 9: nobody cared!                                                                                     Call Trace:                                                                                               [<c010c86b>] __report_bad_irq+0x2b/0x90                                                                  [<c0383eb5>] acpi_irq+0xf/0x1a                                                                           [<c010c964>] note_interrupt+0x64/0xa0                                                                    [<c010cc95>] do_IRQ+0x165/0x1a0                                                                          [<c0105000>] _stext+0x0/0x70                                                                             [<c010af0c>] common_interrupt+0x18/0x20
 [<c0108040>] default_idle+0x0/0x40
 [<c0105000>] _stext+0x0/0x70
 [<c010806f>] default_idle+0x2f/0x40
 [<c01080fb>] cpu_idle+0x3b/0x50
 [<c066e901>] start_kernel+0x1a1/0x1f0
 [<c066e4a0>] unknown_bootoption+0x0/0x100
 
handlers:
[<c0383ea6>] (acpi_irq+0x0/0x1a)
Disabling IRQ #9
hdd: ATAPI-CD ROM-DRIVE-52MAX, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)


Fri, Jan 09, 2004 at 08:39:38AM +0100, Markus Kossmann wrote:

> When I run 2.60 on my PC with Tyan S2462 (AMD 762 MP)  motherboard 
> I allways get after some time the message "Disabling IRQ #9"
> and the following messages in the syslog :
> Jan  8 20:30:44 emil3 kernel: irq 9: nobody cared!
> Jan  8 20:30:44 emil3 kernel: Call Trace:
> Jan  8 20:30:44 emil3 kernel:  [__report_bad_irq+42/144] __report_bad_irq
> +0x2a/0
> x90
> Jan  8 20:30:44 emil3 kernel:  [<c010e8ca>] __report_bad_irq+0x2a/0x90
> Jan  8 20:30:44 emil3 kernel:  [note_interrupt+149/192] note_interrupt
> +0x95/0xc0
> Jan  8 20:30:44 emil3 kernel:  [<c010e9e5>] note_interrupt+0x95/0xc0
> Jan  8 20:30:44 emil3 kernel:  [do_IRQ+278/320] do_IRQ+0x116/0x140
> Jan  8 20:30:44 emil3 kernel:  [<c010ec96>] do_IRQ+0x116/0x140
> Jan  8 20:30:44 emil3 kernel:  [common_interrupt+24/32] common_interrupt
> +0x18/0x
> 20
> Jan  8 20:30:44 emil3 kernel:  [<c010ce1c>] common_interrupt+0x18/0x20
> Jan  8 20:30:44 emil3 kernel:  [do_softirq+93/224] do_softirq+0x5d/0xe0
> Jan  8 20:30:44 emil3 kernel:  [<c012c19d>] do_softirq+0x5d/0xe0
> Jan  8 20:30:44 emil3 kernel:  [do_IRQ+285/320] do_IRQ+0x11d/0x140
> Jan  8 20:30:44 emil3 kernel:  [<c010ec9d>] do_IRQ+0x11d/0x140
> Jan  8 20:30:44 emil3 kernel:  [common_interrupt+24/32] common_interrupt
> +0x18/0x
> 20
> Jan  8 20:30:44 emil3 kernel:  [<c010ce1c>] common_interrupt+0x18/0x20
> Jan  8 20:30:44 emil3 kernel:  [default_idle+0/64] default_idle+0x0/0x40
> Jan  8 20:30:44 emil3 kernel:  [<c010a030>] default_idle+0x0/0x40
> Jan  8 20:30:44 emil3 kernel:  [default_idle+41/64] default_idle+0x29/0x40
> Jan  8 20:30:44 emil3 kernel:  [<c010a059>] default_idle+0x29/0x40
> Jan  8 20:30:44 emil3 kernel:  [cpu_idle+52/80] cpu_idle+0x34/0x50
> Jan  8 20:30:44 emil3 kernel:  [<c010a0e4>] cpu_idle+0x34/0x50
> Jan  8 20:30:44 emil3 kernel:  [printk+393/416] printk+0x189/0x1a0
> Jan  8 20:30:44 emil3 kernel:  [<c01288a9>] printk+0x189/0x1a0
> Jan  8 20:30:44 emil3 kernel:
> Jan  8 20:30:44 emil3 kernel: handlers:
> Jan  8 20:30:44 emil3 kernel: [acpi_irq+0/22] (acpi_irq+0x0/0x16)
> Jan  8 20:30:44 emil3 kernel: [<c01fb426>] (acpi_irq+0x0/0x16)
> Jan  8 20:30:44 emil3 kernel: Disabling IRQ #9
> 
> 
> What can I do to fix that problem  ? 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
