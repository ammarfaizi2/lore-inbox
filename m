Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313016AbSEULoT>; Tue, 21 May 2002 07:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSEULoS>; Tue, 21 May 2002 07:44:18 -0400
Received: from host162-6.pool8173.interbusiness.it ([81.73.6.162]:25613 "EHLO
	shiva.lab.novalabs.net") by vger.kernel.org with ESMTP
	id <S313016AbSEULoN>; Tue, 21 May 2002 07:44:13 -0400
Date: Tue, 21 May 2002 13:44:06 +0200
Message-Id: <200205211144.g4LBi6dY004917@shiva.lab.novalabs.net>
From: Alessandro Morelli <alex@alphac.it>
Subject: PROBLEM: memory corruption with i815 chipset variant
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to all,

1. Memory corruption tied to use of agpgart module with variant of
Intel i815

2. Loading the agpgart module causes memory corruption in presence of
an Intel i815 AGP Bridge (PCI ID 0x1131, specifically). Command
"memtest all" reports failures in writing to addresses throughout
entire memory space, filesystem opertions start to fail, albeit in
limited manner, memory intensive applications eventually generate
oopses lamenting NULL pointer exceptions, invalid pages, invalid EIP
in apparently unrelated sections of the kernel (VM, VFS, networking
layer, SMP, et cetera)

3. AGP, modules, kernel, memory, corruption, instability

4. Version currently under test:
Linux version 2.4.19-pre8-ac5 (root@anduril) (gcc version 2.95.4 20010810 (Debian prerelease)) #1 Tue May 21 11:24:29 CEST 2002

5. N/A. Oopses were seen in non-exactly-repeatable conditions
(although memory intensive tasks increased frequency)

6. Not really applicable, however...
	modprobe agpgart

7. Machine under test: ASUS L8400L
7.1
Linux palantir 2.4.19-pre8-ac5 #1 Tue May 21 11:24:29 CEST 2002 i686 unknown

Gnu C				2.95.4
Gnu make			3.79.1
util-linux			2.11h
mount				2.10q
modutils			2.4.11
e2fsprogs			1.27
reiserprogs			3.x.0j
PPP				2.4.0
Linux C Library			2.2.5
Dynamic linker (ldd)		2.2.5
Procps				2.0.6
Net-tools			1.54
Console-tools			0.2.3
Sh-utils			2.0
Modules Loaded			agpgart pcmcia_core lp irnet ppp_generic slhc irlan irtty irport i2c-philips-par parport i2c-velleman i2c-proc i2c-dev i2c-algo-pcf i2c-algo-bit i2c-core ircomm-tty ircomm irda ospm_processor ospm_button ospm_battery ospm_ac_adapter ospm_system ospm_busmgr 8139too mii rtc

7.2
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU             1133MHz
stepping        : 1
cpu MHz         : 1135.944
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2267.54
 
7.3
agpgart		       29632   0 (unused)
pcmcia_core            35392   0
lp                      6976   0 (autoclean) (unused)
irnet                  27360   0 (unused)
ppp_generic            19820   0 [irnet]
slhc                    4368   0 [ppp_generic]
irlan                  18560   0 (unused)
irtty                   5472   0 (unused)
irport                  4664   0 (unused)
i2c-philips-par         1928   0 (unused)
parport                22944   0 [lp i2c-philips-par]
i2c-velleman            1408   0 (unused)
i2c-proc                6240   0 (unused)
i2c-dev                 3840   0 (unused)
i2c-algo-pcf            4864   0 (unused)
i2c-algo-bit            7084   1 [i2c-philips-par i2c-velleman]
i2c-core               12800   0 [i2c-proc i2c-dev i2c-algo-pcf i2c-algo-bit]
ircomm-tty             18880   0 (unused)
irlan                  18560   0 (unused)
irtty                   5472   0 (unused)
irport                  4664   0 (unused)
i2c-philips-par         1928   0 (unused)
parport                22944   0 [lp i2c-philips-par]
i2c-velleman            1408   0 (unused)
i2c-proc                6240   0 (unused)
i2c-dev                 3840   0 (unused)
i2c-algo-pcf            4864   0 (unused)
i2c-algo-bit            7084   1 [i2c-philips-par i2c-velleman]
i2c-core               12800   0 [i2c-proc i2c-dev i2c-algo-pcf i2c-algo-bit]
ircomm-tty             18880   0 (unused)
ircomm                  7068   0 [ircomm-tty]
irda                   80396   0 [irnet irlan irtty irport ircomm-tty ircomm]
ospm_processor          5464   0 (unused)
ospm_button             3136   0 (unused)
ospm_battery            5540   0 (unused)
ospm_ac_adapter         2004   0 (unused)
ospm_system             5836   0 (unused)
ospm_busmgr            11392   0 [ospm_processor ospm_button ospm_battery ospm_ac_adapter ospm_system]
8139too                14816   1
mii                     1088   0 [8139too]
rtc                     5916   0 (autoclean)

7.4
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0290-0297 : PnPBIOS PNP0c02
02f8-02ff : serial(set)
0378-037f : i2c (Vellemann adapter)
03c0-03df : vga+
03f0-03f1 : PnPBIOS PNP0c02
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a400-a41f : Intel Corp. 82801BA/BAM USB (Hub #1)
  a400-a41f : usb-uhci
a800-a80f : Intel Corp. 82801BA IDE U100
  a800-a807 : ide0
  a808-a80f : ide1
b000-bfff : PCI Bus #02
  b000-b0ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    b000-b0ff : 8139too
  b400-b4ff : ESS Technology ESS Modem
  b800-b8ff : ESS Technology ES1988 Allegro-1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Radeon Mobility M6 LY
e400-e47f : PnPBIOS PNP0c02
ec00-ec3f : PnPBIOS PNP0c02

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-002c18ba : Kernel code
  002c18bb-0036509f : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
ee800000-eeffffff : PCI Bus #02
  ee800000-ee8000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    ee800000-ee8000ff : 8139too
  ee801000-ee801fff : Ricoh Co Ltd RL5c476 II
  ee802000-ee802fff : Ricoh Co Ltd RL5c476 II (#2)
ef000000-efefffff : PCI Bus #01
  ef000000-ef00ffff : ATI Technologies Inc Radeon Mobility M6 LY
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : ATI Technologies Inc Radeon Mobility M6 LY
f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
fffc0000-ffffffff : reserved

7.5
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 04)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [e104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 1131 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ef000000-efefffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: ee800000-eeffffff
	Prefetchable memory behind bridge: eff00000-efefffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 05)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 05) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 1567
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: [virtual] I/O ports at 01f0
	Region 1: [virtual] I/O ports at 03f4
	Region 2: [virtual] I/O ports at 0170
	Region 3: [virtual] I/O ports at 0374
	Region 4: I/O ports at a800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 05) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 1567
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at a400 [size=32]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 1491
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at effe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
	Subsystem: Asustek Computer, Inc.: Unknown device 1049
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:01.1 Communication controller: ESS Technology ESS Modem (rev 12)
	Subsystem: Asustek Computer, Inc.: Unknown device 1049
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=100mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 1045
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b000 [size=256]
	Region 1: Memory at ee800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Asustek Computer, Inc.: Unknown device 1564
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee801000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=0
	Memory window 0: 00000000-00000000 [disabled] (prefetchable)
	Memory window 1: 00000000-00000000 [disabled] (prefetchable)
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

02:05.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
	Subsystem: Asustek Computer, Inc.: Unknown device 1564
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at ee802000 (32-bit, non-prefetchable) [disabled] [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=0
	Memory window 0: 00000000-00000000 [disabled] (prefetchable)
	Memory window 1: 00000000-00000000 [disabled] (prefetchable)
	I/O window 0: 00000000-00000003 [disabled]
	I/O window 1: 00000000-00000003 [disabled]
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001

7.6 N/A

7.7 None

8. Graphic card has 16MB of memory: Region 0 is reported to be 128M
(AFAIK, it could be correct).
ASUS has used the i815 chipset without the CGC, using a Radeon
Mobility M6 LY instead.  All problems seem to stem from the agpgart
module: since at least 2.4.9 (after the VM change, IIRC) the kernel
has shown fundamental instability on this machine.

The problem has somewhat diminished during kernel evolution, from fast
death to slow death (i.e., with this kernel in particular, kernel
oopses are rare, compared to previous kernels, which were most
efficient in producing oopses).

Without agpgart module, kernel seems stable.  A naive (totally naive,
I admit it) interpretation suggests a problem in setting the AGP aperture.

Good work to all,
Alessandro Morelli
AlphaC srl

P.S.: Feel free to contact me anytime
