Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUBCJ77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 04:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265948AbUBCJ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 04:59:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:21926 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265947AbUBCJ7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 04:59:15 -0500
X-Authenticated: #4512188
Message-ID: <401F70E1.5070408@gmx.de>
Date: Tue, 03 Feb 2004 10:58:57 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc3-mm1
References: <20040202235817.5c3feaf3.akpm@osdl.org>
In-Reply-To: <20040202235817.5c3feaf3.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------030906090408000805060508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030906090408000805060508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am getting this on init. I think while udev inits:

i_size_write() called without i_sem
Feb  3 10:53:53 tachyon Call Trace:
Feb  3 10:53:53 tachyon [<c013d347>] i_size_write_check+0x57/0x60
Feb  3 10:53:53 tachyon [<c01767de>] simple_commit_write+0x3e/0xa0
Feb  3 10:53:53 tachyon [<c0167f3c>] page_symlink+0xec/0x1dd
Feb  3 10:5i_size_write() called without i_sem
Feb  3 10:53:53 tachyon Call Trace:
Feb  3 10:53:53 tachyon [<c013d347>] i_size_write_check+0x57/0x60
Feb  3 10:53:53 tachyon [<c01767de>] simple_commit_write+0x3e/0xa0
Feb  3 10:53:53 tachyon [<c0167f3c>] page_symlink+0xec/0x1dd
Feb  3 10:53:53 tachyon [<c01bbbdd>] ramfs_symlink+0x5d/0xc0
Feb  3 10:53:53 tachyon [<c0166e37>] vfs_symlink+0x57/0xb0
Feb  3 10:53:53 tachyon [<c0166f63>] sys_symlink+0xd3/0xf0
Feb  3 10:53:53 tachyon [<c038fa86>] sysenter_past_esp+0x43/0x65
3:53 tachyon [<c01bbbdd>] ramfs_symlink+0x5d/0xc0
Feb  3 10:53:53 tachyon [<c0166e37>] vfs_symlink+0x57/0xb0
Feb  3 10:53:53 tachyon [<c0166f63>] sys_symlink+0xd3/0xf0
Feb  3 10:53:53 tachyon [<c038fa86>] sysenter_past_esp+0x43/0x65

This appears about 10 times. I haven't teste the kernel further.

.config attached

dmesg:

