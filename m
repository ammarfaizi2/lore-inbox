Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVFWNwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVFWNwa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVFWNwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:52:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54732 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262594AbVFWNv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:51:56 -0400
Date: Thu, 23 Jun 2005 15:53:18 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: SMP+irq handling broken in current git?
Message-ID: <20050623135318.GC9768@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Something strange is going on with current git as of this morning (head
ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
800MHz), using the same old config I always do on this box has very
broken interrupt handling:

[...]

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALLP AS40.0, ATA DISK drive
hdb: IOMEGA DVDRW8824E2Q-D, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IBM-DTLA-307030, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
irq 14: nobody cared!
 [<c01039e7>] dump_stack+0x17/0x20
 [<c0134ec7>] __report_bad_irq+0x27/0x90
 [<c0134fd2>] note_interrupt+0x72/0x90
 [<c01349cb>] __do_IRQ+0x11b/0x130
 [<c0104f9c>] do_IRQ+0x1c/0x30
 [<c01034ca>] common_interrupt+0x1a/0x20
 [<c0100a9c>] cpu_idle+0x6c/0x80
 [<c040c97a>] start_kernel+0x14a/0x170
 [<c010020e>] 0xc010020e
handlers:
[<c02d12b0>] (ide_intr+0x0/0x150)
Disabling IRQ #14
irq 15: nobody cared!
 [<c01039e7>] dump_stack+0x17/0x20
 [<c0134ec7>] __report_bad_irq+0x27/0x90
 [<c0134fd2>] note_interrupt+0x72/0x90
 [<c01349cb>] __do_IRQ+0x11b/0x130
 [<c0104f9c>] do_IRQ+0x1c/0x30
 [<c01034ca>] common_interrupt+0x1a/0x20
 [<c0100a9c>] cpu_idle+0x6c/0x80
 [<c040c97a>] start_kernel+0x14a/0x170
 [<c010020e>] 0xc010020e
handlers:
[<c02d12b0>] (ide_intr+0x0/0x150)
Disabling IRQ #15
hda: max request size: 128KiB
hda: lost interrupt
hda: lost interrupt
hda: 78177792 sectors (40027 MB) w/1902KiB Cache, CHS=65535/16/63,
UDMA(33)
hda: cache flushes not supported
 hda:<4>hda: dma_timer_expiry: dma status == 0x64
hda: DMA interrupt recovery
hda: lost interrupt
 hda1 hda2 hda3 hda4
hdc: max request size: 128KiB
irq 14: nobody cared!
 [<c01039e7>] dump_stack+0x17/0x20
 [<c0134ec7>] __report_bad_irq+0x27/0x90
 [<c0134fd2>] note_interrupt+0x72/0x90
 [<c01349cb>] __do_IRQ+0x11b/0x130
 [<c0104f9c>] do_IRQ+0x1c/0x30
 [<c01034ca>] common_interrupt+0x1a/0x20
 [<c0100a9c>] cpu_idle+0x6c/0x80
 [<c040c97a>] start_kernel+0x14a/0x170
 [<c010020e>] 0xc010020e
handlers:
[<c02d12b0>] (ide_intr+0x0/0x150)
Disabling IRQ #14
hdc: lost interrupt

Going to UP makes it work just fine for me. Does anyone know what is
going on here?!

-- 
Jens Axboe

