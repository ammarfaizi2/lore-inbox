Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSJAL3K>; Tue, 1 Oct 2002 07:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJAL3K>; Tue, 1 Oct 2002 07:29:10 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:8465 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261583AbSJAL3I>; Tue, 1 Oct 2002 07:29:08 -0400
Message-ID: <3D99885B.533C320D@aitel.hist.no>
Date: Tue, 01 Oct 2002 13:34:51 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.39 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.39 "Sleeping function called from illegal context at slab.c:1374"
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get two of these during bootup of 2.5.39 UP, preempt
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MPB3032ATU, ATA DISK drive
hdb: CD-ROM 32X/AKU, ATAPI CD/DVD-ROM drive
Sleeping function called from illegal context at slab.c:1374
c12b3ec4 c01146c4 c02801a0 c0284429 0000055e 000001d0 c012dca0 c0284429 
       0000055e c039a390 c01d1b84 04000000 c039a390 c010915f 00000018
000001d0 
       c039a390 c039a380 cfe0e2c0 04000000 c01cb617 0000000e c01d1b84
04000000 
Call Trace:
 [<c01146c4>]__might_sleep+0x54/0x60
 [<c012dca0>]kmalloc+0x4c/0x130
 [<c01d1b84>]ide_intr+0x0/0x17c
 [<c010915f>]request_irq+0x53/0xa8
 [<c01cb617>]init_irq+0x1e7/0x338
 [<c01d1b84>]ide_intr+0x0/0x17c
 [<c01cbaa6>]hwif_init+0x112/0x258
 [<c01cb31c>]probe_hwif_init+0x1c/0x6c
 [<c01d789d>]ide_setup_pci_device+0x3d/0x68
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: WDC WD200BB-00CAA0, ATA DISK drive


And a little later:

hdb: ATAPI 20X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
NTFS driver 2.1.0 [Flags: R/O MODULE].
NTFS volume version 1.2.
Sleeping function called from illegal context at slab.c:1374
ca93bf6c c01146c4 c02801a0 c0284429 0000055e 000001d0 c012dca0 c0284429 
       0000055e 00000000 00000400 bffffdd4 caae8a60 c010b6b2 00000080
000001d0 
       ca93a000 00000100 bffffdd4 bffffcdc 00000000 c0106fbb 00000000
00000400 
Call Trace:
 [<c01146c4>]__might_sleep+0x54/0x60
 [<c012dca0>]kmalloc+0x4c/0x130
 [<c010b6b2>]sys_ioperm+0x82/0x11c
 [<c0106fbb>]syscall_call+0x7/0xb

MTRR: setting reg 2
MTRR: setting reg 2
MTRR: setting reg 2
Uniform CD-ROM driver unloaded
devfs_dealloc_unique_number(): number 0 was already free

Helge Hafting
