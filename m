Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310475AbSCGTTc>; Thu, 7 Mar 2002 14:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310474AbSCGTT2>; Thu, 7 Mar 2002 14:19:28 -0500
Received: from slarti.muc.de ([193.149.48.10]:42758 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S310457AbSCGTTJ> convert rfc822-to-8bit;
	Thu, 7 Mar 2002 14:19:09 -0500
Date: Wed, 6 Mar 2002 18:05:05 +0100
From: Stephan Maciej <stephan@maciej.muc.de>
Fcc: sent-mail
Message-ID: <Pine.LNX.4.33.0203061734540.808@maciej.muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: filldir64 oopses on smbfs
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I probably found a buf somewhere in the (v)fs layer. I do mount smb 
filesystems over the network. Mounting works fine, say I do a

mount -t smbfs -o username="..." //1.2.3.4/test /mnt/windows
ls /mnt/windows

(that gives, e.g. some files and directories...)

ls /mnt/windows/somedirectory
dies with a segfault and I find the following stuff on the syslog:

--START OF LOG

Unable to handle kernel paging request at virtual address d0000000
 printing eip:
d11d5c13
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d11d5c13>]    Not tainted
EFLAGS: 00210282
eax: 58ea5128   ebx: 2a037f58   ecx: fa6373fd   edx: 782edd08
esi: d0000000   edi: ca1f5e30   ebp: ca1f5ec8   esp: ca1f5de0
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 1603, stackpage=ca1f5000)
Stack: c0146a10 ca1f5e98 d11e4502 00000001 00000000 00000000 00000000 ce7f5180 
       c35fe6c0 00000000 00028955 c4fe2f40 00000000 00000000 c9f16000 0000002f 
       00000000 00000000 00000001 00000031 d11d43c5 c906cf40 ca1f5fb0 c0146a10 
Call Trace: [filldir64+176/368] [<d11d43c5>] [filldir64+176/368] 
[filldir64+176/368] [<d11d445c>] 
   [filldir64+176/368] [<d11d5343>] [filldir64+176/368] 
[dcache_readdir+94/288] [filldir64+176/368] [sys_getdents64+255/259] 
   [filldir64+176/368] [send_sigio_to_task+160/208] [system_call+51/56] 

Code: 0f b6 06 46 89 c2 c1 e2 04 01 da c1 e8 04 01 c2 8d 04 92 8d 



Unable to handle kernel paging request at virtual address d0000000
 printing eip:
d11d9c13
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d11d9c13>]    Not tainted
EFLAGS: 00010282
eax: 1e6d7025   ebx: a95729eb   ecx: f54c83fd   edx: 6c7c49a1
esi: d0000000   edi: c6207e30   ebp: c6207ec8   esp: c6207de0
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 1681, stackpage=c6207000)
Stack: c0146a10 c6207e98 d11e8502 00000001 00000000 00000000 00000000 ca6a4040 
       c4b3d540 00000003 0018ef3e 00000003 00000000 00000000 c2068000 0000002f 
       00000000 00000000 00000001 00000031 d11d83c5 c63364c0 c6207fb0 c0146a10 
Call Trace: [filldir64+176/368] [<d11d83c5>] [filldir64+176/368] 
[filldir64+176/368] [<d11d845c>] 
   [filldir64+176/368] [<d11d9343>] [filldir64+176/368] 
[dcache_readdir+94/288] [filldir64+176/368] [sys_getdents64+255/259] 
   [filldir64+176/368] [__vma_link+19/176] [system_call+51/56] 

Code: 0f b6 06 46 89 c2 c1 e2 04 01 da c1 e8 04 01 c2 8d 04 92 8d 




Unable to handle kernel paging request at virtual address d0000000
 printing eip:
d11d5c13
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d11d5c13>]    Not tainted
EFLAGS: 00010282
eax: 2327c529   ebx: e6f11827   ecx: fd52d3fd   edx: a0a18dd5
esi: d0000000   edi: cd4d5e30   ebp: cd4d5ec8   esp: cd4d5de0
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 793, stackpage=cd4d5000)
Stack: c0146a10 cd4d5e98 d11e4502 00000001 00000000 00000000 00000000 cd12f2c0 
       cd291dc0 00000000 000022c8 00000000 00000000 00000000 cd163000 0000002f 
       00000000 00000000 00000001 00000031 d11d43c5 cd3859c0 cd4d5fb0 c0146a10 
