Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSJABMY>; Mon, 30 Sep 2002 21:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSJABMY>; Mon, 30 Sep 2002 21:12:24 -0400
Received: from mesatop.zianet.com ([216.234.192.105]:32526 "HELO
	mesatop.zianet.com") by vger.kernel.org with SMTP
	id <S261425AbSJABMX>; Mon, 30 Sep 2002 21:12:23 -0400
Subject: 2.5.39 Oops on boot (device_attach+0x3a)
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 30 Sep 2002 19:13:02 -0600
Message-Id: <1033434784.3100.10.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to boot 2.5.39 on my home machine and got the
following oops on boot with CONFIG_KALLSYMS=y (thanks Ingo!).

*pde = 00000000
Oops: 0002

CPU:	0
EIP:	0060:[<c01a7979>]	Not tainted
EFLAGS:	00010286
EIP is at attach+0x1d/0x30
eax: c0276724	ebx: 00000000	ecx: c40c8060	edx: c40c8078
esi: c0276700	edi: 00000000	ebp: 00000000	esp: c40ddf94
ds:  0068 	es: 0068	ss: 0068
Process swapper (pid: 1, threadinfo=c40dc000 task=c40da040)
Stack: 00000000 c01a7a5a c40c8060 c40c8060 c01a7c20 c40c8060 c40c8060 c40c8060
       c40d7720 c028b879 c40c8060 00000001 c02b9bf4 00000000 00000000 00000000
       c027e6f2 c0105030 c010504c c0105030 00000000 00000000 00000000 c0105495
Call Trace:
[<c01a7a5a>] device_attach+0x3a/0x40
[<c01a7c20>] device_register+0xd0/0x120
[<c0105030>] init+0x0/0x160
[<c010504c>] init+0x1c/0x160
[<c0105030>] init+0x0/0x160
[<c0105495>] kernel_thread_helper+0x5/0x10

Code: 89 13 89 4c 24 08 5b e9 37 0d 00 00 8d b4 26 00 00 00 00 57
Spurious 8959A interrupt: IRQ7
Kernel panic: Attempted to kill init!

The "Spurious 8959A interrupt" message occurred only once among several
boot attempts with slightly differently configured kernels (taking more and more
stuff out like sound and usb).  The traceback was the same each time however.

The box is a Gateway P450 single PIII with Jabil motherboard.  I have a 
Promise Ultra/66 disk controller installed.  Support for the 20262 was 
compiled into 2.5.39 with CONFIG_BLK_DEV_PDC202XX_OLD=y and CONFIG_BLK_DEV_PDC202XX=y.
Support for the PIIX4 was provided with CONFIG_BLK_DEV_PIIX=y.  
I tried booting with the onboard IDE and then the PDC20262 with the same oops above.
Either of those work with 2.4.x kernels.

Here is a snippet from dmesg from a normal 2.4.18 boot:

fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at port 0x02f8 (irq = 10) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide1: BM-DMA at 0x1428-0x142f, BIOS settings: hdc:DMA, hdd:pio
PDC20262: IDE controller on PCI bus 00 dev 78
PCI: Found IRQ 5 for device 00:0f.0
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide0: BM-DMA at 0x10c0-0x10c7, BIOS settings: hda:DMA, hdb:DMA
    ide2: BM-DMA at 0x10c8-0x10cf, BIOS settings: hde:DMA, hdf:pio
hda: ST330620A, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8584A, ATAPI CD/DVD-ROM drive
ide0 at 0x1440-0x1447,0x1436 on irq 5
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(66)
hdc: ATAPI 32X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12

Steven


