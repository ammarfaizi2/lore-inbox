Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTAQDzl>; Thu, 16 Jan 2003 22:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267236AbTAQDzl>; Thu, 16 Jan 2003 22:55:41 -0500
Received: from ccinets1.cc.okayama-u.ac.jp ([150.46.41.2]:30734 "EHLO
	ccinets1.cc.okayama-u.ac.jp") by vger.kernel.org with ESMTP
	id <S267224AbTAQDzg>; Thu, 16 Jan 2003 22:55:36 -0500
Content-Type: text/plain;
  charset="iso-2022-jp"
From: Mamoru Yamanishi <yama@o2.biotech.okayama-u.ac.jp>
Reply-To: yama@biotech.okayama-u.ac.jp
Organization: Okayama University
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: bad device file for cdrom while using devfs and ide-scsi
Date: Fri, 17 Jan 2003 13:04:55 +0900
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200301171304.55582.yama@o2.biotech.okayama-u.ac.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

	bad device file for cdrom while using devfs and ide-scsi

[2.] Full description of the problem/report:

	I use Kernle-2.4.20 with devfs and ide-scsi.
	"devfs" is mounted at boot.

	I wonder that the symbolic-link to actual device file of cdrom is not
	correct, which is placed in /dev as

		"cdrom0 -> ../scsi/host0/bus0/target0/lun0/cd"

	It should be placed in subdirectory /dev/cdroms, or it should be
	linked to "scsi/host0/bus0/target0/lun0/cd", I think.

	Without ide-scsi, there is /dev/cdroms/cdrom0 which is correctry
	linked to actual device file.

	I was looking around the kernel source codes, but I cannot find
	where it was.

[3.] Keywords (i.e., modules, networking, kernel):

	kernel
	file system
	dev fs
	ide scsi
	device file
	cdrom

[4.] Kernel version (from /proc/version):

	Linux version 2.4.20 (root@athlon) (gcc version 2.95.3 20010315 (release))
	#6 SMP 木 1月 16 09:36:55 JST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

	nothing

[6.] A small shell script or example program which triggers the
     problem (if possible)

	nothing

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux athlon 2.4.20 #6 SMP 木 1月 16 09:36:55 JST 2003 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.16
e2fsprogs              1.27
jfsutils               1.0.18
reiserfsprogs          3.x.1b
pcmcia-cs              3.1.33
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) MP 2400+
stepping        : 1
cpu MHz         : 2000.127
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3984.58

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) MP 2400+
stepping        : 1
cpu MHz         : 2000.127
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3997.69

[7.3.] Module information (from /proc/modules):

	nothing (IDE-SCSI is included statically into kernel)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0330-0331 : cmpci Midi
0376-0376 : ide1
0388-038b : cmpci FM
03c0-03df : vesafb
03f6-03f6 : ide0
0441-0441 : IB700 WDT
0443-0443 : Acquire WDT
0cf8-0cff : PCI conf1
8000-8fff : PCI Bus #02
  8800-88ff : C-Media Electronics Inc CM8738
    8800-88ff : cmpci
9800-983f : Intel Corp. 82540EM Gigabit Ethernet Controller
  9800-983f : e1000
a000-a00f : Promise Technology, Inc. 20268R
  a000-a007 : ide2
  a008-a00f : ide3
a400-a403 : Promise Technology, Inc. 20268R
  a402-a402 : ide3
a800-a807 : Promise Technology, Inc. 20268R
  a800-a807 : ide3
b000-b003 : Promise Technology, Inc. 20268R
  b002-b002 : ide2
b400-b407 : Promise Technology, Inc. 20268R
  b400-b407 : ide2
b800-b80f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo 3
e800-e803 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller

00000000-0009d3ff : System RAM
0009d400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000d47ff : Extension ROM
000d8000-000d97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-003555d1 : Kernel code
  003555d2-004d2cab : Kernel data
f2000000-f27fffff : PCI Bus #02
  f2000000-f2000fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
f2800000-f281ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  f2800000-f281ffff : e1000
f3000000-f301ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  f3000000-f301ffff : e1000
f3800000-f380ffff : Promise Technology, Inc. 20268R
f4000000-f7cfffff : PCI Bus #01
  f4000000-f5ffffff : 3Dfx Interactive, Inc. Voodoo 3
f7d00000-f7dfffff : PCI Bus #02
f7f00000-fb7fffff : PCI Bus #01
  f8000000-f9ffffff : 3Dfx Interactive, Inc. Voodoo 3
    f8000000-f8ffffff : vesafb
fb800000-fb800fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
fc000000-fdffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fb800000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: f4000000-f7cfffff
        Prefetchable memory behind bridge: f7f00000-fb7fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Subsystem: Asustek Computer, Inc. A7M-D Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 
04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at b800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Asustek Computer, Inc. A7M-D Mainboard
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:08.0 RAID bus controller: Promise Technology, Inc. 20268R (rev 02) (prog-if 
85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at b400 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at a800 [size=8]
        Region 3: I/O ports at a400 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at f3800000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Intel Corp.: Unknown device 100e (rev 02)
        Subsystem: Intel Corp.: Unknown device 002e
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at f3000000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at f2800000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 9800 [size=64]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, 
DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message 
Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: f2000000-f27fffff
        Prefetchable memory behind bridge: f7d00000-f7dfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) 
(prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at f4000000 (32-bit, non-prefetchable) [size=32M]
        Region 1: Memory at f8000000 (32-bit, prefetchable) [size=32M]
        Region 2: I/O ports at d800 [size=256]
        Expansion ROM at f7ff0000 [disabled] [size=64K]
        Capabilities: [54] AGP version 1.0
                Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 
07) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 8044
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc. CMI8738 6-channel audio controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at 8800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-48125W       Rev: VS06
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

	/proc/scsi/ide-scsi/0 :

 SCSI host adapter emulation for IDE ATAPI devices

[X.] Other notes, patches, fixes, workarounds:

	XFS patches are applied:

	linux-2.4.20-xfs-2002-12-27.patch.bz2
-- 
Mamoru Yamanishi, Ph. D
<yama@biotech.okayama-u.ac.jp>

