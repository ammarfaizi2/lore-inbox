Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262460AbSKCUHJ>; Sun, 3 Nov 2002 15:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSKCUHH>; Sun, 3 Nov 2002 15:07:07 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:55303 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262460AbSKCUGl>; Sun, 3 Nov 2002 15:06:41 -0500
From: Han-Wen Nienhuys <hanwen@cs.uu.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown
Content-Transfer-Encoding: 7bit
Message-ID: <15813.33891.429000.126394@blauw.xs4all.nl>
Date: Sun, 3 Nov 2002 21:17:39 +0100
To: linux-kernel@vger.kernel.org
Subject: [Help!] 2.4.20 IDE-SCSI / CD-writing crash
X-Mailer: VM 7.05 under Emacs 21.2.1
Reply-To: hanwen@cs.uu.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I have severe trouble trying to write a CD rewritable under
linux. Symptoms are as follows: writing fails approximately 75 % of
the times I try. When this happens, the SCSI or IDE layer goes into a
reset-self-loop. This takes up all CPU time, and makes the machine
unusable; this forces me hit the power-switch. This happens with
RedHat 8.0 stock, 2.4.19 and 2.4.20-rc1 kernels, both with RH8
cdrecord, and the latest version (1.11a39).

The writer is a brand-new Philips CDD6911, and I successfully burnt a
300mb rewritable with it on Windows 98 with NERO (I admit to not doing
very many tests, sorry.). Catting /dev/cdrom on a normal CD didn't
cause any errors. The machine is a Compaq EN Deskpro, PII/400 (Intel
BX chipset.) with RH8.0 installed


I'm supposed to "roll out" this machine at my mom's next weekend, so a
speedy reply would be very much appreciated.

Any thoughts?  

The following corresponds to the 2.4.19 run that failed, but other
kernels fail similarly.

Samples from /var/log/messages

[2.4.19]
	Oct 29 22:48:33 oolong kernel: hdd: irq timeout: status=0xd0 { Busy }
	Oct 29 22:48:33 oolong kernel: hdd: DMA disabled
	Oct 29 22:48:33 oolong kernel: hdd: ATAPI reset complete
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xd1 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Oct 29 22:48:33 oolong kernel: hdd: ATAPI reset complete
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xc0 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xd0 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Oct 29 22:48:33 oolong kernel: hdd: ATAPI reset complete
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xd0 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Oct 29 22:48:33 oolong kernel: hdd: ATAPI reset complete
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xd0 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Oct 29 22:48:33 oolong kernel: hdd: status timeout: status=0xd0 { Busy }
	Oct 29 22:48:33 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

	Nov  2 01:23:52 oolong kernel: ^ISense class 0, sense error 0, extended sense 0
	Nov  2 01:23:52 oolong kernel: sr0: CDROM (ioctl) error, command: Test Unit Ready 00 00 00 00 00 
	Nov  2 01:23:52 oolong kernel: sr00:00: old sense key None
	Nov  2 01:23:52 oolong kernel: Non-extended sense class 0 code 0x0
	Nov  2 01:23:52 oolong kernel: hdd: ststatus=0xd0 { Busy }

	Nov  3 11:53:06 oolong kernel: SCSI bus is being reset for host 0 channel 0.
	Nov  3 11:53:07 oolong kernel: scsi : aborting command due to timeout : pid 1944, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
	Nov  3 11:53:07 oolong kernel: SCSI host 0 abort (pid 1944) timed out - resetting
	Nov  3 11:53:07 oolong kernel: SCSI bus is being reset for host 0 channel 0.
	Nov  3 11:53:07 oolong kernel: scsi : aborting command due to timeout : pid 1944, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
	Nov  3 11:53:07 oolong kernel: SCSI host 0 abort (pid 1944) timed out - resetting
	Nov  3 11:53:07 oolong kernel: SCSI bus is being reset for host 0 channel 0.
	Nov  3 11:53:08 oolong kernel: scsi : aborting command due to timeout : pid 1944, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
	Nov  3 11:53:08 oolong kernel: SCSI host 0 abort (pid 1944) timed out - resetting