Feb  3 10:53:53 tachyon Linux version 2.6.2-rc3-mm1 (root@tachyon) 
(gcc-Version 3.3.2 20031218 (Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #2 
Tue Feb 3 10:35:35 CET 2004
Feb  3 10:53:53 tachyon BIOS-provided physical RAM map:
Feb  3 10:53:53 tachyon BIOS-e820: 0000000000000000 - 000000000009f800 
(usable)
Feb  3 10:53:53 tachyon BIOS-e820: 000000000009f800 - 00000000000a0000 
(reserved)
Feb  3 10:53:53 tachyon BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Feb  3 10:53:53 tachyon BIOS-e820: 0000000000100000 - 000000003fff0000 
(usable)
Feb  3 10:53:53 tachyon BIOS-e820: 000000003fff0000 - 000000003fff3000 
(ACPI NVS)
Feb  3 10:53:53 tachyon BIOS-e820: 000000003fff3000 - 0000000040000000 
(ACPI data)
Feb  3 10:53:53 tachyon BIOS-e820: 00000000fec00000 - 00000000fec01000 
(reserved)
Feb  3 10:53:53 tachyon BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
Feb  3 10:53:53 tachyon BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Feb  3 10:53:53 tachyon 127MB HIGHMEM available.
Feb  3 10:53:53 tachyon 896MB LOWMEM available.
Feb  3 10:53:53 tachyon zapping low mappings.
Feb  3 10:53:53 tachyon On node 0 totalpages: 262128
Feb  3 10:53:53 tachyon DMA zone: 4096 pages, LIFO batch:1
Feb  3 10:53:53 tachyon Normal zone: 225280 pages, LIFO batch:16
Feb  3 10:53:53 tachyon HighMem zone: 32752 pages, LIFO batch:7
Feb  3 10:53:53 tachyon DMI 2.2 present.
Feb  3 10:53:53 tachyon ACPI: RSDP (v000 Nvidia 
            ) @ 0x000f6b80
Feb  3 10:53:53 tachyon ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3000
Feb  3 10:53:53 tachyon ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff3040
Feb  3 10:53:53 tachyon ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 
0x00000000) @ 0x3fff79c0
Feb  3 10:53:53 tachyon ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 
0x0100000d) @ 0x00000000
Feb  3 10:53:53 tachyon ACPI: PM-Timer IO Port: 0x4008
Feb  3 10:53:53 tachyon Built 1 zonelists
Feb  3 10:53:53 tachyon current: c03f9a60
Feb  3 10:53:53 tachyon current->thread_info: c047e000
Feb  3 10:53:53 tachyon Initializing CPU#0
Feb  3 10:53:53 tachyon Kernel command line: root=/dev/sda7 
devfs=nomount vga=0x51A video=vesa:mtrr,ywrap elevator=cfq doataraid 
noraid hdb=none hdg=none splash=verbose resume2=swap:/dev/hde5
Feb  3 10:53:53 tachyon ide_setup: hdb=none
Feb  3 10:53:53 tachyon ide_setup: hdg=none
Feb  3 10:53:53 tachyon PID hash table entries: 4096 (order 12: 32768 bytes)
Feb  3 10:53:53 tachyon Detected 2104.938 MHz processor.
Feb  3 10:53:53 tachyon Using pmtmr for high-res timesource
Feb  3 10:53:53 tachyon Console: colour dummy device 80x25
Feb  3 10:53:53 tachyon Memory: 1032924k/1048512k available (2623k 
kernel code, 14668k reserved, 950k data, 156k init, 131008k highmem)
Feb  3 10:53:53 tachyon Calibrating delay loop... 4169.72 BogoMIPS
Feb  3 10:53:53 tachyon Dentry cache hash table entries: 131072 (order: 
7, 524288 bytes)
Feb  3 10:53:53 tachyon Inode-cache hash table entries: 65536 (order: 6, 
262144 bytes)
Feb  3 10:53:53 tachyon Mount-cache hash table entries: 512 (order: 0, 
4096 bytes)
Feb  3 10:53:53 tachyon checking if image is initramfs...it isn't 
(ungzip failed); looks like an initrd
Feb  3 10:53:53 tachyon Freeing initrd memory: 304k freed
Feb  3 10:53:53 tachyon CPU:     After generic identify, caps: 0383fbff 
c1c3fbff 00000000 00000000
Feb  3 10:53:53 tachyon CPU:     After vendor identify, caps: 0383fbff 
c1c3fbff 00000000 00000000
Feb  3 10:53:53 tachyon CPU: L1 I Cache: 64K (64 bytes/line), D cache 
64K (64 bytes/line)
Feb  3 10:53:53 tachyon CPU: L2 Cache: 256K (64 bytes/line)
Feb  3 10:53:53 tachyon CPU:     After all inits, caps: 0383fbff 
c1c3fbff 00000000 00000020
Feb  3 10:53:53 tachyon Intel machine check architecture supported.
Feb  3 10:53:53 tachyon Intel machine check reporting enabled on CPU#0.
Feb  3 10:53:53 tachyon CPU: AMD Athlon(tm)  stepping 01
Feb  3 10:53:53 tachyon Enabling fast FPU save and restore... done.
Feb  3 10:53:53 tachyon Enabling unmasked SIMD FPU exception support... 
done.
Feb  3 10:53:53 tachyon Checking 'hlt' instruction... OK.
Feb  3 10:53:53 tachyon POSIX conformance testing by UNIFIX
Feb  3 10:53:53 tachyon NET: Registered protocol family 16
Feb  3 10:53:53 tachyon PCI: Using configuration type 1
Feb  3 10:53:53 tachyon mtrr: v2.0 (20020519)
Feb  3 10:53:53 tachyon ACPI: Subsystem revision 20040116
Feb  3 10:53:53 tachyon ACPI: IRQ9 SCI: Edge set to Level Trigger.
Feb  3 10:53:53 tachyon ACPI: Interpreter enabled
Feb  3 10:53:53 tachyon ACPI: Using PIC for interrupt routing
Feb  3 10:53:53 tachyon ACPI: PCI Root Bridge [PCI0] (00:00)
Feb  3 10:53:53 tachyon PCI: Probing PCI hardware (bus 00)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.HUB0._PRT]
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Routing Table 
[\_SB_.PCI0.AGPB._PRT]
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 
10 *11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 6 7 
*10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 
*10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 
*10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 
10 *11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 
10 *11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 
10 *11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 *5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 
10 11 12 14 15)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APC1] (IRQs 16)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APC2] (IRQs 17)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APC3] (IRQs *18)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APC4] (IRQs *19)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCE] (IRQs 16)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCS] (IRQs *23)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Feb  3 10:53:53 tachyon Linux Plug and Play Support v0.97 (c) Adam Belay
Feb  3 10:53:53 tachyon SCSI subsystem initialized
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 11
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 5
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 10
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 11
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LACI] enabled at IRQ 11
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 5
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 5
Feb  3 10:53:53 tachyon ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
Feb  3 10:53:53 tachyon PCI: Using ACPI for IRQ routing
Feb  3 10:53:53 tachyon PCI: if you experience problems, try using 
option 'pci=noacpi' or even 'acpi=off'
Feb  3 10:53:53 tachyon vesafb: framebuffer at 0xc0000000, mapped to 
0xf8808000, size 16384k
Feb  3 10:53:53 tachyon vesafb: mode is 1280x1024x16, linelength=2560, 
pages=1
Feb  3 10:53:53 tachyon vesafb: protected mode interface info at c000:ea60
Feb  3 10:53:53 tachyon vesafb: scrolling: redraw
Feb  3 10:53:53 tachyon vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Feb  3 10:53:53 tachyon fb0: VESA VGA frame buffer device
Feb  3 10:53:53 tachyon Machine check exception polling timer started.
Feb  3 10:53:53 tachyon IA-32 Microcode Update Driver: v1.13 
<tigran@veritas.com>
Feb  3 10:53:53 tachyon apm: BIOS version 1.2 Flags 0x07 (Driver version 
1.16ac)
Feb  3 10:53:53 tachyon apm: overridden by ACPI.
Feb  3 10:53:53 tachyon highmem bounce pool size: 64 pages
Feb  3 10:53:53 tachyon Installing knfsd (copyright (C) 1996 
okir@monad.swb.de).
Feb  3 10:53:53 tachyon NTFS driver 2.1.6 [Flags: R/W].
Feb  3 10:53:53 tachyon udf: registering filesystem
Feb  3 10:53:53 tachyon ACPI: Power Button (FF) [PWRF]
Feb  3 10:53:53 tachyon ACPI: Fan [FAN] (on)
Feb  3 10:53:53 tachyon ACPI: Processor [CPU0] (supports C1)
Feb  3 10:53:53 tachyon ACPI: Thermal Zone [THRM] (36 C)
Feb  3 10:53:53 tachyon Console: switching to colour frame buffer device 
160x64
Feb  3 10:53:53 tachyon pty: 256 Unix98 ptys configured
Feb  3 10:53:53 tachyon Real Time Clock Driver v1.12
Feb  3 10:53:53 tachyon Non-volatile memory driver v1.2
Feb  3 10:53:53 tachyon Serial: 8250/16550 driver $Revision: 1.90 $ 8 
ports, IRQ sharing disabled
Feb  3 10:53:53 tachyon ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb  3 10:53:53 tachyon ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Feb  3 10:53:53 tachyon Using cfq io scheduler
Feb  3 10:53:53 tachyon Floppy drive(s): fd0 is 1.44M
Feb  3 10:53:53 tachyon FDC 0 is a post-1991 82077
Feb  3 10:53:53 tachyon loop: loaded (max 8 devices)
Feb  3 10:53:53 tachyon forcedeth.c: Reverse Engineered nForce ethernet 
driver. Version 0.19.
Feb  3 10:53:53 tachyon PCI: Setting latency timer of device 
0000:00:04.0 to 64
Feb  3 10:53:53 tachyon eth0: forcedeth.c: subsystem: 0147b:1c00 bound 
to 0000:00:04.0
Feb  3 10:53:53 tachyon drivers/media/dvb/b2c2/skystar2.c: 
FlexCopII(rev.130) chip found
Feb  3 10:53:53 tachyon drivers/media/dvb/b2c2/skystar2.c: the chip has 
6 hardware filters
Feb  3 10:53:53 tachyon driver_initialize MAC address = 
ff:ff:ff:ff:ff:ff:00:00
Feb  3 10:53:53 tachyon DVB: registering new adapter (Technisat SkyStar2 
driver).
Feb  3 10:53:53 tachyon DVB: registering frontend 0:0 (Zarlink MT312)...
Feb  3 10:53:53 tachyon Uniform Multi-Platform E-IDE driver Revision: 
7.00alpha2
Feb  3 10:53:53 tachyon ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Feb  3 10:53:53 tachyon NFORCE2: IDE controller at PCI slot 0000:00:09.0
Feb  3 10:53:53 tachyon NFORCE2: chipset revision 162
Feb  3 10:53:53 tachyon NFORCE2: not 100% native mode: will probe irqs later
Feb  3 10:53:53 tachyon NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
Feb  3 10:53:53 tachyon ide0: BM-DMA at 0xf000-0xf007, BIOS settings: 
hda:DMA, hdb:DMA
Feb  3 10:53:53 tachyon ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: 
hdc:DMA, hdd:DMA
Feb  3 10:53:53 tachyon hda: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
Feb  3 10:53:53 tachyon ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb  3 10:53:53 tachyon hdc: NU DVDRW DDW-081, ATAPI CD/DVD-ROM drive
Feb  3 10:53:53 tachyon hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
Feb  3 10:53:53 tachyon ide1 at 0x170-0x177,0x376 on irq 15
Feb  3 10:53:53 tachyon hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Feb  3 10:53:53 tachyon Uniform CD-ROM driver Revision: 3.20
Feb  3 10:53:53 tachyon hdc: ATAPI 40X DVD-ROM CD-R/RW drive, 2048kB 
Cache, UDMA(33)
Feb  3 10:53:53 tachyon ide-floppy driver 0.99.newide
Feb  3 10:53:53 tachyon hdd: No disk in drive
Feb  3 10:53:53 tachyon hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 
sector size, 2941 rpm
Feb  3 10:53:53 tachyon libata version 0.81 loaded.
Feb  3 10:53:53 tachyon sata_sil version 0.52
Feb  3 10:53:53 tachyon ata1: SATA max UDMA/133 cmd 0xF993F080 ctl 
0xF993F08A bmdma 0xF993F000 irq 11
Feb  3 10:53:53 tachyon ata2: SATA max UDMA/133 cmd 0xF993F0C0 ctl 
0xF993F0CA bmdma 0xF993F008 irq 11
Feb  3 10:53:53 tachyon spurious 8259A interrupt: IRQ7.
Feb  3 10:53:53 tachyon ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 
85:3c69 86:3c01 87:4003 88:203f
Feb  3 10:53:53 tachyon ata1: dev 0 ATA, max UDMA/100, 312581808 sectors 
(lba48)
Feb  3 10:53:53 tachyon ata1: dev 0 configured for UDMA/100
Feb  3 10:53:53 tachyon scsi0 : sata_sil
Feb  3 10:53:53 tachyon ata2: no device found (phy stat 00000000)
Feb  3 10:53:53 tachyon ata2: thread exiting
Feb  3 10:53:53 tachyon scsi1 : sata_sil
Feb  3 10:53:53 tachyon Vendor: ATA       Model: SAMSUNG SP1614N   Rev: 0.81
Feb  3 10:53:53 tachyon Type:   Direct-Access                      ANSI 
SCSI revision: 05
Feb  3 10:53:53 tachyon SCSI device sda: 312581808 512-byte hdwr sectors 
(160042 MB)
Feb  3 10:53:53 tachyon SCSI device sda: drive cache: write through
Feb  3 10:53:53 tachyon sda: sda1 sda2 sda3 < sda5 sda6 sda7 >
Feb  3 10:53:53 tachyon Attached scsi disk sda at scsi0, channel 0, id 
0, lun 0
Feb  3 10:53:53 tachyon Console: switching to colour frame buffer device 
160x64
Feb  3 10:53:53 tachyon mice: PS/2 mouse device common for all mice
Feb  3 10:53:53 tachyon serio: i8042 AUX port at 0x60,0x64 irq 12
Feb  3 10:53:53 tachyon input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
Feb  3 10:53:53 tachyon serio: i8042 KBD port at 0x60,0x64 irq 1
Feb  3 10:53:53 tachyon input: AT Translated Set 2 keyboard on 
isa0060/serio0
Feb  3 10:53:53 tachyon I2O Core - (C) Copyright 1999 Red Hat Software
Feb  3 10:53:53 tachyon I2O: Event thread created as pid 14
Feb  3 10:53:53 tachyon i2o: Checking for PCI I2O controllers...
Feb  3 10:53:53 tachyon I2O configuration manager v 0.04.
Feb  3 10:53:53 tachyon (C) Copyright 1999 Red Hat Software
Feb  3 10:53:53 tachyon i2c /dev entries driver
Feb  3 10:53:53 tachyon i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
Feb  3 10:53:53 tachyon i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
Feb  3 10:53:53 tachyon Advanced Linux Sound Architecture Driver Version 
1.0.2 (Tue Jan 27 10:28:52 2004 UTC).
Feb  3 10:53:53 tachyon request_module: failed /sbin/modprobe -- 
snd-card-0. error = -16
Feb  3 10:53:53 tachyon PCI: Setting latency timer of device 
0000:00:06.0 to 64
Feb  3 10:53:53 tachyon intel8x0_measure_ac97_clock: measured 49513 usecs
Feb  3 10:53:53 tachyon intel8x0: clocking to 47375
Feb  3 10:53:53 tachyon ALSA device list:
Feb  3 10:53:53 tachyon #0: NVidia nForce2 at 0xcc081000, irq 11
Feb  3 10:53:53 tachyon NET: Registered protocol family 2
Feb  3 10:53:53 tachyon IP: routing cache hash table of 8192 buckets, 
64Kbytes
Feb  3 10:53:53 tachyon TCP: Hash tables configured (established 262144 
bind 65536)
Feb  3 10:53:53 tachyon NET: Registered protocol family 1
Feb  3 10:53:53 tachyon NET: Registered protocol family 17
Feb  3 10:53:53 tachyon ACPI: (supports S0 S3 S4 S5)
Feb  3 10:53:53 tachyon found reiserfs format "3.6" with standard journal
Feb  3 10:53:53 tachyon Reiserfs journal params: device sda7, size 8192, 
journal first block 18, max trans len 1024, max batch 900, max commit 
age 30, max trans age 30
Feb  3 10:53:53 tachyon reiserfs: checking transaction log (sda7) for (sda7)
Feb  3 10:53:53 tachyon Using r5 hash to sort names
Feb  3 10:53:53 tachyon VFS: Mounted root (reiserfs filesystem) readonly.
Feb  3 10:53:53 tachyon Freeing unused kernel memory: 156k freed




