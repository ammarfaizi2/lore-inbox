Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293755AbSBRFdp>; Mon, 18 Feb 2002 00:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310120AbSBRFdh>; Mon, 18 Feb 2002 00:33:37 -0500
Received: from waste.org ([209.173.204.2]:47534 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S310113AbSBRFd0>;
	Mon, 18 Feb 2002 00:33:26 -0500
Date: Sun, 17 Feb 2002 23:33:23 -0600 (CST)
From: Brak <brak@waste.org>
To: linux-kernel@vger.kernel.org
Subject: 2.5.5-pre1 File size limit exceeded in fdisk on extended partitions
Message-ID: <Pine.LNX.4.44.0202172317140.11770-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using the suggested bug reporting format, and couldn't pick someone
from MAINTAINERS that seemed correct. Sorry if this is too long.

After changing extended partition type on sda or sdb (1 Gig
or 2 Gig partition) and attempting to write partition table, fdisk exits with File
size limit exceeded error message.

Here are the current disk layouts of /dev/sda and /dev/sdb, I will
describe the error after this section:
Disk /dev/sda: 255 heads, 63 sectors, 2232 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sda1   *         1        16    128488+  83  Linux
/dev/sda2            17       538   4192965   83  Linux
/dev/sda3           539       799   2096482+  83  Linux
/dev/sda4           800      2232  11510572+   5  Extended
/dev/sda5           800       930   1052226   83  Linux
/dev/sda6           931      1061   1052226   83  Linux
/dev/sda7          1062      1192   1052226   83  Linux
/dev/sda8          1193      1257    522081   83  Linux
/dev/sda9          1258      1506   2000061   82  Linux swap
/dev/sda10         1507      1637   1052226   83  Linux

Disk /dev/sdb: 255 heads, 63 sectors, 2232 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/sdb1   *         1        16    128488+  83  Linux
/dev/sdb2            17       538   4192965   83  Linux
/dev/sdb3           539       799   2096482+  83  Linux
/dev/sdb4           800      2232  11510572+   5  Extended
/dev/sdb5           800       930   1052226   fd  Linux raid autodetect
/dev/sdb6           931      1061   1052226   fd  Linux raid autodetect
/dev/sdb7          1062      1192   1052226   fd  Linux raid autodetect
/dev/sdb8          1193      1257    522081   83  Linux
/dev/sdb9          1258      1506   2000061   83  Linux
/dev/sdb10         1507      1637   1052226   83  Linux

At this point if I try to change the partition type of /dev/sdb5 + to
either 83 or 82 and "write", fdisk exits with File size limit exceeded.

x:/usr/src/linux/scripts# sh ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux x 2.5.5-pre1 #3 Sun Feb 17 22:19:34 GMT 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.10f
modutils               2.4.13
e2fsprogs              1.26
PPP                    2.3.11
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.6
Net-tools              1.60
Kbd                    command
Sh-utils               2.0
Modules Loaded

x:/usr/src/linux/scripts# cat /proc/version
Linux version 2.5.5-pre1 (root@x) (gcc version 2.95.4 20011002 (Debian
prerelease)) #3 Sun Feb 17 22:19:34 GMT 2002


x:/usr/src/linux/scripts# fdisk /dev/sdb
Command (m for help): t
Partition number (1-10): 9
Hex code (type L to list codes): 82
Changed system type of partition 9 to 82 (Linux swap)

Command (m for help): w
File size limit exceeded
x:/usr/src/linux/scripts#

x:/usr/src/linux/scripts# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 746.163
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1487.66

x:/usr/src/linux/scripts# cat /proc/modules
x:/usr/src/linux/scripts#
x:/usr/src/linux/scripts# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial(set)
03c0-03df : vga+
03f8-03ff : serial(set)
0c00-0c3f : Intel Corp. 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
1040-105f : Intel Corp. 82371AB PIIX4 ACPI
2000-20ff : Adaptec 7896
  2000-20ff : aic7xxx
2400-24ff : Adaptec 7896 (#2)
  2400-24ff : aic7xxx
2800-283f : Intel Corp. 82557 [Ethernet Pro 100]
  2800-283f : eepro100
2840-285f : Intel Corp. 82371AB PIIX4 USB
2860-286f : Intel Corp. 82371AB PIIX4 IDE

x:/usr/src/linux/scripts# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cd7ff : Extension ROM
000cd800-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00266c37 : Kernel code
  00266c38-002d0ff3 : Kernel data
3fff0000-3ffffbff : ACPI Tables
3ffffc00-3fffffff : ACPI Non-volatile Storage
f4000000-f40fffff : Intel Corp. 82557 [Ethernet Pro 100]
f4100000-f4100fff : Adaptec 7896
  f4100000-f4100fff : aic7xxx
f4101000-f4101fff : Adaptec 7896 (#2)
  f4101000-f4101fff : aic7xxx
f4102000-f4102fff : Intel Corp. 82557 [Ethernet Pro 100]
  f4102000-f4102fff : eepro100
f4103000-f4103fff : Cirrus Logic GD 5480
f6000000-f7ffffff : Cirrus Logic GD 5480
f8000000-fbffffff : Intel Corp. 440GX - 82443GX Host bridge
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

x:/usr/src/linux/scripts# lspci -vvv
00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:0c.0 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 2000 [disabled] [size=256]
        Region 1: Memory at f4100000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 2400 [disabled] [size=256]
        Region 1: Memory at f4101000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on
Motherboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 56 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f4102000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2800 [size=64]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at <unassigned> [disabled] [size=1M]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI+ D1+ D2+ PME+
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set

00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Region 4: I/O ports at 2860 [size=16]
00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at 2840 [size=32]

00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if
00 [VGA])
        Subsystem: Cirrus Logic: Unknown device 00bc
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 2 min, 10 max, 64 set
        Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at f4103000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=32K]

01:0f.0 PCI bridge: Digital Equipment Corporation: Unknown device 0023
(rev 06) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 240 set, cache line size 08
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge:
00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


x:/usr/src/linux/scripts# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS_V_18_WLS   Rev: 0230
  Type:   Direct-Access                    ANSI SCSI revision: 03



-- 
-brak

