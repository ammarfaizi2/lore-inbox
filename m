Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVGYK2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVGYK2r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVGYK2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:28:47 -0400
Received: from ip3e83f6c9.speed.planet.nl ([62.131.246.201]:33965 "EHLO
	mail.pronexus.nl") by vger.kernel.org with ESMTP id S261197AbVGYK2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:28:46 -0400
Message-ID: <20050725122847.y6jtfiswtskcw8gc@intranet.pronexus.loc>
Date: Mon, 25 Jul 2005 12:28:47 +0200
From: msmulders@pronexus.nl
To: linux-kernel@vger.kernel.org
Subject: Re: help! kernel errors?
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.1)
X-VirusScanned-By: Pronexus BV
X-SpamScanned-By: Pronexus BV
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm sorry, here's some info on the backup procedure and system info:

The backup script mounts an smbfs filesystem (smbmnt v2.2.10) over a direct
(crosslink) 1000mbps link and uses rsync to backup the remote files from the
mountpoint to a local removable disk. (yeah I know. I tried nfs, but it's a
pain in the butt on Winblows. Better ideas/suggestions are welcome!)
The removable disk is a Maxtor 6Y120P0 120GB drive in a Promise SuperSWAP 1000
bay connected to a Promise TX2000 ATA RAID card. Using kernel module 'FastTrak'
built from the latest PROMISE FastTrak Series Linux Driver source.

The backup was running flawlessly until a month ago. I updated the kernel (as
can be seen below) but to no avail.
Now, the backup runs ok for quite some time.. when it started spitting the
errors it had already transferred 65GB of data.

Thanks for any pointers in the right direction!

# /usr/src/linux-2.4.31/scripts/ver_linux
Linux server 2.4.31 #1 Thu Jul 7 12:19:58 CEST 2005 i686 unknown unknown
GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.25
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
pcmcia-cs              3.2.5
quota-tools            3.09.
PPP                    2.4.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         ide-scsi natsemi crc32 ns83820 agpgart FastTrak

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 0
model name      : Intel(R) Pentium(R) 4 CPU 1400MHz
stepping        : 10
cpu MHz         : 1399.990
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 2791.83

# cat /proc/modules
ide-scsi               10288   0
natsemi                16800   1
crc32                   2880   0 [natsemi]
ns83820                12268   1
agpgart                40440   0 (unused)
FastTrak               94692   0

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0500-050f : Intel Corp. 82801BA/BAM SMBus
0cf8-0cff : PCI conf1
9000-9007 : Promise Technology, Inc. PDC20271
  9000-9007 : ide2
9400-9403 : Promise Technology, Inc. PDC20271
  9402-9402 : ide2
9800-9807 : Promise Technology, Inc. PDC20271
  9800-9807 : FT(base)
9c00-9c03 : Promise Technology, Inc. PDC20271
  9c02-9c02 : FT(ctrl)
a000-a00f : Promise Technology, Inc. PDC20271
  a000-a007 : ide2
  a008-a00f : ide3
a400-a4ff : National Semiconductor Corporation DP83815 (MacPhyter) Ethernet
Controller
  a400-a4ff : eth1
a800-a8ff : National Semiconductor Corporation DP83820 10/100/1000 Ethernet
Controller
f000-f00f : Intel Corp. 82801BA IDE U100
  f000-f007 : ide0
  f008-f00f : ide1

# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-17ffffff : System RAM
  00100000-002e1a28 : Kernel code
  002e1a29-00379e03 : Kernel data
e0000000-e3ffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64
Pro]
e6000000-e7ffffff : PCI Bus #01
  e6000000-e6ffffff : nVidia Corporation NV5M64 [RIVA TNT2 Model 64/Model 64
Pro]
e9000000-e900ffff : Promise Technology, Inc. PDC20271
e9010000-e9010fff : National Semiconductor Corporation DP83815 (MacPhyter)
Ethernet Controller
  e9010000-e9010fff : eth1
e9011000-e9011fff : National Semiconductor Corporation DP83820 10/100/1000
Ethernet Controller
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev
03)
        Subsystem: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [0104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans-
64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e6000000-e7ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 12) (prog-if 00
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 00009000-0000afff
        Memory behind bridge: e8000000-e9ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 12)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 12) (prog-if 80
[Master])
        Subsystem: Intel Corp.: Unknown device 2442
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 12)
        Subsystem: Intel Corp.: Unknown device 2442
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 4: I/O ports at 0500 [size=16]

01:00.0 VGA compatible controller: nVidia Corporation NV5M64 [RIVA TNT2 Model
64/Model 64 Pro] (rev 15) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- HTrans-
64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>

02:09.0 RAID bus controller: Promise Technology, Inc. PDC20271 (rev 02) (prog-if
85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9000 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9800 [size=8]
        Region 3: I/O ports at 9c00 [size=4]
        Region 4: I/O ports at a000 [size=16]
        Region 5: Memory at e9000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller
        Subsystem: National Semiconductor Corporation DP83815 (MacPhyter)
Ethernet Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2750ns min, 13000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at e9010000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:0b.0 Ethernet controller: National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2750ns min, 13000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a800 [size=256]
        Region 1: Memory at e9011000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]

# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Promise  Model: 1+0 Span         Rev: 1.10
  Type:   Direct-Access                    ANSI SCSI revision: 02


Beantwoorden Frederik Deweerdt <frederik.deweerdt@gmail.com>:

> Hi,
> Reading this may help kernel developers to help you:
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
> Regards,
> Frederik Deweerdt
>
>