--------------030906090408000805060508
Content-Type: text/plain;
 name=".config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".config"

#
# Automatically generated make config: don't edit
#
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
# CONFIG_CLEAN_COMPILE is not set
# CONFIG_STANDALONE is not set
CONFIG_BROKEN=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
CONFIG_OBSOLETE_MODPARM=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# Processor type and features
#
CONFIG_X86_PC=y
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
# CONFIG_X86_GENERICARCH is not set
# CONFIG_X86_ES7000 is not set

#
# Processor support
#

#
# Select all processors your kernel should support
#
# CONFIG_CPU_386 is not set
# CONFIG_CPU_486 is not set
# CONFIG_CPU_586 is not set
# CONFIG_CPU_586TSC is not set
# CONFIG_CPU_586MMX is not set
# CONFIG_CPU_686 is not set
# CONFIG_CPU_PENTIUMII is not set
# CONFIG_CPU_PENTIUMIII is not set
# CONFIG_CPU_PENTIUMM is not set
# CONFIG_CPU_PENTIUM4 is not set
# CONFIG_CPU_K6 is not set
CONFIG_CPU_K7=y
# CONFIG_CPU_K8 is not set
# CONFIG_CPU_CRUSOE is not set
# CONFIG_CPU_WINCHIPC6 is not set
# CONFIG_CPU_WINCHIP2 is not set
# CONFIG_CPU_WINCHIP3D is not set
# CONFIG_CPU_CYRIXIII is not set
# CONFIG_CPU_VIAC3_2 is not set
CONFIG_CPU_ONLY_K7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
# CONFIG_X86_4G is not set
# CONFIG_X86_SWITCH_PAGETABLES is not set
# CONFIG_X86_4G_VM_LAYOUT is not set
# CONFIG_X86_UACCESS_INDIRECT is not set
# CONFIG_X86_HIGH_ENTRY is not set
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
# CONFIG_SMP is not set
CONFIG_PREEMPT=y
# CONFIG_X86_UP_APIC is not set
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
CONFIG_MICROCODE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
# CONFIG_EDD is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=y
CONFIG_HIGHPTE=y
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
# CONFIG_EFI is not set
CONFIG_HAVE_DEC_LOCK=y
# CONFIG_REGPARM is not set

