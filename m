Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTDNL7S (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262985AbTDNL7S (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:59:18 -0400
Received: from nat-wohnheime.rz.uni-karlsruhe.de ([193.196.41.250]:47775 "EHLO
	au.hadiko.de") by vger.kernel.org with ESMTP id S262982AbTDNL7M convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 07:59:12 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jens =?iso-8859-1?q?K=FCbler?= <cleanerx@au.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:Software Raid5 freezes System
Date: Mon, 14 Apr 2003 00:26:05 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304140026.05645.cleanerx@au.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

My system is:
Duron 750
Abit K7Raid (just using the 2 ide controllers, not the hptraid part)
256MB RAM (100% OK / tested)

Western DIgital 120GB AB (part. 20/60/40 GB)
Maxtor 80 GB (part 60/20 GB)
Maxtor 60 GB (part 60)
Maxtor 60 GB (part 60)

Each harddisk is connected as master to the four IDE channels.

These four Partititions are combined to an software raid5
using raidtools 0.90
Partitition type is Linux Autoraid (0xFD)

Distribution was Mandrake 9.0 and now is 9.1
Kernel was 2.4.19 and is now 2.4.21-0.13mdk (although I cannot understand why 
they already use it since it is still not official) build with gcc 3.2.2

The harddisks did they work without any problems when they were used 
standalone. Now I combined these four partitions and the raid5 starts the 
synchronisation of the array. At an arbitrary amount of time the system 
freezes during this synchronisation. When I do an raidstop /dev/md0 the 
system runs stable for hours.
I checked the log files and due to the freeze I could not find any hint.
I don't get a kernel panic.

Greetings
Jens Kübler

Appendix: Output of several /procs

[root@au root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) processor
stepping        : 0
cpu MHz         : 750.059
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1494.22

[root@au root]# cat /proc/modules
parport_pc             25128   1 (autoclean)
lp                      8128   0 (autoclean)
parport                34208   1 (autoclean) [parport_pc lp]
es1371                 29000   0
soundcore               6308   0 [es1371]
ac97_codec             12488   0 [es1371]
gameport                3348   0 [es1371]
nfsd                   74288   8 (autoclean)
af_packet              14984   0 (autoclean)
ip_vs                  83224   0 (autoclean)
floppy                 55164   0
3c59x                  29616   1 (autoclean)
supermount             15296   2 (autoclean)
usb-uhci               24684   0 (unused)
usbcore                73024   1 [usb-uhci]
rtc                     8092   0 (autoclean)
reiserfs              175120   1
raid5                  16912   0
xor                     5472   0 [raid5]
[root@au root]# cat /proc/ioports
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
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : 3Dfx Interactive, Inc. Voodoo 3
a000-a00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
a400-a41f : VIA Technologies, Inc. USB
  a400-a41f : usb-uhci
a800-a81f : VIA Technologies, Inc. USB (#2)
  a800-a81f : usb-uhci
ac00-ac3f : Ensoniq ES1371 [AudioPCI-97]
  ac00-ac3f : es1371
b000-b03f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  b000-b03f : 00:0d.0
b400-b407 : Triones Technologies, Inc. HPT366/368/370/370A/372
  b400-b407 : ide2
b800-b803 : Triones Technologies, Inc. HPT366/368/370/370A/372
  b802-b802 : ide2
bc00-bc07 : Triones Technologies, Inc. HPT366/368/370/370A/372
  bc00-bc07 : ide3
c000-c003 : Triones Technologies, Inc. HPT366/368/370/370A/372
  c002-c002 : ide3
c400-c4ff : Triones Technologies, Inc. HPT366/368/370/370A/372
  c400-c407 : ide2
  c408-c40f : ide3
  c410-c4ff : HPT370

[root@au root]# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-00260a36 : Kernel code
  00260a37-0037831f : Kernel data
0fff0000-0fff2fff : ACPI Non-volatile Storage
0fff3000-0fffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
e4000000-e7ffffff : PCI Bus #01
  e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo 3
e8000000-e9ffffff : PCI Bus #01[root@au root]# lspci -vvv
  e8000000-e9ffffff : 3Dfx Interactive, Inc. Voodoo 3
ffff0000-ffffffff : reserved


00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
        Subsystem: ABIT Computer Corp. KT7/KT7-RAID/KT7A/KT7A-RAID Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: e4000000-e7ffffff
        Prefetchable memory behind bridge: e8000000-e9ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
22)
        Subsystem: ABIT Computer Corp.: Unknown device 0000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 
IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at a000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at a800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
        Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 11
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at ac00 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b000 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. 
HPT366/368/370/370A/372 (rev 03)
        Subsystem: Triones Technologies, Inc. HPT370A
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b400 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at bc00 [size=8]
        Region 3: I/O ports at c000 [size=4]
        Region 4: I/O ports at c400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 12
        Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at 9000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit+ FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

No SCSI - no Information :-)

This is the process where System freezes:

cat /proc/mdstat
Personalities : [raid5]
read_ahead 1024 sectors
md0 : active raid5 ide/host2/bus0/target0/lun0/part1[2] 
ide/host0/bus1/target0/lun0/part1[1] ide/host0/bus0/target0/lun0/part2[0] 
ide/host2/bus1/target0/lun0/part1[3]
      180096768 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
      [>....................]  resync =  0.2% (122056/60032256) finish=81.7min 
speed=12205K/sec
unused devices: <none>


