Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTKWSxI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 13:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTKWSxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 13:53:08 -0500
Received: from attila.bofh.it ([213.92.8.2]:54984 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263388AbTKWSxB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 13:53:01 -0500
Date: Sun, 23 Nov 2003 19:52:53 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@muc.de>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123185253.GA1986@wonderland.linux.it>
References: <20031123114055.GA1844@wonderland.linux.it> <Pine.LNX.4.44.0311230829270.17378-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311230829270.17378-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, Linus Torvalds <torvalds@osdl.org> wrote:

 >On Sun, 23 Nov 2003, Marco d'Itri wrote:
 >> 
 >> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 >> hdc: IRQ probe failed (0x3cfa: 0). Guessing at 15
 >> hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
 >> hdd: 32X10, ATAPI CD/DVD-ROM drive
 >> Badness in request_irq at arch/i386/kernel/irq.c:572
 >> Call Trace:
 >>  [<c021a770>] ide_intr+0x0/0x130
 >
 >There was nothing before this?
 >
 >The probe failed _before_ the first warning?
Yes.

 >Does this one make a difference?
No:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100%% native mode on irq 3
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
VP_IDE: chipset revision 6
VP_IDE: not 100%% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9400-0x9407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9408-0x940f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: 32X10, ATAPI CD/DVD-ROM drive
Badness in request_irq at arch/i386/kernel/irq.c:572
Call Trace:
 [<c021a770>] ide_intr+0x0/0x130
 [<c010acfc>] request_irq+0xcc/0x100
 [<c021bd06>] init_irq+0x156/0x400
 [<c021a770>] ide_intr+0x0/0x130
 [<c021c398>] hwif_init+0xb8/0x250
 [<c021b9cc>] probe_hwif_init+0x2c/0x80
 [<c022769a>] ide_setup_pci_device+0x7a/0x80
 [<c021906d>] via_init_one+0x3d/0x50
 [<c039791d>] ide_scan_pcidev+0x5d/0x70
 [<c0397976>] ide_scan_pcibus+0x46/0xd0
 [<c0397823>] probe_for_hwifs+0x13/0x20
 [<c0397838>] ide_init_builtin_drivers+0x8/0x20
 [<c0397898>] ide_init+0x48/0x70
 [<c038674b>] do_initcalls+0x2b/0xa0
 [<c01278f2>] init_workqueues+0x12/0x60
 [<c0105097>] init+0x27/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

irq 15: nobody cared!
Call Trace:
 [<c010a92b>] __report_bad_irq+0x2b/0x90
 [<c010aa24>] note_interrupt+0x64/0xa0
 [<c010ac2a>] do_IRQ+0xea/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c011d104>] do_softirq+0x44/0xa0
 [<c010ac11>] do_IRQ+0xd1/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c010b034>] setup_irq+0x64/0xb0
 [<c021a770>] ide_intr+0x0/0x130
 [<c010acb9>] request_irq+0x89/0x100
 [<c021bd06>] init_irq+0x156/0x400
 [<c021a770>] ide_intr+0x0/0x130
 [<c021c398>] hwif_init+0xb8/0x250
 [<c021b9cc>] probe_hwif_init+0x2c/0x80
 [<c022769a>] ide_setup_pci_device+0x7a/0x80
 [<c021906d>] via_init_one+0x3d/0x50
 [<c039791d>] ide_scan_pcidev+0x5d/0x70
 [<c0397976>] ide_scan_pcibus+0x46/0xd0
 [<c0397823>] probe_for_hwifs+0x13/0x20
 [<c0397838>] ide_init_builtin_drivers+0x8/0x20
 [<c0397898>] ide_init+0x48/0x70
 [<c038674b>] do_initcalls+0x2b/0xa0
 [<c01278f2>] init_workqueues+0x12/0x60
 [<c0105097>] init+0x27/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

handlers:
[<c021a770>] (ide_intr+0x0/0x130)
Disabling IRQ #15
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=65535/16/63, UDMA(133)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >

-- 
ciao, |
Marco | [3237 agt8As3FpLsEE]