#
# Power management options (ACPI, APM)
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set
# CONFIG_PM_DISK is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set
CONFIG_X86_PM_TIMER=y

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
CONFIG_APM_CPU_IDLE=y
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
CONFIG_PCI_GODIRECT=y
# CONFIG_PCI_GOANY is not set
CONFIG_PCI_DIRECT=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set
CONFIG_PCMCIA_PROBE=y

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_MISC=y

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#
CONFIG_PNP=y
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
# CONFIG_ISAPNP is not set
# CONFIG_PNPBIOS is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_LBD=y

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=y
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_IDE_GENERIC is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_MAX_SD_DISKS=256
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
CONFIG_SCSI_REPORT_LUNS=y
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_SATA=y
# CONFIG_SCSI_SATA_SVW is not set
# CONFIG_SCSI_ATA_PIIX is not set
# CONFIG_SCSI_SATA_PROMISE is not set
CONFIG_SCSI_SATA_SIL=y
# CONFIG_SCSI_SATA_VIA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_GENERIC_NCR5380_MMIO is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA2XXX_CONFIG=y
# CONFIG_SCSI_QLA21XX is not set
# CONFIG_SCSI_QLA22XX is not set
# CONFIG_SCSI_QLA23XX is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
CONFIG_I2O=y
CONFIG_I2O_PCI=y
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set
CONFIG_I2O_PROC=y

