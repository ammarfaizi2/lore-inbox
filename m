Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131195AbQKWKag>; Thu, 23 Nov 2000 05:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131227AbQKWKa1>; Thu, 23 Nov 2000 05:30:27 -0500
Received: from toesinperil.com ([216.207.184.47]:31748 "HELO toesinperil.com")
        by vger.kernel.org with SMTP id <S131195AbQKWKaR>;
        Thu, 23 Nov 2000 05:30:17 -0500
Date: Thu, 23 Nov 2000 02:02:03 -0800
From: Michael Elkins <me@sigpipe.org>
To: rsousa@grad.physics.sunysb.edu, usb@in.tum.de
Cc: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1
Message-ID: <20001123020203.A30491@toesinperil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:    

kernel 2.4.0-test11-ac1 hang with usb-uhci and emu10k1

[2.] Full description of the problem/report:

If I load the emu10k1.o module prior to loading the usb-uhci.o module, the
system will completely hang with no oops.  3-finger-salute has no effect,
had to soft-reset the system.

To figure out which modules were the problem, I booted into single-user mode.
First, emu10k1.o is loaded.  The usbcore.o module loads with no problems.  But
I get a complete hang every time when usb-uhci.o is loaded.

If I load the usb-uhci.o module before emu10k1.o, there is no problem.

[3.] Keywords (i.e., modules, networking, kernel): kernel usb sound emu10k1
[4.] Kernel version (from /proc/version):

Linux version 2.4.0-test11-ac1 (root@we-24-130-82-118) (gcc driver version 2.95.3 19991030 (prerelease) executing gcc version egcs-2.91.66) #1 Wed Nov 22 17:38:15 PST 2000

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No oops, complete system hang.

[6.] A small shell script or example program which triggers the
     problem (if possible)

Boot into single user mode, then:
	modprobe emu10k1
	modprobe usb-uhci

[7.] Environment

Hardware: Dell Dimension XPS T700r
Distribution: Linux Mandrake 7.2

[7.1.] Software (add the output of the ver_linux script here)

Linux ns.linux.bogus 2.4.0-test11-ac1 #1 Wed Nov 22 17:38:15 PST 2000 i686 unknown
Kernel modules         2.3.21
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.0.24
Linux C Library        2.1.3
Dynamic linker         ldd (GNU libc) 2.1.3
Procps                 2.0.7
Mount                  2.10o
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         ne 8390 3c59x emu10k1 soundcore dc2xx usb-uhci usbcore st ide-scsi scsi_mod

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 698.000399
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
features        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 1392.64

[7.3.] Module information (from /proc/modules):

ne                      7024   1 (autoclean)
8390                    6240   0 (autoclean) [ne]
3c59x                  22864   1 (autoclean)
emu10k1                44992   0
soundcore               3888   4 [emu10k1]
dc2xx                   3056   0 (unused)
usb-uhci               22160   0 (unused)
usbcore                47328   1 [dc2xx usb-uhci]
st                     26816   0 (unused)
ide-scsi                7920   0
scsi_mod               86608   2 [st ide-scsi]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

(linux)% cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
0320-033f : eth1
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-107f : 3Com Corporation 3c900B-TPC [Etherlink XL TPC]
  1000-107f : eth0
1080-10bf : Promise Technology, Inc. 20262
10c0-10df : Intel Corporation 82371AB PIIX4 USB
  10c0-10df : usb-uhci
10e0-10ff : Creative Labs SB Live! EMU10000
  10e0-10ff : EMU10K1
1400-140f : Intel Corporation 82371AB PIIX4 IDE
1410-1413 : Promise Technology, Inc. 20262
1414-1417 : Promise Technology, Inc. 20262
  1416-1416 : ide2
1418-141f : Promise Technology, Inc. 20262
1420-1427 : Promise Technology, Inc. 20262
  1420-1427 : ide2
1428-142f : Creative Labs SB Live!
7000-701f : Intel Corporation 82371AB PIIX4 ACPI
8000-803f : Intel Corporation 82371AB PIIX4 ACPI

(linux)% cat /proc/iomem 
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c9000-000ca7ff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-040fd7ff : System RAM
  00100000-001ef2d7 : Kernel code
  001ef2d8-00200d47 : Kernel data
040fd800-040ff7ff : ACPI Tables
040ff800-040ffbff : ACPI Non-volatile Storage
040ffc00-0fffffff : System RAM
f4000000-f401ffff : Promise Technology, Inc. 20262
f4020000-f402007f : 3Com Corporation 3c900B-TPC [Etherlink XL TPC]
f5000000-f5ffffff : PCI Bus #01
  f5000000-f5ffffff : nVidia Corporation Vanta [NV6]
f8000000-fbffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fc000000-fdffffff : PCI Bus #01
  fc000000-fdffffff : nVidia Corporation Vanta [NV6]
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f5000000-f5ffffff
        Prefetchable memory behind bridge: fc000000-fdffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at 1400 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at 10c0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:0d.0 Ethernet controller: 3Com Corporation 3c900B-TPC [Etherlink XL TPC] (rev 04)
        Subsystem: 3Com Corporation 3c900B-TPC [Etherlink XL TPC]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 80 (2500ns min, 12000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 1000 [size=128]
        Region 1: Memory at f4020000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at 1420 [size=8]
        Region 1: I/O ports at 1414 [size=4]
        Region 2: I/O ports at 1418 [size=8]
        Region 3: I/O ports at 1410 [size=4]
        Region 4: I/O ports at 1080 [size=64]
        Region 5: Memory at f4000000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 10e0 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 Input device controller: Creative Labs SB Live! (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 0: I/O ports at 1428 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at fc000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HP       Model: COLORADO 14GB    Rev: 4.01
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SONY     Model: CD-RW  CRX140E   Rev: 1.0n
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

[root@ns linux]# cat /proc/bus/usb/devices 
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=10c0
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=040a ProdID=0132 Rev= 1.00
S:  Manufacturer=Eastman Kodak Company
S:  Product=KODAK DC3400 ZOOM Digital Camera
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  2mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=dc2xx
E:  Ad=01(O) Atr=02(Bulk) MxPS=  64 Ivl=  0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=  0ms

[root@ns linux]# cat /proc/bus/usb/drivers 
 80- 95: dc2xx
         hub
         usbdevfs

[X.] Other notes, patches, fixes, workarounds:

Loading the usb-uhci module before the emu10k1 driver seems to work.  I tested
playing audio while accessing images from my digital camera via USB with
no errors.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
