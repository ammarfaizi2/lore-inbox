Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261727AbTCZPmC>; Wed, 26 Mar 2003 10:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261730AbTCZPmC>; Wed, 26 Mar 2003 10:42:02 -0500
Received: from n1x6.imsa.edu ([143.195.1.6]:63385 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S261727AbTCZPlw>;
	Wed, 26 Mar 2003 10:41:52 -0500
Message-ID: <3E81CCD9.4050503@imsa.edu>
Date: Wed, 26 Mar 2003 09:52:57 -0600
From: Steve Terrell <spt@imsa.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel oops
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Unable to handle kernel NULL pointer dereference at
virtual address 00000004

Intermittent kernel oops - user programs segfaulting

[2.] Full description of the problem/report:

A previously stable system (1 year) running kernel 2.4.18 began 
segfaulting and logging kernel oops intermittently. The kernel was then 
upgraded to 2.4.20 with no change occurring. This is the only one of 
four fairly identical boxes showing the problem. The primary difference 
is that there are typically 90-100 users logging into shells via ssh. 
The problem is not reproducible. There are no load issues. The box also 
runs apache, samba and NFS. The oops are identical except for the CPU 
number.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, oops, segfault, 2.4.20

[4.] Kernel version (from /proc/version):

Linux version 2.4.20 (root@earl.devnet.imsa.edu) (gcc version 2.96 
20000731 (Red Hat Linux 7.3 2.96-113)) #1 SMP Wed Mar 19 08:18:05 CST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

ksymoops 2.4.4 on i686 2.4.20.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20/ (default)
      -m /boot/System.map-2.4.20 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid 
lsmod file?
Mar 25 14:46:16 1x5 kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Mar 25 14:46:16 1x5 kernel: f7d297cb
Mar 25 14:46:16 1x5 kernel: *pde = 00000000
Mar 25 14:46:16 1x5 kernel: Oops: 0000
Mar 25 14:46:16 1x5 kernel: CPU:    0
Mar 25 14:46:16 1x5 kernel: EIP:    0010:[<f7d297cb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 25 14:46:16 1x5 kernel: EFLAGS: 00010286
Mar 25 14:46:16 1x5 kernel: eax: bffff774   ebx: eeaa0000   ecx: 
00000000   edx: 00000000
Mar 25 14:46:16 1x5 kernel: esi: c01070c3   edi: 0000000b   ebp: 
eeaa1fb8   esp: eeaa1f80
Mar 25 14:46:16 1x5 kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 14:46:16 1x5 kernel: Process clear (pid: 12355, stackpage=eeaa1000)
Mar 25 14:46:16 1x5 kernel: Stack: eeaa0000 c01070c3 0000000b c672d000 
c014395e c672d000 c672d000 0000000b
Mar 25 14:46:16 1x5 kernel:        00000000 bffff774 0000000b 00000000 
00000a3a 00000020 bfff5a28 f7d299b4
Mar 25 14:46:16 1x5 kernel:        00000000 00000000 00000000 00000000 
00000000 00000000 00000000 00000000
Mar 25 14:46:16 1x5 kernel: Call Trace:    [<c01070c3>] [<c014395e>]
Mar 25 14:46:16 1x5 kernel: Code: 8b 42 04 83 f8 ff 0f 84 69 01 00 00 83 
f8 fc 77 07 c7 42 04


 >>EIP; f7d297cb <END_OF_CODE+3795366f/????>   <=====

Trace; c01070c3 <system_call+33/38>
Trace; c014395e <getname+5e/a0>
Code;  f7d297cb <END_OF_CODE+3795366f/????>
00000000 <_EIP>:
Code;  f7d297cb <END_OF_CODE+3795366f/????>   <=====
    0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f7d297ce <END_OF_CODE+37953672/????>
    3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f7d297d1 <END_OF_CODE+37953675/????>
    6:   0f 84 69 01 00 00         je     175 <_EIP+0x175> f7d29940 
<END_OF_CODE+379537e4/????>
Code;  f7d297d7 <END_OF_CODE+3795367b/????>
    c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f7d297da <END_OF_CODE+3795367e/????>
    f:   77 07                     ja     18 <_EIP+0x18> f7d297e3 
<END_OF_CODE+37953687/????>
Code;  f7d297dc <END_OF_CODE+37953680/????>
   11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)


2 warnings issued.  Results may not be reliable.

[6.] A small shell script or example program which triggers the
      problem (if possible)
none

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux 1x5 2.4.20 #1 SMP Wed Mar 19 08:18:05 CST 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27
reiserfsprogs          3.x.0j
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         i2o_proc i2o_core

[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Pentium(R) III CPU family      1266MHz
stepping	: 1
cpu MHz		: 1263.496
cache size	: 32 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips	: 2523.13

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 11
model name	: Intel(R) Pentium(R) III CPU family      1266MHz
stepping	: 1
cpu MHz		: 1263.496
cache size	: 32 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips	: 2523.13

[7.3.] Module information (from /proc/modules):

i2o_proc               46400   0 (unused)
i2o_core               41248   0 [i2o_proc]

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
03a0-03af : ServerWorks CSB5 IDE Controller
   03a0-03a7 : ide0
   03a8-03af : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0410-0413 : ServerWorks CSB5 IDE Controller
0cf8-0cff : PCI conf1
1000-10ff : ATI Technologies Inc Rage XL
1400-143f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   1400-143f : eepro100
1440-147f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   1440-147f : eepro100
2000-20ff : Adaptec AIC-7899P U160/m (#2)
2400-24ff : Adaptec AIC-7899P U160/m
2800-28ff : Adaptec AIC-7892A U160/m
3000-30ff : Adaptec AIC-7892A U160/m (#2)


00000000-0009afff : System RAM
0009b000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000c9800-000cafff : Extension ROM
000cb000-000d0fff : Extension ROM
000d1000-000d65ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
   00100000-002abb40 : Kernel code
   002abb41-0034c87f : Kernel data
3fff0000-3fffefff : ACPI Tables
3ffff000-3fffffff : ACPI Non-volatile Storage
fd000000-fdffffff : ATI Technologies Inc Rage XL
fe940000-fe940fff : ServerWorks OSB4/CSB5 OHCI USB Controller
fe960000-fe97ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
fe980000-fe980fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
   fe980000-fe980fff : eepro100
fe9a0000-fe9bffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
fe9e0000-fe9e0fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
   fe9e0000-fe9e0fff : eepro100
fe9f0000-fe9f0fff : ATI Technologies Inc Rage XL
feb80000-feb80fff : Adaptec AIC-7892A U160/m (#2)
   feb80000-feb80fff : aic7xxx
feb90000-feb90fff : Adaptec AIC-7892A U160/m
   feb90000-feb90fff : aic7xxx
febe0000-febe0fff : Adaptec AIC-7899P U160/m
   febe0000-febe0fff : aic7xxx
febf0000-febf0fff : Adaptec AIC-7899P U160/m (#2)
   febf0000-febf0fff : aic7xxx
fec00000-fec01fff : reserved
fee00000-fee00fff : reserved
fff00000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006 (rev 01)
	Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-

00:03.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 21
	Region 0: Memory at fe9e0000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1400 [size=64]
	Region 2: Memory at fe9a0000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fe990000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:04.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] 
(rev 0d)
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 20
	Region 0: Memory at fe980000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 1440 [size=64]
	Region 2: Memory at fe960000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at fe950000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) 
(prog-if 00 [VGA])
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at 1000 [size=256]
	Region 2: Memory at fe9f0000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fe9c0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 92)
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 92) (prog-if 
8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Region 0: I/O ports at <unassigned> [size=8]
	Region 1: I/O ports at <unassigned> [size=4]
	Region 2: I/O ports at <unassigned> [size=8]
	Region 3: I/O ports at <unassigned> [size=4]
	Region 4: I/O ports at 03a0 [size=16]
	Region 5: I/O ports at 0410 [size=4]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 05) 
(prog-if 10 [OHCI])
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at fe940000 (32-bit, non-prefetchable) [size=4K]

00:0f.3 Host bridge: ServerWorks: Unknown device 0230
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10

01:07.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 27
	BIST result: 00
	Region 0: I/O ports at 2400 [disabled] [size=256]
	Region 1: Memory at febe0000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feba0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
	Subsystem: Intel Corp.: Unknown device 340f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin B routed to IRQ 26
	BIST result: 00
	Region 0: I/O ports at 2000 [disabled] [size=256]
	Region 1: Memory at febf0000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 31
	BIST result: 00
	Region 0: I/O ports at 2800 [disabled] [size=256]
	Region 1: Memory at feb90000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feb60000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
	Subsystem: Adaptec 29160 Ultra160 SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 30
	BIST result: 00
	Region 0: I/O ports at 3000 [disabled] [size=256]
	Region 1: Memory at feb80000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feb40000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)


Attached devices:
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: SEAGATE  Model: ST318406LC       Rev: 0109
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 06 Lun: 00
   Vendor: ESG-SHV  Model: SCA HSBP M16     Rev: 0.05
   Type:   Processor                        ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
   Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 01 Lun: 00
   Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 02 Lun: 00
   Vendor: SEAGATE  Model: ST1181677LCV     Rev: 0002
   Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 08 Lun: 00
   Vendor: NEXSAN   Model: XRAID 8J MLSAFTE Rev: 1.10
   Type:   Processor                        ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:


-- 
Steve Terrell
Sr. Network Administrator
Illinois Mathematics and Science Academy
spt@imsa.edu
630 907 5994

