Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVEFXYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVEFXYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEFXYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:24:12 -0400
Received: from mail.scgiservices.com ([198.107.3.67]:21508 "EHLO
	mail.scgiservices.com") by vger.kernel.org with ESMTP
	id S261336AbVEFXJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:09:48 -0400
From: "Anthony Brock" <brocka@sterlingcgi.com>
To: <linux-kernel@vger.kernel.org>
Subject: Freeze during boot when using serial console
Date: Fri, 6 May 2005 16:09:32 -0700
Message-ID: <OJEEKGNKKDLJIEPBEJMIGEKBCAAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0005_01C55255.FD353E70"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0005_01C55255.FD353E70
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I am not subscribed to the list, so please CC me on any replies.

I am attempting to upgrade my system (SuSE 9.1 Professional distribution)
from kernel 2.6.10. I initially tried kernel 2.6.11.6. However, the system
"freezes" during boot when the console is redirected to the serial port.

I have tried booting with kernels 2.6.11.6, 2.6.11.7, and 2.6.12-rc3. This
behavior is not observed with 2.6.10. Also, the system boots correctly with
2.6.11.[67] if I boot using the built-in video card and keyboard. However,
the problem can be reproduced on a development system.

While it can "freeze" at various places, it most often freezes at:

kjournald starting.  Commit interval 5 seconds
EXT3 FS on md1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Adding 1052216k swap on /dev/hde1.  Priority:42 extents:1
Adding 1052216k swap on /dev/hdg1.  Priority:42 extents:1

At this point, the system will sit for hours with no activity. Also, the
system never initializes the network or other software during this period.
However, pressing any key on an attached console will allow additional text
to appear. For example, pressing <tab> made the following appear:

/dev/md1 on /va

Pressing <tab> again displays:

r/lib/mysql typ

If I hold down the <tab> key, the boot will proceed normally until I see a
login prompt. At this point, everything seems to function normally (MySQL,
Apache, etc). If I stop at any point, the boot process immediately freezes
again. Intermittently, it will continue booting for several lines of output
before freezing.

The system is a Tyan Transport GX28 (B2882) with the supplied Thunder K8S
Pro (S2882) motherboard, 4 GB of ram and two AMD Opteron 242 processors. Our
hard drives (software mirrored ST3120026AS disks) are attached to a
HighPoint RocketRAID 1640 (HPT374) controller (we experienced instability
with the motherboard's builtin SATA controller).

The development system is identical except that it has 2 GB RAM and software
mirrored WDC WD2500JD-00GBB0 disks. The grub boot command is:

title Linux
    kernel (hd0,1)/boot/vmlinuz root=/dev/hde2 vga=0x314 splash=silent
console=tty0 console=ttyS0,38400n8 resume=/dev/hde1 showopts
    initrd (hd0,1)/boot/initrd

Please see the attached documents for the 2.6.12-rc3 configuration and
output from 'lspci -vv'. Any ideas on how to correct or troubleshoot the
issue?

Tony

------=_NextPart_000_0005_01C55255.FD353E70
Content-Type: text/plain;
	name="lspci-output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci-output.txt"

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev =
07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fca00000-feafffff
	Expansion ROM at 0000b000 [disabled] [size=3D4K]
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev =
05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE =
(rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=3D16]

0000:00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev =
02)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 9
	Region 0: I/O ports at cc00

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X =
Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D64
	Memory behind bridge: fc900000-fc9fffff
	Prefetchable memory behind bridge: 00000000ff500000-00000000ff500000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev =
01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febff000 (64-bit, non-prefetchable)

0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X =
Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D64
	I/O behind bridge: 00008000-0000afff
	Memory behind bridge: fc800000-fc8fffff
	Expansion ROM at 00008000 [disabled] [size=3D12K]
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] 	Capabilities: [b8] #08 [8000]

0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev =
01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 36c0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at febfe000 (64-bit, non-prefetchable)

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-

0000:01:03.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev =
07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at 9c00 [size=3Dfc8e0000]
	Region 1: I/O ports at 9400 [size=3D4]
	Region 2: I/O ports at 9000 [size=3D8]
	Region 3: I/O ports at 8c00 [size=3D4]
	Region 4: I/O ports at 8800 [size=3D256]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:01:03.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev =
07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: I/O ports at ac00
	Region 1: I/O ports at a800 [size=3D4]
	Region 2: I/O ports at a400 [size=3D8]
	Region 3: I/O ports at a000 [size=3D4]
	Region 4: I/O ports at 9800 [size=3D256]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 =
