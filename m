Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbSLKPL4>; Wed, 11 Dec 2002 10:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSLKPLz>; Wed, 11 Dec 2002 10:11:55 -0500
Received: from halon.barra.com ([144.203.11.1]:65270 "EHLO halon.barra.com")
	by vger.kernel.org with ESMTP id <S267174AbSLKPLv>;
	Wed, 11 Dec 2002 10:11:51 -0500
From: Fedor Karpelevitch <fedor@apache.org>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [2.4]ALi M5451 sound hangs on init; workaround
Date: Wed, 11 Dec 2002 07:15:20 -0800
User-Agent: KMail/1.5
Cc: Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net,
       "Debian-Laptops" <debian-laptop@lists.debian.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Ia199gzBPBKVmnw"
Message-Id: <200212110715.20617.fedor@apache.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Ia199gzBPBKVmnw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have ALi M5451 souncard in my laptop (Compaq Presario 900z for those 
searching) and it hangs the machine with any kernel I tried 
(currently 2.4.20-ac1 + hirofumi patch). I traced it down to the line 
where it hangs - that is drivers/sound/trident.c:3379 which says:
pci_write_config_byte(pci_dev, 0xB8, ~temp);

removing this line fixes the problem for me.
I am not sure what would be the proper fix.
The hanging looks slightly different at different times: sometimes it 
would just freeze, but sometimes it would would start giving ide 
errors on any operation and sometimes it was giving this message:
"i8253 count too high! resetting." once or twice, but anyway the 
system was not functional after that.
I got similar results with alsa drivers for this card, but I did not 
debug that.

I am also getting several IRQ conflict messages on boot, I wonder if 
that could be related to this problem and I wonder whether they are 
something I should worry about or not.

Fedor

PS. some additional info about the system in case it is relevant: it's 
Compaq Presario 900z with Athlon XP 1500+, lspci output is attached, 
distribution is debian unstable.



--Boundary-00=_Ia199gzBPBKVmnw
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci-vv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="lspci-vv.txt"

00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f4400000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 8090 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: ATI Technologies Inc: Unknown device 700f (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: f4100000-f41fffff
	Prefetchable memory behind bridge: f6000000-f7ffffff
	Secondary status: SERR
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4010000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at f4011000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ffbfe000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=0
	Memory window 1: fbbfd000-ffbfc000 (prefetchable)
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 20)
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at f4013000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
	Subsystem: Compaq Computer Corporation: Unknown device 8d88
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=64K]
	Region 1: I/O ports at 8098 [size=8]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] USB 1.1 Controller
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f4012000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at 8080 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4336 (prog-if 00 [VGA])
	Subsystem: Compaq Computer Corporation: Unknown device 00b0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at f4100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--Boundary-00=_Ia199gzBPBKVmnw
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

Linux version 2.4.20-tridentfix (root@bologoe.karpelevitch.net) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Tue Dec 10 15:08:22 PST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e800 (usable)
 BIOS-e820: 000000000009e800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000eef0000 (usable)
 BIOS-e820: 000000000eef0000 - 000000000eeff000 (ACPI data)
 BIOS-e820: 000000000eeff000 - 000000000ef00000 (ACPI NVS)
 BIOS-e820: 000000000ef00000 - 000000000f000000 (usable)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
240MB LOWMEM available.
On node 0 totalpages: 61440
zone(0): 4096 pages.
zone(1): 57344 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=Linux ro root=302 ide0=ata66 ide1=ata66
ide_setup: ide0=ata66
ide_setup: ide1=ata66
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 1325.116 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 2641.10 BogoMIPS
Memory: 240568k/245760k available (1192k kernel code, 4736k reserved, 360k data, 264k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
CPU: AMD Mobile AMD Athlon(tm) XP 1500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1325.1467 MHz.
..... host bus clock speed is 265.0292 MHz.
cpu: 0, clocks: 2650292, slice: 1325146
CPU0<T0:2650288,T1:1325136,D:6,S:1325146,C:2650292>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfd87e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 00:07.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
ACPI: System firmware supports S0 S3 S4 S5
Processor[0]: C0 C1, 8 throttling states
ACPI: AC Adapter found
ACPI: Power Button (FF) found
ACPI: Multiple power buttons detected, ignoring fixed-feature
ACPI: Power Button (CM) found
ACPI: Sleep Button (FF) found
ACPI: Multiple sleep buttons detected, ignoring fixed-feature
ACPI: Sleep Button (CM) found
ACPI: Lid Switch (CM) found
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 80
PCI: No IRQ known for interrupt pin A of device 00:10.0. Please try using pci=biosirq.
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
ALI15X3: ATA-66/100 forced bit set (WARNING)!!
    ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
ALI15X3: ATA-66/100 forced bit set (WARNING)!!
    ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MHR2030AT, ATA DISK drive
hdc: Compaq DVD-ROM SD-C2612, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3648/255/63
hdc: ATAPI 24X DVD-ROM drive, 192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 > p4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 190M
agpgart: unsupported bridge
agpgart: no supported devices found.
[drm] Initialized radeon 1.1.1 20010405 on minor 0
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 264k freed
Adding Swap: 289128k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
8139cp: 10/100 PCI Ethernet driver v0.3.0 (Sep 29, 2002)
PCI: Assigned IRQ 11 for device 00:0b.0
IRQ routing conflict for 00:0c.0, have irq 10, want irq 11
IRQ routing conflict for 01:05.0, have irq 10, want irq 11
eth0: RTL-8139C+ at 0xcf848000, 00:08:02:f3:99:58, IRQ 11
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 15:13:01 Dec 10 2002
PCI: Found IRQ 4 for device 00:08.0
IRQ routing conflict for 00:08.0, have irq 5, want irq 4
trident: ALi Audio Accelerator found at IO 0x8400, IRQ 5
ac97_codec: AC97 Audio codec, id: ADS97(Analog Devices AD1886)
spurious 8259A interrupt: IRQ7.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link down
eth0: link down
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available
mtrr: no more MTRRs available

--Boundary-00=_Ia199gzBPBKVmnw--
