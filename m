Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTKWTx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTKWTx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:53:27 -0500
Received: from attila.bofh.it ([213.92.8.2]:63184 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S263441AbTKWTxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:53:25 -0500
Date: Sun, 23 Nov 2003 20:41:05 +0100
From: "Marco d'Itri" <md@Linux.IT>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Len Brown <len.brown@intel.com>, Andi Kleen <ak@muc.de>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
Message-ID: <20031123194105.GA1766@wonderland.linux.it>
References: <20031123185253.GA1986@wonderland.linux.it> <Pine.LNX.4.44.0311231056070.17378-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311231056070.17378-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, Linus Torvalds <torvalds@osdl.org> wrote:

 >Also, Marco, it might actually be a VIA IDE driver bug, that leaves the 
 >interrupt on during setup somewhere (and the bug just doesn't matter when 
 >the IRQ is edge-triggered). So it would be interesting to know what 
 >happens if you disable the VIA-specific IDE support...
Nothing I can see.
I will now open a bugzilla ticket as requested by Len.

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VIA8237SATA: IDE controller at PCI slot 0000:00:0f.0
VIA8237SATA: chipset revision 128
VIA8237SATA: 100%% native mode on irq 3
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 6Y080P0, ATA DISK drive
hdb: MAXTOR 6L040J2, ATA DISK drive
hdc: CD-ROM 50X, ATAPI CD/DVD-ROM drive
hdd: 32X10, ATAPI CD/DVD-ROM drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Badness in request_irq at arch/i386/kernel/irq.c:572
Call Trace:
 [<c0219c30>] ide_intr+0x0/0x130
 [<c010ae0c>] request_irq+0xcc/0x100
 [<c021b1c6>] init_irq+0x156/0x400
 [<c0219c30>] ide_intr+0x0/0x130
 [<c021b858>] hwif_init+0xb8/0x250
 [<c01753c0>] init_file+0x0/0x20
 [<c021bae4>] ideprobe_init+0xf4/0x106
 [<c0398c7d>] ide_init_builtin_drivers+0xd/0x20
 [<c0398cd8>] ide_init+0x48/0x70
 [<c038679b>] do_initcalls+0x2b/0xa0
 [<c01285b2>] init_workqueues+0x12/0x60
 [<c010509c>] init+0x2c/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

irq 15: nobody cared!
Call Trace:
 [<c010aa3b>] __report_bad_irq+0x2b/0x90
 [<c010ab34>] note_interrupt+0x64/0xa0
 [<c010ad3a>] do_IRQ+0xea/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c011ddc4>] do_softirq+0x44/0xa0
 [<c010ad21>] do_IRQ+0xd1/0xf0
 [<c01092a0>] common_interrupt+0x18/0x20
 [<c010b144>] setup_irq+0x64/0xb0
 [<c0219c30>] ide_intr+0x0/0x130
 [<c010adc9>] request_irq+0x89/0x100
 [<c021b1c6>] init_irq+0x156/0x400
 [<c0219c30>] ide_intr+0x0/0x130
 [<c021b858>] hwif_init+0xb8/0x250
 [<c01753c0>] init_file+0x0/0x20
 [<c021bae4>] ideprobe_init+0xf4/0x106
 [<c0398c7d>] ide_init_builtin_drivers+0xd/0x20
 [<c0398cd8>] ide_init+0x48/0x70
 [<c038679b>] do_initcalls+0x2b/0xa0
 [<c01285b2>] init_workqueues+0x12/0x60
 [<c010509c>] init+0x2c/0x110
 [<c0105070>] init+0x0/0x110
 [<c01072a9>] kernel_thread_helper+0x5/0xc

handlers:
[<c0219c30>] (ide_intr+0x0/0x130)
Disabling IRQ #15
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 160086528 sectors (81964 MB) w/7936KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 >
hdb: max request size: 128KiB
hdb: 78177792 sectors (40027 MB) w/1820KiB Cache, CHS=65535/16/63
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 >

-- 
ciao, |
Marco | [3238 gere5SFl/jVj6]
