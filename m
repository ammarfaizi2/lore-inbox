Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262826AbVHEDII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262826AbVHEDII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 23:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVHEDII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 23:08:08 -0400
Received: from mgr2.xmission.com ([198.60.22.202]:52096 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S262826AbVHEDIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 23:08:04 -0400
Message-ID: <42F2DAF6.1040601@xmission.com>
Date: Thu, 04 Aug 2005 21:20:22 -0600
From: George Van Tuyl <gvtlinux@xmission.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: make modules Segfault
X-SA-Exim-Connect-IP: 166.70.99.220
X-SA-Exim-Mail-From: gvtlinux@xmission.com
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mgr1.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To:  linux-kernel@vger.kernel.org



[1.] One line summary of the problem:

   make modules failed Segfault (program cpp0)

[2.] Full description of the problem/report:

gcc: Internal error: Segmentation fault (program cpp0)
Please submit a full bug report.
See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
make[3]: *** [cycx_drv.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.31/drivers/net/wan'
make[2]: *** [_modsubdir_wan] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.31/drivers/net'
make[1]: *** [_modsubdir_net] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.31/drivers'
make: *** [_mod_drivers] Error 2
[root@wulff linux-2.4.31]# In file included from 
/usr/src/linux-2.4.31/include/linux/vmalloc.h:5,
                 from /usr/src/linux-2.4.31/include/asm/io.h:47,
                 from cycx_drv.c:60:
/usr/src/linux-2.4.31/include/linux/mm.h:155: parse error at end of input
/usr/src/linux-2.4.31/include/linux/mm.h:155: warning: no semicolon at 
end of struct or union


[3.] Keywords (i.e., modules, networking, kernel):
    Modules

[4.] Kernel version (from /proc/version):

[gvtlinux@wulff linux-2.4.31]$ cat /proc/version
Linux version 2.4.20-28.7 (bhcompile@porky.devel.redhat.com) (gcc 
version 2.96 20000731 (Red Hat Linux 7.3 2.96-126)) #1 Thu Dec 18 
11:18:28 EST 2003    

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
     problem (if possible)
Presently running RedHat 7.3 with kernel-athlon-2.4.20-28.7 from rpm

cd /usr/src/linux-2.4.31 downloaded today at 6:45 PM MST 8/4/05
make mrproper
cp /boot/config-2.4.20-28.7 /usr/src/linux-2.4.31/.config
make oldconfig  (Took all of the defaults no changes)
make xconfig
make dep
make bzImage
make modules


[7.] Environment
ASUS A7M-266, Athlon 1.4GHz, 512M, Nvidia Riva TNT/2, Link-Sys 10/100, 
D-Link 1000 Marvell, Promise tx/100 IDE controller. RedHat 7.3 with as 
updates as currently available from RedHat, Grrr!

[7.1.] Software (add the output of the ver_linux script here)

[gvtlinux@wulff linux-2.4.31]$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux wulff 2.4.20-28.7 #1 Thu Dec 18 11:18:28 EST 2003 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.18
e2fsprogs              1.27
reiserfsprogs          3.x.0j
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod cmpci soundcore binfmt_misc autofs tulip 
ipchains ide-scsi scsi_mod ide-cd cdrom usb-uhci usbcore ext3 jbd


[7.2.] Processor information (from /proc/cpuinfo):

[gvtlinux@wulff linux-2.4.31]$ cat /proc/cpuinfo
processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 6
model        : 4
model name    : AMD Athlon(tm) Processor
stepping    : 4
cpu MHz        : 1400.110
cache size    : 256 KB
fdiv_bug    : no
hlt_bug        : no
f00f_bug    : no
coma_bug    : no
fpu        : yes
fpu_exception    : yes
cpuid level    : 1
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips    : 2791.83

[7.3.] Module information (from /proc/modules):

[gvtlinux@wulff linux-2.4.31]$ cat /proc/modules
sr_mod                 16216   2 (autoclean)
cmpci                  32468   0 (autoclean)
soundcore               6436   4 (autoclean) [cmpci]
binfmt_misc             7204   1
autofs                 11780   0 (autoclean) (unused)
tulip                  42272   1
ipchains               49484  10
ide-scsi               10816   1
scsi_mod              107212   2 [sr_mod ide-scsi]
ide-cd                 32064   0
cdrom                  31936   0 [sr_mod ide-cd]
usb-uhci               24356   0 (unused)
usbcore                73504   1 [usb-uhci]
ext3                   65280   2
jbd                    47468   2 [ext3]

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

[gvtlinux@wulff linux-2.4.31]$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0330-0331 : cmpci Midi
0376-0376 : ide1
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8000-80ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  8000-80ff : tulip
8400-84ff : PCI device 1186:4c00 (D-Link System Inc)
8800-880f : Promise Technology, Inc. 20268
  8800-8807 : ide2
  8808-880f : ide3
9000-9003 : Promise Technology, Inc. 20268
9400-9407 : Promise Technology, Inc. 20268
9800-9803 : Promise Technology, Inc. 20268
a000-a007 : Promise Technology, Inc. 20268
a400-a4ff : C-Media Electronics Inc CM8738
  a400-a4ff : cmpci
d000-d01f : VIA Technologies, Inc. USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e000-e003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
e300-e37f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]


[gvtlinux@wulff linux-2.4.31]$ cat /proc/ioports
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
02f8-02ff : serial(auto)
0330-0331 : cmpci Midi
0376-0376 : ide1
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8000-80ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  8000-80ff : tulip
8400-84ff : PCI device 1186:4c00 (D-Link System Inc)
8800-880f : Promise Technology, Inc. 20268
  8800-8807 : ide2
  8808-880f : ide3
9000-9003 : Promise Technology, Inc. 20268
9400-9407 : Promise Technology, Inc. 20268
9800-9803 : Promise Technology, Inc. 20268
a000-a007 : Promise Technology, Inc. 20268
a400-a4ff : C-Media Electronics Inc CM8738
  a400-a4ff : cmpci
d000-d01f : VIA Technologies, Inc. USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e000-e003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
e300-e37f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
[gvtlinux@wulff linux-2.4.31]$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-0022250a : Kernel code
  0022250b-0031845f : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
f0800000-f08003ff : Linksys Network Everywhere Fast Ethernet 10/100 
model NC100
  f0800000-f08003ff : tulip
f1000000-f1003fff : PCI device 1186:4c00 (D-Link System Inc)
f1800000-f1803fff : Promise Technology, Inc. 20268
f2000000-f3dfffff : PCI Bus #01
  f2000000-f2ffffff : nVidia Corporation RIVA TNT2 Model 64
f3f00000-f77fffff : PCI Bus #01
  f4000000-f5ffffff : nVidia Corporation RIVA TNT2 Model 64
f7800000-f7800fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller
f8000000-fbffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

[root@wulff linux-2.4.31]# /sbin/lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] 
System Controller (rev 13)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 32
    Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Region 1: Memory at f7800000 (32-bit, prefetchable) [size=4K]
    Region 2: I/O ports at e000 [disabled] [size=4]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP 
Bridge (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000e000-0000dfff
    Memory behind bridge: f2000000-f3dfffff
    Prefetchable memory behind bridge: f3f00000-f77fffff
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
    Subsystem: Asustek Computer, Inc.: Unknown device 8040
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Region 4: I/O ports at d800 [size=16]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
    Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Interrupt: pin D routed to IRQ 9
    Region 4: I/O ports at d400 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
    Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Interrupt: pin D routed to IRQ 9
    Region 4: I/O ports at d000 [size=32]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Non-VGA unclassified device: VIA Technologies, Inc. VT82C686 
[Apollo Super ACPI] (rev 40)
    Subsystem: Asustek Computer, Inc.: Unknown device 8040
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin ? routed to IRQ 9
    Capabilities: [68] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
    Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (500ns min, 6000ns max)
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at a400 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20268 
(rev 02) (prog-if 85)
    Subsystem: Promise Technology, Inc. Ultra100TX2
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (1000ns min, 4500ns max), cache line size 08
    Interrupt: pin A routed to IRQ 5
    Region 0: I/O ports at a000 [size=8]
    Region 1: I/O ports at 9800 [size=4]
    Region 2: I/O ports at 9400 [size=8]
    Region 3: I/O ports at 9000 [size=4]
    Region 4: I/O ports at 8800 [size=16]
    Region 5: Memory at f1800000 (32-bit, non-prefetchable) [size=16K]
    Expansion ROM at <unassigned> [disabled] [size=16K]
    Capabilities: [60] Power Management version 1
        Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: D-Link System Inc: Unknown device 4c00 (rev 11)
    Subsystem: D-Link System Inc: Unknown device 4c00
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (5750ns min, 7750ns max), cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at f1000000 (32-bit, non-prefetchable) [size=16K]
    Region 1: I/O ports at 8400 [size=256]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [48] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=7 DScale=1 PME-
    Capabilities: [50] Vital Product Data

00:0d.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 
10/100 model NC100 (rev 11)
    Subsystem: Linksys: Unknown device 0574
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (63750ns min, 63750ns max), cache line size 08
    Interrupt: pin A routed to IRQ 9
    Region 0: I/O ports at 8000 [size=256]
    Region 1: Memory at f0800000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation RIVA TNT2 Model 64 
(rev 15) (prog-if 00 [VGA])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f2000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at f4000000 (32-bit, prefetchable) [size=32M]
    Expansion ROM at f3ff0000 [disabled] [size=64K]
    Capabilities: [60] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 2.0
        Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


[7.6.] SCSI information (from /proc/scsi/scsi)

[gvtlinux@wulff linux-2.4.31]$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Memorex  Model: 52MAXX 2452AJ    Rev: 6WS2
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

kernel configuration file supplied upon request to gvtlinux@xmission.com

[X.] Other notes, patches, fixes, workarounds:


I  expect you to tell me to upgrade everything.  Thanks for taking this 
bug report.

Thanks

George Van Tuyl
gvtlinux@xmission.com