#
# Macintosh device drivers
#

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=y
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MII is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set

#
# Tulip family network device support
#
# CONFIG_NET_TULIP is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_AMD8111_ETH is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_B44 is not set
CONFIG_FORCEDETH=y
# CONFIG_CS89x0 is not set
# CONFIG_DGRS is not set
# CONFIG_EEPRO100 is not set
# CONFIG_E100 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set
# CONFIG_KGDBOE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NETPOLL_RX is not set
# CONFIG_NETPOLL_TRAP is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1024
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_HW_RANDOM is not set
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HANGCHECK_TIMER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=y
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_I810 is not set
# CONFIG_I2C_ISA is not set
CONFIG_I2C_NFORCE2=y
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_PROSAVAGE is not set
# CONFIG_I2C_SAVAGE4 is not set
# CONFIG_SCx200_ACB is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set
# CONFIG_I2C_VOODOO3 is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ASB100 is not set
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_LM75=y
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM90 is not set
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_W83781D=y
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=y
CONFIG_DVB_CORE=y

#
# Supported Frontend Modules
#
# CONFIG_DVB_TWINHAN_DST is not set
# CONFIG_DVB_STV0299 is not set
# CONFIG_DVB_SP887X is not set
# CONFIG_DVB_ALPS_TDLB7 is not set
# CONFIG_DVB_ALPS_TDMB7 is not set
# CONFIG_DVB_ATMEL_AT76C651 is not set
# CONFIG_DVB_CX24110 is not set
# CONFIG_DVB_GRUNDIG_29504_491 is not set
# CONFIG_DVB_GRUNDIG_29504_401 is not set
CONFIG_DVB_MT312=y
# CONFIG_DVB_VES1820 is not set
# CONFIG_DVB_VES1X93 is not set
# CONFIG_DVB_TDA1004X is not set

