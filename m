Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290277AbSCCWsX>; Sun, 3 Mar 2002 17:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290289AbSCCWsG>; Sun, 3 Mar 2002 17:48:06 -0500
Received: from 216-174-237-33.atgi.net ([216.174.237.33]:4 "EHLO
	spinel.gh.landmark-appraisal.com") by vger.kernel.org with ESMTP
	id <S290277AbSCCWsB>; Sun, 3 Mar 2002 17:48:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ian Eure <ieure@northwestappraiser.com>
Reply-To: linux-kernel@vger.kernel.org, ieure@northwestappraiser.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel panic during BUSLOGIC SCSI tape write
Date: Sun, 3 Mar 2002 14:47:04 -0800
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16heky-000097-00@heliodor>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
Kernel panic during BUSLOGIC SCSI tape write

[2.] Full description of the problem/report:
When amflush runs on my new Amanda backup server, the kernel panics. The 
crash is 100% repeatable, and it always panics at the exact same spot.

The specific command I invoke is:
'su backup -c /usr/sbin/amflush daily'

(as root)

[3.] Keywords (i.e., modules, networking, kernel):
kernel scsi scheduler idle

[4.] Kernel version (from /proc/version):
Linux version 2.4.18 (root@heliodor) (gcc version 2.95.4 (Debian prerelease)) 
#1 Fri Mar 1 19:00:42 PST 2002

[5.] Output of Oops.. message (if applicable) with symbolic information 
resolved:

-- snip --
Unable to handle kernel NULL pointer dereference at virtual address 00000000
00000000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<00000000>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000    ebx: c0105150   ecx: f6986270   edx: f6986270
esi: c02a8000    edi: c0105150   ebp: 0008e000   esp: c02a9fd0
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02a9000)
Stack: c0105173 00000010 00000246 c01051d9 00038000 000a0600 c0105000 c0105027
       c02aa7f4 00000002 c02e8060 c0100197
Call Trace: [<c0105173>] [<c01051d9>] [<c0105000>] [<c0105027>]
Code: Bad EIP value.

>>EIP; 00000000 Before first symbol
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>

 <0> Kernel panic: Attempted to kill the idle task!
-- snip --

[6.] A small shell script or example program which triggers the problem (if 
possible):

n/a

[7.] Environment


[7.1.] Software (add the output of the ver_linux script here)
Linux axinite 2.4.18 #1 Fri Mar 1 19:00:42 PST 2002 i686 unknown

./ver_linux: gcc: command not found
Gnu C
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.25
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.751
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1992.29


[7.3.] Module information (from /proc/modules):

Kernel compiled without modules


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a000-a007 : US Robotics/3Com 56K FaxModem Model 5610 (#4)
  a000-a007 : serial(auto)
a400-a407 : US Robotics/3Com 56K FaxModem Model 5610 (#3)
  a400-a407 : serial(auto)
a800-a803 : BusLogic BT-946C (BA80C30) [MultiMaster 10]
  a800-a803 : BusLogic BT-948
b000-b07f : 3Com Corporation 3c905C-TX [Fast Etherlink]
  b000-b07f : 00:08.0
b400-b407 : US Robotics/3Com 56K FaxModem Model 5610 (#2)
  b400-b407 : serial(auto)
b800-b807 : US Robotics/3Com 56K FaxModem Model 5610
  b800-b807 : serial(auto)
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]

/proc/iomem:
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cc7ff : Extension ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-0024a23c : Kernel code
  0024a23d-002a70d7 : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
ed000000-ed000fff : BusLogic BT-946C (BA80C30) [MultiMaster 10]
ed800000-ed80007f : 3Com Corporation 3c905C-TX [Fast Etherlink]
ee000000-efdfffff : PCI Bus #01
  ee000000-eeffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
eff00000-fbffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV11 (GeForce2 MX DDR)
fc000000-fdffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
        Subsystem: Asustek Computer, Inc.: Unknown device 80e7
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: ee000000-efdfffff
        Prefetchable memory behind bridge: eff00000-fbffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
        Subsystem: Asustek Computer, Inc.: Unknown device 80e7
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 00 
[UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) 
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com: Unknown device 00d7
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at b800 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) 
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com: Unknown device 00d7
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b400 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:08.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 
78)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC 
Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at b000 [size=128]
        Region 1: Memory at ed800000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:09.0 SCSI storage controller: BusLogic BT-946C (BA80C30) [MultiMaster 10] 
(rev 08)
        Subsystem: BusLogic BT-946C (BA80C30) [MultiMaster 10]
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at a800 [size=4]
        Region 1: Memory at ed000000 (32-bit, non-prefetchable) [disabled] 
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=16K]

00:0a.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) 
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com: Unknown device 00d7
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at a400 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 01) 
(prog-if 02 [16550])
        Subsystem: US Robotics/3Com: Unknown device 00d7
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a000 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX DDR) 
(rev b2) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at efff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices:
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: HP       Model: C1557A           Rev: U709
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 01
  Vendor: HP       Model: C1557A           Rev: U709
  Type:   Medium Changer                   ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Vanilla kernel.
Not subscribed to the list; please CC on replies.
