Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbTAYUZC>; Sat, 25 Jan 2003 15:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262190AbTAYUZC>; Sat, 25 Jan 2003 15:25:02 -0500
Received: from web20501.mail.yahoo.com ([216.136.226.136]:12328 "HELO
	web20501.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262089AbTAYUY6>; Sat, 25 Jan 2003 15:24:58 -0500
Message-ID: <20030125203413.90667.qmail@web20501.mail.yahoo.com>
Date: Sat, 25 Jan 2003 12:34:13 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: FW: PDC202XX DMA loss in 2.4.21-pre3-ac4
To: linux-kernel@vger.kernel.org
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1D07@xch-b.win.zambeel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

0xd0 indicates that the driver aborted the command.
Can you try to get the SMART data from the drive using
smartctl?

use "smartctl -e /dev/hdX" to enable SMART collection

use "smartctl -a /dev/hdX" to collect the SMART data
...

Thanks
Manish

> I'm sending this out now to see if others are
> noticing the same problem.
> 
> Under heavy disk IO I'm loosing DMA on a disk disk
> is being handled by 
> the new PDC202XX driver.  The HD controller is a
> PDC20269 based 
> controler like those in the Maxtor HD/Controller
> bundles.  Sofar it has 
> lost DMA 4 times under heavy loads when multiple
> disks are being 
> accessed at once.  It appears to lose DMA at a
> random point durring 
> heavy disk IO.  It has gone hours before it happened
> to lasting less 
> than 30 minutes.  I'm doing a test over night to see
> if it happens when 
> it is the only disk being accessed heavily.  My
> first guess is it is 
> dropping a DMA finish interrupt then failing when it
> tries to set one up 
> again but I'm not sure on that.  The other idea I
> had is that when the 
> code is trying to get a DMA channel all are in use
> and it fails.  Any 
> help on what to look into would be appreciated.
> 
> Jan 24 22:41:14 blip kernel: hde: dma_intr:
> status=0xd0 { Busy }
> Jan 24 22:41:14 blip kernel:
> Jan 24 22:41:14 blip kernel: hde: DMA disabled
> Jan 24 22:41:14 blip kernel: PDC202XX: Primary
> channel reset.
> Jan 24 22:41:14 blip kernel: ide2: reset: success
> 
> The mother board is an ASUS A7N8X and it has
> assigned ide2, ide2 (both
> controllers on the Promices card), the nVidia sound,
> and the display to
> the same interrupt.  I've was trying to see if that
> was the problem but
> dissabling other devices didn't seam to help.  It
> still happened.
> 
> The PDC20269 controller has one Maxtor 4G160J8
> (160GB) disk per channel 
> and each is jumpered to be master.  (hdparm -I
> ouputs below)  I've also 
> added in the current dmesg output, and a cat of
> /proc/interrupts.
> 
> ---------------------
> # dmesg
> Linux version 2.4.21-pre3-ac4 (root@blip) (gcc
> version 2.95.4 20011002 
> (Debian prerelease)) #21 SMP Sun Jan 19 13:54:23 CST
> 2003
> BIOS-provided physical RAM map:
>   BIOS-e820: 0000000000000000 - 000000000009e800
> (usable)
>   BIOS-e820: 000000000009e800 - 00000000000a0000
> (reserved)
>   BIOS-e820: 00000000000f0000 - 0000000000100000
> (reserved)
>   BIOS-e820: 0000000000100000 - 000000001fff0000
> (usable)
>   BIOS-e820: 000000001fff0000 - 000000001fff3000
> (ACPI NVS)
>   BIOS-e820: 000000001fff3000 - 0000000020000000
> (ACPI data)
>   BIOS-e820: 00000000fec00000 - 00000000fec01000
> (reserved)
>   BIOS-e820: 00000000fee00000 - 00000000fee01000
> (reserved)
>   BIOS-e820: 00000000ffff0000 - 0000000100000000
> (reserved)
> 511MB LOWMEM available.
> On node 0 totalpages: 131056
> zone(0): 4096 pages.
> zone(1): 126960 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=Linux ro
> root=302 ide0=ata66 ide1=ata66
> ide_setup: ide0=ata66
> ide_setup: ide1=ata66
> Found and enabled local APIC!
> Initializing CPU#0
> Detected 1737.306 MHz processor.
> Console: colour VGA+ 80x25
> Calibrating delay loop... 3460.30 BogoMIPS
> Memory: 515228k/524224k available (1600k kernel
> code, 8604k reserved, 
> 676k data, 112k init, 0k highmem)
> Dentry cache hash table entries: 65536 (order: 7,
> 524288 bytes)
> Inode cache hash table entries: 32768 (order: 6,
> 262144 bytes)
> Mount cache hash table entries: 512 (order: 0, 4096
> bytes)
> Buffer cache hash table entries: 32768 (order: 5,
> 131072 bytes)
> Page-cache hash table entries: 131072 (order: 7,
> 524288 bytes)
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
> (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU:     After generic, caps: 0383fbff c1c3fbff
> 00000000 00000000
> CPU:             Common caps: 0383fbff c1c3fbff
> 00000000 00000000
> Enabling fast FPU save and restore... done.
> Enabling unmasked SIMD FPU exception support...
> done.
> Checking 'hlt' instruction... OK.
> POSIX conformance testing by UNIFIX
> mtrr: v1.40 (20010327) Richard Gooch
> (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: Intel
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K
> (64 bytes/line)
> CPU: L2 Cache: 256K (64 bytes/line)
> CPU:     After generic, caps: 0383fbff c1c3fbff
> 00000000 00000000
> CPU:             Common caps: 0383fbff c1c3fbff
> 00000000 00000000
> CPU0: AMD Athlon(tm) XP 2100+ stepping 02
> per-CPU timeslice cutoff: 731.30 usecs.
> task migration cache decay timeout: 10 msecs.
> SMP motherboard not detected.
> enabled ExtINT on CPU#0
> ESR value before enabling vector: 00000000
> ESR value after enabling vector: 00000000
> Using local APIC timer interrupts.
> calibrating APIC timer ...
> ..... CPU clock speed is 1737.2981 MHz.
> ..... host bus clock speed is 267.2766 MHz.
> cpu: 0, clocks: 2672766, slice: 1336383
> CPU0<T0:2672752,T1:1336368,D:1,S:1336383,C:2672766>
> migration_task 0 on cpu=0
> PCI: PCI BIOS revision 2.10 entry at 0xfb560, last
> bus=3
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router default [10de/01e0] at 00:00.0
> isapnp: Scanning for PnP cards...
> isapnp: No Plug & Play device found
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society
> NET3.039
> Initializing RT netlink socket
> Starting kswapd
> Journalled Block Device driver loaded
> Installing knfsd (copyright (C) 1996
> okir@monad.swb.de).
> parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
> parport0: irq 7 detected
> i2c-core.o: i2c core module
> i2c-dev.o: i2c /dev entries driver module
> i2c-core.o: driver i2c-dev dummy driver registered.
> i2c-proc.o version 2.6.1 (20010825)
> pty: 256 Unix98 ptys configured
> Serial driver version 5.05c (2001-07-08) with
> MANY_PORTS SHARE_IRQ 
> SERIAL_PCI ISAPNP enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> Real Time Clock Driver v1.10e
> Floppy drive(s): fd0 is 1.44M
> FDC 0 is a post-1991 82077
> RAMDISK driver initialized: 16 RAM disks of 4096K
> size 1024 blocksize
> loop: loaded (max 8 devices)
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory:
> 439M
> agpgart: unsupported bridge
> agpgart: no supported devices found.
> Uniform Multi-Platform E-IDE driver Revision:
> 7.00beta-2.4
> ide: Assuming 33MHz system bus speed for PIO modes;
> override with idebus=xx
> NFORCE2: IDE controller at PCI slot 00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
>      ide0: BM-DMA at 0xf000-0xf007, BIOS settings:
> hda:DMA, hdb:DMA
>      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings:
> hdc:DMA, hdd:DMA
> PDC20269: IDE controller at PCI slot 01:07.0
> PDC20269: chipset revision 2
> PDC20269: not 100% native mode: will probe irqs
> later
> 
=== message truncated ===


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
