Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTJEF2y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 01:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbTJEF2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 01:28:54 -0400
Received: from host-12-107-230-171.dtccom.net ([12.107.230.171]:35463 "EHLO
	glaurung.green-gryphon.com") by vger.kernel.org with ESMTP
	id S262968AbTJEF2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 01:28:48 -0400
X-Mailer: emacs 21.3.1 (via feedmail 8 I)
To: linux-kernel@vger.kernel.org
Subject: Invalid page header errors on 2.6.0-test6
From: Manoj Srivastava <srivasta@debian.org>
Organization: The Debian Project
X-URL: http://www.debian.org/
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
 (i386-pc-linux-gnu)
Mail-Copies-To: nobody
X-Face: #q.#]5@vq!Jz+E0t_/;Y^gTjR\T^"B'fbeuVGiyKrvbfKJl!^e|e:iu(kJ6c|QYB57LP*|t
 &YlP~HF/=h:GA6o6W@I#deQL-%#.6]!z:6Cj0kd#4]>*D,|0djf'CVlXkI,>aV4\}?d_KEqsN{Nnt7
 78"OsbQ["56/!nisvyB/uA5Q.{)gm6?q.j71ww.>b9b]-sG8zNt%KkIa>xWg&1VcjZk[hBQ>]j~`Wq
 Xl,y1a!(>6`UM{~'X[Y_,Bv+}=L\SS*mA8=s;!=O`ja|@PEzb&i0}Qp,`Z\:6:OmRi*
Date: Sun, 05 Oct 2003 00:28:04 -0500
Message-ID: <878yo0s17f.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I am running a 86MB dataset, 250k records, postgresql 7.3.4. I
 get Invalid page header in block XXX of various tables and keys, in
 different locations on each run of the same SQL code.

	Downgrading to 2.4.22 makes everything work correctly.

	I am using lvm2 + devicemapper in both cases, the FS is Ext3.
----------------------------------------------------------------------
[Sat Oct  4 14:23:17 2003] [9413] DBD::Pg::db do failed: ERROR:
Invalid page header in block 30 of assets at CnCCalc/Baseline.pm line
979. 

 next run:
[Sat Oct  4 15:01:17 2003] [14924] DBD::Pg::db do failed: ERROR:
Invalid page header in block 193 of assets_pkey at CnCCalc/Baseline.pm
line 979. 
ERROR:  Invalid page header in block 193 of assets_pkey

 next:
sv107=# select * from assets
sv107-# ;
ERROR:  Invalid page header in block 3941 of assets

 next:
[Sat Oct  4 15:42:41 2003] [20926] DBD::Pg::db do failed: ERROR:
Invalid page header in block 144 of to_prep_pkey at
CnCCalc/Baseline.pm line 979. 

  next:
ERROR:  Invalid page header in block 596 of assets_pkey
----------------------------------------------------------------------

	I understand there is not much to go on here, but I am not
 sure how to get more relevant data.  I'd be willing to provide any
 additional requested information.

	manoj

======================================================================
__> cat /proc/version 
Linux version 2.6.0-test6 (root@glaurung) (gcc version 3.3.2 20030908
(Debian prerelease)) #1 SMP Thu Oct 2 16:05:06 CDT 2003 

__> cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1666.741
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
bogomips        : 3322.67

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 2000+
stepping        : 2
cpu MHz         : 1666.741
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
bogomips        : 3329.22


00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e800 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: df000000-dfcfffff
	Prefetchable memory behind bridge: dff00000-fb7fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Subsystem: Asustek Computer, Inc. A7M-D Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Subsystem: Asustek Computer, Inc. A7M-D Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
	Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2250ns min), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at b400 [size=16]
	Region 1: Memory at de800000 (32-bit, non-prefetchable) [size=16]
	Region 2: Memory at de000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: da800000-ddffffff
	Prefetchable memory behind bridge: dfd00000-dfdfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL [Radeon 8500 LE] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0f2a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at df000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at dffe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at dd800000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc. CMI8738 6-channel audio controller
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link) (prog-if 10 [OHCI])
	Subsystem: Texas Instruments: Unknown device 8010
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at dc800000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at db800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 16
	Region 0: Memory at db000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
	Subsystem: Unknown device 807d:1043
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), cache line size 10
	Interrupt: pin C routed to IRQ 17
	Region 0: Memory at da800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 
Money is the root of all evil, and man needs roots.
Manoj Srivastava   <srivasta@debian.org>  <http://www.debian.org/%7Esrivasta/>
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C
