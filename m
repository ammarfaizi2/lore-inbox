Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbTCUR72>; Fri, 21 Mar 2003 12:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263346AbTCUR72>; Fri, 21 Mar 2003 12:59:28 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:54946 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S263241AbTCUR7R>; Fri, 21 Mar 2003 12:59:17 -0500
Date: Fri, 21 Mar 2003 19:07:53 +0100
From: Heinz.Mauelshagen@t-online.de (Heinz J . Mauelshagen)
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: System Starvation under heavy io load with HIGHMEM4G
Message-ID: <20030321190753.A16925@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regards,
Heinz    -- The LVM Guy --

[1.] 2.4.20 starvation under heavy write io

[2.] Full description of the problem/report:

Copying 12g onto a 67g ext2 fs causes the system to 'hang' with HIGHMEM4G
configured (system has 1.5GB RAM) after trying to allocate a bounce buffer.

[3.] Keywords: HIGHMEM4G, kernel, starvation

[4.] Kernel version:
Linux h 2.4.20 #14 SMP Fri Mar 21 16:51:07 CET 2003 i686 unknown
gcc v3.2

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)


Linux h 2.4.20 #14 SMP Fri Mar 21 16:51:07 CET 2003 i686 unknown

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11u
mount                  2.11u
modutils               2.4.19
e2fsprogs              1.28
jfsutils               1.0.21
PPP                    2.4.1
isdn4k-utils           3.2p1
Linux C Library        x    1 root     root      1312470 Sep 10  2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.0
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         dm-raid1-mod dm-mod qla2200 st sr_mod cdrom sg 3c59x reiserfs loop md

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 1800+
stepping        : 2
cpu MHz         : 1533.415
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1533.415
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

[7.3.] Module information (from /proc/modules):

qla2200               237984   3 
st                     29584   0  (autoclean)
sr_mod                 15352   0  (autoclean) (unused)
cdrom                  29632   0  (autoclean) [sr_mod]
sg                     35500   0  (autoclean)
3c59x                  29360   1 
reiserfs              181680   1  (autoclean)
loop                   12376   0  (autoclean)
md                     50848   0  (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

$ cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(auto)
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : PCI device 1077:2200
  1000-10fe : qla2200
1400-14ff : PCI device 1077:2200
  1400-14fe : qla2200
1800-18ff : PCI device 9004:8178
1c00-1c7f : PCI device 10b7:9200
  1c00-1c7f : 00:09.0
1c80-1cbf : PCI device 1274:5880
1cd0-1cd3 : PCI device 1022:700c
f000-f00f : PCI device 1022:7411

$ cat /proc/iomem   
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000c8800-000c8fff : Extension ROM
000c9000-000c97ff : Extension ROM
000c9800-000d07ff : Extension ROM
000dc000-000dcfff : PCI device 1022:7414
000f0000-000fffff : System ROM
00100000-3bffffff : System RAM
  00100000-0024b74d : Kernel code
  0024b74e-002eb69f : Kernel data
f4001000-f4001fff : PCI device 1077:2200
f4002000-f4002fff : PCI device 1077:2200
f4003000-f4003fff : PCI device 9004:8178
  f4003000-f4003fff : aic7xxx
f4004000-f400407f : PCI device 10b7:9200
f4100000-f57fffff : PCI Bus #01
  f4100000-f411ffff : PCI device 104c:3d07
  f4800000-f4ffffff : PCI device 104c:3d07
  f5000000-f57fffff : PCI device 104c:3d07
f5a00000-f5a00fff : PCI device 1022:700c
f8000000-fbffffff : PCI device 1022:700c

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f5a00000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1cd0 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x2

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: f4100000-f57fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB (rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 1c80 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2500ns min, 2500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1c00 [size=128]
	Region 1: Memory at f4004000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
	Subsystem: QLogic Corp.: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at f4001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 SCSI storage controller: QLogic Corp. QLA2200 (rev 05)
	Subsystem: QLogic Corp.: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at f4002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 2000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 1800 [disabled] [size=256]
	Region 1: Memory at f4003000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]

01:05.0 VGA compatible controller: Texas Instruments TVP4020 [Permedia 2] (rev 01) (prog-if 00 [VGA])
	Subsystem: Elsa AG WINNER 2000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (48000ns min, 48000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at f4100000 (32-bit, non-prefetchable) [size=128K]
	Region 1: Memory at f5000000 (32-bit, non-prefetchable) [size=8M]
	Region 2: Memory at f4800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):


*** Software bugs are stupid.
    Nevertheless it needs not so stupid people to solve them ***

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
