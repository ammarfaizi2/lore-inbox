Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266944AbUBRXiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267051AbUBRXiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:38:14 -0500
Received: from mibi03.meb.uni-bonn.de ([131.220.21.4]:271 "EHLO
	mibi03.meb.uni-bonn.de") by vger.kernel.org with ESMTP
	id S266944AbUBRXhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:37:42 -0500
Subject: PROBLEM: Linux V. 2.6.3 panics with "Buffers at physical address
	>16Mb used for aha1542" at boot time
From: "Dr. Ernst Molitor" <molitor@cfce.de>
To: linux-kernel@vger.kernel.org
Cc: molitor@uni-bonn.de
Content-Type: text/plain
Message-Id: <1077147443.1614.11.camel@felicia>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.4 
Date: Thu, 19 Feb 2004 00:37:24 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-scanner: scanned by Inflex 2.0.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux gurus,

thank you very much for your work on Linux. Today, I came across a
problem; sorry, I have failed in trying to spot the cause...

[1.] Linux V. 2.6.3 panics with "Buffers at physical address >16Mb used
for aha1542" at boot time on my box.

[2.] Up to Linux-2.6.1-rc2, everything went fine on my somewhat aged box
with both AHA1542 and AIC7xxx-based SCSI controllers. After upgrading to
Linux-2.6.3 (essentially with the same .config file, using make
oldconfig), my box failed to boot with this message:

buf vaddress e7f8be5c paddress 0x27f8be5c length 16
Kernel panic: Buffers at physical address >16Mb used for aha1542

Nothing short of a hard reset let out of this...

[3.] AHA1542, DMA (?)

[7.1] before the upgrade to 2.6.3, ver_linux showed:
Linux felicia 2.6.1-rc2 #1 SMP Thu Jan 8 22:23:49 CET 2004 i686 unknown
  
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.13-pre
e2fsprogs              1.30
reiserfsprogs          3.6.9
isdn4k-utils           isdnctrl)
nfs-utils              0.1.9.1
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.5
Procps                 3.1.15
Net-tools              1.54
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded

[7.2]  cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 451.058
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 888.83
 
[7.3] no modules loaded
[7.4]  cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
02f8-02ff : serial
0330-0333 : aha1542
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-403f : 0000:00:07.3
5000-501f : 0000:00:07.3
c000-cfff : PCI Bus #01
  c000-c0ff : 0000:01:00.0
d000-d01f : 0000:00:07.2
  d000-d01f : uhci_hcd
d400-d4ff : 0000:00:08.0
  d400-d4ff : 8139too
d800-d8ff : 0000:00:09.0
dc00-dcff : 0000:00:0a.0
  dc00-dcff : 8139too
e000-e0ff : 0000:00:0b.0
f000-f00f : 0000:00:07.1

 cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cc000-000d17ff : Extension ROM
000d2000-000d27ff : Extension ROM
000dc000-000dffff : Extension ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  00100000-003f5bac : Kernel code
  003f5bad-0052257f : Kernel data
27ff0000-27ff2fff : ACPI Non-volatile Storage
27ff3000-27ffffff : ACPI Tables
e0000000-e3ffffff : 0000:00:00.0
e4000000-e5ffffff : PCI Bus #01
  e5000000-e5000fff : 0000:01:00.0
e6000000-e6ffffff : PCI Bus #01
  e6000000-e6ffffff : 0000:01:00.0
e9000000-e90000ff : 0000:00:08.0
  e9000000-e90000ff : 8139too
e9001000-e90010ff : 0000:00:0a.0
  e9001000-e90010ff : 8139too
e9002000-e9002fff : 0000:00:0b.0
  e9002000-e9002fff : aic7xxx
e9003000-e9003fff : 0000:00:09.0
  e9003000-e9003fff : aic7xxx
ffff0000-ffffffff : reserved
ernst@felicia:/e/linux$

[7.5] lspci -vvv: 
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64 set
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=21
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=
 
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e4000000-e5ffffff
        Prefetchable memory behind bridge: e6000000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+
 
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 set
 
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 4: I/O ports at f000 [size=16]
 
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 set
        Interrupt: pin D routed to IRQ 15
        Region 4: I/O ports at d000 [size=32]
 
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
 
00:08.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 64 set
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:09.0 SCSI storage controller: Adaptec AHA-2940U2/W
        Subsystem: Adaptec: Unknown device 2180
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 39 min, 25 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 14
        BIST result: 00
        Region 0: I/O ports at d800 [disabled] [size=256]
        Region 1: Memory at e9003000 (64-bit, non-prefetchable)
[size=4K]
        Expansion ROM at e7000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RT8139 (rev
10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 min, 64 max, 64 set
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at e9001000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- AuxPwr- DSI- D1+ D2+ PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:0b.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at e000 [disabled] [size=256]
        Region 1: Memory at e9002000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at e8000000 [disabled] [size=64K]
 
01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP
(rev 7a) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 0084
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 64 set, cache line size 08
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at c000 [size=256]
        Region 2: Memory at e5000000 (32-bit, non-prefetchable)
[size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 1
                Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
[7.6]  cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 1.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: FIREBALL_TM3200S Rev: 300X
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0d
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 04 Lun: 00
  Vendor: CONNER   Model: CP30200-212MB    Rev: 4343
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 05 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: WA6A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 08 Lun: 00
  Vendor: IBM      Model: DNES-309170W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 09 Lun: 00
  Vendor: IBM      Model: DPSS-318350N     Rev: S80D
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 15 Lun: 00
  Vendor: FUJITSU  Model: MAN3184MP        Rev: 0109
  Type:   Direct-Access                    ANSI SCSI revision: 03

I'd very much appreciate any suggestion as to how to solve this problem.


