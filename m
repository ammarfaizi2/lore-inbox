Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSJQXdU>; Thu, 17 Oct 2002 19:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262281AbSJQXdU>; Thu, 17 Oct 2002 19:33:20 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:46240 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S262266AbSJQXdL>; Thu, 17 Oct 2002 19:33:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bug: swsusp in 2.5.42: "Scheduling while atomic"
Date: Thu, 17 Oct 2002 16:36:13 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210171636.13669.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem: 

Scheduling while atomic debug message during swsusp

[2.] Full description of the problem/report:

While swsusp'ing to disk, vast quantities of error messages are echoed to the
console, along the lines of the following pulled from /var/log/messages:

Oct 12 01:46:02 dhcp-364-114 kernel: Stopping tasks: ====pdflush: bogus
wakeup!
Oct 12 01:46:02 dhcp-364-114 kernel: =pdflush: bogus wakeup!
Oct 12 01:46:02 dhcp-364-114 kernel: ========================|
Oct 12 01:46:02 dhcp-364-114 kernel: Freeing memory: |
Oct 12 01:46:02 dhcp-364-114 kernel: Suspending devices
Oct 12 01:46:02 dhcp-364-114 last message repeated 2 times
Oct 12 01:46:02 dhcp-364-114 kernel: /critical section: Counting pages
to copy (pages needed: 11318+512=11830 free: 49957)
Oct 12 01:46:02 dhcp-364-114 kernel: bad: scheduling while atomic!
Oct 12 01:46:02 dhcp-364-114 kernel: Call Trace:
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c0111456>] schedule+0x3d/0x2aa
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c011a696>]
schedule_timeout+0x76/0x96
Oct 12 01:46:02 dhcp-364-114 rhnsd[1131]: running program
/usr/sbin/rhn_check
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c011a616>]
process_timeout+0x0/0xa
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01a40fe>]
pci_set_power_state+0x100/0x123
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c02199ec>] e100_resume+0x15/0x58
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01a54b3>]
pci_device_resume+0x1f/0x25
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01e19f6>]
device_resume+0x57/0x9f
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01220fb>]
drivers_resume+0x11/0x71
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01223b6>]
do_magic_resume_2+0x52/0x86
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c010fd31>] do_magic+0x1de/0x1e1
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01224d0>]
do_software_suspend+0x51/0x66
Oct 12 01:46:02 dhcp-364-114 kernel:
[<c0122512>] software_suspend+0x2d/0x2e
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c01d9942>]
acpi_system_write_sleep+0xd5/0x124
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c015aa4c>]
proc_file_write+0x27/0x31
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c0137b9f>] vfs_write+0xbb/0x149
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c0137c92>] sys_write+0x2a/0x3b
Oct 12 01:46:02 dhcp-364-114 kernel:  [<c0106e87>] syscall_call+0x7/0xb
Oct 12 01:46:02 dhcp-364-114 kernel:



[3.] Keywords (i.e., modules, networking, kernel):

[4.] Kernel version (from /proc/version):
Linux version 2.5.42 (root@dhcp-364-114) (gcc version 2.95.3 20010315 (release)) #1 Sat Oct 12 01:28:50 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
problem (if possible)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux dhcp-364-114 2.5.42 #1 Sat Oct 12 01:28:50 PDT 2002 i686 unknown
 
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

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: GenuineTMx86
cpu family	: 6
model		: 4
model name	: Transmeta(tm) Crusoe(tm) Processor TM5600
stepping	: 3
cpu MHz		: 597.547
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
bogomips	: 1146.88


[7.3.] Module information (from /proc/modules):

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
1000-10ff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
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
  00100000-002dfca3 : Kernel code
  002dfca4-00396107 : Kernel data
0ef5c000-0ef5ffff : reserved
0ef60000-0ef6ffff : ACPI Tables
0ef70000-0f06ffff : reserved
10000000-10000fff : Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device
10001000-10001fff : Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support
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
00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge (rev 01)
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at efd00000 (32-bit, non-prefetchable) [size=1M]

00:00.1 RAM memory: Transmeta Corporation SDRAM controller
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
	Subsystem: Transmeta Corporation: Unknown device 0295
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:04.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1000ns min, 63750ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=128M]
	Expansion ROM at 000c0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: Acer Laboratories Inc. [ALi] M5451 PCI AC-Link Controller Audio Device (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR+ <PERR+
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
	Subsystem: Toshiba America Info Systems: Unknown device 0003
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dffff000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at edc0 [size=64]
	Region 2: Memory at dfe00000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c3) (prog-if e0)
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at edb0 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:12.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to Cardbus Bridge with ZV Support (rev 32)
	Subsystem: Toshiba America Info Systems: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
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

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] USB 1.1 Controller (rev 03) (prog-if 10 [OHCI])
	Subsystem: Toshiba America Info Systems: Unknown device 0004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at dfdfe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

[7.7.] Other information that might be relevant to the problem
(please look in /proc and include all information that you
think to be relevant):

[X.] Other notes, patches, fixes, workarounds:


