Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTLKEwJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 23:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTLKEwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 23:52:09 -0500
Received: from zxa8020.lanisdn-gte.net ([206.46.31.146]:22984 "EHLO
	links.magenta.com") by vger.kernel.org with ESMTP id S263618AbTLKEvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 23:51:50 -0500
Date: Wed, 10 Dec 2003 23:51:45 -0500
From: Raul Miller <moth@magenta.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
Message-ID: <20031210235145.E28449@links.magenta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.

[2.] Full description of problem:

While I have 2G ram installed, I only get the benefit of 1G.  The bios,
and grub, both report 2G.  However, even passing mem=2048m as a boot
parameter doesn't get me access to the other half of my memory.  I see
no warning messages about why this memory isn't available.

I understand that there's a distinct possibility that this won't be
corrected in 2.6 (after all, my machine isn't crashing), but I'm hoping
at least for a few tips on how to patch things up in some ad-hoc fashion.

[3.] Keywords: memory, motherboard

[4.] Kernel version: Linux version 2.6.0-test11 (root@localhost) (gcc version 3.3.2 (Debian)) #3 SMP Fri Dec 5 22:37:08 EST 2003

[5.] Oops: n/a, however here's cat /proc/meminfo, just in case there's
anything relevant here which doesn't show up in /proc/iomem:
MemTotal:       904612 kB
MemFree:        749108 kB
Buffers:         11680 kB
Cached:          71008 kB
SwapCached:          0 kB
Active:          85892 kB
Inactive:        51068 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       904612 kB
LowFree:        749108 kB
SwapTotal:     4000208 kB
SwapFree:      4000208 kB
Dirty:               4 kB
Writeback:           0 kB
Mapped:          81988 kB
Slab:            10716 kB
Committed_AS:   139044 kB
PageTables:        812 kB
VmallocTotal:   122808 kB
VmallocUsed:      2756 kB
VmallocChunk:   119744 kB

[6.] Demo program: (n/a)

[7.1.] ver_linux says:

Linux localhost 2.6.0-test11 #3 SMP Fri Dec 5 22:37:08 EST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         fglrx hid ppp_async ppp_generic slhc uhci_hcd parport_pc lp parport 3c59x usbmouse usbkbd usbcore

It's probably worth noting that I'm using a radeon 9800 xt as one of
my graphics cards.  And, no, the kernel doesn't recognize that card,
either.  Amusingly, the ATI driver doesn't properly recognize it either
(fglrx-flc22, version 3.2.8 reports that I've got a non-ati card).
However, since this happens well after memory is detected, I'm presuming
that it's unrelated to my problem.

[7.2.] /proc/cpuinfo says:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1403.869
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow
bogomips        : 2752.51

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 240
stepping        : 1
cpu MHz         : 1403.869
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow
bogomips        : 2801.66


[7.3.] /proc/modules says:
fglrx 207268 0 - Live 0xf8aca000
hid 33280 0 - Live 0xf8a6f000
ppp_async 12288 0 - Live 0xf8a5d000
ppp_generic 30352 1 ppp_async, Live 0xf8a79000
slhc 7040 1 ppp_generic, Live 0xf8a5a000
uhci_hcd 34064 0 - Live 0xf8a65000
parport_pc 34048 1 - Live 0xf8a1a000
lp 9824 0 - Live 0xf8a10000
parport 30240 2 parport_pc,lp, Live 0xf8a24000
3c59x 39656 0 - Live 0xf8a4f000
usbmouse 5632 0 - Live 0xf8a17000
usbkbd 7296 0 - Live 0xf8a14000
usbcore 114012 6 hid,uhci_hcd,usbmouse,usbkbd, Live 0xf8a32000

[7.4.a] /proc/ioports says:

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  a000-a0ff : 0000:01:00.0
b000-b07f : 0000:00:06.0
  b000-b07f : 0000:00:06.0
b400-b407 : 0000:00:0f.0
b800-b803 : 0000:00:0f.0
bc00-bc07 : 0000:00:0f.0
c000-c003 : 0000:00:0f.0
c400-c40f : 0000:00:0f.0
c800-c8ff : 0000:00:0f.0
cc00-cc0f : 0000:00:0f.1
  cc00-cc07 : ide0
  cc08-cc0f : ide1
d000-d01f : 0000:00:10.0
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:10.1
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:10.2
  d800-d81f : uhci_hcd
e000-e0ff : 0000:00:11.5

[7.4.b] /proc/iomem says:

00000000-0009d7ff : System RAM
0009d800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7feeffff : System RAM
  00100000-003260d8 : Kernel code
  003260d9-003f50bf : Kernel data
7fef0000-7fef2fff : ACPI Non-volatile Storage
7fef3000-7fefffff : ACPI Tables
d0000000-dfffffff : 0000:00:00.0
e0000000-efffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
  e8000000-efffffff : 0000:01:00.1
f0000000-f1ffffff : PCI Bus #01
  f1000000-f100ffff : 0000:01:00.0
  f1010000-f101ffff : 0000:01:00.1
f2000000-f2003fff : 0000:00:05.0
f3000000-f37fffff : 0000:00:05.0
f5000000-f500ffff : 0000:00:0b.0
f5010000-f501007f : 0000:00:06.0
f5011000-f50110ff : 0000:00:10.4
fec00000-ffffffff : reserved

[7.5.] lspci -vvvx says:

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3188 (rev 01)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [80] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=2 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] #08 [8001]
00: 06 11 88 31 06 00 30 22 01 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b188 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f0000000-f1ffffff
	Prefetchable memory behind bridge: e0000000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 88 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 a0 a0 20 22
20: 00 f0 f0 f1 00 e0 f0 ef 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00

00:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] (rev 01) (prog-if 00 [VGA])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f2000000 (32-bit, non-prefetchable) [disabled] [size=16K]
	Region 1: Memory at f3000000 (32-bit, prefetchable) [disabled] [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
00: 2b 10 19 05 80 00 80 02 01 00 00 03 00 00 00 00
10: 00 00 00 f2 08 00 00 f3 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at b000 [size=128]
	Region 1: Memory at f5010000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b7 10 55 90 07 00 10 02 64 00 00 02 08 20 00 00
10: 01 b0 00 00 00 00 01 f5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0a 0a

00:0b.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705 Gigabit Ethernet (rev 03)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (16000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at f5000000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable+ DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: fffffffdfffffbe4  Data: ffff
00: e4 14 53 16 06 00 b0 02 03 00 00 02 08 20 00 00
10: 04 00 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 07 00 00 00 62 14 00 13
30: 00 00 00 00 48 00 00 00 00 00 00 00 0a 01 40 00

00:0f.0 RAID bus controller: VIA Technologies, Inc.: Unknown device 3149 (rev 80)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin B routed to IRQ 20
	Region 0: I/O ports at b400 [size=8]
	Region 1: I/O ports at b800 [size=4]
	Region 2: I/O ports at bc00 [size=8]
	Region 3: I/O ports at c000 [size=4]
	Region 4: I/O ports at c400 [size=16]
	Region 5: I/O ports at c800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 b4 00 00 01 b8 00 00 01 bc 00 00 01 c0 00 00
20: 01 c4 00 00 01 c8 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 02 00 00

00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 20
	Region 4: I/O ports at cc00 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 21
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 81) (prog-if 00 [UHCI])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin B routed to IRQ 21
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 02 00 00

00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin C routed to IRQ 21
	Region 0: Memory at f5011000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 07 00 10 02 86 20 03 0c 08 20 80 00
10: 00 10 01 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 05 03 00 00

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3227
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 60)
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 22
	Region 0: I/O ports at e000 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 e0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 c0 00 00 00 00 00 00 00 05 03 00 00

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]
00: 22 10 00 11 00 00 10 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 01 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 02 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
00: 22 10 03 11 00 00 00 00 00 00 00 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4e4a (prog-if 00 [VGA])
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1300
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at a000 [size=256]
	Region 2: Memory at f1000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 3.0
		Status: RQ=256 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 4a 4e 87 00 b0 02 00 00 00 03 08 ff 80 00
10: 08 00 00 e0 01 a0 00 00 00 00 00 f1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 00 13
30: 00 00 00 00 58 00 00 00 00 00 00 00 0a 01 08 00

01:00.1 Display controller: ATI Technologies Inc: Unknown device 4e6a
	Subsystem: Micro-Star International Co., Ltd.: Unknown device 1301
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: Memory at f1010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 6a 4e 80 00 b0 02 00 00 80 03 08 20 00 00
10: 08 00 00 e8 00 00 01 f1 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 62 14 01 13
30: 00 00 00 00 50 00 00 00 00 00 00 00 ff 00 08 00


[7.6.] I've not turned on scsi yet


[Etc.] 

Motherboard is a K8T Master2 FAR -- chipset is VIA K8T 800 and VIA VT8237.
I think I'll be happy to run tests for people, as long as they're
reasonably specific.

I did have to futz around a bit to get the system up and working, but to
my knowledge I've not done anything which could shed more light on why my
memory map isn't to my taste.  Which shows what little I know, I suppose.

I hope this isn't too much of a distraction from the GPL flames...

Thanks in advance,

-- 
Raul Miller
moth@magenta.com