#
# Supported SAA7146 based PCI Adapters
#
# CONFIG_DVB_AV7110 is not set
# CONFIG_DVB_BUDGET is not set
# CONFIG_DVB_BUDGET_CI is not set
# CONFIG_DVB_BUDGET_AV is not set

#
# Supported USB Adapters
#
# CONFIG_DVB_TTUSB_BUDGET is not set
# CONFIG_DVB_TTUSB_DEC is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_SKYSTAR=y

#
# Supported BT878 Adapters
#

#
# Graphics support
#
CONFIG_FB=y
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
# CONFIG_FB_HGA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_PCI_CONSOLE=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

#
# Logo configuration
#
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set

#
# Generic devices
#
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_VIRMIDI is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# ISA devices
#
# CONFIG_SND_AD1848 is not set
# CONFIG_SND_CS4231 is not set
# CONFIG_SND_CS4232 is not set
# CONFIG_SND_CS4236 is not set
# CONFIG_SND_ES1688 is not set
# CONFIG_SND_ES18XX is not set
# CONFIG_SND_GUSCLASSIC is not set
# CONFIG_SND_GUSEXTREME is not set
# CONFIG_SND_GUSMAX is not set
# CONFIG_SND_INTERWAVE is not set
# CONFIG_SND_INTERWAVE_STB is not set
# CONFIG_SND_OPTI92X_AD1848 is not set
# CONFIG_SND_OPTI92X_CS4231 is not set
# CONFIG_SND_OPTI93X is not set
# CONFIG_SND_SB8 is not set
# CONFIG_SND_SB16 is not set
# CONFIG_SND_SBAWE is not set
# CONFIG_SND_WAVEFRONT is not set
# CONFIG_SND_CMI8330 is not set
# CONFIG_SND_OPL3SA2 is not set
# CONFIG_SND_SGALAXY is not set
# CONFIG_SND_SSCAPE is not set

#
# PCI devices
#
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_YMFPCI is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
CONFIG_SND_INTEL8X0=y
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VX222 is not set

#
# ALSA USB devices
#
# CONFIG_SND_USB_AUDIO is not set

#
# Open Sound System
#
# CONFIG_SOUND_PRIME is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH_TTY is not set
# CONFIG_USB_MIDI is not set
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m
# CONFIG_USB_STORAGE is not set

#
# USB Human Interface Devices (HID)
#
# CONFIG_USB_HID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# CONFIG_USB_AIPTEK is not set
# CONFIG_USB_WACOM is not set
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=m
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_TEST is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
# CONFIG_NFSD_V3 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
CONFIG_SMB_FS=y
# CONFIG_SMB_NLS_DEFAULT is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_DEBUG_KERNEL is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_FRAME_POINTER=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------030906090408000805060508--
