Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUANUho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 15:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUANUhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 15:37:43 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:38845 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S264563AbUANUgs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 15:36:48 -0500
Date: Wed, 14 Jan 2004 15:36:47 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: PROBLEM: AES cryptoloop corruption under recent -mm kernels
Message-ID: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am experiencing data corruption on my AES cryptoloop partition under
recent -mm kernels (including 2.6.1-mm3).  I am unsure how long this
problem has existed, and I am unsure if this problem exists in the
mainstream kernel (I can't test it because of an aic7xxx bug in the
mainstream kernel).

Based on this:
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/002B.html
I'm guessing that the corruption I am experiencing is because I have a
highmem machine.  Its a Dell Precision Workstation 530MT (dual 1.8ghz p4
xeon processors, 1 GB RAM).  I am using a reiserfs-formatted AES
cryptoloop on a hard drive partition:
sifried linux # losetup /dev/loop0
/dev/loop0: [000a]:649 (/dev/hda1), encryption aes (type 18)

The problem is easily repeated.  Just copy 2 or 3 large (~500 MB) files to
the cryptoloop partition simultaneously, and its almost certain that at
least one of them will end up corrupted on the cryptoloop partition.  Just
check with "diff".

Below is some configuration information.  Just let me know if anything
else is needed.

thanks,
Jim Faulkner

sifried linux # cat /proc/version
Linux version 2.6.1-mm3 (root@sifried) (gcc version 3.2.3 20030422 (Gentoo
Linux 1.4 3.2.3-r3, propolice)) #1 SMP Wed Jan 14 13:31:40 EST 2004

sifried linux # sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux sifried 2.6.1-mm3 #1 SMP Wed Jan 14 13:31:40 EST 2004 i686 Intel(R)
Xeon(TM) CPU 1700MHz GenuineIntel GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre4
e2fsprogs              1.34
quota-tools            3.06.
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         parport_pc lp parport mga intel_agp sg sr_mod st

sifried linux # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 0
model name      : Intel(R) Xeon(TM) CPU 1700MHz
stepping        : 10
cpu MHz         : 1695.379
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3342.33

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 0
model name      : Intel(R) Xeon(TM) CPU 1700MHz
stepping        : 10
cpu MHz         : 1695.379
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3383.29

sifried linux # cat /proc/modules
parport_pc 37408 1 - Live 0xf8a5b000
lp 9024 0 - Live 0xf8a16000
parport 37056 2 parport_pc,lp, Live 0xf8a1e000
mga 112320 24 - Live 0xf8a31000
intel_agp 16024 1 - Live 0xf89ec000
sg 23948 0 - Live 0xf89e5000
sr_mod 13472 0 - Live 0xf89cd000
st 36372 0 - Live 0xf89d3000

sifried linux # cat /proc/ioports
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
0cf8-0cff : PCI conf1
c800-c8ff : 0000:00:1f.5
  c800-c8ff : Intel 82801BA-ICH2 - AC'97
cc40-cc7f : 0000:00:1f.5
  cc40-cc7f : Intel 82801BA-ICH2 - Controller
ccd0-ccdf : 0000:00:1f.3
dc80-dcff : 0000:04:0b.0
  dc80-dcff : 0000:04:0b.0
e000-efff : PCI Bus #02
  e000-efff : PCI Bus #03
    ec00-ecff : 0000:03:0e.0
ff60-ff7f : 0000:00:1f.4
  ff60-ff7f : uhci_hcd
ff80-ff9f : 0000:00:1f.2
  ff80-ff9f : uhci_hcd
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

sifried linux # cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c8800-000cdfff : Extension ROM
000ce000-000cffff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ff76fff : System RAM
  00100000-0039ea73 : Kernel code
  0039ea74-0049aa7f : Kernel data
3ff77000-3ff78fff : ACPI Non-volatile Storage
3ff79000-3fffffff : reserved
f0000000-f7ffffff : 0000:00:00.0
f8000000-f9ffffff : PCI Bus #01
  f8000000-f9ffffff : 0000:01:00.0
fd000000-fdffffff : PCI Bus #01
  fd000000-fd7fffff : 0000:01:00.0
  fdefc000-fdefffff : 0000:01:00.0
fe1f8000-fe1fbfff : 0000:04:0c.0
fe1ff000-fe1ff7ff : 0000:04:0c.0
  fe1ff000-fe1ff7ff : ohci1394
fe1ffc00-fe1ffc7f : 0000:04:0b.0
fe300000-fe5fffff : PCI Bus #02
  fe400000-fe5fffff : PCI Bus #03
    fe4fe000-fe4fefff : 0000:03:00.0
    fe4ff000-fe4fffff : 0000:03:0e.0
      fe4ff000-fe4fffff : aic7xxx
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
ffb00000-ffffffff : reserved

sifried linux # lspci -vvv
00:00.0 Host bridge: Intel Corp. 82860 860 (Wombat) Chipset Host Bridge
(MCH) (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4

00:01.0 PCI bridge: Intel Corp. 82850 850 (Tehama) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fd000000-fdffffff
        Prefetchable memory behind bridge: f8000000-f9ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:02.0 PCI bridge: Intel Corp. 82860 860 (Wombat) Chipset AGP Bridge (rev
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=02, subordinate=03, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe300000-fe5fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 04)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe100000-fe2fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801BA ISA Bridge (LPC) (rev 04)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801BA IDE U100 (rev 04) (prog-if 80
[Master])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at ffa0 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #1) (rev 04)
(prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 193
        Region 4: I/O ports at ff80 [size=32]

00:1f.3 SMBus: Intel Corp. 82801BA/BAM SMBus (rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 177
        Region 4: I/O ports at ccd0 [size=16]

00:1f.4 USB Controller: Intel Corp. 82801BA/BAM USB (Hub #2) (rev 04)
(prog-if 00 [UHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 201
        Region 4: I/O ports at ff60 [size=32]

00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 Audio
(rev 04)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 177
        Region 0: I/O ports at c800 [size=256]
        Region 1: I/O ports at cc40 [size=64]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 32Mb SDRAM Dual
Head
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at fdefc000 (32-bit, non-prefetchable) [size=16K]
        Region 2: Memory at fd000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at c1000000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW-
Rate=x4

02:1f.0 PCI bridge: Intel Corp. 82806AA PCI64 Hub PCI Bridge (rev 03)
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=64
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: fe400000-fe5fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

03:00.0 PIC: Intel Corp. 82806AA PCI64 Hub Advanced Programmable Interrupt
Controller (rev 01) (prog-if 20 [IO(X)-APIC])
        Subsystem: Intel Corp. 82806AA PCI64 Hub APIC
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Region 0: Memory at fe4fe000 (32-bit, non-prefetchable) [disabled]
[size=4K]

03:0e.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (10000ns min, 6250ns max), cache line size 10
        Interrupt: pin A routed to IRQ 225
        BIST result: 00
        Region 0: I/O ports at ec00 [disabled] [size=256]
        Region 1: Memory at fe4ff000 (64-bit, non-prefetchable) [size=4K]
        Expansion ROM at fe500000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 78)
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at dc80 [size=128]
        Region 1: Memory at fe1ffc00 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at fe200000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

04:0c.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394
Controller (Link) (prog-if 10 [OHCI])
        Subsystem: Dell Computer Corporation: Unknown device 00d8
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 169
        Region 0: Memory at fe1ff000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at fe1f8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-



