Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTDYHZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 03:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263387AbTDYHZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 03:25:00 -0400
Received: from p50845ADD.dip.t-dialin.net ([80.132.90.221]:32898 "EHLO
	defiant.crash") by vger.kernel.org with ESMTP id S263375AbTDYHYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 03:24:45 -0400
From: Ronald Lembcke <es186@fen-net.de>
Date: Fri, 25 Apr 2003 09:36:52 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc1-ac1: Filesystem corruption
Message-ID: <20030425073652.GA2089@defiant.crash>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've experienced corruption on an ext3 filesystem.
Motherboard: Asus A7N8A Chipset: NForce2

Kernel-config is attatched

Harddrives:
hda: IBM-DJNA-351520
hdb: IC35L080AVVA07-0

hdparm-Settings:
hdparm -A 1 -c 1 -d 1 -m 4 -u 1 /dev/hda
hdparm -A 1 -c 1 -d 1 -m 8 -u 1 /dev/hdb


First problem was:
-rc1-ac1 didn't reboot / halt.
It just saied something about ?syncing buffers? (I think it was something else,
sorry, don't know) hda, and stayed there for a minute till I rebooted.
One process was in D-state at that time.

But I think the corruption happened while normaly booted:

Apr 25 02:19:40 defiant kernel: hdb: dma_timer_expiry: dma status == 0x60
Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
Apr 25 02:19:40 defiant kernel: hdb: (__ide_dma_test_irq) called while not waiting
Apr 25 02:19:40 defiant kernel: hdb: status timeout: status=0xd0 { Busy }
Apr 25 02:19:40 defiant kernel:
Apr 25 02:19:40 defiant kernel: hda: DMA disabled
Apr 25 02:19:40 defiant kernel: hdb: drive not ready for command
Apr 25 02:19:41 defiant kernel: ide0: reset: success

After reboot, still in -rc1-ac1 I got:

Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=808209485, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=537541418, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=544370535, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=809330985, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=1013522492, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=1763719992, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=170470188, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=808209485, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=537541418, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904
Apr 25 02:27:26 defiant kernel: attempt to access beyond end of device
Apr 25 02:27:26 defiant kernel: 03:4b: rw=0, want=538976289, limit=999904


Back in -pre5-ac3 forced fsck.ext3 found some errors on some fs on /dev/hdb
(hda is currently not used under Linux).


Kernel-Bootmessages:
Apr 25 00:37:32 defiant kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Apr 25 00:37:33 defiant kernel: Inspecting /boot/System.map-2.4.21-rc1-ac1
Apr 25 00:37:33 defiant kernel: Loaded 17340 symbols from /boot/System.map-2.4.21-rc1-ac1.
Apr 25 00:37:33 defiant kernel: Symbols match kernel version 2.4.21.
Apr 25 00:37:33 defiant kernel: Loaded 279 symbols from 18 modules.
Apr 25 00:37:33 defiant kernel: Linux version 2.4.21-rc1-ac1 (root@defiant) (gcc version 3.2.3 20030415 (Debian prerelease)) #3 Fri Apr 25 00:07:08 CEST 2003
Apr 25 00:37:33 defiant kernel: BIOS-provided physical RAM map:
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Apr 25 00:37:33 defiant kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Apr 25 00:37:33 defiant kernel: 511MB LOWMEM available.
Apr 25 00:37:33 defiant kernel: On node 0 totalpages: 131056
Apr 25 00:37:33 defiant kernel: zone(0): 4096 pages.
Apr 25 00:37:33 defiant kernel: zone(1): 126960 pages.
Apr 25 00:37:33 defiant kernel: zone(2): 0 pages.
Apr 25 00:37:33 defiant kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=342 panicblink=3 video=radeon:1280x1024-8@85
Apr 25 00:37:33 defiant kernel: Found and enabled local APIC!
Apr 25 00:37:33 defiant kernel: Initializing CPU#0
Apr 25 00:37:33 defiant kernel: Detected 2079.550 MHz processor.
Apr 25 00:37:33 defiant kernel: Console: colour VGA+ 80x25
Apr 25 00:37:33 defiant kernel: Calibrating delay loop... 4141.87 BogoMIPS
Apr 25 00:37:33 defiant kernel: Memory: 516080k/524224k available (1269k kernel code, 7760k reserved, 312k data, 276k init, 0k highmem)
Apr 25 00:37:33 defiant kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Apr 25 00:37:33 defiant kernel: Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Apr 25 00:37:33 defiant kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Apr 25 00:37:33 defiant kernel: Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
Apr 25 00:37:33 defiant kernel: Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
Apr 25 00:37:33 defiant kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Apr 25 00:37:33 defiant kernel: CPU: L2 Cache: 256K (64 bytes/line)
Apr 25 00:37:33 defiant kernel: Intel machine check architecture supported.
Apr 25 00:37:33 defiant kernel: Intel machine check reporting enabled on CPU#0.
Apr 25 00:37:33 defiant kernel: CPU:     After generic, caps: 0383fbff c1c3fbff 00000000 00000000
Apr 25 00:37:33 defiant kernel: CPU:             Common caps: 0383fbff c1c3fbff 00000000 00000000
Apr 25 00:37:33 defiant kernel: CPU: AMD Athlon(tm) XP 2600+ stepping 01
Apr 25 00:37:33 defiant kernel: Enabling fast FPU save and restore... done.
Apr 25 00:37:33 defiant kernel: Enabling unmasked SIMD FPU exception support... done.
Apr 25 00:37:33 defiant kernel: Checking 'hlt' instruction... OK.
Apr 25 00:37:33 defiant kernel: POSIX conformance testing by UNIFIX
Apr 25 00:37:33 defiant kernel: enabled ExtINT on CPU#0
Apr 25 00:37:33 defiant kernel: ESR value before enabling vector: 00000000
Apr 25 00:37:33 defiant kernel: ESR value after enabling vector: 00000000
Apr 25 00:37:33 defiant kernel: Using local APIC timer interrupts.
Apr 25 00:37:33 defiant kernel: calibrating APIC timer ...
Apr 25 00:37:33 defiant kernel: ..... CPU clock speed is 2079.5801 MHz.
Apr 25 00:37:33 defiant kernel: ..... host bus clock speed is 332.7326 MHz.
Apr 25 00:37:33 defiant kernel: cpu: 0, clocks: 3327326, slice: 1663663
Apr 25 00:37:33 defiant kernel: CPU0<T0:3327312,T1:1663648,D:1,S:1663663,C:3327326>
Apr 25 00:37:33 defiant kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Apr 25 00:37:33 defiant kernel: mtrr: detected mtrr type: Intel
Apr 25 00:37:33 defiant kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4b0, last bus=3
Apr 25 00:37:33 defiant kernel: PCI: Using configuration type 1
Apr 25 00:37:33 defiant kernel: PCI: Probing PCI hardware
Apr 25 00:37:33 defiant kernel: PCI: Using IRQ router default [10de/01e0] at 00:00.0
Apr 25 00:37:33 defiant kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf20
Apr 25 00:37:33 defiant kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf50, dseg 0xf0000
Apr 25 00:37:33 defiant kernel: PnPBIOS: 16 nodes reported by PnP BIOS; 16 recorded by driver
Apr 25 00:37:33 defiant kernel: Linux NET4.0 for Linux 2.4
Apr 25 00:37:33 defiant kernel: Based upon Swansea University Computer Society NET3.039
Apr 25 00:37:33 defiant kernel: Initializing RT netlink socket
Apr 25 00:37:33 defiant kernel: BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
Apr 25 00:37:33 defiant kernel: Starting kswapd
Apr 25 00:37:33 defiant kernel: Journalled Block Device driver loaded
Apr 25 00:37:33 defiant kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Apr 25 00:37:33 defiant kernel: devfs: boot_options: 0x0
Apr 25 00:37:33 defiant kernel: ACPI: Core Subsystem version [20011018]
Apr 25 00:37:33 defiant kernel: ACPI: Subsystem enabled
Apr 25 00:37:33 defiant kernel: radeonfb: ref_clk=2700, ref_div=12, xclk=23000 from BIOS
Apr 25 00:37:33 defiant kernel: Console: switching to colour frame buffer device 160x64
Apr 25 00:37:33 defiant kernel: radeonfb: ATI Radeon 7500 QW  DDR SGRAM 64 MB
Apr 25 00:37:33 defiant kernel: radeonfb: DVI port no monitor connected
Apr 25 00:37:33 defiant kernel: radeonfb: CRT port CRT monitor connected
Apr 25 00:37:33 defiant kernel: Detected PS/2 Mouse Port.
Apr 25 00:37:33 defiant kernel: pty: 256 Unix98 ptys configured
Apr 25 00:37:33 defiant kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Apr 25 00:37:33 defiant kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Apr 25 00:37:33 defiant kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Apr 25 00:37:33 defiant kernel: Floppy drive(s): fd0 is 1.44M
Apr 25 00:37:33 defiant kernel: FDC 0 is a post-1991 82077
Apr 25 00:37:33 defiant kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
Apr 25 00:37:33 defiant kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 25 00:37:33 defiant kernel: NFORCE2: IDE controller at PCI slot 00:09.0
Apr 25 00:37:33 defiant kernel: NFORCE2: chipset revision 162
Apr 25 00:37:33 defiant kernel: NFORCE2: not 100%% native mode: will probe irqs later
Apr 25 00:37:33 defiant kernel: AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
Apr 25 00:37:33 defiant kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Apr 25 00:37:33 defiant kernel: AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller on pci00:09.0
Apr 25 00:37:33 defiant kernel:     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
Apr 25 00:37:33 defiant kernel:     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Apr 25 00:37:33 defiant kernel: hdb: C/H/S=39420/16/255 from BIOS ignored
Apr 25 00:37:33 defiant kernel: hda: IBM-DJNA-351520, ATA DISK drive
Apr 25 00:37:33 defiant kernel: hdb: IC35L080AVVA07-0, ATA DISK drive
Apr 25 00:37:33 defiant kernel: hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive
Apr 25 00:37:33 defiant kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Apr 25 00:37:33 defiant kernel: ide1 at 0x170-0x177,0x376 on irq 15
Apr 25 00:37:33 defiant kernel: hda: attached ide-disk driver.
Apr 25 00:37:33 defiant kernel: hda: host protected area => 1
Apr 25 00:37:33 defiant kernel: hda: 30033360 sectors (15377 MB) w/430KiB Cache, CHS=1869/255/63
Apr 25 00:37:33 defiant kernel: hdb: attached ide-disk driver.
Apr 25 00:37:33 defiant kernel: hdb: host protected area => 1
Apr 25 00:37:33 defiant kernel: hdb: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63
Apr 25 00:37:33 defiant kernel: hdd: attached ide-cdrom driver.
Apr 25 00:37:33 defiant kernel: hdd: ATAPI 48X DVD-ROM drive, 128kB Cache
Apr 25 00:37:33 defiant kernel: Uniform CD-ROM driver Revision: 3.12
Apr 25 00:37:33 defiant kernel: Partition check:
Apr 25 00:37:33 defiant kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
Apr 25 00:37:33 defiant kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 < p5 p6 p7 p8 p9 p10 p11 p12 >
Apr 25 00:37:33 defiant kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Apr 25 00:37:33 defiant kernel: IP Protocols: ICMP, UDP, TCP
Apr 25 00:37:33 defiant kernel: IP: routing cache hash table of 4096 buckets, 32Kbytes
Apr 25 00:37:33 defiant kernel: TCP: Hash tables configured (established 32768 bind 65536)
Apr 25 00:37:33 defiant kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: VFS: Mounted root (ext3 filesystem) readonly.
Apr 25 00:37:33 defiant kernel: Freeing unused kernel memory: 276k freed
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,66), internal journal
Apr 25 00:37:33 defiant kernel: 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
Apr 25 00:37:33 defiant kernel: See Documentation/networking/vortex.txt
Apr 25 00:37:33 defiant kernel: 02:01.0: 3Com PCI 3c905C Tornado 2 at 0xa000. Vers LK1.1.18-ac
Apr 25 00:37:33 defiant kernel:  00:26:54:08:a0:cb, IRQ 12
Apr 25 00:37:33 defiant kernel:   product code ffff rev 00.0 date 15-31-127
Apr 25 00:37:33 defiant kernel:   Internal config register is 1600000, transceivers 0x40.
Apr 25 00:37:33 defiant kernel:   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/MII interface.
Apr 25 00:37:33 defiant kernel:   MII transceiver found at address 2, status 786d.
Apr 25 00:37:33 defiant kernel:   Enabling bus-master transmits and whole-frame receives.
Apr 25 00:37:33 defiant kernel: 02:01.0: scatter/gather enabled. h/w checksums enabled
Apr 25 00:37:33 defiant kernel: NET4: Linux IPX 0.47 for NET4.0
Apr 25 00:37:33 defiant kernel: IPX Portions Copyright (c) 1995 Caldera, Inc.
Apr 25 00:37:33 defiant kernel: IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
Apr 25 00:37:33 defiant kernel: mice: PS/2 mouse device common for all mice
Apr 25 00:37:33 defiant kernel: usb.c: registered new driver usbdevfs
Apr 25 00:37:33 defiant kernel: usb.c: registered new driver hub
Apr 25 00:37:33 defiant kernel: usb.c: registered new driver hiddev
Apr 25 00:37:33 defiant kernel: usb.c: registered new driver hid
Apr 25 00:37:33 defiant kernel: hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
Apr 25 00:37:33 defiant kernel: hid-core.c: USB HID support drivers
Apr 25 00:37:33 defiant kernel: usb.c: registered new driver usblp
Apr 25 00:37:33 defiant kernel: printer.c: v0.11: USB Printer Device Class driver
Apr 25 00:37:33 defiant kernel: PCI: Setting latency timer of device 00:02.0 to 64
Apr 25 00:37:33 defiant kernel: usb-ohci.c: USB OHCI at membase 0xe4859000, IRQ 12
Apr 25 00:37:33 defiant kernel: usb-ohci.c: usb-00:02.0, PCI device 10de:0067 (nVidia Corporation)
Apr 25 00:37:33 defiant kernel: usb.c: new USB bus registered, assigned bus number 1
Apr 25 00:37:33 defiant kernel: hub.c: USB hub found
Apr 25 00:37:33 defiant kernel: hub.c: 3 ports detected
Apr 25 00:37:33 defiant kernel: PCI: Setting latency timer of device 00:02.1 to 64
Apr 25 00:37:33 defiant kernel: usb-ohci.c: USB OHCI at membase 0xe485b000, IRQ 12
Apr 25 00:37:33 defiant kernel: usb-ohci.c: usb-00:02.1, PCI device 10de:0067 (nVidia Corporation)
Apr 25 00:37:33 defiant kernel: usb.c: new USB bus registered, assigned bus number 2
Apr 25 00:37:33 defiant kernel: hub.c: USB hub found
Apr 25 00:37:33 defiant kernel: hub.c: 3 ports detected
Apr 25 00:37:33 defiant kernel: ACPI: Power Button (FF) found
Apr 25 00:37:33 defiant kernel: ACPI: Multiple power buttons detected, ignoring fixed-feature
Apr 25 00:37:33 defiant kernel: ACPI: Power Button (CM) found
Apr 25 00:37:33 defiant kernel: Processor[0]: C0 C1
Apr 25 00:37:33 defiant kernel: ACPI: System firmware supports S0 S1 S3 S4 S5
Apr 25 00:37:33 defiant kernel: hub.c: new USB device 00:02.1-2, assigned address 2
Apr 25 00:37:33 defiant kernel: input0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb2:2.0
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,69), internal journal
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,70), internal journal
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,72), internal journal
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,73), internal journal
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: kjournald starting.  Commit interval 5 seconds
Apr 25 00:37:33 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,75), internal journal
Apr 25 00:37:33 defiant kernel: EXT3-fs: mounted filesystem with ordered data mode.
Apr 25 00:37:33 defiant kernel: FAT: bogus logical sector size 49913
Apr 25 00:37:33 defiant kernel: VFS: Can't find a valid FAT filesystem on dev 03:05.
Apr 25 00:37:33 defiant kernel: Real Time Clock Driver v1.10e
Apr 25 00:37:33 defiant kernel: blk: queue c02feb80, I/O limit 4095Mb (mask 0xffffffff)
Apr 25 00:37:33 defiant kernel: blk: queue c02fecc0, I/O limit 4095Mb (mask 0xffffffff)
Apr 25 00:37:37 defiant kernel: spurious 8259A interrupt: IRQ7.
Apr 25 00:37:42 defiant kernel: parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
Apr 25 00:37:42 defiant kernel: lp0: using parport0 (interrupt-driven).
Apr 25 00:37:44 defiant kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Apr 25 00:37:44 defiant kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Apr 25 00:37:44 defiant kernel: hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Apr 25 00:37:44 defiant kernel: hda: drive_cmd: error=0x04 { DriveStatusError }
Apr 25 00:37:45 defiant kernel: hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Apr 25 00:37:45 defiant kernel: hdd: drive_cmd: error=0x04Aborted Command 
Apr 25 00:37:45 defiant kernel: SCSI subsystem driver Revision: 1.00
Apr 25 00:37:46 defiant kernel: hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Apr 25 00:37:46 defiant kernel: hdd: drive_cmd: error=0x04Aborted Command 
Apr 25 00:37:51 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:37:51 defiant kernel: apm: overridden by ACPI.
Apr 25 00:43:57 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:43:57 defiant kernel: apm: overridden by ACPI.
Apr 25 00:44:06 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:44:06 defiant kernel: apm: overridden by ACPI.
Apr 25 00:44:54 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:44:54 defiant kernel: apm: overridden by ACPI.
Apr 25 00:46:00 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:46:00 defiant kernel: apm: overridden by ACPI.
Apr 25 00:47:34 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:47:34 defiant kernel: apm: overridden by ACPI.
Apr 25 00:50:56 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 00:50:56 defiant kernel: apm: overridden by ACPI.
Apr 25 00:51:14 defiant kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,71), internal journal
Apr 25 01:22:16 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:22:16 defiant kernel: apm: overridden by ACPI.
Apr 25 01:23:49 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:23:49 defiant kernel: apm: overridden by ACPI.
Apr 25 01:34:06 defiant kernel: PCI: Setting latency timer of device 00:06.0 to 64
Apr 25 01:34:07 defiant kernel: intel8x0: clocking to 47473
Apr 25 01:37:14 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:37:14 defiant kernel: apm: overridden by ACPI.
Apr 25 01:37:54 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:37:54 defiant kernel: apm: overridden by ACPI.
Apr 25 01:39:17 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:39:17 defiant kernel: apm: overridden by ACPI.
Apr 25 01:45:07 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 01:45:07 defiant kernel: apm: overridden by ACPI.
Apr 25 02:00:19 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 02:00:19 defiant kernel: apm: overridden by ACPI.
Apr 25 02:03:32 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 02:03:32 defiant kernel: apm: overridden by ACPI.
Apr 25 02:07:27 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 02:07:27 defiant kernel: apm: overridden by ACPI.
Apr 25 02:08:41 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 02:08:41 defiant kernel: apm: overridden by ACPI.
Apr 25 02:14:35 defiant kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Apr 25 02:14:35 defiant kernel: apm: overridden by ACPI.
Apr 25 02:19:40 defiant kernel: hdb: dma_timer_expiry: dma status == 0x60
Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
Apr 25 02:19:40 defiant kernel: hdb: timeout waiting for DMA
Apr 25 02:19:40 defiant kernel: hdb: (__ide_dma_test_irq) called while not waiting
Apr 25 02:19:40 defiant kernel: hdb: status timeout: status=0xd0 { Busy }
Apr 25 02:19:40 defiant kernel: 
Apr 25 02:19:40 defiant kernel: hda: DMA disabled
Apr 25 02:19:40 defiant kernel: hdb: drive not ready for command
Apr 25 02:19:41 defiant kernel: ide0: reset: success
Apr 25 02:19:54 defiant kernel: SysRq : Emergency Sync
Apr 25 02:19:54 defiant kernel: Syncing device 03:42 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:41 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:45 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:46 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:47 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:48 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:49 ... OK
Apr 25 02:19:54 defiant kernel: Syncing device 03:4a ... OK
Apr 25 02:19:55 defiant kernel: Syncing device 03:4b ... OK
Apr 25 02:19:55 defiant kernel: Syncing device 03:03 ... OK
Apr 25 02:19:55 defiant kernel: Done.


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-2.4.21-rc1-ac1"

CONFIG_X86=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_EDD=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y

CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BUSMGR=m
CONFIG_ACPI_SYS=m
CONFIG_ACPI_CPU=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_EC=m
CONFIG_ACPI_THERMAL=m
CONFIG_APM=m


CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

CONFIG_PNP=y
CONFIG_PNPBIOS=y

CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_STATS=y


CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_INET_ECN=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IPV6=m


CONFIG_IPX=m
CONFIG_IPX_INTERN=y



CONFIG_NET_PKTGEN=m


CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDESCSI=m

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m

CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y

CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_SYM53C8XX=m
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20


CONFIG_IEEE1394=m

CONFIG_IEEE1394_OHCI1394=m

CONFIG_IEEE1394_VIDEO1394=m
CONFIG_IEEE1394_DV1394=m
CONFIG_IEEE1394_RAWIO=m


CONFIG_NETDEVICES=y

CONFIG_DUMMY=m
CONFIG_EQUALIZER=m
CONFIG_TUN=m

CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_NET_PCI=y
CONFIG_EEPRO100=m
CONFIG_E100=m
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m

CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m







CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m

CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

CONFIG_MOUSE=m
CONFIG_PSMOUSE=y

CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m

CONFIG_INPUT_ANALOG=m

CONFIG_AMD_RNG=m
CONFIG_INTEL_RNG=m
CONFIG_AMD_PM768=m
CONFIG_NVRAM=m
CONFIG_RTC=m

CONFIG_AGP=m
CONFIG_DRM=y

CONFIG_DRM_NEW=y
CONFIG_DRM_RADEON=m

CONFIG_VIDEO_DEV=m

CONFIG_VIDEO_PROC_FS=y

CONFIG_VIDEO_BT848=m


CONFIG_AUTOFS4_FS=m
CONFIG_REISERFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m

CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=m

CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MDA_CONSOLE=m

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VGA16=m
CONFIG_VIDEO_SELECT=y
CONFIG_FB_RADEON=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=m
CONFIG_FBCON_VGA=m
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y

CONFIG_SOUND=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_AD1816=m
CONFIG_SOUND_MPU401=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_TVMIXER=m

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI=m

CONFIG_USB_PRINTER=m

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_MOUSE=m

CONFIG_USB_SCANNER=m
CONFIG_USB_MICROTEK=m
CONFIG_USB_HPUSBSCSI=m







CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_PANIC_MORSE=y

CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m

--AhhlLboLdkugWU4S--