[2.4.20rc1]

	Nov  3 17:59:54 oolong kernel: scsi : aborting command due to timeout : pid 480, scsi0, channel 0, id 0, lun 0 Test Unit Ready 00 00 00 00 00 
	Nov  3 18:00:00 oolong kernel: hdd: irq timeout: status=0xd0 { Busy }
	Nov  3 18:00:00 oolong kernel: hdd: DMA disabled
	Nov  3 18:00:00 oolong kernel: hdd: ATAPI reset complete
	Nov  3 18:00:00 oolong kernel: hdd: status timeout: status=0xc0 { Busy }
	Nov  3 18:00:00 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Nov  3 18:00:00 oolong kernel: hdd: ATAPI reset complete
	Nov  3 18:00:00 oolong kernel: hdd: status timeout: status=0x90 { Busy }
	Nov  3 18:00:00 oolong kernel: ide-scsi: Strange, packet command initiated yet DRQ isn't asserted
	Nov  3 18:00:00 oolong kernel: hdd: status timeout: status=0xd0 { Busy }
	Nov  3 18:00:00 oolong kernel: hdd: drive not ready for command
	Nov  3 18:00:01 oolong kernel: hdd: ATAPI reset complete

Cdrecord 1.11a39 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J,bv(Brg
Schilling. (I believe the flags were -speed=12 -dev 0,0,0 -blank=fast):

	scsidev: '0,0,0'
	scsibus: 0 target: 0 lun: 0
	Linux sg driver version: 3.1.24
	Cdrecord 1.11a39 (i686-pc-linux-gnu) Copyright (C) 1995-2002 J,bv(Brg Schilling
	Using libscg version 'schily-0.7'
	Device type    : Removable CD-ROM
	Version        : 0
	Response Format: 1
	Vendor_info    : 'PHILIPS '
	Identifikation : 'CDD6911         '
	Revision       : 'B1.0'
	Device seems to be: Generic mmc CD-RW.
	Using generic SCSI-3/mmc CD-R driver (mmc_cdr).
	Driver flags   : MMC-2 SWABAUDIO BURNFREE 
	Supported modes: TAO PACKET SAO SAO/R96P RAW/R16 RAW/R96R
	Starting to write CD/DVD at speed 12 in real TAO mode for single session.

versions:

	Linux oolong 2.4.20-rc1 #8 zo nov 3 19:13:09 WET 2002 i686 i686 i386 GNU/Linux

	Gnu C                  3.2
	Gnu make               3.79.1
	util-linux             2.11r
	mount                  2.11r
	modutils               2.4.18
	e2fsprogs              1.27
	jfsutils               1.0.17
	reiserfsprogs          3.6.2
	pcmcia-cs              3.1.31
	PPP                    2.4.1
	isdn4k-utils           3.1pre4
	Linux C Library        2.2.93
	Dynamic linker (ldd)   2.2.93
	Procps                 2.0.7
	Net-tools              1.60
	Kbd                    1.06
	Sh-utils               2.0.12

no modules loaded

cpu:

	processor	: 0
	vendor_id	: GenuineIntel
	cpu family	: 6
	model		: 5
	model name	: Pentium II (Deschutes)
	stepping	: 2
	cpu MHz		: 397.957
	cache size	: 512 KB
	fdiv_bug	: no
	hlt_bug		: no
	f00f_bug	: no
	coma_bug	: no
	fpu		: yes
	fpu_exception	: yes
	cpuid level	: 2
	wp		: yes
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
	bogomips	: 794.62


PCI

	00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
		Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR+ <PERR-
		Latency: 64
		Region 0: Memory at 44000000 (32-bit, prefetchable) [size=64M]
		Capabilities: [a0] AGP version 1.0
			Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
			Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

	00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
		Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
		Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
		I/O behind bridge: 0000f000-00000fff
		Memory behind bridge: fff00000-000fffff
		Prefetchable memory behind bridge: fff00000-000fffff
		BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

	00:0e.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
		Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
		Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64 (2500ns min, 2500ns max), cache line size 08
		Interrupt: pin A routed to IRQ 11
		Region 0: I/O ports at 2000 [size=128]
		Region 1: Memory at 40200000 (32-bit, non-prefetchable) [size=128]
		Expansion ROM at <unassigned> [disabled] [size=128K]
		Capabilities: [dc] Power Management version 1
			Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
			Status: D0 PME-Enable- DSel=0 DScale=0 PME-

	00:10.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
		Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin A routed to IRQ 11
		Region 0: Memory at 40100000 (32-bit, non-prefetchable) [size=16K]
		Region 1: Memory at 40800000 (32-bit, prefetchable) [size=8M]
		Expansion ROM at <unassigned> [disabled] [size=64K]

	00:14.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
		Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 0

	00:14.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Region 4: I/O ports at 20a0 [size=16]

	00:14.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
		Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Latency: 64
		Interrupt: pin D routed to IRQ 11
		Region 4: I/O ports at 2080 [size=32]

	00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
		Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
		Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
		Interrupt: pin ? routed to IRQ 9

SCSI

	Host: scsi0 Channel: 00 Id: 00 Lun: 00
	  Vendor: PHILIPS  Model: CDD6911          Rev: B1.0
	  Type:   CD-ROM                           ANSI SCSI revision: 02



startup info:

	Linux version 2.4.19 (root@oolong) (gcc versie 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #6 wo okt 30 23:51:00 WET 2002
	BIOS-provided physical RAM map:
	 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
	 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
	 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
	 BIOS-e820: 0000000000100000 - 0000000008000000 (usable)
	 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
	128MB LOWMEM available.
	Advanced speculative caching feature not present
	On node 0 totalpages: 32768
	zone(0): 4096 pages.
	zone(1): 28672 pages.
	zone(2): 0 pages.
	Kernel command line: root=/dev/hda2 hdd=ide-scsi sb=220,5,1,0 video=matrox:vesa:0x11A,sync:0x28
	ide_setup: hdd=ide-scsi
	Local APIC disabled by BIOS -- reenabling.
	Found and enabled local APIC!
	Initializing CPU#0
	Detected 397.949 MHz processor.
	Console: colour VGA+ 80x25
	Calibrating delay loop... 794.62 BogoMIPS
	Memory: 126200k/131072k available (1982k kernel code, 4484k reserved, 676k data, 152k init, 0k highmem)
	Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
	Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
	Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
	Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
	Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
	CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
	CPU: L1 I cache: 16K, L1 D cache: 16K
	CPU: L2 cache: 512K
	CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
	Intel machine check architecture supported.
	Intel machine check reporting enabled on CPU#0.
	CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
	CPU:             Common caps: 0183fbff 00000000 00000000 00000000
	CPU: Intel Pentium II (Deschutes) stepping 02
	Enabling fast FPU save and restore... done.
	Checking 'hlt' instruction... OK.
	POSIX conformance testing by UNIFIX
	enabled ExtINT on CPU#0
	ESR value before enabling vector: 00000000
	ESR value after enabling vector: 00000000
	Using local APIC timer interrupts.
	calibrating APIC timer ...
	..... CPU clock speed is 397.9481 MHz.
	..... host bus clock speed is 99.4868 MHz.
	cpu: 0, clocks: 994868, slice: 497434
	CPU0<T0:994864,T1:497424,D:6,S:497434,C:994868>
	mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
	mtrr: detected mtrr type: Intel
	PCI: PCI BIOS revision 2.10 entry at 0xed880, last bus=1
	PCI: Using configuration type 1
	PCI: Probing PCI hardware
	Unknown bridge resource 0: assuming transparent
	Unknown bridge resource 1: assuming transparent
	Unknown bridge resource 2: assuming transparent
	PCI: Using IRQ router PIIX [8086/7110] at 00:14.0
	Limiting direct PCI/PCI transfers.
	isapnp: Scanning for PnP cards...
	isapnp: No Plug & Play device found
	Linux NET4.0 for Linux 2.4
	Based upon Swansea University Computer Society NET3.039
	Initializing RT netlink socket
	Starting kswapd
	Journalled Block Device driver loaded
	Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
	parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
	parport0: irq 7 detected
	PCI: Found IRQ 11 for device 00:10.0
	PCI: Sharing IRQ 11 with 00:14.2
	matroxfb: Matrox Millennium (PCI) detected
	matroxfb: MTRR's turned on
	matroxfb: 1280x1024x16bpp (virtual: 1280x1638)
	matroxfb: framebuffer at 0x40800000, mapped to 0xc8812000, size 4194304
	Console: switching to colour frame buffer device 160x64
	fb0: MATROX VGA frame buffer device
	pty: 256 Unix98 ptys configured
	Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
	ttyS00 at 0x03f8 (irq = 4) is a 16550A
	ttyS01 at 0x02f8 (irq = 3) is a 16550A
	lp0: using parport0 (polling).
	Uniform Multi-Platform E-IDE driver Revision: 6.31
	ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
	PIIX4: IDE controller on PCI bus 00 dev a1
	PIIX4: chipset revision 1
	PIIX4: not 100% native mode: will probe irqs later
	    ide0: BM-DMA at 0x20a0-0x20a7, BIOS settings: hda:DMA, hdb:pio
	    ide1: BM-DMA at 0x20a8-0x20af, BIOS settings: hdc:pio, hdd:DMA
	hda: WDC AC26400R, ATA DISK drive
	hdd: PHILIPS CDD6911, ATAPI CD/DVD-ROM drive
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	ide1 at 0x170-0x177,0x376 on irq 15
	hda: 12594960 sectors (6449 MB) w/512KiB Cache, CHS=833/240/63, UDMA(33)
	ide-floppy driver 0.99.newide
	Partition check:
	 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
	Floppy drive(s): fd0 is 1.44M
	FDC 0 is a National Semiconductor PC87306
	RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
	PCI: Found IRQ 11 for device 00:0e.0
	3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
	00:0e.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x2000. Vers LK1.1.16
	PPP generic driver version 2.4.2
	PPP Deflate Compression module registered
	PPP BSD Compression module registered
	Linux agpgart interface v0.99 (c) Jeff Hartmann
	agpgart: Maximum main memory to use for agp memory: 96M
	agpgart: Detected Intel 440BX chipset
	agpgart: AGP aperture is 64M @ 0x44000000
	[drm] Initialized tdfx 1.0.0 20010216 on minor 0
	[drm] AGP 0.99 on Intel 440BX @ 0x44000000 64MB
	[drm] Initialized radeon 1.1.1 20010405 on minor 1
	ide-floppy driver 0.99.newide
	SCSI subsystem driver Revision: 1.00
	scsi0 : SCSI host adapter emulation for IDE ATAPI devices
	  Vendor: PHILIPS   Model: CDD6911           Rev: B1.0
	  Type:   CD-ROM                             ANSI SCSI revision: 02
	Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
	sr0: scsi3-mmc drive: 12x/12x writer cd/rw xa/form2 cdda tray
	Uniform CD-ROM driver Revision: 3.12
	Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
	sb: No ISAPnP cards found, trying standard ones...
	YM3812 and OPL-3 driver Copyright (C) by Hannu Savolainen, Rob Hooft 1993-1996
	Linux Kernel Card Services 3.1.22
	  options:  [pci] [cardbus] [pm]
	usb.c: registered new driver hub
	uhci.c: USB Universal Host Controller Interface driver v1.1
	PCI: Found IRQ 11 for device 00:14.2
	PCI: Sharing IRQ 11 with 00:10.0
	uhci.c: USB UHCI at I/O 0x2080, IRQ 11
	usb.c: new USB bus registered, assigned bus number 1
	hub.c: USB hub found
	hub.c: 2 ports detected
	usb.c: registered new driver usbscanner
	scanner.c: 0.4.6:USB Scanner Driver
	NET4: Linux TCP/IP 1.0 for NET4.0
	IP Protocols: ICMP, UDP, TCP, IGMP
	IP: routing cache hash table of 1024 buckets, 8Kbytes
	TCP: Hash tables configured (established 8192 bind 16384)
	NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
	ds: no socket drivers loaded!
	EXT3-fs: INFO: recovery required on readonly filesystem.
	EXT3-fs: write access will be enabled during recovery.
	kjournald starting.  Commit interval 5 seconds
	EXT3-fs: recovery complete.
	EXT3-fs: mounted filesystem with ordered data mode.
	VFS: Mounted root (ext3 filesystem) readonly.
	Freeing unused kernel memory: 152k freed
	EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,2), internal journal
	Adding Swap: 158720k swap-space (priority -1)
	kjournald starting.  Commit interval 5 seconds
	EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
	EXT3-fs: mounted filesystem with ordered data mode.
	mtrr: 0x40800000,0x800000 overlaps existing 0x40800000,0x400000


kernel config:

	CONFIG_X86=y
	CONFIG_ISA=y
	CONFIG_UID16=y
	CONFIG_EXPERIMENTAL=y
	CONFIG_MODULES=y
	CONFIG_MODVERSIONS=y
	CONFIG_KMOD=y
	CONFIG_M686=y
	CONFIG_X86_WP_WORKS_OK=y
	CONFIG_X86_INVLPG=y
	CONFIG_X86_CMPXCHG=y
	CONFIG_X86_XADD=y
	CONFIG_X86_BSWAP=y
	CONFIG_X86_POPAD_OK=y
	CONFIG_RWSEM_XCHGADD_ALGORITHM=y
	CONFIG_X86_L1_CACHE_SHIFT=5
	CONFIG_X86_TSC=y
	CONFIG_X86_GOOD_APIC=y
	CONFIG_X86_PGE=y
	CONFIG_X86_USE_PPRO_CHECKSUM=y
	CONFIG_X86_PPRO_FENCE=y
	CONFIG_X86_MCE=y
	CONFIG_NOHIGHMEM=y
	CONFIG_MTRR=y
	CONFIG_X86_UP_APIC=y
	CONFIG_X86_LOCAL_APIC=y
	CONFIG_NET=y
	CONFIG_PCI=y
	CONFIG_PCI_GOANY=y
	CONFIG_PCI_BIOS=y
	CONFIG_PCI_DIRECT=y
	CONFIG_PCI_NAMES=y
	CONFIG_HOTPLUG=y
	CONFIG_PCMCIA=y
	CONFIG_CARDBUS=y
	CONFIG_SYSVIPC=y
	CONFIG_SYSCTL=y
	CONFIG_KCORE_ELF=y
	CONFIG_BINFMT_AOUT=y
	CONFIG_BINFMT_ELF=y
	CONFIG_BINFMT_MISC=y
	CONFIG_PM=y


	CONFIG_PARPORT=y
	CONFIG_PARPORT_PC=y
	CONFIG_PARPORT_PC_CML1=y
	CONFIG_PARPORT_PC_FIFO=y
	CONFIG_PARPORT_PC_SUPERIO=y
	CONFIG_PARPORT_1284=y

	CONFIG_PNP=y
	CONFIG_ISAPNP=y
	CONFIG_BLK_DEV_FD=y
	CONFIG_BLK_DEV_RAM=y
	CONFIG_BLK_DEV_RAM_SIZE=4096

	CONFIG_PACKET=y
	CONFIG_UNIX=y
	CONFIG_INET=y
	CONFIG_IP_MULTICAST=y
	CONFIG_IDE=y

	CONFIG_BLK_DEV_IDE=y
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_IDEDISK_MULTI_MODE=y
	CONFIG_IDEDISK_STROKE=y
	CONFIG_BLK_DEV_IDECD=y
	CONFIG_BLK_DEV_IDEFLOPPY=y
	CONFIG_BLK_DEV_IDESCSI=y
	CONFIG_BLK_DEV_CMD640=y
	CONFIG_BLK_DEV_RZ1000=y
	CONFIG_BLK_DEV_IDEPCI=y
	CONFIG_IDEPCI_SHARE_IRQ=y
	CONFIG_BLK_DEV_IDEDMA_PCI=y
	CONFIG_IDEDMA_PCI_AUTO=y
	CONFIG_BLK_DEV_IDEDMA=y
	CONFIG_BLK_DEV_ADMA=y
	CONFIG_BLK_DEV_PIIX=y
	CONFIG_PIIX_TUNING=y
	CONFIG_IDEDMA_AUTO=y
	CONFIG_BLK_DEV_IDE_MODES=y

	CONFIG_SCSI=y
	CONFIG_BLK_DEV_SD=y
	CONFIG_SD_EXTRA_DEVS=40
	CONFIG_BLK_DEV_SR=y
	CONFIG_SR_EXTRA_DEVS=2
	CONFIG_CHR_DEV_SG=y
	CONFIG_SCSI_DEBUG_QUEUES=y
	CONFIG_SCSI_MULTI_LUN=y
	CONFIG_SCSI_CONSTANTS=y

	CONFIG_SCSI_SYM53C8XX=y
	CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
	CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
	CONFIG_SCSI_NCR53C8XX_SYNC=20





	CONFIG_NETDEVICES=y

	CONFIG_DUMMY=m

	CONFIG_NET_ETHERNET=y
	CONFIG_NET_VENDOR_3COM=y
	CONFIG_EL3=y
	CONFIG_VORTEX=y
	CONFIG_NET_PCI=y
	CONFIG_EEPRO100=y
	CONFIG_NE2K_PCI=y
	CONFIG_8139CP=y
	CONFIG_8139TOO=y

	CONFIG_PPP=y
	CONFIG_PPP_DEFLATE=y
	CONFIG_PPP_BSDCOMP=y




	CONFIG_NET_PCMCIA=y
	CONFIG_PCMCIA_PCNET=y
	CONFIG_NET_PCMCIA_RADIO=y
	CONFIG_PCMCIA_RAYCS=y






	CONFIG_VT=y
	CONFIG_VT_CONSOLE=y
	CONFIG_SERIAL=y
	CONFIG_UNIX98_PTYS=y
	CONFIG_UNIX98_PTY_COUNT=256
	CONFIG_PRINTER=y


	CONFIG_MOUSE=y
	CONFIG_PSMOUSE=y



	CONFIG_AGP=y
	CONFIG_AGP_INTEL=y
	CONFIG_AGP_I810=y
	CONFIG_AGP_VIA=y
	CONFIG_AGP_AMD=y
	CONFIG_AGP_SIS=y
	CONFIG_AGP_ALI=y
	CONFIG_DRM=y
	CONFIG_DRM_NEW=y
	CONFIG_DRM_TDFX=y
	CONFIG_DRM_RADEON=y



	CONFIG_AUTOFS4_FS=y
	CONFIG_EXT3_FS=y
	CONFIG_JBD=y
	CONFIG_FAT_FS=y
	CONFIG_MSDOS_FS=y
	CONFIG_VFAT_FS=y
	CONFIG_TMPFS=y
	CONFIG_RAMFS=y
	CONFIG_ISO9660_FS=y
	CONFIG_JOLIET=y
	CONFIG_ZISOFS=y
	CONFIG_MINIX_FS=y
	CONFIG_PROC_FS=y
	CONFIG_DEVPTS_FS=y
	CONFIG_EXT2_FS=y

	CONFIG_NFS_FS=y
	CONFIG_NFSD=y
	CONFIG_SUNRPC=y
	CONFIG_LOCKD=y
	CONFIG_ZISOFS_FS=y
	CONFIG_ZLIB_FS_INFLATE=y

	CONFIG_MSDOS_PARTITION=y
	CONFIG_NLS=y

	CONFIG_NLS_DEFAULT="iso8859-1"

	CONFIG_VGA_CONSOLE=y
	CONFIG_VIDEO_SELECT=y

	CONFIG_FB=y
	CONFIG_DUMMY_CONSOLE=y
	CONFIG_VIDEO_SELECT=y
	CONFIG_FB_MATROX=y
	CONFIG_FB_MATROX_MILLENIUM=y
	CONFIG_FBCON_CFB8=y
	CONFIG_FBCON_CFB16=y
	CONFIG_FBCON_CFB24=y
	CONFIG_FBCON_CFB32=y
	CONFIG_FONT_8x8=y
	CONFIG_FONT_8x16=y

	CONFIG_SOUND=y
	CONFIG_SOUND_OSS=y
	CONFIG_SOUND_SB=y
	CONFIG_SOUND_YM3812=y
	CONFIG_USB=y
	CONFIG_USB_UHCI_ALT=y
	CONFIG_USB_SCANNER=y
	CONFIG_DEBUG_KERNEL=y
	CONFIG_MAGIC_SYSRQ=y


-- 

Han-Wen Nienhuys   |   hanwen@cs.uu.nl   |   http://www.cs.uu.nl/~hanwen 
