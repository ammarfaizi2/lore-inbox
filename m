Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSHZH0t>; Mon, 26 Aug 2002 03:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317971AbSHZH0t>; Mon, 26 Aug 2002 03:26:49 -0400
Received: from mgw-x4.nokia.com ([131.228.20.27]:62422 "EHLO mgw-x4.nokia.com")
	by vger.kernel.org with ESMTP id <S317950AbSHZH0p>;
	Mon, 26 Aug 2002 03:26:45 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Tommi Tervo <tommi.tervo@nokia.com>
Organization: Nokia
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: oops when making tape backup
Date: Mon, 26 Aug 2002 10:32:42 +0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208261032.42158.tommi.tervo@nokia.com>
X-OriginalArrivalTime: 26 Aug 2002 07:31:00.0490 (UTC) FILETIME=[869A56A0:01C24CD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Machine crashes randomly during backup.
2. We have perl script which make some tarballs and it puts them to LTO tape 
using xfsdump. Machine crashes sometimes during backup. Average uptime is 
about 2 weeks. It passes memtest86.
3. Keywords: scsi tape backup oops.
4.
Vanilla 2.4.19 + SGI xfs patch for 2.4.19, gcc version egcs-2.91.66 
19990314/Linux (egcs-1.1.2 release / Linux-Mandrake 8.0. (all 2.4 kernels 
what I have used has crashed on that machines, two other with similar 
hadrware without scsi-tape are running 2.4.18-xfs 1.1 and uptime is over 130 
days).

5. 
ksymoops 2.4.3 on i686 2.4.19-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-xfs/ (default)
     -m /boot/System.map-2.4.19-xfs (default)


Unable to handle kernel paging request at virtual address 6d5f7370
c012a890
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c012a890>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 5f6e6961   ebx: 00000001   ecx: c60f3020   edx: 6d5f736c
esi: c184bea0   edi: 00000286   ebp: 00000002   esp: da5f9f90
ds: 0018   es: 0018   ss: 0018
Process make_tarballs_m (pid: 17471, stackpage=da5f9000)
Stack: 00000000 c60f3000 080c03cc da5f9fbc c01074a3 c60f3000 c01074c3 c184bea0
       c60f3000 da5f8000 00000008 bffffa78 c01087a3 00000000 00000000 00000000
       00000000 00000000 00000000 00000000 0000002b 0000002b 0000000b 40001db0
Call Trace:    [<c01074a3>] [<c01074c3>] [<c01087a3>]
Code: 89 42 04 89 10 8b 46 10 89 48 04 8d 56 10 89 01 89 51 04 89

>>EIP; c012a890 <kmem_cache_free+54/98>   <=====
Trace; c01074a2 <sys_execve+2e/60>
Trace; c01074c2 <sys_execve+4e/60>
Trace; c01087a2 <system_call+32/40>
Code;  c012a890 <kmem_cache_free+54/98>
00000000 <_EIP>:
Code;  c012a890 <kmem_cache_free+54/98>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c012a892 <kmem_cache_free+56/98>
   3:   89 10                     mov    %edx,(%eax)
Code;  c012a894 <kmem_cache_free+58/98>
   5:   8b 46 10                  mov    0x10(%esi),%eax
Code;  c012a898 <kmem_cache_free+5c/98>
   8:   89 48 04                  mov    %ecx,0x4(%eax)
Code;  c012a89a <kmem_cache_free+5e/98>
   b:   8d 56 10                  lea    0x10(%esi),%edx
Code;  c012a89e <kmem_cache_free+62/98>
   e:   89 01                     mov    %eax,(%ecx)
Code;  c012a8a0 <kmem_cache_free+64/98>
  10:   89 51 04                  mov    %edx,0x4(%ecx)
Code;  c012a8a2 <kmem_cache_free+66/98>
  13:   89 00                     mov    %eax,(%eax)

Entering kdb (current=0xda5f8000, pid 17471) Oops: Oops
eax = 0x5f6e6961 ebx = 0x00000001 ecx = 0xc60f3020 edx = 0x6d5f736c
esi = 0xc184bea0 edi = 0x00000286 esp = 0xda5f9f90 eip = 0xc012a890
ebp = 0x00000002 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010046

1 warning issued.  Results may not be reliable.

6. -
7. 
7.1 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10s
mount                  2.11b
modutils               2.4.3
e2fsprogs              1.22
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.59
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         aic7xxx st scsi_mod

7.2
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1200.054
cache size	: 256 KB
7.3
aic7xxx               126044   0 (autoclean)
st                     30244   0 (autoclean)
scsi_mod               93962   2 (autoclean) [aic7xxx st]

7.4
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage XL AGP 2X
a000-a00f : VIA Technologies, Inc. Bus Master IDE
  a000-a007 : ide0
  a008-a00f : ide1
ac00-ac3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  ac00-ac3f : eepro100
b000-b03f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  b000-b03f : eepro100
b400-b43f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
  b400-b43f : eepro100
b800-b8ff : Adaptec AIC-7892A U160/m
bc00-bc07 : Triones Technologies, Inc. HPT366 / HPT370
  bc00-bc07 : ide2
c000-c003 : Triones Technologies, Inc. HPT366 / HPT370
  c002-c002 : ide2
c400-c407 : Triones Technologies, Inc. HPT366 / HPT370
  c400-c407 : ide3
c800-c803 : Triones Technologies, Inc. HPT366 / HPT370
  c802-c802 : ide3
cc00-ccff : Triones Technologies, Inc. HPT366 / HPT370
  cc00-cc07 : ide2
  cc08-cc0f : ide3
  cc10-ccff : HPT370A
---00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000ca000-000cb7ff : Extension ROM
000cc000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffeffff : System RAM
  00100000-002711df : Kernel code
  002711e0-00343fe3 : Kernel data
2fff0000-2fff2fff : ACPI Non-volatile Storage
2fff3000-2fffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d6ffffff : PCI Bus #01
  d4000000-d4ffffff : ATI Technologies Inc Rage XL AGP 2X
  d6000000-d6000fff : ATI Technologies Inc Rage XL AGP 2X
d8000000-d801ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
d8020000-d803ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
d8040000-d805ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
d8060000-d8060fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  d8060000-d8060fff : eepro100
d8061000-d8061fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#3)
  d8061000-d8061fff : eepro100
d8062000-d8062fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
  d8062000-d8062fff : eepro100
d8063000-d8063fff : Adaptec AIC-7892A U160/m
  d8063000-d8063fff : aic7xxx
ffff0000-ffffffff : reserved

7.5

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
	Subsystem: ABIT Computer Corp.: Unknown device a401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d4000000-d6ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) 
(prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 
0c)
	Subsystem: Intel Corporation: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: Memory at d8060000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at ac00 [size=64]
	Region 2: Memory at d8000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 
0c)
	Subsystem: Intel Corporation: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d8062000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b000 [size=64]
	Region 2: Memory at d8020000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00:0f.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 
0c)
	Subsystem: Intel Corporation: Unknown device 0040
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d8061000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at b400 [size=64]
	Region 2: Memory at d8040000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	BIST result: 00
	Region 0: I/O ports at b800 [disabled] [size=256]
	Region 1: Memory at d8063000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366 
(rev 04)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 120 (2000ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at bc00 [size=8]
	Region 1: I/O ports at c000 [size=4]
	Region 2: I/O ports at c400 [size=8]
	Region 3: I/O ports at c800 [size=4]
	Region 4: I/O ports at cc00 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 27) 
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at d4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at d6000000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

7.6
Host: scsi0 Channel: 00 Id: 03 Lun: 00
Vendor: HP       Model: Ultrium 1-SCSI   Rev: E22D
Type:   Sequential-Access                ANSI SCSI revision: 03

7.7
my .config <URL: http://www.hut.fi/u/tttervo2/config>

If you have anything to ask, please CC.

Tommi Tervo



