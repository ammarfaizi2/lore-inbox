Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264898AbUFAGcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbUFAGcL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 02:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264906AbUFAGcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 02:32:11 -0400
Received: from smtpsrv6.hrz.uni-oldenburg.de ([134.106.87.26]:49887 "EHLO
	smtpsrv6.hrz.uni-oldenburg.de") by vger.kernel.org with ESMTP
	id S264898AbUFAGbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 02:31:52 -0400
To: linux-kernel@vger.kernel.org
Cc: Jeff Garzik <jgarzik@pobox.com>
Subject: 2.4.26 fails to detect two Realtek cards
From: Kevin Bube <k.bube@web.de>
Date: Tue, 01 Jun 2004 08:31:07 +0200
Message-ID: <m1acznpz6c.fsf@ntcora.icbm.uni-oldenburg.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-PMX-Version: 4.5.0.92886, Antispam-Core: 4.0.4.93542, Antispam-Data: 2004.5.31.102126
X-PerlMx-Spam: Gauge=IIIIIIII, Probability=8%, Report='__TO_MALFORMED_2 0, __HAS_MSGID 0, __SANE_MSGID 0, __USER_AGENT 0, __MIME_VERSION 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, SIGNATURE_SHORT_DENSE 0, USER_AGENT 0.000'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi all,

I have a DSL home router with two cheapo Realtek network cards. With a
2.4.18-bf24 kernel from Debian Woody 3.0r1 they both get detected and
everything runs fine.

The problem now is: if I try a vanilla 2.4.26 only one card gets
detected. I tried passing ether=0,0,eth1 at the boot prompt in order to
force autodetection of the second card, but it did not work. Neither did
passing the interrupt directly. I also tried compiling the rtl8139too
driver as a module but that didn't work either: only one card. Btw. the
same happens with 2.4.24.

Was there a major change in the driver between 2.4.24 and 2.4.18? What
can I do to track down the problem?

Attached below is the relevant part of lspci, dmesg, rtl8139-diag and
.config. Tell me if you need more information.

Regards,

Kevin

P.S. Please CC me as I am not on the list.


dmesg from 2.4.26:

May 26 19:33:58 daisy kernel: Linux version 2.4.26 (kevin@dagobert) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Mit Mai 26 16:42:31 CEST 2004
May 26 19:33:58 daisy kernel: BIOS-provided physical RAM map:
May 26 19:33:58 daisy kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
May 26 19:33:58 daisy kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 26 19:33:58 daisy kernel:  BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
May 26 19:33:58 daisy kernel:  BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
May 26 19:33:58 daisy kernel:  BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
May 26 19:33:58 daisy kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
May 26 19:33:58 daisy kernel: 63MB LOWMEM available.
May 26 19:33:58 daisy kernel: On node 0 totalpages: 16368
May 26 19:33:58 daisy kernel: zone(0): 4096 pages.
May 26 19:33:58 daisy kernel: zone(1): 12272 pages.
May 26 19:33:58 daisy kernel: zone(2): 0 pages.
May 26 19:33:58 daisy kernel: Kernel command line: auto BOOT_IMAGE=Linux ro root=301 ether=5,0xa000,eth0 ether=12,0xd800,eth1
May 26 19:33:58 daisy kernel: Local APIC disabled by BIOS -- reenabling.
May 26 19:33:58 daisy kernel: Found and enabled local APIC!
May 26 19:33:59 daisy kernel: Initializing CPU#0
May 26 19:33:59 daisy kernel: Detected 400.960 MHz processor.
May 26 19:33:59 daisy kernel: Console: colour VGA+ 80x25
May 26 19:33:59 daisy kernel: Calibrating delay loop... 799.53 BogoMIPS
May 26 19:33:59 daisy kernel: Memory: 62100k/65472k available (1362k kernel code, 2988k reserved, 403k data, 272k init, 0k highmem)
May 26 19:33:59 daisy kernel: Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
May 26 19:33:59 daisy kernel: Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
May 26 19:34:00 daisy kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
May 26 19:34:00 daisy kernel: Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
May 26 19:34:00 daisy kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
May 26 19:34:00 daisy kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 26 19:34:00 daisy kernel: CPU: L2 cache: 128K
May 26 19:34:00 daisy kernel: Intel machine check architecture supported.
May 26 19:34:00 daisy kernel: Intel machine check reporting enabled on CPU#0.
May 26 19:34:00 daisy kernel: CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
May 26 19:34:00 daisy kernel: CPU:             Common caps: 0183fbff 00000000 00000000 00000000
May 26 19:34:00 daisy kernel: CPU: Intel Celeron (Mendocino) stepping 05
May 26 19:34:00 daisy kernel: Enabling fast FPU save and restore... done.
May 26 19:34:01 daisy kernel: Checking 'hlt' instruction... OK.
May 26 19:34:01 daisy kernel: POSIX conformance testing by UNIFIX
May 26 19:34:01 daisy kernel: enabled ExtINT on CPU#0
May 26 19:34:01 daisy kernel: ESR value before enabling vector: 00000000
May 26 19:34:01 daisy kernel: ESR value after enabling vector: 00000000
May 26 19:34:01 daisy kernel: Using local APIC timer interrupts.
May 26 19:34:01 daisy kernel: calibrating APIC timer ...
May 26 19:34:01 daisy kernel: ..... CPU clock speed is 400.9181 MHz.
May 26 19:34:01 daisy kernel: ..... host bus clock speed is 66.8195 MHz.
May 26 19:34:01 daisy kernel: cpu: 0, clocks: 668195, slice: 334097
May 26 19:34:02 daisy kernel: CPU0<T0:668192,T1:334080,D:15,S:334097,C:668195>
May 26 19:34:02 daisy kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
May 26 19:34:02 daisy kernel: mtrr: detected mtrr type: Intel
May 26 19:34:02 daisy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb150, last bus=1
May 26 19:34:02 daisy kernel: PCI: Using configuration type 1
May 26 19:34:02 daisy kernel: PCI: Probing PCI hardware
May 26 19:34:02 daisy kernel: PCI: Probing PCI hardware (bus 00)
May 26 19:34:02 daisy kernel: PCI: Using IRQ router VIA [1106/0596] at 00:07.0
May 26 19:34:02 daisy kernel: Activating ISA DMA hang workarounds.
May 26 19:34:02 daisy kernel: isapnp: Scanning for PnP cards...
May 26 19:34:02 daisy kernel: isapnp: No Plug & Play device found
May 26 19:34:02 daisy kernel: Linux NET4.0 for Linux 2.4
May 26 19:34:02 daisy kernel: Based upon Swansea University Computer Society NET3.039
May 26 19:34:02 daisy kernel: Initializing RT netlink socket
May 26 19:34:02 daisy kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
May 26 19:34:02 daisy kernel: Starting kswapd
May 26 19:34:02 daisy kernel: Journalled Block Device driver loaded
May 26 19:34:02 daisy kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
May 26 19:34:02 daisy kernel: NTFS driver v1.1.22 [Flags: R/O]
May 26 19:34:02 daisy kernel: Detected PS/2 Mouse Port.
May 26 19:34:02 daisy kernel: pty: 256 Unix98 ptys configured
May 26 19:34:03 daisy kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
May 26 19:34:03 daisy kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
May 26 19:34:03 daisy kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 26 19:34:03 daisy kernel: keyboard: Timeout - AT keyboard not present?(ed)
May 26 19:34:03 daisy kernel: keyboard: Timeout - AT keyboard not present?(f4)
May 26 19:34:03 daisy kernel: FDC 0 is a post-1991 82077
May 26 19:34:03 daisy kernel: 8139cp: 10/100 PCI Ethernet driver v1.1 (Aug 30, 2003)
May 26 19:34:03 daisy kernel: 8139cp: pci dev 00:0c.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
May 26 19:34:03 daisy kernel: 8139cp: Try the "8139too" driver instead.
May 26 19:34:03 daisy kernel: 8139too Fast Ethernet driver 0.9.26
May 26 19:34:03 daisy kernel: PCI: Found IRQ 5 for device 00:0c.0
May 26 19:34:03 daisy kernel: PCI: Sharing IRQ 5 with 00:0d.0
May 26 19:34:03 daisy kernel: eth0: RealTek RTL8139 at 0xc480d000, 00:50:fc:f6:9e:39, IRQ 5
May 26 19:34:03 daisy kernel: eth0:  Identified 8139 chip type 'RTL-8100B/8139D'

[...]


dmesg from 2.4.18-bf24

May 26 17:06:26 daisy kernel: Linux version 2.4.18-bf2.4 (root@zombie) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Son Apr 14 09:53:28 CEST 2002
May 26 17:06:26 daisy kernel: BIOS-provided physical RAM map:
May 26 17:06:26 daisy kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
May 26 17:06:26 daisy kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
May 26 17:06:26 daisy kernel:  BIOS-e820: 0000000000100000 - 0000000003ff0000 (usable)
May 26 17:06:26 daisy kernel:  BIOS-e820: 0000000003ff0000 - 0000000003ff3000 (ACPI NVS)
May 26 17:06:26 daisy kernel:  BIOS-e820: 0000000003ff3000 - 0000000004000000 (ACPI data)
May 26 17:06:26 daisy kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
May 26 17:06:26 daisy kernel: On node 0 totalpages: 16368
May 26 17:06:26 daisy kernel: zone(0): 4096 pages.
May 26 17:06:26 daisy kernel: zone(1): 12272 pages.
May 26 17:06:26 daisy kernel: zone(2): 0 pages.
May 26 17:06:26 daisy kernel: Local APIC disabled by BIOS -- reenabling.
May 26 17:06:26 daisy kernel: Found and enabled local APIC!
May 26 17:06:26 daisy kernel: Kernel command line: auto BOOT_IMAGE=LinuxOLD ro root=301 ether=5,0xd000,eth0 ether=12,0xd800,eth1
May 26 17:06:26 daisy kernel: Initializing CPU#0
May 26 17:06:27 daisy kernel: Detected 400.954 MHz processor.
May 26 17:06:27 daisy kernel: Console: colour VGA+ 80x25
May 26 17:06:27 daisy kernel: Calibrating delay loop... 799.53 BogoMIPS
May 26 17:06:27 daisy kernel: Memory: 61112k/65472k available (1783k kernel code, 3976k reserved, 549k data, 280k init, 0k highmem)
May 26 17:06:27 daisy kernel: Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
May 26 17:06:27 daisy kernel: Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
May 26 17:06:27 daisy kernel: Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
May 26 17:06:28 daisy kernel: Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
May 26 17:06:28 daisy kernel: Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
May 26 17:06:28 daisy kernel: CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
May 26 17:06:28 daisy kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
May 26 17:06:28 daisy kernel: CPU: L2 cache: 128K
May 26 17:06:28 daisy kernel: CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
May 26 17:06:28 daisy kernel: Intel machine check architecture supported.
May 26 17:06:28 daisy kernel: Intel machine check reporting enabled on CPU#0.
May 26 17:06:28 daisy kernel: CPU:     After generic, caps: 0183fbff 00000000 00000000 00000000
May 26 17:06:28 daisy kernel: CPU:             Common caps: 0183fbff 00000000 00000000 00000000
May 26 17:06:28 daisy kernel: CPU: Intel Celeron (Mendocino) stepping 05
May 26 17:06:28 daisy kernel: Enabling fast FPU save and restore... done.
May 26 17:06:29 daisy kernel: Checking 'hlt' instruction... OK.
May 26 17:06:29 daisy kernel: Checking for popad bug... OK.
May 26 17:06:29 daisy kernel: POSIX conformance testing by UNIFIX
May 26 17:06:29 daisy kernel: enabled ExtINT on CPU#0
May 26 17:06:29 daisy kernel: ESR value before enabling vector: 00000000
May 26 17:06:29 daisy kernel: ESR value after enabling vector: 00000000
May 26 17:06:29 daisy kernel: Using local APIC timer interrupts.
May 26 17:06:29 daisy kernel: calibrating APIC timer ...
May 26 17:06:29 daisy kernel: ..... CPU clock speed is 400.9175 MHz.
May 26 17:06:30 daisy kernel: ..... host bus clock speed is 66.8195 MHz.
May 26 17:06:30 daisy kernel: cpu: 0, clocks: 668195, slice: 334097
May 26 17:06:30 daisy kernel: CPU0<T0:668192,T1:334080,D:15,S:334097,C:668195>
May 26 17:06:30 daisy kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
May 26 17:06:30 daisy kernel: mtrr: detected mtrr type: Intel
May 26 17:06:30 daisy kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb150, last bus=1
May 26 17:06:30 daisy kernel: PCI: Using configuration type 1
May 26 17:06:30 daisy kernel: PCI: Probing PCI hardware
May 26 17:06:30 daisy kernel: PCI: Using IRQ router VIA [1106/0596] at 00:07.0
May 26 17:06:30 daisy kernel: Activating ISA DMA hang workarounds.
May 26 17:06:30 daisy kernel: Linux NET4.0 for Linux 2.4
May 26 17:06:30 daisy kernel: Based upon Swansea University Computer Society NET3.039
May 26 17:06:30 daisy kernel: Initializing RT netlink socket
May 26 17:06:30 daisy kernel: Starting kswapd
May 26 17:06:30 daisy kernel: VFS: Diskquotas version dquot_6.4.0 initialized
May 26 17:06:30 daisy kernel: Journalled Block Device driver loaded
May 26 17:06:30 daisy kernel: vga16fb: initializing
May 26 17:06:30 daisy kernel: vga16fb: mapped to 0xc00a0000
May 26 17:06:30 daisy kernel: Console: switching to colour frame buffer device 80x30
May 26 17:06:30 daisy kernel: fb0: VGA16 VGA frame buffer device
May 26 17:06:30 daisy kernel: Detected PS/2 Mouse Port.
May 26 17:06:30 daisy kernel: pty: 256 Unix98 ptys configured
May 26 17:06:30 daisy kernel: keyboard: Timeout - AT keyboard not present?(ed)
May 26 17:06:31 daisy kernel: keyboard: Timeout - AT keyboard not present?(f4)
May 26 17:06:31 daisy kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
May 26 17:06:31 daisy kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
May 26 17:06:31 daisy kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
May 26 17:06:31 daisy kernel: Real Time Clock Driver v1.10e
May 26 17:06:31 daisy kernel: block: 128 slots per queue, batch=32
May 26 17:06:31 daisy kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
May 26 17:06:31 daisy kernel: Uniform Multi-Platform E-IDE driver Revision: 6.31
May 26 17:06:31 daisy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 26 17:06:31 daisy kernel: VP_IDE: IDE controller on PCI bus 00 dev 39
May 26 17:06:31 daisy kernel: VP_IDE: chipset revision 6
May 26 17:06:31 daisy kernel: VP_IDE: not 100%% native mode: will probe irqs later
May 26 17:06:32 daisy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
May 26 17:06:32 daisy kernel: VP_IDE: VIA vt82c596a (rev 07) IDE UDMA33 controller on pci00:07.1
May 26 17:06:32 daisy kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:pio
May 26 17:06:32 daisy kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:pio, hdd:pio
May 26 17:06:32 daisy kernel: hda: ST34342A, ATA DISK drive
May 26 17:06:32 daisy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
May 26 17:06:32 daisy kernel: hda: 8404830 sectors (4303 MB) w/128KiB Cache, CHS=523/255/63
May 26 17:06:32 daisy kernel: ide-floppy driver 0.97.sv
May 26 17:06:32 daisy kernel: Partition check:
May 26 17:06:32 daisy kernel:  hda: hda1 hda2
May 26 17:06:32 daisy kernel: FDC 0 is a post-1991 82077
May 26 17:06:32 daisy kernel: Loading I2O Core - (c) Copyright 1999 Red Hat Software
May 26 17:06:33 daisy kernel: I2O configuration manager v 0.04.
May 26 17:06:33 daisy kernel:   (C) Copyright 1999 Red Hat Software
May 26 17:06:33 daisy kernel: loop: loaded (max 8 devices)
May 26 17:06:33 daisy kernel: Compaq CISS Driver (v 2.4.5)
May 26 17:06:33 daisy kernel: ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
May 26 17:06:33 daisy kernel:   http://www.scyld.com/network/ne2k-pci.html
May 26 17:06:33 daisy kernel: PCI: Found IRQ 12 for device 00:0a.0
May 26 17:06:33 daisy kernel: eth0: RealTek RTL-8029 found at 0xd800, IRQ 12, 00:20:18:B8:B7:38.
May 26 17:06:33 daisy kernel: 8139cp 10/100 PCI Ethernet driver v0.0.6 (Nov 19, 2001)
May 26 17:06:33 daisy kernel: 8139cp: pci dev 00:0c.0 (id 10ec:8139 rev 10) is not an 8139C+ compatible chip
May 26 17:06:33 daisy kernel: 8139cp: Try the "8139too" driver instead.
May 26 17:06:33 daisy kernel: 8139too Fast Ethernet driver 0.9.24
May 26 17:06:34 daisy kernel: PCI: Found IRQ 5 for device 00:0c.0
May 26 17:06:34 daisy kernel: PCI: Sharing IRQ 5 with 00:0d.0
May 26 17:06:34 daisy kernel: eth1: RealTek RTL8139 Fast Ethernet at 0xc481a000, 00:50:fc:f6:9e:39, IRQ 5
May 26 17:06:34 daisy kernel: eth1:  Identified 8139 chip type 'RTL-8139C'

[...]


.config from 2.4.26

[...]
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=y
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
[...]


lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev 06)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e4000000-e5ffffff
	Prefetchable memory behind bridge: e6000000-e6ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 07)
	Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d400 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at d800 [size=32]
	Expansion ROM at e7000000 [disabled] [size=32K]

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev 7a) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0084
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



rtl8139-diag -mmmaaaeeef

rtl8139-diag.c:v1.01 4/30/99 Donald Becker (becker@cesdis.gsfc.nasa.gov)
Index #1: Found a RealTek RTL8139 adapter at 0xdc00.
RealTek chip registers at 0xdc00
 0x000: f6fc5000 0000399e 80000000 00000000 00002000 00002000 00002000 00002000
 0x020: 026de000 026de600 026dec00 026df200 02f80000 0d000000 0000fff0 0000c07f
 0x040: 74400680 0000f78e 2fe74e8c 00000000 004d10c6 00000000 0088c51c 00100000
 0x060: 1000000f 01e17809 00000000 00000000 00000704 000003c0 60f60c59 7b732660.
  No interrupt sources are pending.
 The chip configuration is 0x10 0x4d, MII full-duplex mode.
Parsing the EEPROM of a RealTek chip:
  PCI IDs -- Vendor 0x10ec, Device 0x8139, Subsystem 0x10ec.
  PCI timer settings -- minimum grant 32, maximum latency 64.
  General purpose pins --  direction 0xe5  value 0x12.
  Station Address 00:50:FC:F6:9E:39.
  Configuration register 0/1 -- 0x4d / 0xc2.
 EEPROM active region checksum is 0a9c.
EEPROM contents:
  8129 10ec 8139 10ec 8139 4020 e512 5000
  f6fc 399e 4d10 f7c2 8801 03b9 60f4 071a
  dfa3 9836 dfa3 9836 03b9 60f4 1a1a 1a1a
  0000 a2d1 0000 0000 0000 0000 0000 2000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
  0000 0000 0000 0000 0000 0000 0000 0000
 The word-wide EEPROM checksum is 0xcf3d.
 The RTL8139 does not use a MII transceiver.
 It does have internal MII-compatible registers:
   Basic mode control register   0x7809.
   Basic mode status register    0x1000.
   Autonegotiation Advertisement 0x01e1.
   Link Partner Ability register 0x0000.
   Autonegotiation expansion     0x0000.
   Disconnects                   0x0000.
   False carrier sense counter   0x0000.
   NWay test register            0x0704.
   Receive frame error count     0x0000.


-- 
publickey 1024D/215F9C87: http://www.icbm.de/~bube/publickey.asc
fingerprint: 607B 39BC C9E9 0F5E EF7F  4557 31D4 A73C 215F 9C87

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAvCKyMdSnPCFfnIcRAildAKCF9lbtSC5QgtDa/ij4fZt5JC21MACfZ1VI
/M9udXqO3m23aSozbuO2ZIc=
=fAhG
-----END PGP SIGNATURE-----
--=-=-=--
