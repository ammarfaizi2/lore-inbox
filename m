Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbUKQQeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUKQQeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUKQQeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:34:09 -0500
Received: from limicola.its.UU.SE ([130.238.7.33]:1221 "EHLO
	limicola.its.uu.se") by vger.kernel.org with ESMTP id S262400AbUKQQby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:31:54 -0500
Date: Wed, 17 Nov 2004 17:30:00 +0100
Subject: PROBLEM: booting from 3w-9000 RAID array
To: linux-kernel@vger.kernel.org
From: "Filipe Maia" <fmaia@gmx.net>
Content-Type: multipart/mixed; boundary=----------vQDc0cPb9rP0Au8VRpfCb1
MIME-Version: 1.0
Message-ID: <opshmasawxi22er4@xray.bmc.uu.se>
User-Agent: Opera M2/7.50 (Linux, build 673)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------vQDc0cPb9rP0Au8VRpfCb1
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: quoted-printable

1. Cannot boot from /dev/sda2 and /dev/sda3 with 3w-9xxx driver from 2.6 =
=20
kernel series. Booting from /dev/sda1 looks to work.

2. I have a 3w-9000 and the following partitions:

/dev/sda1 on /boot type ext3 (rw)
/dev/sda2 on / type ext3 (rw)
/dev/sda3 on /mnt/debian type ext3 (rw)
/dev/sda4 on /homes/hirst/dsk1 type ext3 (rw,noatime,data=3Dwriteback)
/dev/sdb1 on /homes/hirst/dsk2 type ext3 (rw,noatime,data=3Dwriteback)

On WhiteBox Linux 3.0. Bootloader is grub (GNU GRUB 0.93) installed in =20
/dev/sda.
The 2.4 drivers that 3ware provides work fine (both with custom and pre =20
compiled redhat kernels).
But if i use a 2.6 kernel with a builtin driver i get a:

Please append a correct "root=3D" boot option
Kernel panic: VFS: Unable to mount root fs on unknown-block(8,2)

The strange thing is that if i use sda1 as root (801) it's able to mount =
=20
root fs (but obviously fails,
because it doesn't find init). If i try the same using the driver as =20
module and initrd the error is in:
pivot_root: no such file or directory.

I tried both stock kernel from kernel.org (2.6.9) and debian =20
2.6.8-1smp(precompiled with module driver).

It looks like the driver recognizes the disks during boot (i get some =20
output about 3w-9xxx founding sda and sdb),
but not the partitions inside the drives (i don't get any output about th=
e =20
sda1, sda2, etc...).

3. Keywords - 2.6, boot, 3w-9xxx
4. Kernel version - 2.6.9 and 2.6.8-1smp from debian

5. Hardware:
Processors	1=09
Model	Intel(R) Xeon(TM) CPU 2.80GHz=09
Chip MHz	2800.16 MHz=09
Cache Size	512 KB=09
System Bogomips	5583.66=09
PCI Devices	0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA =20
Storage Controller
0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller
0000:01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL
0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC
0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC
0000:03:01.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet =20
Controller
0000:03:02.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet =20
Controller
0000:04:01.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
0000:04:02.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
=09
IDE Devices	none=09
SCSI Devices
3ware Logical Disk 00 (Direct-Access)
3ware Logical Disk 00 (Direct-Access)

more /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: 3ware    Model: Logical Disk 00  Rev: 1.00
   Type:   Direct-Access                    ANSI SCSI revision: ffffffff
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: 3ware    Model: Logical Disk 00  Rev: 1.00
   Type:   Direct-Access                    ANSI SCSI revision: ffffffff

lspci -vvv attached

--=20
All generalizations are false, including this one.
          -- Mark Twain
------------vQDc0cPb9rP0Au8VRpfCb1
Content-Disposition: attachment; filename=pci
Content-Type: application/octet-stream; name=pci
Content-Transfer-Encoding: quoted-printable

0000:00:00.0 Host bridge: Intel Corp. E7501 Memory Controller Hub (rev 01=
)
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [40] #09 [1105]

0000:00:02.0 PCI bridge: Intel Corp. E7500/E7501 Hub Interface B PCI-to-P=
CI Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=3D00, secondary=3D02, subordinate=3D04, sec-latency=3D0
	I/O behind bridge: 0000b000-0000cfff
	Memory behind bridge: fe800000-feafffff
	Prefetchable memory behind bridge: fa300000-fc5fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02=
) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 16
	Region 4: I/O ports at e000 [size=3D32]

0000:00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02=
) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 19
	Region 4: I/O ports at e400 [size=3D32]

0000:00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02=
) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 18
	Region 4: I/O ports at e800 [size=3D32]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 42) (prog-if 0=
0 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: fc700000-fe7fffff
	Prefetchable memory behind bridge: fa200000-fa2fffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801CA LPC Interface Controller (re=
v 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801CA Ultra ATA Storage Control=
ler (rev 02) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=3D16]
	Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=3D1K]

0000:00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
	Subsystem: Super Micro Computer Inc: Unknown device 4880
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 17
	Region 4: I/O ports at 0540 [size=3D32]

0000:01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev=
 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=3D16M]
	Region 1: I/O ports at a000 [size=3D256]
	Region 2: Memory at fe5ff000 (32-bit, non-prefetchable) [size=3D4K]
	Expansion ROM at fe5c0000 [disabled] [size=3D128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,D2-,D3hot-,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:02:1c.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20=
 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3D0 OST=3D0
		Status: Bus=3D2 Dev=3D28 Func=3D0 64bit+ 133MHz+ SCD- USC-, DC=3Dsimple=
, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-

0000:02:1d.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04=
) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D02, secondary=3D04, subordinate=3D04, sec-latency=3D64
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: fe900000-fe9fffff
	Prefetchable memory behind bridge: 00000000fa400000-00000000fc400000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] PCI-X bridge device.
		Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3D0
		Status: Bus=3D2 Dev=3D29 Func=3D0 64bit+ 133MHz+ SCD- USC-, SCO-, SRD-
		: Upstream: Capacity=3D65535, Commitment Limit=3D65535
		: Downstream: Capacity=3D65535, Commitment Limit=3D65535

0000:02:1e.0 PIC: Intel Corp. 82870P2 P64H2 I/OxAPIC (rev 04) (prog-if 20=
 [IO(X)-APIC])
	Subsystem: Intel Corp. 82870P2 P64H2 I/OxAPIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]
	Capabilities: [50] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3D0 OST=3D0
		Status: Bus=3D2 Dev=3D30 Func=3D0 64bit+ 133MHz+ SCD- USC-, DC=3Dsimple=
, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-

0000:02:1f.0 PCI bridge: Intel Corp. 82870P2 P64H2 Hub PCI Bridge (rev 04=
) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- <TAbort=
- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x10 (64 bytes)
	Bus: primary=3D02, secondary=3D03, subordinate=3D03, sec-latency=3D64
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: fe800000-fe8fffff
	Prefetchable memory behind bridge: 00000000fa300000-00000000fa300000
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [50] PCI-X bridge device.
		Secondary Status: 64bit+, 133MHz+, SCD-, USC-, SCO-, SRD- Freq=3D0
		Status: Bus=3D2 Dev=3D31 Func=3D0 64bit+ 133MHz+ SCD- USC-, SCO-, SRD-
		: Upstream: Capacity=3D65535, Commitment Limit=3D65535
		: Downstream: Capacity=3D65535, Commitment Limit=3D65535

0000:03:01.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Co=
ntroller (Copper)
	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at fe8c0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at b400 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=3D0 OST=3D0
		Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple,=
 DMMRBC=3D2, DMOST=3D0, DMCRS=3D0, RSCEM-

0000:03:02.0 Ethernet controller: Intel Corp. 82541EI Gigabit Ethernet Co=
ntroller (Copper)
	Subsystem: Intel Corp. PRO/1000 MT Desktop Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at fe8e0000 (32-bit, non-prefetchable) [size=3D128K]
	Region 2: I/O ports at b800 [size=3D64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1-,D2-,D3hot+,D3c=
old+)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=3D0 OST=3D0
		Status: Bus=3D0 Dev=3D0 Func=3D0 64bit- 133MHz- SCD- USC-, DC=3Dsimple,=
 DMMRBC=3D2, DMOST=3D0, DMCRS=3D0, RSCEM-

0000:04:01.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
	Subsystem: 3ware Inc 3ware ATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 48
	Region 0: I/O ports at c400 [size=3D256]
	Region 1: Memory at fe9ff800 (64-bit, non-prefetchable) [size=3D256]
	Region 3: Memory at fb000000 (64-bit, prefetchable) [size=3D8M]
	Expansion ROM at fe9d0000 [disabled] [size=3D64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3D0 OST=3D0
		Status: Bus=3D255 Dev=3D31 Func=3D0 64bit+ 133MHz+ SCD- USC-, DC=3Dsimp=
le, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+,D2-,D3hot+,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

0000:04:02.0 RAID bus controller: 3ware Inc 3ware ATA-RAID
	Subsystem: 3ware Inc 3ware ATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Step=
ping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- <TAbo=
rt- <MAbort- >SERR- <PERR-
	Latency: 64 (2250ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 52
	Region 0: I/O ports at c800 [size=3D256]
	Region 1: Memory at fe9ffc00 (64-bit, non-prefetchable) [size=3D256]
	Region 3: Memory at fb800000 (64-bit, prefetchable) [size=3D8M]
	Expansion ROM at fe9e0000 [disabled] [size=3D64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=3D0 OST=3D0
		Status: Bus=3D255 Dev=3D31 Func=3D0 64bit+ 133MHz+ SCD- USC-, DC=3Dsimp=
le, DMMRBC=3D0, DMOST=3D0, DMCRS=3D0, RSCEM-
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA PME(D0+,D1+,D2-,D3hot+,D3c=
old-)
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-


------------vQDc0cPb9rP0Au8VRpfCb1--

