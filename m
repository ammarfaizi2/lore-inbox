Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287519AbRLaOdg>; Mon, 31 Dec 2001 09:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287526AbRLaOda>; Mon, 31 Dec 2001 09:33:30 -0500
Received: from smtp2.libero.it ([193.70.192.52]:27083 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S287527AbRLaOdN>;
	Mon, 31 Dec 2001 09:33:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Fabio Tudone <ftudone@libero.it>
Reply-To: ftudone@libero.it
Organization: Universita` Ca' Foscari di Venezia (DSI)
To: linux-kernel@vger.kernel.org
Subject: IRQ assignment probs with "1st Supersonic M6T Gericom" laptop
Date: Mon, 31 Dec 2001 15:26:51 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011231143320Z287527-18285+6905@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've just got a Gericom laptop (Gericom 1st Supersonic M6T 1200,
also known as Gericom A380) and I'm having alot of trouble getting
the internal peripherals working (all of them are supported using
kernel-included drivers, except the Lucent WinModem, which is
supported using a separate module).

The basic problem is that I've been able to get interrupts assigned to the 
peripherals  _only_ booting into Windows 2000 (other Windows versions won't
do the trick) _from poweroff_ and then booting into Linux (I think that in 
fact it's a broken BIOS problem, but there are no upgrades available yet).

Even then, the  soundcard didn't work correctly (I think because of another 
IRQ routing problem).

I've tested kernels from RH 7.2 (2.4.7 + RH patches), from Mandrake 8.1
(2.4.8 + MDK patches), clean 2.4.17 and 2.4.18pre1.

The laptop HW configuration is the following:

- Chipset VIA vt82c686b (rev 40) with PIII 1200 stepping 01, 384 MB RAM
- Radeon Mobility
- Accton EN2242 Series MiniPCI Fast Ethernet AAdapter (using tulip driver)
- Lucent Technologies LT Win Modem (using linmodem external module)
- Lucent Technologies IEEE 1394 firewire controller (OHCI compatible, using 
OHCI driver)
- VIA 686a AC97 audio (using via82cxxx driver)
- Serial port, IRDA port, parallel port
- 1 atapi HD (/dev/hda)
- 1 atapi CDRW/DVD (/dev/hdc)

The ethernet card, the modem and the firewire controller
all share IRQ 10 (together with 2 Cardbus bridge) under W2000. The sound
device uses IRQ 5 together with the video card and the USB controller.

Under Linux, the soundcard gets assigned IRQ 4 but it doesn't work correctly
and the ethernet card, the modem and the firewire all get
IRQ 0 (= IRQ not found, right?) when not coming from a previous W2000
boot. The Cardbus devices seem to work correctly (I haven't tested them, 
though).

I've tried to figure out what's happening enabling the DEBUG #defs
in "linux/arch/i386/kernel/pci-*", but my knowledge of bios32/PCI/chipset
inner workings are non-existent to say the least :-(

I'm adding as attachment the boot messages of a 2.4.17 kernel (with
PCI debug enabled, APM, no ACPI and relevant drivers compiled in) before and 
after booting  fresh into W2000, together with the respective output of the 
"lspci -vv" command. The command line was:

    ro root=/dev/hda5 hdc=ide-scsi

I've tried also the "pci=bios", "pci=nobios", "pci=biosirq" boot options
without success.

Has anyone else alread been experiencing that ?

Is there any fix/workaraound/gross hack ?

Thanks for your time.

Bye


- Fabio "Lievore" Tudone ---------- ftudone@libero.it -----------------
----- ICQ# = 19799351 --------------- AIM  = Ljevore ------------------



-------------------------"lspci -vv" before W2000---------------------------

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0000000-e00fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: Askey Computer Corp.: Unknown device 4005
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 18000000 (32-bit, non-prefetchable) [disabled] [size=256]
	Region 1: I/O ports at 1018 [disabled] [size=8]
	Region 2: I/O ports at 1800 [disabled] [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=160mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 4
	Region 0: I/O ports at 1400 [size=256]
	Region 1: I/O ports at 1014 [size=4]
	Region 2: I/O ports at 1010 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Accton Technology Corporation: Unknown device 
1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: Memory at 18000400 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 18001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 18400000-187ff000 (prefetchable)
	Memory window 1: 18800000-18bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 18002000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 18c00000-18fff000 (prefetchable)
	Memory window 1: 19000000-193ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 
(rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at 18003000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 
(prog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1930
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
----------------------------------------------------------------------------



-------------------------boot log before W2000------------------------------

Linux version 2.4.17 (root@diana.nonworld.wuhsin) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-98)) #8 lun dic 31 12:48:33 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda5 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1199.825 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 384436k/393216k available (1329k kernel code, 8328k reserved, 381k 
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f6d60
PCI: BIOS32 Service Directory entry at 0xfd730
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd84e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/0691] 000600 00
PCI: Calling quirk c010dd40 for 00:00.0
Found 00:08 [1106/8598] 000604 01
PCI: Calling quirk c010dd40 for 00:01.0
Found 00:30 [11c1/0450] 000780 00
PCI: Calling quirk c010dd40 for 00:06.0
Found 00:38 [1106/0686] 000601 00
PCI: Calling quirk c010dd40 for 00:07.0
Found 00:39 [1106/0571] 000101 00
PCI: Calling quirk c010dd40 for 00:07.1
PCI: IDE base address fixup for 00:07.1
Found 00:3a [1106/3038] 000c03 00
PCI: Calling quirk c010dd40 for 00:07.2
Found 00:3c [1106/3057] 000601 00
PCI: Calling quirk c010dd40 for 00:07.4
PCI: Calling quirk c02bc230 for 00:07.4
PCI: Calling quirk c02bc2a0 for 00:07.4
Found 00:3d [1106/3058] 000401 00
PCI: Calling quirk c010dd40 for 00:07.5
Found 00:48 [1113/1216] 000200 00
PCI: Calling quirk c010dd40 for 00:09.0
Found 00:60 [1217/6933] 000607 02
PCI: Calling quirk c010dd40 for 00:0c.0
Found 00:61 [1217/6933] 000607 02
PCI: Calling quirk c010dd40 for 00:0c.1
Found 00:68 [11c1/5811] 000c00 00
PCI: Calling quirk c010dd40 for 00:0d.0
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [1002/4c59] 000300 00
PCI: Calling quirk c010dd40 for 01:00.0
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:0c.0, config 000000, pass 0
Scanning behind PCI bridge 00:0c.1, config 000000, pass 0
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Scanning behind PCI bridge 00:0c.0, config 000000, pass 1
Scanning behind PCI bridge 00:0c.1, config 000000, pass 1
Bus scan for 00 returning with max=09
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf80
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: IRQ fixup
00:07.5: ignoring bogus IRQ 255
IRQ for 00:06.0:0 -> not found in routing table
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=0 -> got IRQ 4
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
IRQ for 00:09.0:0 -> not found in routing table
IRQ for 00:0d.0:0 -> not found in routing table
PCI: Allocating resources
PCI: Resource e8000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 00001000-0000100f (f=101, d=0, p=0)
PCI: Resource 00001020-0000103f (f=101, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Resource 00001014-00001017 (f=105, d=0, p=0)
PCI: Resource 00001010-00001013 (f=101, d=0, p=0)
PCI: Resource 00001c00-00001cff (f=101, d=0, p=0)
PCI: Resource 18000400-180007ff (f=200, d=0, p=0)
PCI: Resource 18001000-18001fff (f=200, d=0, p=0)
PCI: Resource 18002000-18002fff (f=200, d=0, p=0)
PCI: Resource 18003000-18003fff (f=200, d=0, p=0)
PCI: Resource f0000000-f7ffffff (f=1208, d=0, p=0)
PCI: Resource 00009000-000090ff (f=101, d=0, p=0)
PCI: Resource e0000000-e000ffff (f=200, d=0, p=0)
PCI: Resource 18000000-180000ff (f=200, d=1, p=1)
PCI: Resource 00001018-0000101f (f=109, d=1, p=1)
PCI: Resource 00001800-000018ff (f=101, d=1, p=1)
PCI: Sorting device list...
PCI: Calling quirk c02bc3b0 for 00:00.0
PCI: Calling quirk c02bc3b0 for 00:01.0
PCI: Calling quirk c02bc3b0 for 00:06.0
PCI: Calling quirk c02bc3b0 for 00:07.0
PCI: Calling quirk c02bc3b0 for 00:07.1
PCI: Calling quirk c02bc3b0 for 00:07.2
PCI: Calling quirk c02bc2e0 for 00:07.2
PCI: Calling quirk c02bc3b0 for 00:07.4
PCI: Calling quirk c02bc3b0 for 00:07.5
PCI: Calling quirk c02bc2e0 for 00:07.5
PCI: Via IRQ fixup for 00:07.5, from 255 to 4
PCI: Calling quirk c02bc3b0 for 00:09.0
PCI: Calling quirk c02bc3b0 for 00:0c.0
PCI: Calling quirk c02bc3b0 for 00:0c.1
PCI: Calling quirk c02bc3b0 for 00:0d.0
PCI: Calling quirk c02bc3b0 for 01:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
IRQ for 01:00.0:0 -> not found in routing table
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: Failed to detect DFP panel size
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
IRQ for 00:09.0:0 -> not found in routing table
PCI: No IRQ known for interrupt pin A of device 00:09.0. Please try using 
pci=biosirq.
PCI: Enabling bus mastering for device 00:09.0
eth0: ADMtek Comet rev 17 at 0x1c00, 00:90:96:1C:FF:1A, IRQ 0.
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
IRQ for 00:0d.0:0 -> not found in routing table
PCI: No IRQ known for interrupt pin A of device 00:0d.0. Please try using 
pci=biosirq.
PCI: Enabling bus mastering for device 00:0d.0
ohci1394: Failed to allocate shared interrupt 0
Trying to free free IRQ0
Via 686a audio driver 1.9.1
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=4 -> got IRQ 4
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0x800000)
via82cxxx: timeout while reading AC97 codec (0xBC0000)
ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1400, IRQ 4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Real Time Clock Driver v1.10e
Adding Swap: 602396k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 12:04:23 Dec 30 2001
usb-uhci.c: High bandwidth mode enabled
IRQ for 00:07.2:3 -> PIRQ 57, mask 0020, excl 0000 -> newirq=5 -> got IRQ 5
PCI: Found IRQ 5 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NTFS driver v1.1.21 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
----------------------------------------------------------------------------



-------------------------"lspci -vv" after W2000----------------------------

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0000000-e00fffff
	Prefetchable memory behind bridge: f0000000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Communication controller: Lucent Microelectronics LT WinModem
	Subsystem: Askey Computer Corp.: Unknown device 4005
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffefcf00 (32-bit, non-prefetchable) [disabled] [size=256]
	Region 1: I/O ports at fff0 [disabled] [size=8]
	Region 2: I/O ports at f900 [disabled] [size=256]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=160mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at 1000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at 1020 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1840
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 4
	Region 0: I/O ports at 1400 [size=256]
	Region 1: I/O ports at 1014 [size=4]
	Region 2: I/O ports at 1010 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Accton Technology Corporation: Unknown device 
1216 (rev 11)
	Subsystem: Accton Technology Corporation: Unknown device 2242
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 80 (63750ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f800 [size=256]
	Region 1: Memory at ffefc800 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 18400000-187ff000 (prefetchable)
	Memory window 1: 18800000-18bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0c.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 01)
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1860
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 18001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 18c00000-18fff000 (prefetchable)
	Memory window 1: 19000000-193ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0d.0 FireWire (IEEE 1394): Lucent Microelectronics: Unknown device 5811 
(rev 04) (prog-if 10 [OHCI])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1881
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (3000ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at ffeff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c59 
(prog-if 00 [VGA])
	Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 1930
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
----------------------------------------------------------------------------



-------------------------boot log after W2000-------------------------------

Linux version 2.4.17 (root@diana.nonworld.wuhsin) (gcc version 2.96 20000731 
(Red Hat Linux 7.1 2.96-98)) #8 lun dic 31 12:48:33 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000d0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ef0000 (usable)
 BIOS-e820: 0000000017ef0000 - 0000000017eff000 (ACPI data)
 BIOS-e820: 0000000017eff000 - 0000000017f00000 (ACPI NVS)
 BIOS-e820: 0000000017f00000 - 0000000018000000 (usable)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda5 hdc=ide-scsi
ide_setup: hdc=ide-scsi
Initializing CPU#0
Detected 1199.817 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 2392.06 BogoMIPS
Memory: 384436k/393216k available (1329k kernel code, 8328k reserved, 381k 
data, 220k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383f9ff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000000
CPU:             Common caps: 0383f9ff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) III CPU             1200MHz stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: BIOS32 Service Directory structure at 0xc00f6d60
PCI: BIOS32 Service Directory entry at 0xfd730
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfd84e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1106/0691] 000600 00
PCI: Calling quirk c010dd40 for 00:00.0
Found 00:08 [1106/8598] 000604 01
PCI: Calling quirk c010dd40 for 00:01.0
Found 00:30 [11c1/0450] 000780 00
PCI: Calling quirk c010dd40 for 00:06.0
Found 00:38 [1106/0686] 000601 00
PCI: Calling quirk c010dd40 for 00:07.0
Found 00:39 [1106/0571] 000101 00
PCI: Calling quirk c010dd40 for 00:07.1
PCI: IDE base address fixup for 00:07.1
Found 00:3a [1106/3038] 000c03 00
PCI: Calling quirk c010dd40 for 00:07.2
Found 00:3c [1106/3057] 000601 00
PCI: Calling quirk c010dd40 for 00:07.4
PCI: Calling quirk c02bc230 for 00:07.4
PCI: Calling quirk c02bc2a0 for 00:07.4
Found 00:3d [1106/3058] 000401 00
PCI: Calling quirk c010dd40 for 00:07.5
Found 00:48 [1113/1216] 000200 00
PCI: Calling quirk c010dd40 for 00:09.0
Found 00:60 [1217/6933] 000607 02
PCI: Calling quirk c010dd40 for 00:0c.0
Found 00:61 [1217/6933] 000607 02
PCI: Calling quirk c010dd40 for 00:0c.1
Found 00:68 [11c1/5811] 000c00 00
PCI: Calling quirk c010dd40 for 00:0d.0
Fixups for bus 00
PCI: Scanning for ghost devices on bus 0
Scanning behind PCI bridge 00:01.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [1002/4c59] 000300 00
PCI: Calling quirk c010dd40 for 01:00.0
Fixups for bus 01
PCI: Scanning for ghost devices on bus 1
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:0c.0, config 000000, pass 0
Scanning behind PCI bridge 00:0c.1, config 000000, pass 0
Scanning behind PCI bridge 00:01.0, config 010100, pass 1
Scanning behind PCI bridge 00:0c.0, config 000000, pass 1
Scanning behind PCI bridge 00:0c.1, config 000000, pass 1
Bus scan for 00 returning with max=09
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00fdf80
PCI: Attempting to find IRQ router for 1106:0596
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI: IRQ fixup
00:07.5: ignoring bogus IRQ 255
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=0 -> got IRQ 4
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
PCI: Allocating resources
PCI: Resource e8000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 00001000-0000100f (f=101, d=0, p=0)
PCI: Resource 00001020-0000103f (f=101, d=0, p=0)
PCI: Resource 00001400-000014ff (f=101, d=0, p=0)
PCI: Resource 00001014-00001017 (f=105, d=0, p=0)
PCI: Resource 00001010-00001013 (f=101, d=0, p=0)
PCI: Resource 0000f800-0000f8ff (f=101, d=0, p=0)
PCI: Resource ffefc800-ffefcbff (f=200, d=0, p=0)
PCI: Resource ffeff000-ffefffff (f=200, d=0, p=0)
PCI: Resource f0000000-f7ffffff (f=1208, d=0, p=0)
PCI: Resource 00009000-000090ff (f=101, d=0, p=0)
PCI: Resource e0000000-e000ffff (f=200, d=0, p=0)
PCI: Resource ffefcf00-ffefcfff (f=200, d=1, p=1)
PCI: Resource 0000fff0-0000fff7 (f=101, d=1, p=1)
PCI: Resource 0000f900-0000f9ff (f=101, d=1, p=1)
  got res[18000000:18000fff] for resource 0 of O2 Micro, Inc. OZ6933 Cardbus 
Controller
  got res[18001000:18001fff] for resource 0 of O2 Micro, Inc. OZ6933 Cardbus 
Controller (#2)
PCI: Sorting device list...
PCI: Calling quirk c02bc3b0 for 00:00.0
PCI: Calling quirk c02bc3b0 for 00:01.0
PCI: Calling quirk c02bc3b0 for 00:06.0
PCI: Calling quirk c02bc3b0 for 00:07.0
PCI: Calling quirk c02bc3b0 for 00:07.1
PCI: Calling quirk c02bc3b0 for 00:07.2
PCI: Calling quirk c02bc2e0 for 00:07.2
PCI: Calling quirk c02bc3b0 for 00:07.4
PCI: Calling quirk c02bc3b0 for 00:07.5
PCI: Calling quirk c02bc2e0 for 00:07.5
PCI: Via IRQ fixup for 00:07.5, from 255 to 4
PCI: Calling quirk c02bc3b0 for 00:09.0
PCI: Calling quirk c02bc3b0 for 00:0c.0
PCI: Calling quirk c02bc3b0 for 00:0c.1
PCI: Calling quirk c02bc3b0 for 00:0d.0
PCI: Calling quirk c02bc3b0 for 01:00.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.15)
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.7 (20011216) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
parport0: PC-style at 0x378 [PCSPP,TRISTATE,EPP]
parport_pc: Via 686A parallel port: io=0x378
IRQ for 01:00.0:0 -> not found in routing table
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: Failed to detect DFP panel size
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI 
ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0x1000-0x1007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1008-0x100f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N020ATDA04-0, ATA DISK drive
hdc: UJDA710, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39070080 sectors (20004 MB) w/1806KiB Cache, CHS=2432/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
IRQ for 00:09.0:0 -> not found in routing table
PCI: Enabling bus mastering for device 00:09.0
eth0: ADMtek Comet rev 17 at 0xf800, 00:90:96:1C:FF:1A, IRQ 10.
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
IRQ for 00:0d.0:0 -> not found in routing table
PCI: Enabling bus mastering for device 00:0d.0
PCI: Setting latency timer of device 00:0d.0 to 64
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[ffeff000-fff00000]  Max 
Packet=[2048]
Via 686a audio driver 1.9.1
IRQ for 00:07.5:2 -> PIRQ 56, mask 0020, excl 0000 -> newirq=4 -> got IRQ 4
PCI: Found IRQ 4 for device 00:07.5
IRQ routing conflict for 00:0c.1, have irq 10, want irq 4
via82cxxx: timeout while reading AC97 codec (0xAA0000)
via82cxxx: timeout while reading AC97 codec (0x800000)
via82cxxx: timeout while reading AC97 codec (0xBC0000)
ac97_codec: AC97  codec, id: 0x4144:0x5361 (Unknown)
via82cxxx: board #1 at 0x1400, IRQ 4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 220k freed
Real Time Clock Driver v1.10e
Adding Swap: 602396k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 12:04:23 Dec 30 2001
usb-uhci.c: High bandwidth mode enabled
IRQ for 00:07.2:3 -> PIRQ 57, mask 0020, excl 0000 -> newirq=5 -> assigning 
IRQ 5 ... OK
PCI: Assigned IRQ 5 for device 00:07.2
usb-uhci.c: USB UHCI at I/O 0x1020, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,5), internal journal
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NTFS driver v1.1.21 [Flags: R/O MODULE]
NTFS: Warning! NTFS volume version is Win2k+: Mounting read-only
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: UJDA710           Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
----------------------------------------------------------------------------

