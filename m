Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285013AbRLKMcS>; Tue, 11 Dec 2001 07:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285007AbRLKMcK>; Tue, 11 Dec 2001 07:32:10 -0500
Received: from ucs.co.za ([196.23.43.2]:42769 "EHLO ucs.co.za")
	by vger.kernel.org with ESMTP id <S285013AbRLKMb6>;
	Tue, 11 Dec 2001 07:31:58 -0500
Subject: PROBLEM: Kernel Oops on cat /proc/ioports
From: Berend De Schouwer <bds@jhb.ucs.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 11 Dec 2001 14:29:56 +0200
Message-Id: <1008073796.5535.5.camel@bds.ucs.co.za>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

Running "cat /proc/ioports" causes a segfault and kernel oops.


[2.] Full description of the problem/report:

Running "cat /proc/ioports" may cause cat to segfault, and the kernel to
Oops.  It doesn't happen immediately after boot -- its required to run
the kernel for some time (minimum two days for me), and make it do some
work.


[3.] Keywords (i.e., modules, networking, kernel):

kernel, proc


[4.] Kernel version (from /proc/version):

Linux version 2.4.14 (root@clo002c.clobea.co.za)
  (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81))
  #3 SMP Mon Nov 12 15:34:14 SAST 2001


[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

Unable to handle kernel paging request at virtual address f886bc55
 printing eip:
c02a925b
*pde = 37bb5067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[vsnprintf+523/1056]    Not tainted
EIP:    0010:[<c02a925b>]    Not tainted
EFLAGS: 00010297
eax: f886bc55   ebx: d957f16c   ecx: f886bc55   edx: fffffffe
esi: ffffffff   edi: e98ddec4   ebp: ffffffff   esp: e98dde6c
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 29869, stackpage=e98dd000)
Stack: 00000000 ffffffff 0000000a d760e480 d957f15e 00000006 d9580000 c02a94a6 
       d957f15e 26a80ea2 c02bd8a6 e98ddeb8 c02a94c4 d957f15e c02bd895 e98ddeb8 
       c011dcfb d957f15e c02bd895 00003000 0000307f f886bc55 c2838478 d957f15e 
Call Trace: [vsprintf+22/32] [sprintf+20/32] [do_resource_list+75/128] [do_resource_list+107/128] [get_resource_list+66/96] 
Call Trace: [<c02a94a6>] [<c02a94c4>] [<c011dcfb>] [<c011dd1b>] [<c011dd72>] 
   [ioports_read_proc+46/96] [proc_file_read+206/400] [sys_read+150/208] [sys_brk+186/240] [system_call+51/56] 
   [<c0154eae>] [<c0152a3e>] [<c01368f6>] [<c0127caa>] [<c010712b>] 
Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10 89 c6 

and ksymoops < oops:

Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base
says c0254350, System.map says c01560b0.  Ignoring ksyms_base entry

>>EIP; c02a925b <vsnprintf+20b/420>   <=====
Trace; c02a94a6 <vsprintf+16/20>
Trace; c02a94c4 <sprintf+14/20>
Trace; c011dcfb <do_resource_list+4b/80>
Trace; c011dd1b <do_resource_list+6b/80>
Trace; c011dd72 <get_resource_list+42/60>
Trace; c0154eae <ioports_read_proc+2e/60>
Trace; c0152a3e <proc_file_read+ce/190>
Trace; c01368f6 <sys_read+96/d0>
Trace; c0127caa <sys_brk+ba/f0>
Trace; c010712b <system_call+33/38>
Code;  c02a925b <vsnprintf+20b/420>
00000000 <_EIP>:
Code;  c02a925b <vsnprintf+20b/420>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c02a925e <vsnprintf+20e/420>
   3:   74 07                     je     c <_EIP+0xc> c02a9267 <vsnprintf+217/420>
Code;  c02a9260 <vsnprintf+210/420>
   5:   40                        inc    %eax
Code;  c02a9261 <vsnprintf+211/420>
   6:   4a                        dec    %edx
Code;  c02a9262 <vsnprintf+212/420>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c02a9265 <vsnprintf+215/420>
   a:   75 f4                     jne    0 <_EIP>
Code;  c02a9267 <vsnprintf+217/420>
   c:   29 c8                     sub    %ecx,%eax
Code;  c02a9269 <vsnprintf+219/420>
   e:   f6 04 24 10               testb  $0x10,(%esp,1)
Code;  c02a926d <vsnprintf+21d/420>
  12:   89 c6                     mov    %eax,%esi



[6.] A small shell script or example program which triggers the
     problem (if possible)

cat /proc/ioports


[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux clo002c.clobea.co.za 2.4.14 #3 SMP Mon Nov 12 15:34:14 SAST 2001 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11b
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         cyclades eepro100


[7.2.] Processor information (from /proc/cpuinfo):


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 999.584
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1992.29

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 8
model name	: Pentium III (Coppermine)
stepping	: 10
cpu MHz		: 999.584
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips	: 1998.84


[7.3.] Module information (from /proc/modules):

cyclades              147616  16 (autoclean)
eepro100               16960   1 (autoclean)


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

I can't add this :(  It causes the oops.


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE (rev 06)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08

00:07.0 Communication controller: Cyclades Corporation Cyclom_Y below first megabyte (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 25
	Region 0: Memory at 61100000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at 3000 [size=128]
	Region 2: Memory at 000dc000 (low-1M, non-prefetchable) [size=16K]
	Expansion ROM at 61120000 [disabled] [size=4K]

00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
	Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at 63200000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 3800 [size=64]
	Region 2: Memory at 63300000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at 63400000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0d.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 65) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at 62000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 3400 [size=256]
	Region 2: Memory at 61400000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 61420000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 (rev 50)
	Subsystem: ServerWorks OSB4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:0f.1 IDE interface: ServerWorks: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 30c0 [size=16]

00:0f.2 USB Controller: ServerWorks: Unknown device 0220 (rev 04) (prog-if 10 [OHCI])
	Subsystem: ServerWorks: Unknown device 0220
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 15
	Region 0: Memory at 63f00000 (32-bit, non-prefetchable) [size=4K]

01:03.0 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Citicorp TTI: Unknown device 10e3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	BIST result: 00
	Region 0: I/O ports at 5000 [disabled] [size=256]
	Region 1: Memory at 63c20000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 63c40000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.1 SCSI storage controller: Adaptec 7899P (rev 01)
	Subsystem: Citicorp TTI: Unknown device 10e3
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 18
	BIST result: 00
	Region 0: I/O ports at 5400 [disabled] [size=256]
	Region 1: Memory at 63c21000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at 63c60000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.0 PCI bridge: Intel Corporation: Unknown device 0962 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

01:06.1 RAID bus controller: Mylex Corporation: Unknown device 0050 (rev 02)
	Subsystem: Mylex Corporation: Unknown device 0052
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at 63e00000 (32-bit, prefetchable) [size=8K]
	Expansion ROM at 63c00000 [disabled] [size=32K]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: DEC      Model: DLT2000          Rev: 8B37
  Type:   Sequential-Access                ANSI SCSI revision: 02


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

cat /proc/meminfo:
        total:    used:    free:  shared: buffers:  cached:
Mem:  1582149632 1576222720  5926912        0   868352 706162688
Swap: 271392768 15073280 256319488
MemTotal:      1545068 kB
MemFree:          5788 kB
MemShared:           0 kB
Buffers:           848 kB
Cached:         685944 kB
SwapCached:       3668 kB
Active:        1145656 kB
Inactive:       334440 kB
HighTotal:      655296 kB
HighFree:         2044 kB
LowTotal:       889772 kB
LowFree:          3744 kB
SwapTotal:      265032 kB
SwapFree:       250312 kB


[X.] Other notes, patches, fixes, workarounds:

I've had it with 2.4.12, 2.4.12-ac, and 2.4.14.  I've tested the RAM
with memtest86, and memtest, and haven't found a problem yet.  Oddly
enough I can run "cat /proc/ioports" right after the machine boots, but
not after its done some work.  The address listed in "Cannot handle
kernel paging request" is always the same.  Workaround: don't do that.


Thank you
-- 
Berend De Schouwer

