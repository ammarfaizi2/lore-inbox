Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261423AbSJDBYc>; Thu, 3 Oct 2002 21:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261422AbSJDBYc>; Thu, 3 Oct 2002 21:24:32 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:48028 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261423AbSJDBYX>; Thu, 3 Oct 2002 21:24:23 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.40: Accessing various ACPI state info fails to acquire ACPI mutex
Date: Thu, 3 Oct 2002 17:59:17 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210031759.17244.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem: 

Accessing various ACPI state info fails to acquire ACPI mutex

[2.] Full description of the problem/report:

catting /proc/acpi/fan/FAN0/state hangs; upon ^C we get:

Oct  3 17:52:24 dhcp-362-41 kernel:   utmisc-0608 [40] 
Ut_acquire_mutex      : Thread B86 could not acquire Mutex 
[ACPI_MTX_Namespace] AE_ERROR
Oct  3 17:52:24 dhcp-362-41 kernel: acpi_bus-0074 [40] 
acpi_bus_get_device   : Error getting context for object [c12c4224]

catting /proc/acpi/toshiba/lcd hangs; upon ^C we get:
Oct  3 17:55:51 dhcp-362-41 kernel:   utmisc-0608 [39] 
Ut_acquire_mutex      : Thread B8D could not acquire Mutex 
[ACPI_MTX_Namespace] AE_ERROR

[3.] Keywords (i.e., modules, networking, kernel):

ACPI, mutex

[4.] Kernel version (from /proc/version):
Linux version 2.5.40 (root@localhost.localdomain) (gcc version 2.95.3 
20010315 (release)) #2 Wed Oct 2 13:52:25 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic 
information 
resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
problem (if possible)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dhcp-362-41 2.5.40 #2 Wed Oct 2 13:52:25 PDT 2002 i686 unknown
 
Gnu C                  Attempting to call wrong gcc!
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineTMx86
cpu family	: 6
model		: 4
model name	: Transmeta(tm) Crusoe(tm) Processor TM5600
stepping	: 3
cpu MHz		: 597.596
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti
bogomips	: 1175.55


[7.3.] Module information (from /proc/modules):

[7.4.] Loaded driver and hardware information (/proc/ioports, 
/proc/iomem)

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-10ff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller 
Audio Device
  1000-10ff : ALI 5451
4000-40ff : PCI CardBus #01
4400-44ff : PCI CardBus #01
edb0-edbf : Acer Laboratories Inc. [ALi] M5229 IDE
edc0-edff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  edc0-edff : e100
ee00-ee3f : Acer Laboratories Inc. [ALi] M7101 PMU
ef00-ef1f : Acer Laboratories Inc. [ALi] M7101 PMU

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ef5bfff : System RAM
  00100000-0031b56d : Kernel code
  0031b56e-004298e7 : Kernel data
0ef5c000-0ef5ffff : reserved
0ef60000-0ef6ffff : ACPI Tables
0ef70000-0f06ffff : reserved
10000000-10000fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link 
Controller Audio Device
10001000-10001fff : Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support
10400000-107fffff : PCI CardBus #01
10800000-10bfffff : PCI CardBus #01
dfdfe000-dfdfefff : Acer Laboratories Inc. [ALi] USB 1.1 Controller
dfe00000-dfefffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  dfe00000-dfefffff : e100
dffff000-dfffffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  dffff000-dfffffff : e100
e0000000-e7ffffff : S3 Inc. 86C270-294 Savage/IX-MV
efd00000-efdfffff : Transmeta Corporation LongRun Northbridge
ffe00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 
01)
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at efd00000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV 
(rev 13) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] 
M5451 PCI AC-Link Controller Audio Device (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA 
Bridge [Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 08)
	Subsystem: Toshiba America Info Systems: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at edc0 [size=64]
	Region 2: Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) 
(prog-if e0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at edb0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 
Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at dfdfe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: none

[7.7.] Other information that might be relevant to the problem
(please look in /proc and include all information that you
think to be relevant):

[X.] Other notes, patches, fixes, workarounds:


