Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUAaDGm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 22:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbUAaDGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 22:06:42 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:40101 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S261152AbUAaDG3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 22:06:29 -0500
Date: Fri, 30 Jan 2004 22:06:27 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: major network performance difference between 2.4 and 2.6.2-rc2
Message-ID: <Pine.GSO.4.58.0401302108560.1211@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a major networking performance problem on my machine under recent
2.6 kernels.  I have a dual Athlon-MP machine with an onboard Intel
Ethernet Pro 100 device, which can use either the e100 or eepro100 driver.

I ran some tests under 2.4 and recent 2.6 kernels to see what kind of
performance I could get.  I tested using both ftp and samba, the client
machine is a windows box with an onboard 3com 3c920b controller.  They
are connected through a D-Link 100 megabit full duplex switch.

Under both 2.6.2-rc2 and 2.6.2-rc2-mm2, the performance is pretty bad.
Copying 4.3 gigabytes of data from the linux machine to the windows box
via samba takes about 35 minutes.  LFTP shows FTP transfers from the linux
box to the windows box to go at about 2 megabytes per second.  The
performance is even worse in the opposite direction, LFTP shows transfers
from the linux box to the windows box to be around 1.5 megabytes per
second.

I repeated the above tests with both the e100 driver and the eepro100
driver and got the same results.  Running ifconfig shows "errors:0
dropped:0 overruns:0 frame:0" and "errors:0 dropped:0 overruns:0
carrier:0 collisions:0" for the device.

Unfortunately my OS (unstable Gentoo) does not appear to support 2.4
kernels anymore, so I had to use a Knoppix CD to test 2.4 kernels.  I am
using Knoppix nov 19 2003 version, which I believe uses a 2.4.21 or 2.4.22
kernel.  It uses the eepro100 driver.

Under the Knoppix 2.4 kernel, using the exact same samba configuration
file, I was able to copy 4.3 gigabytes of data from the linux machine to
the windows machine in about 8 minutes.  Copying in the opposite direction
takes about 10 minutes.  Unfortunately Knoppix doesn't include an FTP
server so I wasn't able to test that.

It appears that my network device is capable of 4 times the throughput
under 2.4 kernels versus recent 2.6 kernels.  I believe this problem arose
recently, probably sometime since 2.6.0, since I only recently noticed
this performance issue.

I don't know if this problem is specific to my configuration or not, so
included below is lots of configuration information.  Please note that the
funky modules like nvidia, vmware and cbm were not loaded when I ran my
tests.

thanks,
Jim Faulkner

delta-9 linux # cat /proc/version
Linux version 2.6.2-rc2-mm2 (root@delta-9) (gcc version 3.3.2 20031218
(Gentoo Linux 3.3.2-r5, propolice-3.3-7)) #1 SMP Fri Jan 30 16:07:03 EST
2004

delta-9 linux # scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux delta-9 2.6.2-rc2-mm2 #1 SMP Fri Jan 30 16:07:03 EST 2004 i686 AMD
Athlon(tm) MP 2200+ AuthenticAMD GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      3.0-pre8
e2fsprogs              1.34
PPP                    2.4.2
nfs-utils              1.0.6
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Procps                 3.1.15
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.0.91
Modules Loaded         nvidia vmnet vmmon btaudio amd_k7_agp agpgart
8139too e100 parport_pc cbm parport

delta-9 linux # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP 2200+
stepping        : 1
cpu MHz         : 1800.573
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
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3538.94

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) MP
stepping        : 1
cpu MHz         : 1800.573
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
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3596.28

delta-9 linux # cat /proc/modules
nvidia 2071816 12 - Live 0xf92e1000
vmnet 32784 2 - Live 0xf8e07000
vmmon 81192 0 - Live 0xf8f55000
btaudio 17488 1 - Live 0xf8ded000
amd_k7_agp 7820 1 - Live 0xf8d93000
agpgart 32748 2 amd_k7_agp, Live 0xf8d9a000
8139too 25728 0 - Live 0xf8ad2000
e100 34816 0 - Live 0xf8ac8000
parport_pc 40000 1 - Live 0xf8abd000
cbm 8812 0 - Live 0xf8a98000
parport 45096 2 parport_pc,cbm, Live 0xf8aa2000