Call Trace: [filldir64+176/368] [<d11d43c5>] [filldir64+176/368] 
[filldir64+176/368] [<d11d445c>] 
   [filldir64+176/368] [<d11d5343>] [filldir64+176/368] 
[dcache_readdir+94/288] [filldir64+176/368] [sys_getdents64+255/259] 
   [filldir64+176/368] [__vma_link+19/176] [system_call+51/56] 

Code: 0f b6 06 46 89 c2 c1 e2 04 01 da c1 e8 04 01 c2 8d 04 92 8d 

-- END OF LOG

As you see, the bug is reproducible (at least three times). Of course I 
rebooted my computer always after these things happened.

My kernel version (/proc/version):  

Linux version 2.4.18 (root@lap) (gcc version 2.95.3 20010315 (SuSE)) #8 SMP 
Sun Mar 3 16:35:43 CET 2002

ver_linux says:

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux maciej 2.4.18 #8 SMP Sun Mar 3 16:35:43 CET 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
PPP                    2.4.1
isdn4k-utils           3.1pre2
Linux C Library        x    1 root     root      1384168 Sep 20 05:52 
/lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         nls_cp437 nls_iso8859-1 smbfs serial

Processor information (/proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 7
model name	: AMD Duron(tm) Processor
stepping	: 1
cpu MHz		: 1000.048
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 1992.29

Modules (/proc/modules):

nls_cp437               4384   1 (autoclean)
nls_iso8859-1           2880   1 (autoclean)
smbfs                  33104   1 (autoclean)
serial                 46112   0 (autoclean)

ioports (/proc/ioports):

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
0376-0376 : ide1
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : VIA Technologies, Inc. AC97 Audio Controller
1400-14ff : VIA Technologies, Inc. AC97 Modem Controller
1800-18ff : Realtek Semiconductor Co., Ltd. RTL-8139
  1800-18ff : 8139too
1c00-1c1f : VIA Technologies, Inc. UHCI USB
  1c00-1c1f : usb-uhci
1c20-1c3f : VIA Technologies, Inc. UHCI USB (#2)
  1c20-1c3f : usb-uhci
1c40-1c4f : VIA Technologies, Inc. Bus Master IDE
  1c40-1c47 : ide0
  1c48-1c4f : ide1
1c50-1c53 : VIA Technologies, Inc. AC97 Audio Controller
1c54-1c57 : VIA Technologies, Inc. AC97 Audio Controller
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
6800-687f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
8100-810f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
9000-9fff : PCI Bus #01
  9000-90ff : ATI Technologies Inc Rage Mobility P/M AGP 2x

iomem (/proc/iomem, you guessed it):

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0feeffff : System RAM
  00100000-002a8bc7 : Kernel code
  002a8bc8-0031957f : Kernel data
0fef0000-0fefefff : ACPI Tables
0feff000-0fefffff : ACPI Non-volatile Storage
0ff00000-0fffffff : System RAM
10000000-10000fff : Texas Instruments PCI1420
10001000-10001fff : Texas Instruments PCI1420 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
e8000000-e8003fff : PCI device 104c:8020 (Texas Instruments)
e8004000-e80047ff : PCI device 104c:8020 (Texas Instruments)
e8004800-e80048ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e8004800-e80048ff : 8139too
e8100000-e9ffffff : PCI Bus #01
  e8100000-e8100fff : ATI Technologies Inc Rage Mobility P/M AGP 2x
  e9000000-e9ffffff : ATI Technologies Inc Rage Mobility P/M AGP 2x
    e9000000-e97effff : vesafb
f0000000-f7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
fffe0000-ffffffff : reserved

And finally, here's my lspci -vvv output:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e8100000-e9ffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at 1c40 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1c00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at 1c20 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1000 [size=256]
	Region 1: I/O ports at 1c54 [size=4]
	Region 2: I/O ports at 1c50 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.6 Communication controller: VIA Technologies, Inc. AC97 Modem Controller 
(rev 30)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at 1400 [size=256]
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 10400000-107ff000 (prefetchable)
	Memory window 1: 10800000-10bff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0a.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 168, cache line size 10
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 10c00000-10fff000 (prefetchable)
	Memory window 1: 11000000-113ff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

00:0e.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 
10 [OHCI])
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e8004000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at e8000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 128 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1800 [size=256]
	Region 1: Memory at e8004800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 
2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Sony Corporation: Unknown device 80f6
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e9000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


-- 

Okay, that's all, folks.

Hope I helped.

Stephan
