Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264129AbUFCSD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUFCSD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 14:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUFCSD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 14:03:59 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:22415 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S263807AbUFCSBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 14:01:34 -0400
From: "andreamrl@tiscali.it" <andreamrl@tiscali.it>
Reply-To: andreamrl@tiscali.it
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:kernel BUG at mm/page_alloc.c:786!
Date: Thu, 3 Jun 2004 20:01:33 +0200
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406032001.34172.andreamrl@tiscali.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 
I had a kernel bug. I report it following the guidelines at
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
Thanks,
Andrea Merello

[1.] One line summary of the problem:    
kernel BUG at mm/page_alloc.c:786!

[2.] Full description of the problem/report:
I got kernel oops when insmodding the intel pro wireless 2100 driver. There 
was written "kernel BUG" in the oops  (so suppose not bug in the driver).
The driver insmodded but didn't worked. I couldn't rmmod it. So i rebooted but 
the system seemed to hang during stopping services. This is the first time it 
happen.
Note all the information i attach here (except the oops) has been obtained the 
next reboot. Maybe it was better if I got immediately after the Oops.. 
sorry..

[3.] Keywords (i.e., modules, networking, kernel):
kernel 2.6.6
modules
hosap
hostap_crypt_wep
slamr (driver for my modem)
and the insmodding ipw2100

[4.] Kernel version (from /proc/version):
Linux version 2.6.6 (root@bloodymary) (gcc version 3.2 20020903 (Red Hat Linux 
8.0 3.2-7)) #5 Tue May 25 10:36:47 CEST 2004

[5.] Output of Oops.. message (if applicable) with symbolic information 

  ------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:786!
invalid operand: 0000 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c013b11e>]    Tainted: P
EFLAGS: 00210246   (2.6.6)
EIP is at __free_pages+0x3e/0x50
eax: 00000000   ebx: 00001000   ecx: c1011b80   edx: 00000000
esi: 008dc000   edi: c08dc000   ebp: c3547220   esp: c14cde30
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 1600, threadinfo=c14cc000 task=ccb0b7b0)
Stack: 00000800 c08db000 d0f3bef6 cf4a3c44 00001000 c08dc000 008dc000 c3547220
       cf4a3c00 c3547220 d0f3cbe9 c3547220 c354763c c3547220 c3547220 cf4a3c00
       c3547000 d0f3dfbb c3547220 fffffff4 d0f3fc97 c3547220 c3547000 c3547220
Call Trace:
 [<d0f3bef6>] bd_queue_free+0xa6/0xe0 [ipw2100]
 [<d0f3cbe9>] ipw2100_rx_free+0x29/0x120 [ipw2100]
 [<d0f3dfbb>] ipw2100_queues_allocate+0x2b/0x60 [ipw2100]
 [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
 [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
 [<c021c202>] pci_device_probe_static+0x52/0x70
 [<c021c25c>] __pci_device_probe+0x3c/0x50
 [<c021c29c>] pci_device_probe+0x2c/0x50
 [<c0278cef>] bus_match+0x3f/0x70
 [<c0278e1c>] driver_attach+0x5c/0x90
 [<c02790cd>] bus_add_driver+0x8d/0xa0
 [<c027951f>] driver_register+0x2f/0x40
 [<c021c48c>] pci_register_driver+0x5c/0x90
 [<d0f3b98d>] ipw2100_proc_init+0xad/0x150 [ipw2100]
 [<d0ec2065>] ipw2100_init+0x65/0x92 [ipw2100]
 [<c01326cc>] sys_init_module+0x12c/0x250
 [<c01051fb>] syscall_call+0x7/0xb

Code: 0f 0b 12 03 c0 2a 3d c0 eb cd 90 8d b4 26 00 00 00 00 85 c0

[6.] A small shell script or example program which triggers the
     problem (if possible)

[7.] Environment
KDE was finishing to restore the applications that i leaved opened the 
previous session. In the same time i have insmodded the driver using the KDE 
console.

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux bloodymary 2.6.6 #5 Tue May 25 10:36:47 CEST 2004 i686 i686 i386 
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
binutils               2.13.90.0.2
util-linux             2.11r
mount                  2.11r
module-init-tools      0.9.14
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
quota-tools            3.06.
PPP                    2.4.1
isdn4k-utils           3.1pre4
nfs-utils              1.0.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipw2100 hostap_crypt_wep hostap slamr

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1600MHz
stepping        : 5
cpu MHz         : 600.111
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat 
clflush dts acpi mmx fxsr sse sse2 tm
bogomips        : 1187.84


[7.3.] Module information (from /proc/modules):

ipw2100 163460 0 - Live 0xd08ef000
hostap_crypt_wep 5120 1 - Live 0xd08b8000
hostap 105672 2 ipw2100,hostap_crypt_wep, Live 0xd08d4000
slamr 319300 2 - Live 0xd091f000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[user@bloodymary user]$ cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
04d0-04d1 : pnp 00:0b
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-105f : pnp 00:0b
    1008-100b : ACPI timer
    1010-1015 : ACPI CPU throttle
  1060-107f : pnp 00:0b
1180-11bf : 0000:00:1f.0
  1180-11bf : pnp 00:0b
1800-1807 : 0000:00:02.0
1810-181f : 0000:00:1f.1
  1810-1817 : ide0
  1818-181f : ide1
1820-183f : 0000:00:1d.0
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.1
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.2
  1860-187f : uhci_hcd
1880-189f : 0000:00:1f.3
  1880-188f : i801-smbus
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel ICH4
2000-207f : 0000:00:1f.6
  2000-207f : ICH4
2400-24ff : 0000:00:1f.6
  2400-24ff : ICH4
4000-40ff : PCI CardBus #03
4400-44ff : PCI CardBus #03
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000ccbff : Video ROM
000cd000-000cdfff : Adapter ROM
000ce000-000cefff : Adapter ROM
000f0000-000fffff : System ROM
00100000-0f6dffff : System RAM
  00100000-003bab92 : Kernel code
  003bab93-004b713f : Kernel data
0f6e0000-0f6eafff : ACPI Tables
0f6eb000-0f6fffff : ACPI Non-volatile Storage
0f700000-0fffffff : reserved
10000000-100003ff : 0000:00:1f.1
10001000-10001fff : 0000:02:09.0
  10001000-10001fff : yenta_socket
10400000-107fffff : PCI CardBus #03
10800000-10bfffff : PCI CardBus #03
e0000000-e007ffff : 0000:00:02.0
e0080000-e00fffff : 0000:00:02.1
e0100000-e01003ff : 0000:00:1d.7
  e0100000-e01003ff : ehci_hcd
e0100800-e01008ff : 0000:00:1f.5
  e0100800-e01008ff : ich_audio MBBAR
e0100c00-e0100dff : 0000:00:1f.5
  e0100c00-e0100dff : ich_audio MMBAR
e0200000-e0201fff : 0000:02:05.0
  e0200000-e0201fff : b44
e0202000-e0202fff : 0000:02:03.0
  e0202000-e02027ff : ohci1394
e0203000-e0203fff : 0000:02:06.0
  e0203000-e0203fff : ipw2100
e8000000-efffffff : 0000:00:02.0
  e8000000-e87cffff : vesafb
f0000000-f7ffffff : 0000:00:02.1
fec10000-fec1ffff : reserved
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Capabilities: [40] #09 [a105]

00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O Control 
Registers (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH Configuration Process 
Registers (rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:02.0 VGA compatible controller: Intel Corp. 82852/855GM Integrated Graphics 
Device (rev 02) (prog-if 00 [VGA])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e0000000 (32-bit, non-prefetchable) [size=512K]
        Region 2: I/O ports at 1800 [size=8]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corp. 82852/855GM Integrated Graphics Device 
(rev 02)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: Memory at e0080000 (32-bit, non-prefetchable) [size=512K]
        Capabilities: [d0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #1 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1820 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #2 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 1840 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB (ICH4) USB UHCI #3 (rev 03) 
(prog-if 00 [UHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 11
        Region 4: I/O ports at 1860 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB (ICH4) USB2 EHCI Controller (rev 
03) (prog-if 20 [EHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 11
        Region 0: Memory at e0100000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 83) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort+ 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e0200000-e02fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev 03)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage 
Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at 1810 [size=16]
        Region 5: Memory at 10000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB/DBM (ICH4) SMBus Controller (rev 03)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801DB (ICH4) AC'97 Audio 
Controller (rev 03)
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 1c00 [size=256]
        Region 1: I/O ports at 18c0 [size=64]
        Region 2: Memory at e0100c00 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at e0100800 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corp. 82801DB (ICH4) AC'97 Modem Controller (rev 03) 
(prog-if 00 [Generic])
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2400 [size=256]
        Region 1: I/O ports at 2000 [size=128]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:03.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61) (prog-if 
10 [OHCI])
        Subsystem: Unknown device 1734:1033
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96 (3000ns min, 6000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0202000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:05.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
        Subsystem: Unknown device 17c0:1082
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0200000 (32-bit, non-prefetchable) [size=8K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:06.0 Network controller: Intel Corp. PRO/Wireless LAN 2100 3B Mini PCI 
Adapter (rev 04)
        Subsystem: Intel Corp.: Unknown device 2527
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 8500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0203000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:09.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
        Subsystem: Unknown device 1734:1033
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001


[7.6.] SCSI information (from /proc/scsi/scsi)
[root@bloodymary user]# cat /proc/scsi/scsi
Attached devices:
[root@bloodymary user]#

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Nothing i think.. execpt i have modified my XFree i810 driver applyng i855crt 
patches. But I really think it isn't related
[X.] Other notes, patches, fixes, workarounds:
I attach also what is written BEFORE the line "cut here"

modprobe: page allocation failure. order:0, mode:0x20
Call Trace:
 [<c013afc1>] __alloc_pages+0x2e1/0x320
 [<c013b01f>] __get_free_pages+0x1f/0x40
 [<c013e507>] cache_grow+0xa7/0x290
 [<c013e7be>] cache_alloc_refill+0xce/0x210
 [<c013ebe9>] __kmalloc+0x69/0x70
 [<c03252f7>] alloc_skb+0x47/0xf0
 [<d0f3c880>] ipw2100_rx_allocate+0x140/0x2f0 [ipw2100]
 [<d0f3dfaf>] ipw2100_queues_allocate+0x1f/0x60 [ipw2100]
 [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
 [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
 [<c021c202>] pci_device_probe_static+0x52/0x70
 [<c021c25c>] __pci_device_probe+0x3c/0x50
 [<c021c29c>] pci_device_probe+0x2c/0x50
 [<c0278cef>] bus_match+0x3f/0x70
 [<c0278e1c>] driver_attach+0x5c/0x90
 [<c02790cd>] bus_add_driver+0x8d/0xa0
 [<c027951f>] driver_register+0x2f/0x40
 [<c021c48c>] pci_register_driver+0x5c/0x90
 [<d0f3b98d>] ipw2100_proc_init+0xad/0x150 [ipw2100]
 [<d0ec2065>] ipw2100_init+0x65/0x92 [ipw2100]
 [<c01326cc>] sys_init_module+0x12c/0x250
 [<c01051fb>] syscall_call+0x7/0xb

I include also the output of ksymoops
It seems to have problems with and without the -k option
[user@bloodymary user]$ ksymoops <kbug -k /proc/kallsyms
ksymoops 2.4.5 on i686 2.6.6.  Options used
     -V (default)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6/ (default)
     -m /boot/System.map-2.6.6 (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a valid 
ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 [<c013afc1>] __alloc_pages+0x2e1/0x320
 [<c013b01f>] __get_free_pages+0x1f/0x40
 [<c013e507>] cache_grow+0xa7/0x290
 [<c013e7be>] cache_alloc_refill+0xce/0x210
 [<c013ebe9>] __kmalloc+0x69/0x70
 [<c03252f7>] alloc_skb+0x47/0xf0
 [<d0f3c880>] ipw2100_rx_allocate+0x140/0x2f0 [ipw2100]
 [<d0f3dfaf>] ipw2100_queues_allocate+0x1f/0x60 [ipw2100]
 [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
 [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
 [<c021c202>] pci_device_probe_static+0x52/0x70
 [<c021c25c>] __pci_device_probe+0x3c/0x50
 [<c021c29c>] pci_device_probe+0x2c/0x50
 [<c0278cef>] bus_match+0x3f/0x70
 [<c0278e1c>] driver_attach+0x5c/0x90
 [<c02790cd>] bus_add_driver+0x8d/0xa0
 [<c027951f>] driver_register+0x2f/0x40
 [<c021c48c>] pci_register_driver+0x5c/0x90
 [<d0f3b98d>] ipw2100_proc_init+0xad/0x150 [ipw2100]
 [<d0ec2065>] ipw2100_init+0x65/0x92 [ipw2100]
 [<c01326cc>] sys_init_module+0x12c/0x250
 [<c01051fb>] syscall_call+0x7/0xb
kernel BUG at mm/page_alloc.c:786!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c013b11e>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246   (2.6.6)
eax: 00000000   ebx: 00001000   ecx: c1011b80   edx: 00000000
esi: 008dc000   edi: c08dc000   ebp: c3547220   esp: c14cde30
ds: 007b   es: 007b   ss: 0068
Stack: 00000800 c08db000 d0f3bef6 cf4a3c44 00001000 c08dc000 008dc000 c3547220
       cf4a3c00 c3547220 d0f3cbe9 c3547220 c354763c c3547220 c3547220 cf4a3c00
       c3547000 d0f3dfbb c3547220 fffffff4 d0f3fc97 c3547220 c3547000 c3547220
 [<d0f3bef6>] bd_queue_free+0xa6/0xe0 [ipw2100]
 [<d0f3cbe9>] ipw2100_rx_free+0x29/0x120 [ipw2100]
 [<d0f3dfbb>] ipw2100_queues_allocate+0x2b/0x60 [ipw2100]
 [<d0f3fc97>] ipw2100_pci_init_one+0x367/0x5a0 [ipw2100]
 [<c0187f0e>] sysfs_new_inode+0x5e/0xb0
 [<c021c202>] pci_device_probe_static+0x52/0x70
 [<c021c25c>] __pci_device_probe+0x3c/0x50
 [<c021c29c>] pci_device_probe+0x2c/0x50
 [<c0278cef>] bus_match+0x3f/0x70
 [<c0278e1c>] driver_attach+0x5c/0x90
 [<c02790cd>] bus_add_driver+0x8d/0xa0
 [<c027951f>] driver_register+0x2f/0x40
 [<c021c48c>] pci_register_driver+0x5c/0x90
 [<d0f3b98d>] ipw2100_proc_init+0xad/0x150 [ipw2100]
 [<d0ec2065>] ipw2100_init+0x65/0x92 [ipw2100]
 [<c01326cc>] sys_init_module+0x12c/0x250
 [<c01051fb>] syscall_call+0x7/0xb
Code: 0f 0b 12 03 c0 2a 3d c0 eb cd 90 8d b4 26 00 00 00 00 85 c0


>>EIP; c013b11e <__free_pages+3e/50>   <=====

>>ebx; 00001000 Before first symbol
>>ecx; c1011b80 <pg0+b0db80/3fafa000>
>>esi; 008dc000 Before first symbol
>>edi; c08dc000 <pg0+3d8000/3fafa000>
>>ebp; c3547220 <pg0+3043220/3fafa000>
>>esp; c14cde30 <pg0+fc9e30/3fafa000>

Code;  c013b11e <__free_pages+3e/50>
00000000 <_EIP>:
Code;  c013b11e <__free_pages+3e/50>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013b120 <__free_pages+40/50>
   2:   12 03                     adc    (%ebx),%al
Code;  c013b122 <__free_pages+42/50>
   4:   c0 2a 3d                  shrb   $0x3d,(%edx)
Code;  c013b125 <__free_pages+45/50>
   7:   c0 eb cd                  shr    $0xcd,%bl
Code;  c013b128 <__free_pages+48/50>
   a:   90                        nop
Code;  c013b129 <__free_pages+49/50>
   b:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c013b130 <free_pages+0/40>
  12:   85 c0                     test   %eax,%eax


1 warning issued.  Results may not be reliable.
[user@bloodymary user]$
