Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUJBRP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUJBRP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 13:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUJBROJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 13:14:09 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:9441 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S267445AbUJBRJZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 13:09:25 -0400
Message-ID: <415EE0C4.90406@verizon.net>
Date: Sat, 02 Oct 2004 13:09:24 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Thinkpad 760ED PnP issues.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Sat, 2 Oct 2004 12:09:24 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having problems with my Thinkpad 760ED - I cannot get IRQ's for Cardbus 
cards.  I have verified that the slots are okay - my APA-1460A SCSI 
adapter (16-bit) works perfectly.

I've already mucked about with the BIOS IRQ configurations - IRQ 9 for 
Card slot 1, IRQ 10 for Card slot 2, IRQ 11 for PCI IRQ steering.

The Ali USB 2.0/1.1 controller is on the card I have installed - but my 
Netgear FA511 that shipped with the tulip driver and an IBM IEEE1394 
card with an OHCI-compliant chipset do the same thing - the drivers 
start to register, but fail since they cannot get an IRQ.

There are some other issues with this thing (vesafb fails, primarily), 
but this is the corker.

I'm new to kernel hacking - what is necessary to get the card slots 
working properly?

dump_pirq output:

No PCI interrupt routing table was found.
 
Interrupt router at 00:01.0: Intel 82371FB PIIX PCI-to-ISA bridge
  PIRQ1 (link 0x60): irq 11
  PIRQ2 (link 0x61): irq 11
  PIRQ3 (link 0x62): unrouted
  PIRQ4 (link 0x63): unrouted
  Serial IRQ: [disabled] [quiet] [frame=17] [pulse=4]
  Level mask: 0x0800 [11]


lspci -vvv output:

00:00.0 Host bridge: Intel Corp. 430MX - 82437MX Mob. System Ctrlr 
(MTSC) & 82438MX Data Path (MTDP) (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
 
00:01.0 ISA bridge: Intel Corp. 82371FB PIIX ISA [Triton I] (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:02.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10812000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=01, subordinate=04, sec-latency=176
        Memory window 0: 10000000-103ff000 (prefetchable)
        Memory window 1: 10400000-107ff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ 
PostWrite+
        16-bit legacy interface ports at 0001
 
00:02.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 08
        Interrupt: pin B routed to IRQ 0
        Region 0: Memory at 10811000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=08, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- 
PostWrite+
        16-bit legacy interface ports at 0001
 
00:03.0 VGA compatible controller: Trident Microsystems TGUI 
9660/938x/968x (rev d3) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 08000000 (32-bit, non-prefetchable) [size=4M]
        Region 1: Memory at 08400000 (32-bit, non-prefetchable) [size=64K]
        Region 2: Memory at 08800000 (32-bit, non-prefetchable) [size=4M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
 
00:05.0 Multimedia video controller: IBM MPEG PCI Bridge
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10810000 (32-bit, non-prefetchable) [size=256]
 
01:00.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) 
(prog-if 10 [OHCI])
        Subsystem: ALi Corporation USB 1.1 Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10400000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01) 
(prog-if 20 [EHCI])
        Subsystem: ALi Corporation USB 2.0 Controller
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at 10401000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2090]


dmesg output:

Linux version 2.6.8.1-Thinkpad.2 (root@david) (gcc version 3.3.3 
20040412 (Red Hat Linux 3.3.3-7)) #1 Fri Oct 1 23:56:10 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000005000000 (usable)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
80MB LOWMEM available.
On node 0 totalpages: 20480
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 16384 pages, LIFO batch:4
  HighMem zone: 0 pages, LIFO batch:1
DMI not present.
ACPI: Unable to locate RSDP
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6_kernel ro root=303
Initializing CPU#0
PID hash table entries: 512 (order 9: 4096 bytes)
Detected 132.675 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 77132k/81920k available (2360k kernel code, 4280k reserved, 819k 
data, 144k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 259.07 BogoMIPS
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 000001bf 00000000 00000000 00000000
CPU: After vendor identify, caps:  000001bf 00000000 00000000 00000000
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After all inits, caps:        000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd930, last bus=6
PCI: Using configuration type 1
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: the driver 'system' has been registered
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fe700
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xe724, dseg 0xf0000
pnp: match found with the PnP device '00:10' and the driver 'system'
pnp: 00:10: ioport range 0x100-0x107 has been reserved
pnp: 00:10: ioport range 0x26e-0x26f has been reserved
pnp: 00:10: ioport range 0xd00-0xd01 has been reserved
pnp: 00:10: ioport range 0x15e8-0x15ef has been reserved
spurious 8259A interrupt: IRQ7.
PnPBIOS: 17 nodes reported by PnP BIOS; 17 recorded by driver

[snip]

Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
PCI: No IRQ known for interrupt pin A of device 0000:00:02.0. Please try 
using pci=biosirq.
Yenta: CardBus bridge found at 0000:00:02.0 [0000:0000]
Yenta: ISA IRQ mask 0x0638, PCI irq 0
Socket status: 30000020
PCI: No IRQ known for interrupt pin B of device 0000:00:02.1. Please try 
using pci=biosirq.
Yenta: CardBus bridge found at 0000:00:02.1 [0000:0000]
Yenta: ISA IRQ mask 0x0638, PCI irq 0
Socket status: 30000006
PCI: Enabling device 0000:01:00.3 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 0000:01:00.3. Please try 
using pci=biosirq.
ehci_hcd 0000:01:00.3: Found HC with no IRQ.  Check BIOS/PCI 
0000:01:00.3 setup!
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Enabling device 0000:01:00.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 0000:01:00.0. Please try 
using pci=biosirq.
ohci_hcd 0000:01:00.0: Found HC with no IRQ.  Check BIOS/PCI 
0000:01:00.0 setup!
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0820-0x08ff: clean.
cs: IO port probe 0x0800-0x080f: clean.
cs: IO port probe 0x03e0-0x04ff: excluding 0x4d0-0x4d7
cs: IO port probe 0x0100-0x03af: clean.
cs: IO port probe 0x0a00-0x0aff: excluding 0xa68-0xa6f
USB Universal Host Controller Interface driver v2.2