Gigabit Ethernet (rev 03)
	Subsystem: Broadcom Corporation: Unknown device 1644
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at fc9c0000 (64-bit, non-prefetchable) =
[size=3Dfc9a0000]
	Region 2: Memory at fc9b0000 (64-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/3 =
Enable-
		Address: 084c0ada21203008  Data: 0189

0000:02:09.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 =
Gigabit Ethernet (rev 03)
	Subsystem: Broadcom Corporation: Unknown device 1644
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin B routed to IRQ 25
	Region 0: Memory at fc9f0000 (64-bit, non-prefetchable) =
[size=3Dfc9d0000]
	Region 2: Memory at fc9e0000 (64-bit, non-prefetchable) [size=3D64K]
	Expansion ROM at 00010000 [disabled]
	Capabilities: [40] 	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=3D0/3 =
Enable-
		Address: 42f121222c214900  Data: 0007

0000:03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB =
(rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at feafc000 (32-bit, non-prefetchable)

0000:03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB =
(rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at feafd000 (32-bit, non-prefetchable)

0000:03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL =
(rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) =
[size=3Dfeac0000]
	Region 1: I/O ports at b800 [size=3D256]
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:03:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro =
100] (rev 10)
	Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at feafb000 (32-bit, non-prefetchable)
	Region 1: I/O ports at bc00 [size=3D64]
	Region 2: Memory at feaa0000 (32-bit, non-prefetchable) [size=3D128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-


------=_NextPart_000_0005_01C55255.FD353E70
Content-Type: text/plain;
	name="config-output.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="config-output.txt"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.12-rc3
# Fri May  6 14:31:41 2005
#
CONFIG_X86=3Dy
CONFIG_MMU=3Dy
CONFIG_UID16=3Dy
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_IOMAP=3Dy

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=3Dy
CONFIG_CLEAN_COMPILE=3Dy
CONFIG_LOCK_KERNEL=3Dy
CONFIG_INIT_ENV_ARG_LIMIT=3D32

#
# General setup
#
CONFIG_LOCALVERSION=3D""
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
# CONFIG_BSD_PROCESS_ACCT_V3 is not set
CONFIG_SYSCTL=3Dy
CONFIG_AUDIT=3Dy
CONFIG_AUDITSYSCALL=3Dy
CONFIG_HOTPLUG=3Dy
CONFIG_KOBJECT_UEVENT=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_CPUSETS is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=3Dy
# CONFIG_KALLSYMS_ALL is not set
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SHMEM=3Dy
CONFIG_CC_ALIGN_FUNCTIONS=3D0
CONFIG_CC_ALIGN_LABELS=3D0
CONFIG_CC_ALIGN_LOOPS=3D0
CONFIG_CC_ALIGN_JUMPS=3D0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=3D0

#
# Loadable module support
#
CONFIG_MODULES=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
CONFIG_OBSOLETE_MODPARM=3Dy
CONFIG_MODVERSIONS=3Dy
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_KMOD=3Dy
CONFIG_STOP_MACHINE=3Dy

#
# Processor type and features
#
# CONFIG_X86_PC is not set
# CONFIG_X86_ELAN is not set
# CONFIG_X86_VOYAGER is not set
# CONFIG_X86_NUMAQ is not set
# CONFIG_X86_SUMMIT is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_VISWS is not set
CONFIG_X86_GENERICARCH=3Dy
# CONFIG_X86_ES7000 is not set
CONFIG_X86_CYCLONE_TIMER=3Dy
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=3Dy
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MGEODE is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
CONFIG_X86_GENERIC=3Dy
CONFIG_X86_CMPXCHG=3Dy
CONFIG_X86_XADD=3Dy
CONFIG_X86_L1_CACHE_SHIFT=3D7
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_X86_PPRO_FENCE=3Dy
CONFIG_X86_WP_WORKS_OK=3Dy
CONFIG_X86_INVLPG=3Dy
CONFIG_X86_BSWAP=3Dy
CONFIG_X86_POPAD_OK=3Dy
CONFIG_X86_GOOD_APIC=3Dy
CONFIG_X86_INTEL_USERCOPY=3Dy
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy
# CONFIG_HPET_TIMER is not set
CONFIG_SMP=3Dy
CONFIG_NR_CPUS=3D32
CONFIG_SCHED_SMT=3Dy
# CONFIG_PREEMPT is not set
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_TSC=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_X86_MCE_NONFATAL is not set
CONFIG_X86_MCE_P4THERMAL=3Dy
CONFIG_TOSHIBA=3Dm
CONFIG_I8K=3Dm
CONFIG_MICROCODE=3Dm
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm

#
# Firmware Drivers
#
CONFIG_EDD=3Dm
CONFIG_EFI_VARS=3Dm
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=3Dy
# CONFIG_HIGHMEM64G is not set
CONFIG_HIGHMEM=3Dy
CONFIG_HIGHPTE=3Dy
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=3Dy
CONFIG_EFI=3Dy
CONFIG_IRQBALANCE=3Dy
CONFIG_HAVE_DEC_LOCK=3Dy
CONFIG_BOOT_IOREMAP=3Dy
CONFIG_REGPARM=3Dy
CONFIG_SECCOMP=3Dy

#
# Power management options (ACPI, APM)
#
CONFIG_PM=3Dy
# CONFIG_PM_DEBUG is not set
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=3Dy
CONFIG_ACPI_BOOT=3Dy
CONFIG_ACPI_INTERPRETER=3Dy
CONFIG_ACPI_SLEEP=3Dy
CONFIG_ACPI_SLEEP_PROC_FS=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dm
CONFIG_ACPI_VIDEO=3Dm
CONFIG_ACPI_FAN=3Dm
CONFIG_ACPI_PROCESSOR=3Dm
CONFIG_ACPI_THERMAL=3Dm
CONFIG_ACPI_ASUS=3Dm
CONFIG_ACPI_IBM=3Dm
CONFIG_ACPI_TOSHIBA=3Dm
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ACPI_BLACKLIST_YEAR=3D0
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=3Dy
CONFIG_ACPI_EC=3Dy
CONFIG_ACPI_POWER=3Dy
CONFIG_ACPI_PCI=3Dy
CONFIG_ACPI_SYSTEM=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_ACPI_CONTAINER=3Dm

#
# APM (Advanced Power Management) BIOS Support
#
CONFIG_APM=3Dy
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=3Dy
# CONFIG_APM_CPU_IDLE is not set
CONFIG_APM_DISPLAY_BLANK=3Dy
# CONFIG_APM_RTC_IS_GMT is not set
CONFIG_APM_ALLOW_INTS=3Dy
# CONFIG_APM_REAL_MODE_POWER_OFF is not set

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_TABLE=3Dm
# CONFIG_CPU_FREQ_DEBUG is not set
CONFIG_CPU_FREQ_STAT=3Dm
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm

#
# CPUFreq processor drivers
#
CONFIG_X86_ACPI_CPUFREQ=3Dm
CONFIG_X86_POWERNOW_K6=3Dm
CONFIG_X86_POWERNOW_K7=3Dm
CONFIG_X86_POWERNOW_K7_ACPI=3Dy
CONFIG_X86_POWERNOW_K8=3Dm
CONFIG_X86_POWERNOW_K8_ACPI=3Dy
CONFIG_X86_GX_SUSPMOD=3Dm
CONFIG_X86_SPEEDSTEP_CENTRINO=3Dm
CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI=3Dy
CONFIG_X86_SPEEDSTEP_CENTRINO_TABLE=3Dy
CONFIG_X86_SPEEDSTEP_ICH=3Dm
CONFIG_X86_SPEEDSTEP_SMI=3Dm
CONFIG_X86_P4_CLOCKMOD=3Dm
CONFIG_X86_CPUFREQ_NFORCE2=3Dm
CONFIG_X86_LONGRUN=3Dm
CONFIG_X86_LONGHAUL=3Dm

#
# shared options
#
# CONFIG_X86_ACPI_CPUFREQ_PROC_INTF is not set
CONFIG_X86_SPEEDSTEP_LIB=3Dm
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=3Dy
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=3Dy
CONFIG_PCI_BIOS=3Dy
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dm
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_LEGACY_PROC is not set
# CONFIG_PCI_NAMES is not set
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA=3Dy
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_SCx200=3Dm

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=3Dm
CONFIG_HOTPLUG_PCI_FAKE=3Dm
CONFIG_HOTPLUG_PCI_COMPAQ=3Dm
CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM=3Dy
CONFIG_HOTPLUG_PCI_IBM=3Dm
CONFIG_HOTPLUG_PCI_ACPI=3Dm
# CONFIG_HOTPLUG_PCI_ACPI_IBM is not set
CONFIG_HOTPLUG_PCI_CPCI=3Dy
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
CONFIG_HOTPLUG_PCI_SHPC=3Dm
# CONFIG_HOTPLUG_PCI_SHPC_POLL_EVENT_MODE is not set

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_BINFMT_AOUT=3Dm
CONFIG_BINFMT_MISC=3Dm

#
# Device Drivers
#

#
# Generic Driver Options
#
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dm
# CONFIG_DEBUG_DRIVER is not set

#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=3Dm
# CONFIG_MTD_DEBUG is not set
CONFIG_MTD_CONCAT=3Dm
CONFIG_MTD_PARTITIONS=3Dy
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_CHAR=3Dm
CONFIG_MTD_BLOCK=3Dm
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
CONFIG_MTD_CFI_ADV_OPTIONS=3Dy
CONFIG_MTD_CFI_NOSWAP=3Dy
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
# CONFIG_MTD_CFI_GEOMETRY is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_AMDSTD_RETRY=3D0
CONFIG_MTD_CFI_STAA=3Dm
CONFIG_MTD_CFI_UTIL=3Dm
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
CONFIG_MTD_ABSENT=3Dm

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
CONFIG_MTD_PHYSMAP=3Dm
CONFIG_MTD_PHYSMAP_START=3D0x8000000
CONFIG_MTD_PHYSMAP_LEN=3D0x4000000
CONFIG_MTD_PHYSMAP_BANKWIDTH=3D2
# CONFIG_MTD_PNC2000 is not set
CONFIG_MTD_SC520CDP=3Dm
# CONFIG_MTD_NETSC520 is not set
# CONFIG_MTD_TS5500 is not set
# CONFIG_MTD_SBC_GXX is not set
# CONFIG_MTD_ELAN_104NC is not set
# CONFIG_MTD_SCx200_DOCFLASH is not set
CONFIG_MTD_AMD76XROM=3Dm
# CONFIG_MTD_ICHXROM is not set
CONFIG_MTD_SCB2_FLASH=3Dm
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_DILNETPC is not set
CONFIG_MTD_L440GX=3Dm
CONFIG_MTD_PCI=3Dm

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=3Dm
CONFIG_MTD_PMC551_BUGFIX=3Dy
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_SLRAM=3Dm
# CONFIG_MTD_PHRAM is not set
CONFIG_MTD_MTDRAM=3Dm
CONFIG_MTDRAM_TOTAL_SIZE=3D4096
CONFIG_MTDRAM_ERASE_SIZE=3D128
CONFIG_MTD_BLKMTD=3Dm
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOC2000=3Dm
CONFIG_MTD_DOC2001=3Dm
CONFIG_MTD_DOC2001PLUS=3Dm
CONFIG_MTD_DOCPROBE=3Dm
CONFIG_MTD_DOCECC=3Dm
CONFIG_MTD_DOCPROBE_ADVANCED=3Dy
CONFIG_MTD_DOCPROBE_ADDRESS=3D0x0000
CONFIG_MTD_DOCPROBE_HIGH=3Dy
CONFIG_MTD_DOCPROBE_55AA=3Dy

#
# NAND Flash Device Drivers
#
CONFIG_MTD_NAND=3Dm
# CONFIG_MTD_NAND_VERIFY_WRITE is not set
CONFIG_MTD_NAND_IDS=3Dm
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_NAND_NANDSIM is not set

#
# Parallel port support
#
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_SERIAL=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_1284=3Dy

#
# Plug and Play support
#
CONFIG_PNP=3Dy
# CONFIG_PNP_DEBUG is not set

#
# Protocols
#
CONFIG_ISAPNP=3Dy
# CONFIG_PNPBIOS is not set
CONFIG_PNPACPI=3Dy

#
# Block devices
#
CONFIG_BLK_DEV_FD=3Dy
CONFIG_BLK_DEV_XD=3Dm
CONFIG_PARIDE=3Dm
CONFIG_PARIDE_PARPORT=3Dm

#
# Parallel IDE high-level drivers
#
CONFIG_PARIDE_PD=3Dm
CONFIG_PARIDE_PCD=3Dm
CONFIG_PARIDE_PF=3Dm
CONFIG_PARIDE_PT=3Dm
CONFIG_PARIDE_PG=3Dm

#
# Parallel IDE protocol modules
#
CONFIG_PARIDE_ATEN=3Dm
CONFIG_PARIDE_BPCK=3Dm
CONFIG_PARIDE_BPCK6=3Dm
CONFIG_PARIDE_COMM=3Dm
CONFIG_PARIDE_DSTR=3Dm
CONFIG_PARIDE_FIT2=3Dm
CONFIG_PARIDE_FIT3=3Dm
CONFIG_PARIDE_EPAT=3Dm
CONFIG_PARIDE_EPATC8=3Dy
CONFIG_PARIDE_EPIA=3Dm
CONFIG_PARIDE_FRIQ=3Dm
CONFIG_PARIDE_FRPW=3Dm
CONFIG_PARIDE_KBIC=3Dm
CONFIG_PARIDE_KTTI=3Dm
CONFIG_PARIDE_ON20=3Dm
CONFIG_PARIDE_ON26=3Dm
CONFIG_BLK_CPQ_DA=3Dm
CONFIG_BLK_CPQ_CISS_DA=3Dm
CONFIG_CISS_SCSI_TAPE=3Dy
CONFIG_BLK_DEV_DAC960=3Dm
CONFIG_BLK_DEV_UMEM=3Dm
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_SX8=3Dm
# CONFIG_BLK_DEV_UB is not set
CONFIG_BLK_DEV_RAM=3Dy
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D524288
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_LBD=3Dy
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
CONFIG_IOSCHED_AS=3Dy
CONFIG_IOSCHED_DEADLINE=3Dy
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_ATA_OVER_ETH=3Dm

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=3Dy
CONFIG_BLK_DEV_IDE=3Dy

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=3Dy
CONFIG_IDEDISK_MULTI_MODE=3Dy
CONFIG_BLK_DEV_IDECD=3Dm
CONFIG_BLK_DEV_IDETAPE=3Dm
CONFIG_BLK_DEV_IDEFLOPPY=3Dy
CONFIG_BLK_DEV_IDESCSI=3Dm
# CONFIG_IDE_TASK_IOCTL is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=3Dy
CONFIG_BLK_DEV_CMD640=3Dy
CONFIG_BLK_DEV_CMD640_ENHANCED=3Dy
CONFIG_BLK_DEV_IDEPNP=3Dy
CONFIG_BLK_DEV_IDEPCI=3Dy
CONFIG_IDEPCI_SHARE_IRQ=3Dy
CONFIG_BLK_DEV_OFFBOARD=3Dy
CONFIG_BLK_DEV_GENERIC=3Dy
CONFIG_BLK_DEV_OPTI621=3Dy
CONFIG_BLK_DEV_RZ1000=3Dy
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=3Dy
CONFIG_IDEDMA_ONLYDISK=3Dy
CONFIG_BLK_DEV_AEC62XX=3Dy
CONFIG_BLK_DEV_ALI15X3=3Dy
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=3Dy
CONFIG_BLK_DEV_ATIIXP=3Dy
CONFIG_BLK_DEV_CMD64X=3Dy
CONFIG_BLK_DEV_TRIFLEX=3Dy
CONFIG_BLK_DEV_CY82C693=3Dy
CONFIG_BLK_DEV_CS5520=3Dm
CONFIG_BLK_DEV_CS5530=3Dm
CONFIG_BLK_DEV_HPT34X=3Dy
CONFIG_HPT34X_AUTODMA=3Dy
CONFIG_BLK_DEV_HPT366=3Dy
CONFIG_BLK_DEV_SC1200=3Dy
CONFIG_BLK_DEV_PIIX=3Dy
CONFIG_BLK_DEV_NS87415=3Dy
CONFIG_BLK_DEV_PDC202XX_OLD=3Dy
CONFIG_PDC202XX_BURST=3Dy
CONFIG_BLK_DEV_PDC202XX_NEW=3Dy
CONFIG_PDC202XX_FORCE=3Dy
CONFIG_BLK_DEV_SVWKS=3Dy
CONFIG_BLK_DEV_SIIMAGE=3Dy
CONFIG_BLK_DEV_SIS5513=3Dy
CONFIG_BLK_DEV_SLC90E66=3Dy
CONFIG_BLK_DEV_TRM290=3Dy
CONFIG_BLK_DEV_VIA82CXXX=3Dy
# CONFIG_IDE_ARM is not set
CONFIG_IDE_CHIPSETS=3Dy

#
# Note: most of these also require special kernel boot parameters
#
CONFIG_BLK_DEV_4DRIVES=3Dy
CONFIG_BLK_DEV_ALI14XX=3Dy
CONFIG_BLK_DEV_DTC2278=3Dy
CONFIG_BLK_DEV_HT6560B=3Dy
CONFIG_BLK_DEV_QD65XX=3Dy
CONFIG_BLK_DEV_UMC8672=3Dy
CONFIG_BLK_DEV_IDEDMA=3Dy
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=3Dy
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=3Dm
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dm
CONFIG_CHR_DEV_ST=3Dm
CONFIG_CHR_DEV_OSST=3Dm
CONFIG_BLK_DEV_SR=3Dm
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=3Dm

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy

#
# SCSI Transport Attributes
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_ISCSI_ATTRS=3Dm

#
# SCSI low-level drivers
#
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
CONFIG_SCSI_3W_9XXX=3Dm
CONFIG_SCSI_7000FASST=3Dm
CONFIG_SCSI_ACARD=3Dm
CONFIG_SCSI_AHA152X=3Dm
CONFIG_SCSI_AHA1542=3Dm
CONFIG_SCSI_AACRAID=3Dm
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC7XXX_OLD=3Dm
CONFIG_SCSI_AIC79XX=3Dm
CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
# CONFIG_AIC79XX_ENABLE_RD_STRM is not set
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_DPT_I2O=3Dm
CONFIG_SCSI_IN2000=3Dm
CONFIG_MEGARAID_NEWGEN=3Dy
CONFIG_MEGARAID_MM=3Dm
CONFIG_MEGARAID_MAILBOX=3Dm
CONFIG_SCSI_SATA=3Dy
CONFIG_SCSI_SATA_AHCI=3Dm
CONFIG_SCSI_SATA_SVW=3Dm
CONFIG_SCSI_ATA_PIIX=3Dm
CONFIG_SCSI_SATA_NV=3Dm
CONFIG_SCSI_SATA_PROMISE=3Dm
CONFIG_SCSI_SATA_QSTOR=3Dm
CONFIG_SCSI_SATA_SX4=3Dm
CONFIG_SCSI_SATA_SIL=3Dm
CONFIG_SCSI_SATA_SIS=3Dm
CONFIG_SCSI_SATA_ULI=3Dm
CONFIG_SCSI_SATA_VIA=3Dm
CONFIG_SCSI_SATA_VITESSE=3Dm
CONFIG_SCSI_BUSLOGIC=3Dm
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
CONFIG_SCSI_DMX3191D=3Dm
CONFIG_SCSI_DTC3280=3Dm
CONFIG_SCSI_EATA=3Dm
CONFIG_SCSI_EATA_TAGGED_QUEUE=3Dy
CONFIG_SCSI_EATA_LINKED_COMMANDS=3Dy
CONFIG_SCSI_EATA_MAX_TAGS=3D16
CONFIG_SCSI_FUTURE_DOMAIN=3Dm
CONFIG_SCSI_GDTH=3Dm
CONFIG_SCSI_GENERIC_NCR5380=3Dm
CONFIG_SCSI_GENERIC_NCR5380_MMIO=3Dm
CONFIG_SCSI_GENERIC_NCR53C400=3Dy
CONFIG_SCSI_IPS=3Dm
CONFIG_SCSI_INITIO=3Dm
CONFIG_SCSI_INIA100=3Dm
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_NCR53C406A=3Dm
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
CONFIG_SCSI_IPR=3Dm
CONFIG_SCSI_IPR_TRACE=3Dy
CONFIG_SCSI_IPR_DUMP=3Dy
CONFIG_SCSI_PAS16=3Dm
CONFIG_SCSI_PSI240I=3Dm
CONFIG_SCSI_QLOGIC_FAS=3Dm
CONFIG_SCSI_QLOGIC_FC=3Dm
CONFIG_SCSI_QLOGIC_FC_FIRMWARE=3Dy
CONFIG_SCSI_QLOGIC_1280=3Dm
# CONFIG_SCSI_QLOGIC_1280_1040 is not set
CONFIG_SCSI_QLA2XXX=3Dm
CONFIG_SCSI_QLA21XX=3Dm
CONFIG_SCSI_QLA22XX=3Dm
CONFIG_SCSI_QLA2300=3Dm
CONFIG_SCSI_QLA2322=3Dm
CONFIG_SCSI_QLA6312=3Dm
CONFIG_SCSI_LPFC=3Dm
CONFIG_SCSI_SYM53C416=3Dm
CONFIG_SCSI_DC395x=3Dm
CONFIG_SCSI_DC390T=3Dm
CONFIG_SCSI_T128=3Dm
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
CONFIG_SCSI_NSP32=3Dm
CONFIG_SCSI_DEBUG=3Dm

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
CONFIG_CD_NO_IDESCSI=3Dy
CONFIG_AZTCD=3Dm
CONFIG_GSCD=3Dm
# CONFIG_MCDX is not set
CONFIG_OPTCD=3Dm
CONFIG_SJCD=3Dm
CONFIG_ISP16_CDI=3Dm
CONFIG_CDU535=3Dm

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dy
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID5=3Dm
CONFIG_MD_RAID6=3Dm
CONFIG_MD_MULTIPATH=3Dm
# CONFIG_MD_FAULTY is not set
CONFIG_BLK_DEV_DM=3Dm
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_EMC=3Dm

#
# Fusion MPT device support
#
CONFIG_FUSION=3Dm
CONFIG_FUSION_MAX_SGE=3D40
CONFIG_FUSION_CTL=3Dm
CONFIG_FUSION_LAN=3Dm

#
# IEEE 1394 (FireWire) support
#
CONFIG_IEEE1394=3Dm

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set
CONFIG_IEEE1394_EXTRA_CONFIG_ROMS=3Dy
CONFIG_IEEE1394_CONFIG_ROM_IP1394=3Dy

#
# Device Drivers
#
CONFIG_IEEE1394_PCILYNX=3Dm
CONFIG_IEEE1394_OHCI1394=3Dm

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=3Dm
CONFIG_IEEE1394_SBP2=3Dm
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
CONFIG_IEEE1394_ETH1394=3Dm
CONFIG_IEEE1394_DV1394=3Dm
CONFIG_IEEE1394_RAWIO=3Dm
CONFIG_IEEE1394_CMP=3Dm
CONFIG_IEEE1394_AMDTP=3Dm

#
# I2O device support
#
CONFIG_I2O=3Dm
CONFIG_I2O_CONFIG=3Dm
CONFIG_I2O_BLOCK=3Dm
CONFIG_I2O_SCSI=3Dm
CONFIG_I2O_PROC=3Dm

#
# Networking support
#
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dm
CONFIG_PACKET_MMAP=3Dy
CONFIG_UNIX=3Dy
CONFIG_NET_KEY=3Dm
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_FWMARK=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
# CONFIG_IP_ROUTE_MULTIPATH_CACHED is not set
CONFIG_IP_ROUTE_VERBOSE=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE=3Dm
CONFIG_NET_IPGRE_BROADCAST=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_IP_TCPDIAG=3Dy
# CONFIG_IP_TCPDIAG_IPV6 is not set

#
# IP: Virtual Server Configuration
#
CONFIG_IP_VS=3Dm
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IPV6=3Dm
CONFIG_IPV6_PRIVACY=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_NETFILTER=3Dy
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_BRIDGE_NETFILTER=3Dy

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=3Dm
# CONFIG_IP_NF_CT_ACCT is not set
CONFIG_IP_NF_CONNTRACK_MARK=3Dy
# CONFIG_IP_NF_CT_PROTO_SCTP is not set
CONFIG_IP_NF_FTP=3Dm
CONFIG_IP_NF_IRC=3Dm
CONFIG_IP_NF_TFTP=3Dm
CONFIG_IP_NF_AMANDA=3Dm
CONFIG_IP_NF_QUEUE=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_LIMIT=3Dm
CONFIG_IP_NF_MATCH_IPRANGE=3Dm
CONFIG_IP_NF_MATCH_MAC=3Dm
CONFIG_IP_NF_MATCH_PKTTYPE=3Dm
CONFIG_IP_NF_MATCH_MARK=3Dm
CONFIG_IP_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP_NF_MATCH_TOS=3Dm
CONFIG_IP_NF_MATCH_RECENT=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_DSCP=3Dm
CONFIG_IP_NF_MATCH_AH_ESP=3Dm
CONFIG_IP_NF_MATCH_LENGTH=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_MATCH_TCPMSS=3Dm
CONFIG_IP_NF_MATCH_HELPER=3Dm
CONFIG_IP_NF_MATCH_STATE=3Dm
CONFIG_IP_NF_MATCH_CONNTRACK=3Dm
CONFIG_IP_NF_MATCH_OWNER=3Dm
CONFIG_IP_NF_MATCH_PHYSDEV=3Dm
CONFIG_IP_NF_MATCH_ADDRTYPE=3Dm
CONFIG_IP_NF_MATCH_REALM=3Dm
CONFIG_IP_NF_MATCH_SCTP=3Dm
CONFIG_IP_NF_MATCH_COMMENT=3Dm
CONFIG_IP_NF_MATCH_CONNMARK=3Dm
CONFIG_IP_NF_MATCH_HASHLIMIT=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_LOG=3Dm
CONFIG_IP_NF_TARGET_ULOG=3Dm
CONFIG_IP_NF_TARGET_TCPMSS=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_NAT_NEEDED=3Dy
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_SAME=3Dm
CONFIG_IP_NF_NAT_SNMP_BASIC=3Dm
CONFIG_IP_NF_NAT_IRC=3Dm
CONFIG_IP_NF_NAT_FTP=3Dm
CONFIG_IP_NF_NAT_TFTP=3Dm
CONFIG_IP_NF_NAT_AMANDA=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_TOS=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_DSCP=3Dm
CONFIG_IP_NF_TARGET_MARK=3Dm
CONFIG_IP_NF_TARGET_CLASSIFY=3Dm
CONFIG_IP_NF_TARGET_CONNMARK=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_TARGET_NOTRACK=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm

#
# IPv6: Netfilter Configuration (EXPERIMENTAL)
#
CONFIG_IP6_NF_QUEUE=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_LIMIT=3Dm
CONFIG_IP6_NF_MATCH_MAC=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_MULTIPORT=3Dm
CONFIG_IP6_NF_MATCH_OWNER=3Dm
CONFIG_IP6_NF_MATCH_MARK=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_AHESP=3Dm
CONFIG_IP6_NF_MATCH_LENGTH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_PHYSDEV=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_LOG=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_TARGET_MARK=3Dm
CONFIG_IP6_NF_RAW=3Dm

#
# DECnet: Netfilter Configuration
#
CONFIG_DECNET_NF_GRABULATOR=3Dm

#
# Bridge: Netfilter Configuration
#
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_ULOG=3Dm
CONFIG_XFRM=3Dy
CONFIG_XFRM_USER=3Dm

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_MSG is not set
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_HMAC_NONE is not set
# CONFIG_SCTP_HMAC_SHA1 is not set
CONFIG_SCTP_HMAC_MD5=3Dy
CONFIG_ATM=3Dy
CONFIG_ATM_CLIP=3Dy
CONFIG_ATM_CLIP_NO_ICMP=3Dy
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_BRIDGE=3Dm
CONFIG_VLAN_8021Q=3Dm
CONFIG_DECNET=3Dm
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=3Dy
CONFIG_LLC2=3Dm
CONFIG_IPX=3Dm
# CONFIG_IPX_INTERN is not set
CONFIG_ATALK=3Dm
CONFIG_DEV_APPLETALK=3Dy
CONFIG_LTPC=3Dm
CONFIG_COPS=3Dm
CONFIG_COPS_DAYNA=3Dy
CONFIG_COPS_TANGENT=3Dy
CONFIG_IPDDP=3Dm
CONFIG_IPDDP_ENCAP=3Dy
CONFIG_IPDDP_DECAP=3Dy
CONFIG_X25=3Dm
CONFIG_LAPB=3Dm
# CONFIG_NET_DIVERT is not set
CONFIG_ECONET=3Dm
# CONFIG_ECONET_AUNUDP is not set
# CONFIG_ECONET_NATIVE is not set
CONFIG_WAN_ROUTER=3Dm

#
# QoS and/or fair queueing
#
CONFIG_NET_SCHED=3Dy
CONFIG_NET_SCH_CLK_JIFFIES=3Dy
# CONFIG_NET_SCH_CLK_GETTIMEOFDAY is not set
# CONFIG_NET_SCH_CLK_CPU is not set
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dy
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
# CONFIG_NET_SCH_NETEM is not set
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_QOS=3Dy
CONFIG_NET_ESTIMATOR=3Dy
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_ROUTE=3Dy
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
# CONFIG_CLS_U32_PERF is not set
# CONFIG_NET_CLS_IND is not set
# CONFIG_CLS_U32_MARK is not set
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
# CONFIG_NET_EMATCH is not set
# CONFIG_NET_CLS_ACT is not set
CONFIG_NET_CLS_POLICE=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NETPOLL=3Dy
CONFIG_NETPOLL_RX=3Dy
CONFIG_NETPOLL_TRAP=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dm
CONFIG_AX25_DAMA_SLAVE=3Dy
CONFIG_NETROM=3Dm
CONFIG_ROSE=3Dm

#
# AX.25 network device drivers
#
CONFIG_BPQETHER=3Dm
CONFIG_SCC=3Dm
CONFIG_SCC_DELAY=3Dy
CONFIG_SCC_TRXECHO=3Dy
CONFIG_BAYCOM_SER_FDX=3Dm
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_BAYCOM_PAR=3Dm
CONFIG_BAYCOM_EPP=3Dm
CONFIG_YAM=3Dm
CONFIG_IRDA=3Dm

#
# IrDA protocols
#
CONFIG_IRLAN=3Dm
CONFIG_IRNET=3Dm
CONFIG_IRCOMM=3Dm
CONFIG_IRDA_ULTRA=3Dy

#
# IrDA options
#
CONFIG_IRDA_CACHE_LAST_LSAP=3Dy
# CONFIG_IRDA_FAST_RR is not set
# CONFIG_IRDA_DEBUG is not set

#
# Infrared-port device drivers
#

#
# SIR device drivers
#
CONFIG_IRTTY_SIR=3Dm

#
# Dongle support
#
CONFIG_DONGLE=3Dy
CONFIG_ESI_DONGLE=3Dm
CONFIG_ACTISYS_DONGLE=3Dm
CONFIG_TEKRAM_DONGLE=3Dm
CONFIG_LITELINK_DONGLE=3Dm
CONFIG_MA600_DONGLE=3Dm
CONFIG_GIRBIL_DONGLE=3Dm
CONFIG_MCP2120_DONGLE=3Dm
CONFIG_OLD_BELKIN_DONGLE=3Dm
CONFIG_ACT200L_DONGLE=3Dm

#
# Old SIR device drivers
#

#
# Old Serial dongle support
#

#
# FIR device drivers
#
CONFIG_USB_IRDA=3Dm
CONFIG_SIGMATEL_FIR=3Dm
CONFIG_NSC_FIR=3Dm
CONFIG_WINBOND_FIR=3Dm
CONFIG_TOSHIBA_FIR=3Dm
CONFIG_SMC_IRCC_FIR=3Dm
CONFIG_ALI_FIR=3Dm
CONFIG_VLSI_FIR=3Dm
CONFIG_VIA_FIR=3Dm
CONFIG_BT=3Dm
CONFIG_BT_L2CAP=3Dm
CONFIG_BT_SCO=3Dm
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_CMTP=3Dm
# CONFIG_BT_HIDP is not set

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=3Dm
CONFIG_BT_HCIUSB_SCO=3Dy
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_BCSP_TXCRC=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_DUMMY=3Dm
CONFIG_BONDING=3Dm
CONFIG_EQUALIZER=3Dm
CONFIG_TUN=3Dm
CONFIG_NET_SB1000=3Dm

#
# ARCnet devices
#
CONFIG_ARCNET=3Dm
CONFIG_ARCNET_1201=3Dm
CONFIG_ARCNET_1051=3Dm
CONFIG_ARCNET_RAW=3Dm
CONFIG_ARCNET_CAP=3Dm
CONFIG_ARCNET_COM90xx=3Dm
CONFIG_ARCNET_COM90xxIO=3Dm
CONFIG_ARCNET_RIM_I=3Dm
# CONFIG_ARCNET_COM20020 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=3Dy
CONFIG_MII=3Dm
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNGEM=3Dm
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_EL1=3Dm
CONFIG_EL2=3Dm
CONFIG_ELPLUS=3Dm
CONFIG_EL16=3Dm
CONFIG_EL3=3Dm
CONFIG_3C515=3Dm
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
CONFIG_LANCE=3Dm
CONFIG_NET_VENDOR_SMC=3Dy
CONFIG_WD80x3=3Dm
CONFIG_ULTRA=3Dm
CONFIG_SMC9194=3Dm
CONFIG_NET_VENDOR_RACAL=3Dy
CONFIG_NI52=3Dm
CONFIG_NI65=3Dm

#
# Tulip family network device support
#
CONFIG_NET_TULIP=3Dy
CONFIG_DE2104X=3Dm
CONFIG_TULIP=3Dm
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
CONFIG_TULIP_NAPI=3Dy
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
CONFIG_DE4X5=3Dm
CONFIG_WINBOND_840=3Dm
CONFIG_DM9102=3Dm
CONFIG_AT1700=3Dm
CONFIG_DEPCA=3Dm
CONFIG_HP100=3Dm
CONFIG_NET_ISA=3Dy
CONFIG_E2100=3Dm
CONFIG_EWRK3=3Dm
CONFIG_EEXPRESS=3Dm
CONFIG_EEXPRESS_PRO=3Dm
CONFIG_HPLAN_PLUS=3Dm
CONFIG_HPLAN=3Dm
CONFIG_LP486E=3Dm
CONFIG_ETH16I=3Dm
CONFIG_NE2000=3Dm
CONFIG_ZNET=3Dm
CONFIG_SEEQ8005=3Dm
CONFIG_NET_PCI=3Dy
CONFIG_PCNET32=3Dm
CONFIG_AMD8111_ETH=3Dm
# CONFIG_AMD8111E_NAPI is not set
CONFIG_ADAPTEC_STARFIRE=3Dm
CONFIG_ADAPTEC_STARFIRE_NAPI=3Dy
CONFIG_AC3200=3Dm
CONFIG_APRICOT=3Dm
CONFIG_B44=3Dm
CONFIG_FORCEDETH=3Dm
CONFIG_CS89x0=3Dm
CONFIG_DGRS=3Dm
CONFIG_EEPRO100=3Dm
CONFIG_E100=3Dm
CONFIG_FEALNX=3Dm
CONFIG_NATSEMI=3Dm
CONFIG_NE2K_PCI=3Dm
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_SIS900=3Dm
CONFIG_EPIC100=3Dm
CONFIG_SUNDANCE=3Dm
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_TLAN=3Dm
CONFIG_VIA_RHINE=3Dm
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_NET_POCKET=3Dy
CONFIG_ATP=3Dm
CONFIG_DE600=3Dm
CONFIG_DE620=3Dm

#
# Ethernet (1000 Mbit)
#
CONFIG_ACENIC=3Dm
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_DL2K=3Dm
CONFIG_E1000=3Dm
CONFIG_E1000_NAPI=3Dy
CONFIG_NS83820=3Dm
CONFIG_HAMACHI=3Dm
CONFIG_YELLOWFIN=3Dm
CONFIG_R8169=3Dm
# CONFIG_R8169_NAPI is not set
CONFIG_R8169_VLAN=3Dy
CONFIG_SK98LIN=3Dm
CONFIG_VIA_VELOCITY=3Dm
CONFIG_TIGON3=3Dm

#
# Ethernet (10000 Mbit)
#
CONFIG_IXGB=3Dm
CONFIG_IXGB_NAPI=3Dy
CONFIG_S2IO=3Dm
CONFIG_S2IO_NAPI=3Dy
# CONFIG_2BUFF_MODE is not set

#
# Token Ring devices
#
CONFIG_TR=3Dy
CONFIG_IBMTR=3Dm
CONFIG_IBMOL=3Dm
CONFIG_IBMLS=3Dm
CONFIG_3C359=3Dm
CONFIG_TMS380TR=3Dm
CONFIG_TMSPCI=3Dm
CONFIG_SKISA=3Dm
CONFIG_PROTEON=3Dm
CONFIG_ABYSS=3Dm
CONFIG_SMCTR=3Dm

#
# Wireless LAN (non-hamradio)
#
CONFIG_NET_RADIO=3Dy

#
# Obsolete Wireless cards support (pre-802.11)
#
CONFIG_STRIP=3Dm
# CONFIG_ARLAN is not set
CONFIG_WAVELAN=3Dm

#
# Wireless 802.11b ISA/PCI cards support
#
CONFIG_AIRO=3Dm
CONFIG_HERMES=3Dm
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_ATMEL=3Dm
CONFIG_PCI_ATMEL=3Dm

#
# Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support
#
CONFIG_PRISM54=3Dm
CONFIG_NET_WIRELESS=3Dy

#
# Wan interfaces
#
CONFIG_WAN=3Dy
CONFIG_HOSTESS_SV11=3Dm
# CONFIG_COSA is not set
# CONFIG_DSCC4 is not set
CONFIG_LANMEDIA=3Dm
CONFIG_SEALEVEL_4021=3Dm
CONFIG_SYNCLINK_SYNCPPP=3Dm
CONFIG_HDLC=3Dm
CONFIG_HDLC_RAW=3Dy
CONFIG_HDLC_RAW_ETH=3Dy
CONFIG_HDLC_CISCO=3Dy
CONFIG_HDLC_FR=3Dy
CONFIG_HDLC_PPP=3Dy
CONFIG_HDLC_X25=3Dy
CONFIG_PCI200SYN=3Dm
CONFIG_WANXL=3Dm
# CONFIG_PC300 is not set
CONFIG_N2=3Dm
CONFIG_C101=3Dm
CONFIG_FARSYNC=3Dm
CONFIG_DLCI=3Dm
CONFIG_DLCI_COUNT=3D24
CONFIG_DLCI_MAX=3D8
CONFIG_SDLA=3Dm
# CONFIG_WAN_ROUTER_DRIVERS is not set
CONFIG_LAPBETHER=3Dm
CONFIG_X25_ASY=3Dm
# CONFIG_SBNI is not set

#
# ATM drivers
#
CONFIG_ATM_TCP=3Dm
CONFIG_ATM_LANAI=3Dm
CONFIG_ATM_ENI=3Dm
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=3Dm
CONFIG_ATM_ZATM=3Dm
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=3Dm
CONFIG_ATM_NICSTAR_USE_SUNI=3Dy
CONFIG_ATM_NICSTAR_USE_IDT77105=3Dy
CONFIG_ATM_IDT77252=3Dm
# CONFIG_ATM_IDT77252_DEBUG is not set
CONFIG_ATM_IDT77252_RCV_ALL=3Dy
CONFIG_ATM_IDT77252_USE_SUNI=3Dy
CONFIG_ATM_AMBASSADOR=3Dm
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=3Dm
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=3Dm
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E_MAYBE=3Dm
CONFIG_ATM_FORE200E_PCA=3Dy
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=3Dy
# CONFIG_ATM_FORE200E_USE_TASKLET is not set
CONFIG_ATM_FORE200E_TX_RETRY=3D16
CONFIG_ATM_FORE200E_DEBUG=3D0
CONFIG_ATM_FORE200E=3Dm
CONFIG_ATM_HE=3Dm
CONFIG_ATM_HE_USE_SUNI=3Dy
CONFIG_FDDI=3Dy
# CONFIG_DEFXX is not set
CONFIG_SKFP=3Dm
CONFIG_HIPPI=3Dy
CONFIG_ROADRUNNER=3Dm
CONFIG_ROADRUNNER_LARGE_RINGS=3Dy
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPPOATM=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
CONFIG_NET_FC=3Dy
CONFIG_SHAPER=3Dm
CONFIG_NETCONSOLE=3Dm

#
# ISDN subsystem
#
CONFIG_ISDN=3Dm

#
# Old ISDN4Linux
#
CONFIG_ISDN_I4L=3Dm
CONFIG_ISDN_PPP=3Dy
CONFIG_ISDN_PPP_VJ=3Dy
CONFIG_ISDN_MPP=3Dy
CONFIG_IPPP_FILTER=3Dy
CONFIG_ISDN_PPP_BSDCOMP=3Dm
CONFIG_ISDN_AUDIO=3Dy
CONFIG_ISDN_TTY_FAX=3Dy
CONFIG_ISDN_X25=3Dy

#
# ISDN feature submodules
#
# CONFIG_ISDN_DIVERSION is not set

#
# ISDN4Linux hardware drivers
#

#
# Passive cards
#
CONFIG_ISDN_DRV_HISAX=3Dm

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=3Dy
CONFIG_DE_AOC=3Dy
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
CONFIG_HISAX_1TR6=3Dy
CONFIG_HISAX_NI1=3Dy
CONFIG_HISAX_MAX_CARDS=3D8

#
# HiSax supported cards
#
CONFIG_HISAX_16_0=3Dy
CONFIG_HISAX_16_3=3Dy
CONFIG_HISAX_TELESPCI=3Dy
CONFIG_HISAX_S0BOX=3Dy
CONFIG_HISAX_AVM_A1=3Dy
CONFIG_HISAX_FRITZPCI=3Dy
CONFIG_HISAX_AVM_A1_PCMCIA=3Dy
CONFIG_HISAX_ELSA=3Dy
CONFIG_HISAX_IX1MICROR2=3Dy
CONFIG_HISAX_DIEHLDIVA=3Dy
CONFIG_HISAX_ASUSCOM=3Dy
CONFIG_HISAX_TELEINT=3Dy
CONFIG_HISAX_HFCS=3Dy
CONFIG_HISAX_SEDLBAUER=3Dy
CONFIG_HISAX_SPORTSTER=3Dy
CONFIG_HISAX_MIC=3Dy
CONFIG_HISAX_NETJET=3Dy
CONFIG_HISAX_NETJET_U=3Dy
CONFIG_HISAX_NICCY=3Dy
CONFIG_HISAX_ISURF=3Dy
CONFIG_HISAX_HSTSAPHIR=3Dy
CONFIG_HISAX_BKM_A4T=3Dy
CONFIG_HISAX_SCT_QUADRO=3Dy
CONFIG_HISAX_GAZEL=3Dy
CONFIG_HISAX_HFC_PCI=3Dy
CONFIG_HISAX_W6692=3Dy
CONFIG_HISAX_HFC_SX=3Dy
CONFIG_HISAX_ENTERNOW_PCI=3Dy
CONFIG_HISAX_DEBUG=3Dy

#
# HiSax PCMCIA card service modules
#

#
# HiSax sub driver modules
#
CONFIG_HISAX_ST5481=3Dm
CONFIG_HISAX_HFCUSB=3Dm
CONFIG_HISAX_HFC4S8S=3Dm
CONFIG_HISAX_FRITZ_PCIPNP=3Dm
CONFIG_HISAX_HDLC=3Dy

#
# Active cards
#
CONFIG_ISDN_DRV_ICN=3Dm
CONFIG_ISDN_DRV_PCBIT=3Dm
CONFIG_ISDN_DRV_SC=3Dm
CONFIG_ISDN_DRV_ACT2000=3Dm

#
# CAPI subsystem
#
CONFIG_ISDN_CAPI=3Dm
CONFIG_ISDN_DRV_AVMB1_VERBOSE_REASON=3Dy
CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
CONFIG_ISDN_CAPI_CAPI20=3Dm
CONFIG_ISDN_CAPI_CAPIFS_BOOL=3Dy
CONFIG_ISDN_CAPI_CAPIFS=3Dm
CONFIG_ISDN_CAPI_CAPIDRV=3Dm

#
# CAPI hardware drivers
#

#
# Active AVM cards
#
CONFIG_CAPI_AVM=3Dy
CONFIG_ISDN_DRV_AVMB1_B1ISA=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=3Dy
CONFIG_ISDN_DRV_AVMB1_T1ISA=3Dm
CONFIG_ISDN_DRV_AVMB1_B1PCMCIA=3Dm
CONFIG_ISDN_DRV_AVMB1_T1PCI=3Dm
CONFIG_ISDN_DRV_AVMB1_C4=3Dm

#
# Active Eicon DIVA Server cards
#
CONFIG_CAPI_EICON=3Dy
CONFIG_ISDN_DIVAS=3Dm
CONFIG_ISDN_DIVAS_BRIPCI=3Dy
CONFIG_ISDN_DIVAS_PRIPCI=3Dy
CONFIG_ISDN_DIVAS_DIVACAPI=3Dm
CONFIG_ISDN_DIVAS_USERIDI=3Dm
CONFIG_ISDN_DIVAS_MAINT=3Dm

#
# Telephony Support
#
CONFIG_PHONE=3Dm
CONFIG_PHONE_IXJ=3Dm

#
# Input device support
#
CONFIG_INPUT=3Dy

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_TSDEV=3Dm
CONFIG_INPUT_TSDEV_SCREEN_X=3D240
CONFIG_INPUT_TSDEV_SCREEN_Y=3D320
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ATKBD=3Dy
CONFIG_KEYBOARD_SUNKBD=3Dm
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_XTKBD=3Dm
CONFIG_KEYBOARD_NEWTON=3Dm
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dy
CONFIG_MOUSE_SERIAL=3Dm
CONFIG_MOUSE_INPORT=3Dm
CONFIG_MOUSE_ATIXL=3Dy
CONFIG_MOUSE_LOGIBM=3Dm
CONFIG_MOUSE_PC110PAD=3Dm
# CONFIG_MOUSE_VSXXXAA is not set
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_ANALOG=3Dm
CONFIG_JOYSTICK_A3D=3Dm
CONFIG_JOYSTICK_ADI=3Dm
CONFIG_JOYSTICK_COBRA=3Dm
CONFIG_JOYSTICK_GF2K=3Dm
CONFIG_JOYSTICK_GRIP=3Dm
CONFIG_JOYSTICK_GRIP_MP=3Dm
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dm
CONFIG_JOYSTICK_TMDC=3Dm
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_USB=3Dy
CONFIG_JOYSTICK_IFORCE_232=3Dy
CONFIG_JOYSTICK_WARRIOR=3Dm
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dm
CONFIG_JOYSTICK_SPACEBALL=3Dm
CONFIG_JOYSTICK_STINGER=3Dm
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dm
CONFIG_JOYSTICK_TURBOGRAFX=3Dm
# CONFIG_JOYSTICK_JOYDUMP is not set
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_GUNZE=3Dm
CONFIG_TOUCHSCREEN_ELO=3Dm
CONFIG_TOUCHSCREEN_MTOUCH=3Dm
CONFIG_TOUCHSCREEN_MK712=3Dm
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_PCSPKR=3Dy
CONFIG_INPUT_UINPUT=3Dm

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
CONFIG_SERIO_I8042=3Dy
CONFIG_SERIO_SERPORT=3Dm
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dm
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dy
CONFIG_SERIO_RAW=3Dm
CONFIG_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
CONFIG_GAMEPORT_L4=3Dm
CONFIG_GAMEPORT_EMU10K1=3Dm
CONFIG_GAMEPORT_VORTEX=3Dm
CONFIG_GAMEPORT_FM801=3Dm
CONFIG_GAMEPORT_CS461X=3Dm
CONFIG_SOUND_GAMEPORT=3Dm

#
# Character devices
#
CONFIG_VT=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_SERIAL_NONSTANDARD=3Dy
CONFIG_ROCKETPORT=3Dm
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_ISI=3Dm
CONFIG_SYNCLINK=3Dm
CONFIG_SYNCLINKMP=3Dm
CONFIG_N_HDLC=3Dm
CONFIG_SPECIALIX=3Dm
# CONFIG_SPECIALIX_RTSCTS is not set
CONFIG_SX=3Dm
CONFIG_STALDRV=3Dy

#
# Serial drivers
#
CONFIG_SERIAL_8250=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_MULTIPORT=3Dy
CONFIG_SERIAL_8250_RSA=3Dy

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
CONFIG_TIPAR=3Dm

#
# IPMI
#
CONFIG_IPMI_HANDLER=3Dm
CONFIG_IPMI_PANIC_EVENT=3Dy
CONFIG_IPMI_PANIC_STRING=3Dy
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm

#
# Watchdog Cards
#
CONFIG_WATCHDOG=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
CONFIG_ACQUIRE_WDT=3Dm
CONFIG_ADVANTECH_WDT=3Dm
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
CONFIG_SC520_WDT=3Dm
CONFIG_EUROTECH_WDT=3Dm
CONFIG_IB700_WDT=3Dm
CONFIG_WAFER_WDT=3Dm
CONFIG_I8XX_TCO=3Dm
CONFIG_SC1200_WDT=3Dm
CONFIG_SCx200_WDT=3Dm
CONFIG_60XX_WDT=3Dm
CONFIG_CPU5_WDT=3Dm
CONFIG_W83627HF_WDT=3Dm
CONFIG_W83877F_WDT=3Dm
CONFIG_MACHZ_WDT=3Dm

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=3Dm
CONFIG_MIXCOMWD=3Dm
CONFIG_WDT=3Dm
CONFIG_WDT_501=3Dy

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=3Dm
CONFIG_WDTPCI=3Dm
CONFIG_WDT_501_PCI=3Dy

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=3Dm
CONFIG_HW_RANDOM=3Dm
CONFIG_NVRAM=3Dm
CONFIG_RTC=3Dy
CONFIG_DTLK=3Dm
CONFIG_R3964=3Dm
CONFIG_APPLICOM=3Dm
CONFIG_SONYPI=3Dm

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=3Dm
CONFIG_AGP_ALI=3Dm
CONFIG_AGP_ATI=3Dm
CONFIG_AGP_AMD=3Dm
CONFIG_AGP_AMD64=3Dm
CONFIG_AGP_INTEL=3Dm
CONFIG_AGP_NVIDIA=3Dm
CONFIG_AGP_SIS=3Dm
CONFIG_AGP_SWORKS=3Dm
CONFIG_AGP_VIA=3Dm
CONFIG_AGP_EFFICEON=3Dm
# CONFIG_DRM is not set
CONFIG_MWAVE=3Dm
CONFIG_SCx200_GPIO=3Dm
CONFIG_RAW_DRIVER=3Dm
# CONFIG_HPET is not set
CONFIG_MAX_RAW_DEVS=3D4096
CONFIG_HANGCHECK_TIMER=3Dm

#
# TPM devices
#
CONFIG_TCG_TPM=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm

#
# I2C support
#
CONFIG_I2C=3Dm
CONFIG_I2C_CHARDEV=3Dm

#
# I2C Algorithms
#
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCF=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD756_S4882=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_I801=3Dm
CONFIG_I2C_I810=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_ISA=3Dm
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_PARPORT_LIGHT=3Dm
CONFIG_I2C_PROSAVAGE=3Dm
CONFIG_I2C_SAVAGE4=3Dm
CONFIG_SCx200_I2C=3Dm
CONFIG_SCx200_I2C_SCL=3D12
CONFIG_SCx200_I2C_SDA=3D13
CONFIG_SCx200_ACB=3Dm
CONFIG_I2C_SIS5595=3Dm
CONFIG_I2C_SIS630=3Dm
CONFIG_I2C_SIS96X=3Dm
# CONFIG_I2C_STUB is not set
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm
CONFIG_I2C_VOODOO3=3Dm
CONFIG_I2C_PCA_ISA=3Dm

#
# Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ASB100=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_FSCHER=3Dm
CONFIG_SENSORS_FSCPOS=3Dm
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_GL520SM=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_LM63=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_LM92=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_SIS5595=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83627HF=3Dm

#
# Other I2C Chip support
#
CONFIG_SENSORS_DS1337=3Dm
CONFIG_SENSORS_EEPROM=3Dm
CONFIG_SENSORS_PCF8574=3Dm
CONFIG_SENSORS_PCF8591=3Dm
CONFIG_SENSORS_RTC8564=3Dm
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# CONFIG_I2C_DEBUG_CHIP is not set

#
# Dallas's 1-wire bus
#
CONFIG_W1=3Dm
CONFIG_W1_MATROX=3Dm
CONFIG_W1_DS9490=3Dm
CONFIG_W1_DS9490_BRIDGE=3Dm
CONFIG_W1_THERM=3Dm
CONFIG_W1_SMEM=3Dm

#
# Misc devices
#
CONFIG_IBM_ASM=3Dm

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=3Dm

#
# Video For Linux
#

#
# Video Adapters
#
CONFIG_VIDEO_BT848=3Dm
CONFIG_VIDEO_PMS=3Dm
CONFIG_VIDEO_BWQCAM=3Dm
CONFIG_VIDEO_CQCAM=3Dm
CONFIG_VIDEO_W9966=3Dm
CONFIG_VIDEO_CPIA=3Dm
CONFIG_VIDEO_CPIA_PP=3Dm
CONFIG_VIDEO_CPIA_USB=3Dm
CONFIG_VIDEO_SAA5246A=3Dm
CONFIG_VIDEO_SAA5249=3Dm
CONFIG_TUNER_3036=3Dm
CONFIG_VIDEO_STRADIS=3Dm
# CONFIG_VIDEO_ZORAN is not set
CONFIG_VIDEO_MEYE=3Dm
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_SAA7134_DVB=3Dm
CONFIG_VIDEO_MXB=3Dm
CONFIG_VIDEO_DPC=3Dm
CONFIG_VIDEO_HEXIUM_ORION=3Dm
CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
CONFIG_VIDEO_CX88=3Dm
CONFIG_VIDEO_CX88_DVB=3Dm
# CONFIG_VIDEO_OVCAMCHIP is not set

#
# Radio Adapters
#
CONFIG_RADIO_CADET=3Dm
CONFIG_RADIO_RTRACK=3Dm
CONFIG_RADIO_RTRACK2=3Dm
CONFIG_RADIO_AZTECH=3Dm
CONFIG_RADIO_GEMTEK=3Dm
CONFIG_RADIO_GEMTEK_PCI=3Dm
CONFIG_RADIO_MAXIRADIO=3Dm
CONFIG_RADIO_MAESTRO=3Dm
CONFIG_RADIO_MIROPCM20=3Dm
# CONFIG_RADIO_MIROPCM20_RDS is not set
CONFIG_RADIO_SF16FMI=3Dm
CONFIG_RADIO_SF16FMR2=3Dm
CONFIG_RADIO_TERRATEC=3Dm
CONFIG_RADIO_TRUST=3Dm
CONFIG_RADIO_TYPHOON=3Dm
CONFIG_RADIO_TYPHOON_PROC_FS=3Dy
CONFIG_RADIO_ZOLTRIX=3Dm

#
# Digital Video Broadcasting Devices
#
CONFIG_DVB=3Dy
CONFIG_DVB_CORE=3Dm

#
# Supported SAA7146 based PCI Adapters
#
CONFIG_DVB_AV7110=3Dm
# CONFIG_DVB_AV7110_FIRMWARE is not set
CONFIG_DVB_AV7110_OSD=3Dy
CONFIG_DVB_BUDGET=3Dm
CONFIG_DVB_BUDGET_CI=3Dm
CONFIG_DVB_BUDGET_AV=3Dm
CONFIG_DVB_BUDGET_PATCH=3Dm

#
# Supported USB Adapters
#
CONFIG_DVB_TTUSB_BUDGET=3Dm
CONFIG_DVB_TTUSB_DEC=3Dm
CONFIG_DVB_DIBUSB=3Dm
# CONFIG_DVB_DIBUSB_MISDESIGNED_DEVICES is not set
# CONFIG_DVB_DIBCOM_DEBUG is not set
CONFIG_DVB_CINERGYT2=3Dm
# CONFIG_DVB_CINERGYT2_TUNING is not set

#
# Supported FlexCopII (B2C2) Adapters
#
CONFIG_DVB_B2C2_SKYSTAR=3Dm
CONFIG_DVB_B2C2_USB=3Dm

#
# Supported BT878 Adapters
#
CONFIG_DVB_BT8XX=3Dm

#
# Supported DVB Frontends
#

#
# Customise DVB Frontends
#

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_STV0299=3Dm
CONFIG_DVB_CX24110=3Dm
CONFIG_DVB_TDA8083=3Dm
CONFIG_DVB_TDA80XX=3Dm
CONFIG_DVB_MT312=3Dm
CONFIG_DVB_VES1X93=3Dm

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=3Dm
CONFIG_DVB_SP887X=3Dm
CONFIG_DVB_CX22700=3Dm
CONFIG_DVB_CX22702=3Dm
CONFIG_DVB_L64781=3Dm
CONFIG_DVB_TDA1004X=3Dm
CONFIG_DVB_NXT6000=3Dm
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_DIB3000MB=3Dm
CONFIG_DVB_DIB3000MC=3Dm

#
# DVB-C (cable) frontends
#
CONFIG_DVB_ATMEL_AT76C651=3Dm
CONFIG_DVB_VES1820=3Dm
CONFIG_DVB_TDA10021=3Dm
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terresterial DTV) frontends
#
CONFIG_DVB_NXT2002=3Dm
CONFIG_DVB_OR51132=3Dm
CONFIG_DVB_OR51211=3Dm
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_VIDEO_VIDEOBUF=3Dm
CONFIG_VIDEO_TUNER=3Dm
CONFIG_VIDEO_BUF=3Dm
CONFIG_VIDEO_BUF_DVB=3Dm
CONFIG_VIDEO_BTCX=3Dm
CONFIG_VIDEO_IR=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm

#
# Graphics support
#
CONFIG_FB=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_SOFT_CURSOR=3Dy
# CONFIG_FB_MACMODES is not set
CONFIG_FB_MODE_HELPERS=3Dy
# CONFIG_FB_TILEBLITTING is not set
# CONFIG_FB_CIRRUS is not set
CONFIG_FB_PM2=3Dm
CONFIG_FB_PM2_FIFO_DISCONNECT=3Dy
CONFIG_FB_CYBER2000=3Dm
# CONFIG_FB_ASILIANT is not set
CONFIG_FB_IMSTT=3Dy
CONFIG_FB_VGA16=3Dm
CONFIG_FB_VESA=3Dy
CONFIG_VIDEO_SELECT=3Dy
CONFIG_FB_HGA=3Dm
# CONFIG_FB_HGA_ACCEL is not set
CONFIG_FB_NVIDIA=3Dm
CONFIG_FB_NVIDIA_I2C=3Dy
CONFIG_FB_RIVA=3Dm
# CONFIG_FB_RIVA_I2C is not set
# CONFIG_FB_RIVA_DEBUG is not set
CONFIG_FB_I810=3Dm
CONFIG_FB_I810_GTF=3Dy
CONFIG_FB_INTEL=3Dm
# CONFIG_FB_INTEL_DEBUG is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=3Dm
CONFIG_FB_RADEON_I2C=3Dy
# CONFIG_FB_RADEON_DEBUG is not set
# CONFIG_FB_ATY128 is not set
CONFIG_FB_ATY=3Dm
CONFIG_FB_ATY_CT=3Dy
# CONFIG_FB_ATY_GENERIC_LCD is not set
CONFIG_FB_ATY_XL_INIT=3Dy
CONFIG_FB_ATY_GX=3Dy
CONFIG_FB_SAVAGE=3Dm
CONFIG_FB_SAVAGE_I2C=3Dy
CONFIG_FB_SAVAGE_ACCEL=3Dy
CONFIG_FB_SIS=3Dm
CONFIG_FB_SIS_300=3Dy
CONFIG_FB_SIS_315=3Dy
CONFIG_FB_NEOMAGIC=3Dm
CONFIG_FB_KYRO=3Dm
CONFIG_FB_3DFX=3Dm
# CONFIG_FB_3DFX_ACCEL is not set
CONFIG_FB_VOODOO1=3Dm
CONFIG_FB_TRIDENT=3Dm
# CONFIG_FB_TRIDENT_ACCEL is not set
CONFIG_FB_GEODE=3Dy
CONFIG_FB_GEODE_GX1=3Dm
CONFIG_FB_S1D13XXX=3Dm
# CONFIG_FB_VIRTUAL is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_MDA_CONSOLE=3Dm
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=3Dy
CONFIG_FONT_8x16=3Dy

#
# Logo configuration
#
# CONFIG_LOGO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Sound
#
CONFIG_SOUND=3Dm

#
# Advanced Linux Sound Architecture
#
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dy
CONFIG_SND_RTCTIMER=3Dm
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
CONFIG_SND_DEBUG_MEMORY=3Dy
# CONFIG_SND_DEBUG_DETECT is not set
CONFIG_SND_GENERIC_PM=3Dy

#
# Generic devices
#
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_OPL4_LIB=3Dm
CONFIG_SND_VX_LIB=3Dm
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm

#
# ISA devices
#
CONFIG_SND_AD1848_LIB=3Dm
CONFIG_SND_CS4231_LIB=3Dm
CONFIG_SND_AD1816A=3Dm
CONFIG_SND_AD1848=3Dm
CONFIG_SND_CS4231=3Dm
CONFIG_SND_CS4232=3Dm
CONFIG_SND_CS4236=3Dm
CONFIG_SND_ES968=3Dm
CONFIG_SND_ES1688=3Dm
CONFIG_SND_ES18XX=3Dm
CONFIG_SND_GUS_SYNTH=3Dm
CONFIG_SND_GUSCLASSIC=3Dm
CONFIG_SND_GUSEXTREME=3Dm
CONFIG_SND_GUSMAX=3Dm
CONFIG_SND_INTERWAVE=3Dm
CONFIG_SND_INTERWAVE_STB=3Dm
CONFIG_SND_OPTI92X_AD1848=3Dm
CONFIG_SND_OPTI92X_CS4231=3Dm
CONFIG_SND_OPTI93X=3Dm
CONFIG_SND_SB8=3Dm
CONFIG_SND_SB16=3Dm
CONFIG_SND_SBAWE=3Dm
CONFIG_SND_SB16_CSP=3Dy
CONFIG_SND_WAVEFRONT=3Dm
CONFIG_SND_ALS100=3Dm
CONFIG_SND_AZT2320=3Dm
CONFIG_SND_CMI8330=3Dm
CONFIG_SND_DT019X=3Dm
CONFIG_SND_OPL3SA2=3Dm
CONFIG_SND_SGALAXY=3Dm
CONFIG_SND_SSCAPE=3Dm

#
# PCI devices
#
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_ALI5451=3Dm
CONFIG_SND_ATIIXP=3Dm
# CONFIG_SND_ATIIXP_MODEM is not set
CONFIG_SND_AU8810=3Dm
CONFIG_SND_AU8820=3Dm
CONFIG_SND_AU8830=3Dm
CONFIG_SND_AZT3328=3Dm
CONFIG_SND_BT87X=3Dm
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CS46XX=3Dm
CONFIG_SND_CS46XX_NEW_DSP=3Dy
CONFIG_SND_CS4281=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_EMU10K1X=3Dm
CONFIG_SND_CA0106=3Dm
CONFIG_SND_KORG1212=3Dm
CONFIG_SND_MIXART=3Dm
CONFIG_SND_NM256=3Dm
CONFIG_SND_RME32=3Dm
CONFIG_SND_RME96=3Dm
CONFIG_SND_RME9652=3Dm
CONFIG_SND_HDSP=3Dm
CONFIG_SND_TRIDENT=3Dm
CONFIG_SND_YMFPCI=3Dm
CONFIG_SND_ALS4000=3Dm
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
CONFIG_SND_ES1938=3Dm
CONFIG_SND_ES1968=3Dm
CONFIG_SND_MAESTRO3=3Dm
CONFIG_SND_FM801=3Dm
CONFIG_SND_FM801_TEA575X=3Dm
CONFIG_SND_ICE1712=3Dm
CONFIG_SND_ICE1724=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
CONFIG_SND_SONICVIBES=3Dm
CONFIG_SND_VIA82XX=3Dm
CONFIG_SND_VIA82XX_MODEM=3Dm
CONFIG_SND_VX222=3Dm
CONFIG_SND_HDA_INTEL=3Dm

#
# USB devices
#
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_USX2Y=3Dm

#
# Open Sound System
#
CONFIG_SOUND_PRIME=3Dm
CONFIG_SOUND_BT878=3Dm
CONFIG_SOUND_CMPCI=3Dm
CONFIG_SOUND_CMPCI_FM=3Dy
CONFIG_SOUND_CMPCI_MIDI=3Dy
CONFIG_SOUND_CMPCI_JOYSTICK=3Dy
CONFIG_SOUND_EMU10K1=3Dm
CONFIG_MIDI_EMU10K1=3Dy
# CONFIG_SOUND_FUSION is not set
CONFIG_SOUND_CS4281=3Dm
CONFIG_SOUND_ES1370=3Dm
CONFIG_SOUND_ES1371=3Dm
CONFIG_SOUND_ESSSOLO1=3Dm
CONFIG_SOUND_MAESTRO=3Dm
CONFIG_SOUND_MAESTRO3=3Dm
CONFIG_SOUND_ICH=3Dm
CONFIG_SOUND_SONICVIBES=3Dm
CONFIG_SOUND_TRIDENT=3Dm
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
CONFIG_SOUND_VIA82CXXX=3Dm
CONFIG_MIDI_VIA82CXXX=3Dy
CONFIG_SOUND_OSS=3Dm
CONFIG_SOUND_TRACEINIT=3Dy
CONFIG_SOUND_DMAP=3Dy
# CONFIG_SOUND_AD1816 is not set
CONFIG_SOUND_AD1889=3Dm
CONFIG_SOUND_SGALAXY=3Dm
CONFIG_SOUND_ADLIB=3Dm
CONFIG_SOUND_ACI_MIXER=3Dm
CONFIG_SOUND_CS4232=3Dm
CONFIG_SOUND_SSCAPE=3Dm
CONFIG_SOUND_GUS=3Dm
# CONFIG_SOUND_GUS16 is not set
CONFIG_SOUND_GUSMAX=3Dy
CONFIG_SOUND_VMIDI=3Dm
CONFIG_SOUND_TRIX=3Dm
CONFIG_SOUND_MSS=3Dm
CONFIG_SOUND_MPU401=3Dm
CONFIG_SOUND_NM256=3Dm
CONFIG_SOUND_MAD16=3Dm
CONFIG_MAD16_OLDCARD=3Dy
CONFIG_SOUND_PAS=3Dm
CONFIG_SOUND_PSS=3Dm
CONFIG_PSS_MIXER=3Dy
# CONFIG_PSS_HAVE_BOOT is not set
CONFIG_SOUND_SB=3Dm
# CONFIG_SOUND_AWE32_SYNTH is not set
CONFIG_SOUND_WAVEFRONT=3Dm
CONFIG_SOUND_MAUI=3Dm
CONFIG_SOUND_YM3812=3Dm
CONFIG_SOUND_OPL3SA1=3Dm
CONFIG_SOUND_OPL3SA2=3Dm
CONFIG_SOUND_YMFPCI=3Dm
CONFIG_SOUND_YMFPCI_LEGACY=3Dy
CONFIG_SOUND_UART6850=3Dm
CONFIG_SOUND_AEDSP16=3Dm
CONFIG_SC6600=3Dy
CONFIG_SC6600_JOY=3Dy
CONFIG_SC6600_CDROM=3D4
CONFIG_SC6600_CDROMBASE=3D0x0
# CONFIG_AEDSP16_MSS is not set
# CONFIG_AEDSP16_SBPRO is not set
CONFIG_AEDSP16_MPU401=3Dy
CONFIG_SOUND_TVMIXER=3Dm
CONFIG_SOUND_KAHLUA=3Dm
CONFIG_SOUND_ALI5455=3Dm
CONFIG_SOUND_FORTE=3Dm
CONFIG_SOUND_RME96XX=3Dm
CONFIG_SOUND_AD1980=3Dm

#
# USB support
#
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB_ARCH_HAS_OHCI=3Dy
CONFIG_USB=3Dm
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=3Dy
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_SUSPEND is not set
# CONFIG_USB_OTG is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_SPLIT_ISO=3Dy
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_OHCI_HCD=3Dm
# CONFIG_USB_OHCI_BIG_ENDIAN is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=3Dm

#
# USB Bluetooth TTY can only be used with disabled Bluetooth subsystem
#
CONFIG_USB_MIDI=3Dm
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm

#
# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be =
needed; see USB_STORAGE Help for more information
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=3Dy
CONFIG_USB_STORAGE_FREECOM=3Dy
CONFIG_USB_STORAGE_ISD200=3Dy
CONFIG_USB_STORAGE_DPCM=3Dy
CONFIG_USB_STORAGE_USBAT=3Dy
CONFIG_USB_STORAGE_SDDR09=3Dy
CONFIG_USB_STORAGE_SDDR55=3Dy
CONFIG_USB_STORAGE_JUMPSHOT=3Dy

#
# USB Input Devices
#
CONFIG_USB_HID=3Dm
CONFIG_USB_HIDINPUT=3Dy
CONFIG_HID_FF=3Dy
CONFIG_HID_PID=3Dy
CONFIG_LOGITECH_FF=3Dy
CONFIG_THRUSTMASTER_FF=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
CONFIG_USB_AIPTEK=3Dm
CONFIG_USB_WACOM=3Dm
CONFIG_USB_KBTAB=3Dm
CONFIG_USB_POWERMATE=3Dm
CONFIG_USB_MTOUCH=3Dm
CONFIG_USB_EGALAX=3Dm
CONFIG_USB_XPAD=3Dm
CONFIG_USB_ATI_REMOTE=3Dm

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set

#
# USB Multimedia devices
#
CONFIG_USB_DABUSB=3Dm
CONFIG_USB_VICAM=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_USB_IBMCAM=3Dm
CONFIG_USB_KONICAWC=3Dm
CONFIG_USB_OV511=3Dm
CONFIG_USB_SE401=3Dm
# CONFIG_USB_SN9C102 is not set
CONFIG_USB_STV680=3Dm
CONFIG_USB_PWC=3Dm

#
# USB Network Adapters
#
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_USBNET=3Dm

#
# USB Host-to-Host Cables
#
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_GENESYS=3Dy
CONFIG_USB_NET1080=3Dy
CONFIG_USB_PL2301=3Dy
CONFIG_USB_KC2190=3Dy

#
# Intelligent USB Devices/Gadgets
#
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_ZAURUS=3Dy
CONFIG_USB_CDCETHER=3Dy

#
# USB Network Adapters
#
CONFIG_USB_AX8817X=3Dy
CONFIG_USB_ZD1201=3Dm
# CONFIG_USB_MON is not set

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=3Dm
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP2101=3Dm
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
# CONFIG_USB_SERIAL_IPW is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KEYSPAN_MPR=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XA=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA28XB=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA18X=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QW=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA19QI=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49W=3Dy
CONFIG_USB_SERIAL_KEYSPAN_USA49WLC=3Dy
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
CONFIG_USB_SERIAL_SAFE_PADDED=3Dy
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_EZUSB=3Dy

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_AUERSWALD=3Dm
CONFIG_USB_RIO500=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_LED=3Dm
CONFIG_USB_CYTHERM=3Dm
# CONFIG_USB_PHIDGETKIT is not set
# CONFIG_USB_PHIDGETSERVO is not set
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_SISUSBVGA=3Dm
# CONFIG_USB_TEST is not set

#
# USB ATM/DSL drivers
#
CONFIG_USB_ATM=3Dm
CONFIG_USB_SPEEDTOUCH=3Dm

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#
CONFIG_INFINIBAND=3Dm
CONFIG_INFINIBAND_MTHCA=3Dm
# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
CONFIG_INFINIBAND_IPOIB=3Dm
# CONFIG_INFINIBAND_IPOIB_DEBUG is not set

#
# File systems
#
CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT2_FS_SECURITY=3Dy
CONFIG_EXT3_FS=3Dm
CONFIG_EXT3_FS_XATTR=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_SECURITY=3Dy
CONFIG_JBD=3Dm
CONFIG_JBD_DEBUG=3Dy
CONFIG_FS_MBCACHE=3Dy
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_FS_POSIX_ACL=3Dy

#
# XFS support
#
CONFIG_XFS_FS=3Dm
CONFIG_XFS_EXPORT=3Dy
CONFIG_XFS_RT=3Dy
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_SECURITY=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_MINIX_FS=3Dy
CONFIG_ROMFS_FS=3Dm
CONFIG_QUOTA=3Dy
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_AUTOFS_FS=3Dm
CONFIG_AUTOFS4_FS=3Dm

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dy
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_ZISOFS_FS=3Dy
CONFIG_UDF_FS=3Dm
CONFIG_UDF_NLS=3Dy

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_SYSFS=3Dy
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS_XATTR=3Dy
CONFIG_DEVPTS_FS_SECURITY=3Dy
CONFIG_TMPFS=3Dy
# CONFIG_TMPFS_XATTR is not set
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_RAMFS=3Dy

#
# Miscellaneous filesystems
#
CONFIG_ADFS_FS=3Dm
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=3Dm
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=3Dm
CONFIG_EFS_FS=3Dm
CONFIG_JFFS_FS=3Dm
CONFIG_JFFS_FS_VERBOSE=3D0
CONFIG_JFFS_PROC_FS=3Dy
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
# CONFIG_JFFS2_FS_NAND is not set
# CONFIG_JFFS2_FS_NOR_ECC is not set
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_RTIME=3Dy
# CONFIG_JFFS2_RUBIN is not set
CONFIG_CRAMFS=3Dy
CONFIG_VXFS_FS=3Dm
CONFIG_HPFS_FS=3Dm
CONFIG_QNX4FS_FS=3Dm
CONFIG_SYSV_FS=3Dm
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
CONFIG_NFS_FS=3Dy
CONFIG_NFS_V3=3Dy
# CONFIG_NFS_V4 is not set
CONFIG_NFS_DIRECTIO=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=3Dy
CONFIG_LOCKD=3Dy
CONFIG_LOCKD_V4=3Dy
CONFIG_EXPORTFS=3Dm
CONFIG_SUNRPC=3Dy
CONFIG_SUNRPC_GSS=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dy
CONFIG_RPCSEC_GSS_SPKM3=3Dm
CONFIG_SMB_FS=3Dm
CONFIG_SMB_NLS_DEFAULT=3Dy
CONFIG_SMB_NLS_REMOTE=3D"cp850"
CONFIG_CIFS=3Dm
CONFIG_CIFS_STATS=3Dy
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set
CONFIG_NCP_FS=3Dm
CONFIG_NCPFS_PACKET_SIGNING=3Dy
CONFIG_NCPFS_IOCTL_LOCKING=3Dy
CONFIG_NCPFS_STRONG=3Dy
CONFIG_NCPFS_NFS_NS=3Dy
CONFIG_NCPFS_OS2_NS=3Dy
CONFIG_NCPFS_SMALLDOS=3Dy
CONFIG_NCPFS_NLS=3Dy
CONFIG_NCPFS_EXTRAS=3Dy
CONFIG_CODA_FS=3Dm
# CONFIG_CODA_FS_OLD_API is not set
CONFIG_AFS_FS=3Dm
CONFIG_RXRPC=3Dm

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
CONFIG_OSF_PARTITION=3Dy
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=3Dy
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
# CONFIG_MINIX_SUBPARTITION is not set
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
CONFIG_ULTRIX_PARTITION=3Dy
CONFIG_SUN_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy

#
# Native Language Support
#
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_UTF8=3Dm

#
# Profiling support
#
CONFIG_PROFILING=3Dy
CONFIG_OPROFILE=3Dm

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_LOG_BUF_SHIFT=3D17
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_BUGVERBOSE=3Dy
# CONFIG_DEBUG_INFO is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_FRAME_POINTER is not set
CONFIG_EARLY_PRINTK=3Dy
CONFIG_DEBUG_STACKOVERFLOW=3Dy
# CONFIG_KPROBES is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_4KSTACKS is not set
CONFIG_X86_FIND_SMP_CONFIG=3Dy
CONFIG_X86_MPPARSE=3Dy

#
# Security options
#
# CONFIG_KEYS is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_SECURITY_CAPABILITIES=3Dm
CONFIG_SECURITY_ROOTPLUG=3Dm
# CONFIG_SECURITY_SECLVL is not set
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=3D1
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1

#
# Cryptographic options
#
CONFIG_CRYPTO=3Dy
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_NULL=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_SHA1=3Dm
CONFIG_CRYPTO_SHA256=3Dm
CONFIG_CRYPTO_SHA512=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_DES=3Dy
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_AES_586=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_TEST=3Dm

#
# Hardware crypto devices
#
CONFIG_CRYPTO_DEV_PADLOCK=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy

#
# Library routines
#
CONFIG_CRC_CCITT=3Dm
CONFIG_CRC32=3Dy
CONFIG_LIBCRC32C=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dm
CONFIG_GENERIC_HARDIRQS=3Dy
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_X86_SMP=3Dy
CONFIG_X86_HT=3Dy
CONFIG_X86_BIOS_REBOOT=3Dy
CONFIG_X86_TRAMPOLINE=3Dy
CONFIG_PC=3Dy

------=_NextPart_000_0005_01C55255.FD353E70--

