Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbSJDBYU>; Thu, 3 Oct 2002 21:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261422AbSJDBYU>; Thu, 3 Oct 2002 21:24:20 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:6040 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261421AbSJDBYQ>; Thu, 3 Oct 2002 21:24:16 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: linux-kernel@vger.kernel.org
Subject: BUG: 2.5.40: sleeping function called from illegal context
Date: Thu, 3 Oct 2002 17:59:10 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210031759.10761.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[1.] One line summary of the problem: 

Attempt to activate swsusp yields: "sleeping function called from illegal context"

[2.] Full description of the problem/report:

Echoing '4' to /proc/acpi/sleep does not sleep the machine but causes a
debug message to appear in /var/log/messages, see section 5. below

[3.] Keywords (i.e., modules, networking, kernel):

ACPI, sound, swsusp

[4.] Kernel version (from /proc/version):
Linux version 2.5.40 (root@localhost.localdomain) (gcc version 2.95.3 20010315 (release)) #2 Wed Oct 2 13:52:25 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information resolved (see Documentation/oops-tracing.txt)

No oops, but here's the debug info:
Oct  3 17:46:21 dhcp-362-41 kernel: Debug: sleeping function called from illegal context at
/usr/src/linux-2.5.40/include/asm/semaphore.h:119
Oct  3 17:46:21 dhcp-362-41 kernel: c9b27c70 c01122e4 c0323180 c03a26a0 00000077 c1361600 c0
2afb63 c03a26a0
Oct  3 17:46:21 dhcp-362-41 kernel:        00000077 c9b26000 c12b55fc 00001000 00000000 0000
0004 00000000 c02b17e7
Oct  3 17:46:21 dhcp-362-41 kernel:        c12b55fc c9b26000 c12b55fc c02b1bf8 c12b55fc 0000
4140 00000000 c9b26000
Oct  3 17:46:21 dhcp-362-41 kernel: Call Trace:
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c01122e4>]__might_sleep+0x54/0x58
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02afb63>]snd_pcm_prepare+0x21/0x1dd
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02b17e7>]snd_pcm_common_ioctl1+0x19a/0x238
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02b1bf8>]snd_pcm_playback_ioctl1+0x373/0x381
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02a7886>]snd_pcm_oss_get_space+0x47/0x120
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02b1f69>]snd_pcm_kernel_playback_ioctl+0x27/0x30
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02b1fc5>]snd_pcm_kernel_ioctl+0x23/0x3c
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02a67e6>]snd_pcm_oss_prepare+0x15/0x31
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02a6834>]snd_pcm_oss_make_ready+0x32/0x3e
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02a6b8f>]snd_pcm_oss_write1+0x2f/0x12e
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c02a8809>]snd_pcm_oss_write+0x32/0x67
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c0138a08>]vfs_write+0xaf/0x12a
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c0138ae8>]sys_write+0x2a/0x3b
Oct  3 17:46:21 dhcp-362-41 kernel:  [<c0106eab>]syscall_call+0x7/0xb
Oct  3 17:46:21 dhcp-362-41 kernel:


[6.] A small shell script or example program which triggers the
problem (if possible)

echo 4 > /proc/acpi/sleep

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
  00100000-0031b56d : Kernel code
  0031b56e-004298e7 : Kernel data
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
Attached devices: none

[7.7.] Other information that might be relevant to the problem
(please look in /proc and include all information that you
think to be relevant):

[X.] Other notes, patches, fixes, workarounds:


