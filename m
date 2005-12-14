Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbVLNNQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbVLNNQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbVLNNQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:16:12 -0500
Received: from femail.waymark.net ([206.176.148.84]:55494 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S932474AbVLNNQL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:16:11 -0500
Date: 14 Dec 2005 13:04:42 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [SERIAL, -mm] CRC failure
To: linux-kernel@vger.kernel.org
Message-ID: <d03ede.8e3895@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 14 Dec 05  06:30:18, Alan Cox wrote to All <=-

 >         Three -mm kernels of late, and now v2.6.15-rc5-mm2, give
 > frequent z-modem crc errors with minicom, lrz, and an external v90 modem
 > to a couple of local bb's.  2.6.15-rc5-git2 and before are okay.


 AC> Which -mm kernels gave the error, and which do you know ehrre ok.
some few since the recent serial mods. i remember the relating
announcement around the first. each tried, looks about the same in this
regard.

 AC> Also can you tell me more about the hardware arrangement you are
 AC> using - what cpu, what serial driver ?
e-machines 99.. here's dmesg and lspci -vv. thank you, feel free to
comment please.

 AC> The -mm tree contains some buffering changes I made and those
 AC> would be the obvious candidate for suspicion
i read some of the first -mm patch; nothing obvious.

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR+
        Latency: 0
        Region 0: Memory at fb000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64
Rate=x1
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fca00000-feafffff
        Prefetchable memory behind bridge: fa800000-fa8fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 06)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc.
VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:07.3 Bridge: VIA Technologies, Inc. VT82C596 Power Management
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage IIC AGP
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Ste
SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbor
<MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), cache line size 08
        Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at feac0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3ho
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Linux version 2.6.15-rc5-git2 (ken@fret) (gcc version 3.4.5) #26 Tue Dec 13
08:14:11 CST 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126960 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI not present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fb560
ACPI: RSDT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x1fff0000
ACPI: FADT (v001 AMIINT          0x00000000 MSFT 0x00000097) @ 0x1fff0030
ACPI: DSDT (v001    VIA    VT498 0x00001000 MSFT 0x01000007) @ 0x00000000
ACPI: PM-Timer IO Port: 0x5008
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.15-rc5-git2 ro quiet clock=tsc
dhash_entries=16000 ihash_entries=8000 rhash_entries=500 thash_entries=1000
Initializing CPU#0
CPU 0 irqstacks, hard=c02c7000 soft=c02c6000
PID hash table entries: 256 (order: 8, 4096 bytes)
Detected 200.460 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 100x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 517112k/524224k available (1325k kernel code, 6644k reserved, 326k
data, 140k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 401.75 BogoMIPS (lpj=2008758)
Mount-cache hash table entries: 64
CPU: After generic identify, caps: 0080a135 00000000 00000000 00000000 00000000
00000000 00000000
CPU: After vendor identify, caps: 0080a135 00000000 00000000 00000000 00000000
00000000 00000000
CPU: After all inits, caps: 0080a135 00000000 00000000 00000004 00000000
00000000 00000000
mtrr: v2.0 (20020519)
CPU: Cyrix M II 2x Core/Bus Clock stepping 04
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfdb31, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [NRTH] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.NRTH] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.NRTH._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: Power Resource [GLED] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: fca00000-feafffff
  PREFETCH window: fa800000-fa8fffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
io scheduler noop registered
io scheduler deadline registered
Activating ISA DMA hang workarounds.
ACPI: Power Button (FF) [PWRF]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: Card 'Crystal CS4235'
isapnp: 1 Plug & Play card detected total
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c596a (rev 06) IDE UDMA33 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 2F020J0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QUANTUM FIREBALL EX3.2A, ATA DISK drive
hdd: SAMSUNG SCR-3232, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 40718160 sectors (20847 MB) w/2048KiB Cache, CHS=40395/16/63, UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2
hdc: max request size: 128KiB
hdc: 6306048 sectors (3228 MB) w/418KiB Cache, CHS=6256/16/63, UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1 hdc2 hdc3
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
Advanced Linux Sound Architecture Driver Version 1.0.10rc3 (Mon Nov 07 13:30:21
2005 UTC).
pnp: Device 00:01.00 activated.
pnp: Device 00:01.02 activated.
pnp: Device 00:01.03 activated.
ALSA device list:
  #0: CS4235 at 0x534, irq 5, dma 1&3
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input1
IP route cache hash table entries: 512 (order: -1, 2048 bytes)
TCP established hash table entries: 1024 (order: 0, 4096 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 140k freed
input: PS/2 Generic Mouse as /class/input/input2
Adding 506008k swap on /dev/hda1.  Priority:-1 extents:1 across:506008k
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hdc2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 600 seconds
EXT3 FS on hdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A

--- MultiMail/Linux v0.46
