Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSA2RuI>; Tue, 29 Jan 2002 12:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSA2Rt6>; Tue, 29 Jan 2002 12:49:58 -0500
Received: from loihi.boulder.swri.edu ([198.120.23.2]:32494 "EHLO
	euterpe.boulder.swri.edu") by vger.kernel.org with ESMTP
	id <S289790AbSA2Rtl>; Tue, 29 Jan 2002 12:49:41 -0500
From: zowie@euterpe.boulder.swri.edu (Craig DeForest)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15446.57543.295705.495830@euterpe.boulder.swri.edu>
Date: Tue, 29 Jan 2002 10:49:59 -0700 (MST)
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: MTRR hangs dual-athlon SMP system (2.4.16 - 2.4.18p7)
X-Mailer: VM 6.75 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[1.] One line summary of the problem:    
     
     MTRR hangs dual-athlon SMP system (2.4.9 - 2.4.18p7)

[2.] Full description of the problem/report:

     My system is a dual-Athlon Tyan board with 3GB of memory.  It runs
X, no AGP.  I run perl-based numerical codes on it.  Running one process 
seems to work indefinitely.  Running two processes simultaneously (to take
advantage of the dual processors) works great until about 3 wall-clock
hours into the simulation, when the machine hangs hard -- not even the
magic key combinations on the console can awaken it.  The code I'm running
is perl/PDL based, but I can try to distill it down to a single perl-based
stimulus if needed.  

     There are other clues that this may be something to do with memory 
management:  it takes about 6 hours for the code I'm running to plough
through 3GB of memory allocation (and de-allocation) -- so two instances 
will allocate all of (and deallocate most of) my physical RAM in 3 hours,
which is the approximate time to crash.  Snarfing up a whole bunch of 
memory in a third (sleeping) process shortens the time to crash.

     I have tried several kernels between 2.4.16 and 2.4.18p7, including
the late-model -ac patches, so it appears that no-one may be aware of this
particular problem.  
 
     The problem can be avoided by turning off MTRR support.

[3.] Keywords (i.e., modules, networking, kernel):

     MTRR, SMP, Athlon, VM

[4.] Kernel version (from /proc/version):

     Here's one:
Linux version 2.4.18-pre7 (root@urania) (gcc version 2.96 20000731 (Red Hat Linu
x 7.1 2.96-98)) #2 SMP Mon Jan 28 17:06:15 MST 2002

     I've found the same problem in 2.4.9-13, 2.4.16 and 2.4.17 as well
(with the same gcc 2.96 build environment).

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

     No Oops message -- system hangs.  No evidence in the syslog.

[6.] A small shell script or example program which triggers the
     problem (if possible)

     email me at     deforest (at) boulder.swri.edu     for 
more information, if needed.  (funny email syntax is to thwart autospammers...)

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux urania 2.4.18-pre7 #2 SMP Mon Jan 28 17:06:15 MST 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.6
e2fsprogs              1.23
reiserfsprogs          3.x.0j
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP Processor 1600+
stepping        : 2
cpu MHz         : 1400.064
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
bogomips        : 2791.83

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1400.064
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
bogomips        : 2798.38

[7.3.] Module information (from /proc/modules):

 (none loaded)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

 --NOTE-- these are taken from the working (MTRR-free) kernel; I can re-run
 with the busted kernel if needed.

>From /proc/ioports:
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
03d4-03d5 : cga
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  1000-107f : 00:09.0
1090-1093 : PCI device 1022:700c (Advanced Micro Devices [AMD])
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Radeon VE QY
f000-f00f : Advanced Micro Devices [AMD] AMD-765 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1

>From /proc/iomem:
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-765 [Viper] USB
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-bffeffff : System RAM
  00100000-0025cca5 : Kernel code
  0025cca6-002b47df : Kernel data
bfff0000-bffffbff : ACPI Tables
bffffc00-bfffffff : ACPI Non-volatile Storage
e8001000-e800107f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
e8002000-e8002fff : PCI device 1022:700c (Advanced Micro Devices [AMD])
e8100000-e81fffff : PCI Bus #01
  e8100000-e810ffff : ATI Technologies Inc Radeon VE QY
ea000000-ebffffff : PCI device 1022:700c (Advanced Micro Devices [AMD])
f0000000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : ATI Technologies Inc Radeon VE QY
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at ea000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e8002000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1090 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-765 [Viper] IDE (rev 01) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-765 [Viper] ACPI (rev 01)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-765 [Viper] USB (rev 07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 16 (20000ns max)
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 1000 [size=128]
        Region 1: Memory at e8001000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5159 (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 013a
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

  (No SCSI) 

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[X.] Other notes, patches, fixes, workarounds:

Principal workaround is to switch off MTRR support.  That works for
me, but gives a noticeable (maybe 10%) performance hit in my application.
More memory-intensive applications will be hit harder.
