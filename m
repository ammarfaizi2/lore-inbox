Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbUJ0TDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUJ0TDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbUJ0TBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:01:43 -0400
Received: from bay15-f9.bay15.hotmail.com ([65.54.185.9]:44912 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262653AbUJ0S7Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:59:16 -0400
X-Originating-IP: [80.126.245.90]
X-Originating-Email: [harmweites@hotmail.com]
From: "Harm Weites" <harmweites@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: apic error on cpu#
Date: Wed, 27 Oct 2004 20:58:45 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <BAY15-F9wdpOTziwi7Q00011fe3@hotmail.com>
X-OriginalArrivalTime: 27 Oct 2004 18:59:03.0965 (UTC) FILETIME=[070C74D0:01C4BC57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
im getting very much "APIC error on cpu#" errors.

at the pc i can compile kernels without errors, but when i open an ssh 
session to it or couse http traffic from the apache2 service i start getting 
apic errors and occasionaly "unexpected irq trap on vector d0". Im reading 
this from "dmesg".
I can easily reproduce the errors while doing the following: (this is how i 
found it)
from my P4 WinXP pc i copy an iso image of 4GB to a smb share at the 
"problem" pc. After several MB's i type 'dmesg' at the console and it shows 
at the bottom the APIC errors. Eventually the number of errors increeses and 
causes the system to lock. The console cursor stops blinking and i cant 
connect using ssh/http/etc.

When running winxp at the problem pc i do the exact same thing, and the file 
transfer stalls aftera while. When taking a look at the windowsxp log 
facility it also gives APIC Bios errors.

**cat /proc/version
Linux version 2.6.10-rc1 (root@ophidian) (gcc version 3.3.4) #11 SMP Wed Oct 
27 16:15:27 CEST 2004

**cat /etc/lilo.conf|grep append
append = "apic=debug acpi=off apm=off noapic nolapic"

**dmesg output of the problem:
APIC error on CPU0: 00(04)
APIC error on CPU1: 00(02)
APIC error on CPU1: 02(02)
unexpected irq trap on vector d0
APIC error on CPU0: 04(04)
APIC error on CPU1: 02(02)
APIC error on CPU0: 04(04)
APIC error on CPU1: 02(08)

**System:
Dual P3 XEON 2mb cache
Aopen DX2Gplus -Adaptec AIC-7896 scsi -Intel pro100 lan (i440GX)
1024mb (512,256,128,128) 133mhz sd-ram
diamond viper v770 32mb
MPS spec 1.4 and NO option for 1.1 in bios
slackware 10.0
Hostname is "ophidian" btw :)

**sh ver_linux
Linux ophidian 2.6.10-rc1 #11 SMP Wed Oct 27 16:15:27 CEST 2004 i686 unknown 
unknown GNU/Linux

Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.90.0.3
util-linux             2.12a
mount                  2.12a
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          3.6.17
reiser4progs           line
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.6
Procps                 3.2.1
Net-tools              1.60
Kbd                    81:
Sh-utils               5.2.1
Modules Loaded         smbfs eepro100

**cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.977
cache size      : 2048 KB
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
bogomips        : 1384.44

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 701.977
cache size      : 2048 KB
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
bogomips        : 1396.73

**cat /proc/modules
smbfs 64504 3 - Live 0xf89d6000
eepro100 22892 0 - Live 0xf89bc000

**cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c9bff : Video ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-0034b158 : Kernel code
  0034b159-0040ae1f : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
80100000-820fffff : PCI Bus #01
  81000000-81ffffff : 0000:01:00.0
82100000-821fffff : PCI Bus #02
  82100000-82100fff : 0000:02:09.0
    82100000-82100fff : aic7xxx
  82101000-82101fff : 0000:02:09.1
    82101000-82101fff : aic7xxx
82300000-860fffff : PCI Bus #01
  84000000-85ffffff : 0000:01:00.0
    84000000-84feffff : vesafb
86300000-863fffff : 0000:00:10.0
86500000-86500fff : 0000:00:10.0
  86500000-86500fff : eepro100
e0000000-e1ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

**cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
03c0-03df : vesafb
0400-043f : 0000:00:07.3
0800-081f : 0000:00:07.3
0cf8-0cff : PCI conf1
1000-100f : 0000:00:07.1
1020-103f : 0000:00:07.2
8000-8fff : PCI Bus #02
  8000-80ff : 0000:02:09.0
  8400-84ff : 0000:02:09.1
9040-905f : 0000:00:10.0
  9040-905f : eepro100

**lspci -vvv
00:00.0 Host bridge: Intel Corp. 440GX - 82443GX Host bridge
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440GX - 82443GX AGP bridge (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: 80100000-820fffff
        Prefetchable memory behind bridge: 82300000-860fffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at 1000 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin D routed to IRQ 0
        Region 4: I/O ports at 1020 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224, cache line size 08
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=224
        I/O behind bridge: 00008000-00008fff
        Memory behind bridge: 82100000-821fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
                Bridge: PM- B3+

00:10.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 
05)
        Subsystem: Intel Corp. 82558 10/100 with Wake on LAN
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at 86500000 (32-bit, prefetchable) [size=4K]
        Region 1: I/O ports at 9040 [size=32]
        Region 2: Memory at 86300000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 
Pro] (rev 11) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Viper V770
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: Memory at 81000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at 84000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at 80100000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- 
Rate=<none>

02:09.0 SCSI storage controller: Adaptec AIC-7896U2/7897U2
        Subsystem: Adaptec: Unknown device 080f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 8000 [disabled] [size=256]
        Region 1: Memory at 82100000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at 82120000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.1 SCSI storage controller: Adaptec AIC-7896U2/7897U2
        Subsystem: Adaptec: Unknown device 080f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 224 (9750ns min, 6250ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at 8400 [disabled] [size=256]
        Region 1: Memory at 82101000 (64-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

**cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM-PCCO Model: ST39102LC     !# Rev: B201
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: SEAGATE  Model: SX118202LC       Rev: B704
  Type:   Direct-Access                    ANSI SCSI revision: 02


I hope this is enough info, if not please take a look at my thread at the 
gentoo forum: http://forums.gentoo.org/viewtopic.php?t=242920

Thnx in advance
(ps: someone told me to ask you to reply in cc...)

_________________________________________________________________
Ook een gouden buddy worden in Messenger? Go for gold!  
http://mobile.msn.com/?lc=nl-nl