delta-9 linux # cat /proc/ioports
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
02f8-02ff : serial
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0778-077a : parport0
0cf8-0cff : PCI conf1
a000-cfff : PCI Bus #02
  a000-a01f : 0000:02:04.0
    a000-a01f : EMU10K1
  a400-a407 : 0000:02:04.1
    a400-a407 : emu10k1-gp
  a800-a8ff : 0000:02:05.0
    a800-a8ff : 8139too
  ac00-ac3f : 0000:02:07.0
    ac00-ac3f : e100
  b000-b007 : 0000:02:08.0
    b000-b007 : ide2
  b400-b403 : 0000:02:08.0
    b402-b402 : ide2
  b800-b807 : 0000:02:08.0
    b800-b807 : ide3
  bc00-bc03 : 0000:02:08.0
    bc02-bc02 : ide3
  c000-c00f : 0000:02:08.0
    c000-c007 : ide2
    c008-c00f : ide3
e000-e0ff : 0000:00:09.0
e400-e4ff : 0000:00:09.1
e800-e803 : 0000:00:00.0
f000-f00f : 0000:00:07.1
  f000-f007 : ide0
  f008-f00f : ide1

delta-9 linux # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d0000-000d55ff : Extension ROM
000d6000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00411bbb : Kernel code
  00411bbc-0052993f : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
e0000000-e7ffffff : 0000:00:00.0
e8000000-efffffff : PCI Bus #01
  e8000000-efffffff : 0000:01:05.0
f0000000-f1ffffff : PCI Bus #01
  f0000000-f0ffffff : 0000:01:05.0
f3000000-f4ffffff : PCI Bus #02
  f4000000-f401ffff : 0000:02:07.0
    f4000000-f401ffff : e100
  f4020000-f4023fff : 0000:02:08.0
  f4024000-f4024fff : 0000:02:00.0
    f4024000-f4024fff : ohci_hcd
  f4025000-f40250ff : 0000:02:05.0
    f4025000-f40250ff : 8139too
  f4026000-f4026fff : 0000:02:07.0
    f4026000-f4026fff : e100
f5000000-f50fffff : PCI Bus #02
  f5000000-f5000fff : 0000:02:06.0
    f5000000-f5000fff : bttv0
  f5001000-f5001fff : 0000:02:06.1
    f5001000-f5001fff : btaudio
f5100000-f5100fff : 0000:00:09.1
  f5100000-f5100fff : aic7xxx
f5101000-f5101fff : 0000:00:09.0
  f5101000-f5101fff : aic7xxx
f5102000-f5102fff : 0000:00:00.0
fec00000-ffffffff : reserved

delta-9 linux # lspci -vvv
0000:00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP
[IGD4-2P] System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at e0000000 (32-bit, prefetchable)
        Region 1: Memory at f5102000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at e800 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW+
Rate=x4

0000:00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]
AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: f0000000-f1ffffff
        Prefetchable memory behind bridge: e8000000-efffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA
(rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus]
IDE (rev 04) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at f000 [size=16]

0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev
03)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

0000:00:09.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
        Subsystem: Adaptec AHA-3960D U160/m
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 177
        BIST result: 00
        Region 0: I/O ports at e000 [disabled]
        Region 1: Memory at f5101000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
        Subsystem: Adaptec AHA-3960D U160/m
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (10000ns min, 6250ns max), cache line size 08
        Interrupt: pin B routed to IRQ 185
        BIST result: 00
        Region 0: I/O ports at e400 [disabled]
        Region 1: Memory at f5100000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI
(rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: f3000000-f4ffffff
        Prefetchable memory behind bridge: f5000000-f50fffff
        Expansion ROM at 0000a000 [disabled] [size=12K]
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:01:05.0 VGA compatible controller: nVidia Corporation NV15GL [Quadro2
Pro] (rev a4) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 006d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at f0000000 (32-bit, non-prefetchable)
        Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW+
Rate=x4

0000:02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus]
USB (rev 07) (prog-if 10 [OHCI])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 32 (20000ns max), cache line size 08
        Interrupt: pin D routed to IRQ 193
        Region 0: Memory at f4024000 (32-bit, non-prefetchable)

0000:02:04.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1
(rev 07)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 169
        Region 0: I/O ports at a000
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:04.1 Input device controller: Creative Labs SB Live! MIDI/Game
Port (rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at a400
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:05.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev
10)
        Subsystem: D-Link System Inc DFE-530TX+ 10/100 Ethernet Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: I/O ports at a800
        Region 1: Memory at f4025000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:06.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (4000ns min, 10000ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f5000000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11)
        Subsystem: Hauppauge computer works Inc. WinTV Series
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: Memory at f5001000 (32-bit, prefetchable)
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 0d)
        Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at f4026000 (32-bit, non-prefetchable)
        Region 1: I/O ports at ac00 [size=64]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable)
[size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=2 PME-

0000:02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE
(rev 01) (prog-if 85)
        Subsystem: Giga-byte Technology: Unknown device b001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at b000
        Region 1: I/O ports at b400 [size=4]
        Region 2: I/O ports at b800 [size=8]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=16]
        Region 5: Memory at f4020000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

