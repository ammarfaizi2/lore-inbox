Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269437AbRIBVgT>; Sun, 2 Sep 2001 17:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269593AbRIBVgK>; Sun, 2 Sep 2001 17:36:10 -0400
Received: from cc457643-c.ebnsk1.nj.home.com ([24.18.232.158]:17930 "EHLO
	cc457643-c.ebnsk1.nj.home.com") by vger.kernel.org with ESMTP
	id <S269437AbRIBVgC>; Sun, 2 Sep 2001 17:36:02 -0400
Date: Sun, 2 Sep 2001 05:37:13 -0400
From: Ari Pollak <compwiz@aripollak.com>
To: linux-kernel@vger.kernel.org
Subject: WinTV & A7A266
Message-ID: <20010902053713.A873@darth.ns>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux darth 2.4.9-ac5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please CC all replies to me.)

I'm using kernel 2.4.9-ac5 with a Hauppage WinTV (bt878) card and the
Asus A7A266 (ALiMAGiK chipset), BIOS revision 1006. When I run xawtv to
watch TV after loading the appropriate modules, the kernel spits out a
bunch of error messages about my IDE controller's IRQs and timing out
and such, and that DMA will be disabled. Unfortunately, these messages
don't get written to disk and the system partially freezes a few seconds
after the messages start. Using the mouse or keyboard have no effect,
but I can still see some of the IDE errors in my log window in the
background of X. 

The TV card worked perfectly with my Asus A7V133 motherboard, with
basically the same system configuration. It would seem as if the TV card
has some kind of IRQ conflict, but none of my cards are sharing an IRQ
with anything else. ALi & Hauppage admit a conflict between the card &
motherboard, but a BIOS update to my motherboard seems to have fixed the
problem they're talking about. ALi also put out an updated AGP driver
for Windows which is supposed to fix a crashing problem with the WinTV,
but has the fix also been integrated into the Linux kernel?

Following is the output of lspci -vvv, followed by /proc/interrupts,
then /proc/ioports, and /proc/iomem.

00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d6000000-d67fffff
	Prefetchable memory behind bridge: d7f00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d5800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) (prog-if fa)
	Subsystem: Asustek Computer, Inc.: Unknown device 8053
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at d4800000 (32-bit, non-prefetchable) [size=4K]
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

00:0a.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at a800 [size=128]
	Region 1: Memory at d3800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d7000000 (32-bit, prefetchable) [size=4K]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at d6800000 (32-bit, prefetchable) [size=4K]

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a000 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5144 (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 001a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d6000000 (32-bit, non-prefetchable) [size=512K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=27 SBA+ AGP+ 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

           CPU0       
  0:     133085          XT-PIC  timer
  1:          8          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      29738          XT-PIC  eth0
  8:          1          XT-PIC  rtc
  9:      19473          XT-PIC  usb-ohci, usb-ohci
 10:          2          XT-PIC  bttv
 11:          0          XT-PIC  EMU10K1
 14:      69029          XT-PIC  ide0
 15:          4          XT-PIC  ide1
NMI:          0 
ERR:          0


0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a000-a007 : Creative Labs SB Live!
  a000-a007 : emu10k1-gp
a400-a41f : Creative Labs SB Live! EMU10000
  a400-a41f : EMU10K1
a800-a87f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  a800-a87f : 00:0a.0
b400-b40f : Acer Laboratories Inc. [ALi] M5229 IDE
  b400-b407 : ide0
  b408-b40f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : PCI device 1002:5144 (ATI Technologies Inc)
e400-e43f : Acer Laboratories Inc. [ALi] M7101 PMU
e800-e81f : Acer Laboratories Inc. [ALi] M7101 PMU
  e800-e81f : ali1535-smb

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-001eac39 : Kernel code
  001eac3a-0022b93b : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
d3800000-d380007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
d4800000-d4800fff : Acer Laboratories Inc. [ALi] M5237 USB (#2)
  d4800000-d4800fff : usb-ohci
d5800000-d5800fff : Acer Laboratories Inc. [ALi] M5237 USB
  d5800000-d5800fff : usb-ohci
d6000000-d67fffff : PCI Bus #01
  d6000000-d607ffff : PCI device 1002:5144 (ATI Technologies Inc)
d6800000-d6800fff : Brooktree Corporation Bt878
d7000000-d7000fff : Brooktree Corporation Bt878
  d7000000-d7000fff : bttv
d7f00000-dfffffff : PCI Bus #01
  d8000000-dfffffff : PCI device 1002:5144 (ATI Technologies Inc)
e0000000-efffffff : PCI device 10b9:1647 (Acer Laboratories Inc. [ALi])
ffff0000-ffffffff : reserved
