Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750898AbWGCHWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbWGCHWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 03:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbWGCHWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 03:22:44 -0400
Received: from mx2.mail.ru ([194.67.23.122]:33643 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1750798AbWGCHWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 03:22:43 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17.2 + libata + pata_ali - interminnent can't resume after STR
Date: Mon, 3 Jul 2006 11:22:33 +0400
User-Agent: KMail/1.9.3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607031122.38107.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

2.6.17.2, libata for 2.6.17 from Tejun Heo 
(http://home-tj.org/files/libata-tj-stable/libata-tj-2.6.17-20060625.tar.bz2), 
pata_ali from Jeff Garzik tree patched to add parameter to set transfer mask 
for ATAPI (as already posted it does not detect CD-ROM in DMA so I clamp it 
to PIO4). System - TOSHIBA Portege 4000.

Several times after switching to libata system hung on resume from suspend to 
RAM. It is stuck attempting to initialize hard drive and doing recovery in 
loop.

Unfortunately this notebook does not have any serial port so it is somewhat 
hard capture any console output during resume. 

I have been using STR with legacy IDE drivers without any problems so far. Any 
idea how to debug it welcome.

Thank you

- -andrey

{pts/0}% sudo lspci -vvv
00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [b0] AGP version 2.0
                Status: RQ=28 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [a4] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller (prog-if 00 [Normal 
decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f7f00000-fdffffff
        Prefetchable memory behind bridge: 3c000000-3c0fffff
        Secondary status: 66MHz+ FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR+
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03) (prog-if 
10 [OHCI])
        Subsystem: Toshiba America Info Systems Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f7eff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if f0)
        Subsystem: Toshiba America Info Systems Unknown device 0004
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at eff0 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link 
Controller Audio Device (rev 01)
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at ed00 [size=256]
        Region 1: Memory at f7efe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge [Aladdin 
IV/V/V+]
        Subsystem: Toshiba America Info Systems Unknown device 0004
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] 
(rev 08)
        Subsystem: Toshiba America Info Systems 8255x-based Fast Ethernet
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f7efd000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at eb40 [size=64]
        Region 2: Memory at f7d00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
        Subsystem: Lucent Technologies Unknown device ab01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 3c100000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 30000000-31fff000 (prefetchable)
        Memory window 1: 32000000-33fff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt- PostWrite+
        16-bit legacy interface ports at 0001

00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 3c101000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=0
        Memory window 0: 34000000-35fff000 (prefetchable)
        Memory window 1: 36000000-37fff000
        I/O window 0: 00001800-000018ff
        I/O window 1: 00001c00-00001cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus 
Bridge with ZV Support (rev 32)
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at 3c102000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=0a, subordinate=0d, sec-latency=0
        Memory window 0: 38000000-39fff000 (prefetchable)
        Memory window 1: 3a000000-3bfff000
        I/O window 0: 00002000-000020ff
        I/O window 1: 00002400-000024ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller 
(rev 03)
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f7cffe00 (32-bit, non-prefetchable) [size=512]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1 (rev 
82) (prog-if 00 [VGA])
        Subsystem: Toshiba America Info Systems Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at fbc00000 (32-bit, non-prefetchable) [size=4M]
        Region 2: Memory at f8000000 (32-bit, non-prefetchable) [size=32M]
        Region 3: Memory at f7ff8000 (32-bit, non-prefetchable) [size=32K]
        [virtual] Expansion ROM at 3c000000 [disabled] [size=64K]
        Capabilities: [80] AGP version 2.0
                Status: RQ=33 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [90] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

{pts/0}%
Linux version 2.6.17.2-1avb (bor@cooker) (gcc version 4.1.1 20060518 
(prerelease)) #26 Fri Jun 30 12:51:27 MSD 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ef60000 (usable)
 BIOS-e820: 000000001ef60000 - 000000001ef70000 (ACPI data)
 BIOS-e820: 000000001ef70000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126816
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 122720 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0090
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60054
ACPI: DSDT (v001 TOSHIB 4000     0x20020417 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 resume=/dev/sda1 elevator=cfq vga=791
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013e4000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 747.720 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 499052k/507264k available (1667k kernel code, 7648k reserved, 799k 
data, 180k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1496.76 BogoMIPS (lpj=748383)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs... it is
Freeing initrd memory: 292k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfe5ae, last bus=5
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region ee00-ee3f claimed by ali7101 ACPI
PCI quirk: region ef00-ef1f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f7f00000-fdffffff
  PREFETCH window: 3c000000-3c0fffff
PCI: Bus 2, cardbus bridge: 0000:00:10.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:11.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 10, cardbus bridge: 0000:00:11.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 38000000-39ffffff
  MEM window: 3a000000-3bffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1151845047.480:1): initialized
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xfc000000, mapped to 0xdf880000, using 3072k, total 
16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:775e
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices:
 COM USB1 ASND VIY0 VIY1  LAN MPC0 MPC1 NOV0  LID
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
Freeing unused kernel memory: 180k freed
Write protecting the kernel read-only data: 520k
input: AT Translated Set 2 keyboard as /class/input/input0
SCSI subsystem initialized
libata version 1.30 loaded.
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
scsi0 : pata_ali
ata1.00: configured for UDMA/33
  Vendor: ATA       Model: IC25N020ATDA04-0  Rev: DA3O
  Type:   Direct-Access                      ANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
scsi1 : pata_ali
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata2.00: configured for PIO4
  Vendor: TOSHIBA   Model: DVD-ROM SD-C2502  Rev: 1313
  Type:   CD-ROM                             ANSI SCSI revision: 05
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
ReiserFS: sda2: found reiserfs format "3.6" with standard journal
ReiserFS: sda2: using ordered data mode
ReiserFS: sda2: journal params: device sda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sda2: checking transaction log (sda2)
ReiserFS: sda2: replayed 51 transactions in 8 seconds
ReiserFS: sda2: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000011
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
25 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (38 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
ReiserFS: sda2: Removing [35299 359282 0x0 SD]..done
ReiserFS: sda2: Removing [160679 286174 0x0 SD]..done
ReiserFS: sda2: Removing [79727 236457 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236448 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236444 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236442 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236438 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236410 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236387 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236369 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236368 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236365 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236363 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236338 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236337 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236336 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236333 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236305 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236299 0x0 SD]..done
ReiserFS: sda2: Removing [45614 236298 0x0 SD]..done
ReiserFS: sda2: Removing [45614 235022 0x0 SD]..done
ReiserFS: sda2: Removing [45614 235014 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234983 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234970 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234954 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234925 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234421 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234416 0x0 SD]..done
ReiserFS: sda2: Removing [45614 234396 0x0 SD]..done
ReiserFS: sda2: Removing [45614 233009 0x0 SD]..done
ReiserFS: sda2: Removing [45614 233007 0x0 SD]..done
ReiserFS: sda2: Removing [45614 233004 0x0 SD]..done
ReiserFS: sda2: Removing [45614 232966 0x0 SD]..done
ReiserFS: sda2: Removing [45614 123769 0x0 SD]..done
ReiserFS: sda2: Removing [45614 100962 0x0 SD]..done
ReiserFS: sda2: Removing [45614 87692 0x0 SD]..done
ReiserFS: sda2: Removing [178237 79655 0x0 SD]..done
ReiserFS: sda2: Removing [45614 74578 0x0 SD]..done
ReiserFS: sda2: There were 38 uncompleted unlinks/truncates. Completed
Adding 500432k swap on /dev/sda1.  Priority:-1 extents:1 across:500432k
loop: loaded (max 8 devices)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEqMW9R6LMutpd94wRAuC6AJ4kSKl024bAGzYj3R5rqTWiAZAxLQCgyaH4
FYyHc+bSfm1UGAbkylNUQvA=
=4/EW
-----END PGP SIGNATURE-----
