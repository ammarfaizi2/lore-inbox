Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFGHRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFGHRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 03:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVFGHRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 03:17:45 -0400
Received: from mxsf02.cluster1.charter.net ([209.225.28.202]:7582 "EHLO
	mxsf02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261410AbVFGHQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 03:16:31 -0400
X-IronPort-AV: i="3.93,176,1115006400"; 
   d="txt'?scan'208"; a="1160716430:sNHT27542220"
From: Jacob Martin <martin@cs.uga.edu>
Reply-To: martin@cs.uga.edu
To: linux-kernel@vger.kernel.org
Subject: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping
Date: Tue, 7 Jun 2005 03:18:33 -0400
User-Agent: KMail/1.8
Organization: University of Georgia
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JpUpCEzogqkVgLz"
Message-Id: <200506070318.33284.martin@cs.uga.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_JpUpCEzogqkVgLz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

[1]	OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Hardware and Software 
Memhole Mapping (4GB RAM)

[2]	Both Software or Hardware Mem Hole 
mapping seem to cause these OOPSes.  When Memhole is disabled, I have no 
trouble with OOPSes.

I have MTRR mapping set to Discrete, should it be continuous in BIOS?

[3]	kernel, smp, amd64, dual core


[4]	Linux version 2.6.12-rc6 (root@optimator) (gcc version 3.4.3 20041125 
(Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)) #1 SMP Mon Jun 6 23:53:47 EDT 2005


[5]	See attached file for many OOPS examples


[6]	Sorry, it seems random, so hard to reproduce.

[7.1]

======================================================================================
optimator linux $ sh scripts/ver_linux
Linux optimator 2.6.12-rc6 #1 SMP Mon Jun 6 23:53:47 EDT 2005 x86_64 AMD 
Athlon(tm) or Opteron(tm) CPU-model unknown AuthenticAMD GNU/Linux

Gnu C                  3.4.3
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12i
mount                  2.12i
module-init-tools      3.0
e2fsprogs              1.35
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.25
nfs-utils              1.0.6
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   045
Modules Loaded         smsc47b397 i2c_sensor i2c_isa i2c_core nvidia



[7.2]

=====================================================================================
optimator linux $ cat /proc/cpuinfo

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : AMD Athlon(tm) or Opteron(tm) CPU-model unknown
stepping        : 2
cpu MHz         : 2009.284
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 3981.31
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 33
model name      : AMD Athlon(tm) or Opteron(tm) CPU-model unknown
stepping        : 2
cpu MHz         : 2009.284
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 
3dnowext 3dnow pni lahf_lm cmp_legacy
bogomips        : 4014.08
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp


[7.3]
======================================================================================
optimator linux $ cat /proc/modules

smsc47b397 7952 0 - Live 0xffffffff8843e000
i2c_sensor 4352 1 smsc47b397, Live 0xffffffff8843b000
i2c_isa 3200 0 - Live 0xffffffff88439000
i2c_core 25664 3 smsc47b397,i2c_sensor,i2c_isa, Live 0xffffffff88431000
nvidia 4387396 20 - Live 0xffffffff88000000

[7.4]

======================================================================================
optimator root # cat /proc/ioports
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
01f0-01f7 : ide0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-101f : 0000:00:01.1
1400-14ff : 0000:00:04.0
1800-18ff : 0000:00:04.0
1c00-1c0f : 0000:00:06.0
  1c00-1c07 : ide0
  1c08-1c0f : ide1
1c10-1c1f : 0000:00:07.0
  1c10-1c1f : sata_nv
1c20-1c2f : 0000:00:08.0
  1c20-1c2f : sata_nv
1c30-1c33 : 0000:00:07.0
  1c30-1c33 : sata_nv
1c34-1c37 : 0000:00:07.0
  1c34-1c37 : sata_nv
1c38-1c3f : 0000:00:07.0
  1c38-1c3f : sata_nv
1c40-1c47 : 0000:00:07.0
  1c40-1c47 : sata_nv
1c48-1c4b : 0000:00:08.0
  1c48-1c4b : sata_nv
1c4c-1c4f : 0000:00:08.0
  1c4c-1c4f : sata_nv
1c50-1c57 : 0000:00:08.0
  1c50-1c57 : sata_nv
1c58-1c5f : 0000:00:08.0
  1c58-1c5f : sata_nv
1c60-1c67 : 0000:00:0a.0
  1c60-1c67 : forcedeth
2000-2fff : PCI Bus #0a
  2000-20ff : 0000:0a:06.0
  2400-24ff : 0000:0a:06.1
5000-503f : 0000:00:01.1
  5000-503f : motherboard
5040-507f : 0000:00:01.1
  5040-507f : motherboard
8000-807f : motherboard
  8000-8003 : PM1a_EVT_BLK
  8004-8005 : PM1a_CNT_BLK
  8008-800b : PM_TMR
  8010-8015 : ACPI CPU throttle
  801c-801c : PM2_CNT_BLK
  8020-8027 : GPE0_BLK
8080-80ff : motherboard
8400-847f : motherboard
8480-84ff : motherboard
8800-887f : motherboard
8880-88ff : motherboard
8c00-8c7f : 0000:00:01.0
9000-907f : motherboard
9080-90ff : motherboard
9200-927f : motherboard
9280-92ff : motherboard
9400-947f : motherboard
9480-94ff : motherboard




optimator root # cat /proc/iomem
00000000-000947ff : System RAM
00094800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cf000-000d5bff : Adapter ROM
000f0000-000fffff : System ROM
00100000-bff1ffff : System RAM
  00100000-003dd89f : Kernel code
  003dd8a0-00568baf : Kernel data
bff20000-bff2dfff : ACPI Tables
bff2e000-bff7ffff : ACPI Non-volatile Storage
bff80000-bfffffff : reserved
c8000000-c8000fff : 0000:00:02.0
  c8000000-c8000fff : ohci_hcd
c8001000-c80010ff : 0000:00:02.1
  c8001000-c80010ff : ehci_hcd
c8002000-c8002fff : 0000:00:04.0
c8003000-c8003fff : 0000:00:07.0
  c8003000-c8003fff : sata_nv
c8004000-c8004fff : 0000:00:08.0
  c8004000-c8004fff : sata_nv
c8005000-c8005fff : 0000:00:0a.0
  c8005000-c8005fff : forcedeth
c8100000-c8103fff : 0000:01:05.0
c8104000-c81047ff : 0000:01:05.0
  c8104000-c81047ff : ohci1394
c9000000-cfffffff : PCI Bus #02
  c9000000-c9ffffff : 0000:02:00.0
  cc000000-cfffffff : 0000:02:00.0
    cc000000-cfffffff : nvidia
d0000000-d7ffffff : PCI Bus #02
  d0000000-d7ffffff : 0000:02:00.0
d8000000-d8000fff : 0000:08:0a.1
d8001000-d8001fff : 0000:08:0b.1
d8100000-d84fffff : PCI Bus #0a
  d8100000-d81fffff : 0000:0a:06.0
  d8200000-d82fffff : 0000:0a:06.0
  d8300000-d83fffff : 0000:0a:06.1
  d8400000-d84fffff : 0000:0a:06.1
e0000000-efffffff : reserved
fec00000-fec003ff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved





[7.5]
======================================================================================
optimator root # lspci -vvv
0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller 
(rev a3)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [44] #08 [01e0]
        Capabilities: [e0] #08 [a801]

0000:00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: I/O ports at 8c00

0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 0
        Region 0: I/O ports at 1000
        Region 4: I/O ports at 5000 [size=64]
        Region 5: I/O ports at 5040 [size=64]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) 
(prog-if 10 [OHCI])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at c8000000 (32-bit, non-prefetchable)
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) 
(prog-if 20 [EHCI])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin B routed to IRQ 225
        Region 0: Memory at c8001000 (32-bit, non-prefetchable)
        Capabilities: [44] #0a [2098]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio 
Controller (rev a2)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at 1800
        Region 1: I/O ports at 1400 [size=256]
        Region 2: Memory at c8002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Region 4: I/O ports at 1c00 [size=16]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3) (prog-if 85 [Master SecO PriO])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 185
        Region 0: I/O ports at 1c40
        Region 1: I/O ports at 1c34 [size=4]
        Region 2: I/O ports at 1c38 [size=8]
        Region 3: I/O ports at 1c30 [size=4]
        Region 4: I/O ports at 1c10 [size=16]
        Region 5: Memory at c8003000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller 
(rev a3) (prog-if 85 [Master SecO PriO])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (750ns min, 250ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at 1c58
        Region 1: I/O ports at 1c4c [size=4]
        Region 2: I/O ports at 1c50 [size=8]
        Region 3: I/O ports at 1c48 [size=4]
        Region 4: I/O ports at 1c20 [size=16]
        Region 5: Memory at c8004000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 
01 [Subtractive decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: c8100000-c81fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0 (250ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 177
        Region 0: Memory at c8005000 (32-bit, non-prefetchable)
        Region 1: I/O ports at 1c60 [size=8]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, cache line size 10
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: c9000000-cfffffff
        Prefetchable memory behind bridge: 00000000d0000000-00000000d7f00000
        Secondary status: SERR
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [58] #08 [a800]
        Capabilities: [80] #10 [0141]

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Capabilities: [80] #08 [2101]
        Capabilities: [a0] #08 [2101]
        Capabilities: [c0] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
DRAM Controller
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

0000:01:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 217
        Region 0: Memory at c8104000 (32-bit, non-prefetchable)
        Region 1: Memory at c8100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

0000:02:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 
GT] (rev a2) (prog-if 00 [VGA])
        Subsystem: Chaintech Computer Co. Ltd: Unknown device 1958
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 233
        Region 0: Memory at cc000000 (32-bit, non-prefetchable)
        Region 1: Memory at d0000000 (64-bit, prefetchable) [size=128M]
        Region 3: Memory at c9000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] #10 [0001]

0000:08:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=08, secondary=09, subordinate=09, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]
        Capabilities: [c0] #08 [004a]

0000:08:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) 
(prog-if 10 [IO-APIC])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8000000 (64-bit, non-prefetchable)

0000:08:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge 
(rev 12) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=08, secondary=0a, subordinate=0a, sec-latency=64
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: d8100000-d84fffff
        Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
        Expansion ROM at 00002000 [disabled] [size=4K]
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
        Capabilities: [a0]      Capabilities: [b8] #08 [8000]

0000:08:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) 
(prog-if 10 [IO-APIC])
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8001000 (64-bit, non-prefetchable)

0000:0a:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 1500ns max), cache line size 10
        Interrupt: pin A routed to IRQ 201
        Region 0: I/O ports at 2000
        Region 1: Memory at d8200000 (64-bit, non-prefetchable) [size=1M]
        Region 3: Memory at d8100000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68]
0000:0a:06.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI (rev 07)
        Subsystem: Tyan Computer: Unknown device 2895
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 1500ns max), cache line size 10
        Interrupt: pin B routed to IRQ 209
        Region 0: I/O ports at 2400
        Region 1: Memory at d8400000 (64-bit, non-prefetchable) [size=1M]
        Region 3: Memory at d8300000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68]


======================================================================================
optimator linux $ gcc --version
gcc (GCC) 3.4.3 20041125 (Gentoo 3.4.3-r1, ssp-3.4.3-0, pie-8.7.7)
Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


[7.6]
======================================================================================
optimator root # cat /proc/scsi/scsi
Attached devices:
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD740GD-00FL Rev: 31.0
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD740GD-00FL Rev: 27.0
  Type:   Direct-Access                    ANSI SCSI revision: 05


[7.7]
======================================================================================
optimator linux $ head -n 20 /usr/src/linux/.config
CONFIG_MK8=y
# CONFIG_MPSC is not set
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_SCHED_SMT=y
CONFIG_K8_NUMA=y
# CONFIG_NUMA_EMU is not set
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=8
CONFIG_HPET_TIMER=y
CONFIG_X86_PM_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GART_IOMMU=y
CONFIG_SWIOTLB=y

======================================================================================



I have 4GB RAM, Opteron 270 (dual core), kernel = 2.6.12-r6, Tyan Thunder 2895 
K8WE, Gentoo, bleeding-edge everything.

If you need more information, please don't hesitate to ask!  

Thank you very, very, very, much for everything you do.

Sincerely,

-- 
Jacob Martin

P.S.  I'm also having another problem with the newest kernels.  It is a  
crazy, most-probably unrelated bug :

 http://bugs.gentoo.org/show_bug.cgi?id=94453

In case you have any time :) 


--Boundary-00=_JpUpCEzogqkVgLz
Content-Type: text/plain;
  charset="us-ascii";
  name="oopses.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oopses.txt"

Jun  6 20:38:07 optimator Kernel BUG at "mm/page_alloc.c":972
Jun  6 20:38:07 optimator invalid operand: 0000 [1] PREEMPT SMP
Jun  6 20:38:07 optimator CPU 1
Jun  6 20:38:07 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  6 20:38:07 optimator Pid: 8255, comm: X Tainted: P      2.6.12-rc5
Jun  6 20:38:07 optimator RIP: 0010:[<ffffffff8015dd4c>] <ffffffff8015dd4c>{free_pages+268}
Jun  6 20:38:07 optimator RSP: 0018:ffff81011c273dd0  EFLAGS: 00010246
Jun  6 20:38:07 optimator RAX: 00000000000000ff RBX: ffff810107c29010 RCX: 0000000000000018
Jun  6 20:38:07 optimator RDX: ffff81013ff8f378 RSI: 0000000000000000 RDI: ffff810107c29000
Jun  6 20:38:07 optimator RBP: ffff810107c29010 R08: 0000000000000000 R09: 0000000000000000
Jun  6 20:38:07 optimator R10: 00000000000c178f R11: ffffffff803c04e0 R12: 0000000000000000
Jun  6 20:38:07 optimator R13: 0000000000000021 R14: 0000000000000000 R15: 00000001fffe090a
Jun  6 20:38:07 optimator FS:  00002aaaab287e60(0000) GS:ffffffff805c2f40(0000) knlGS:0000000000000000
Jun  6 20:38:07 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  6 20:38:07 optimator CR2: 00000000099d7000 CR3: 000000013b9a1000 CR4: 00000000000006e0
Jun  6 20:38:07 optimator Process X (pid: 8255, threadinfo ffff81011c272000, task ffff81013e742df0)
Jun  6 20:38:07 optimator Stack: ffffffff8018f9a3 ffff81012bc980c0 0000000200000000 0000000000000021
Jun  6 20:38:07 optimator ffffffff8018feae 0000000000000000 0000000000000000 00000001fffe090a
Jun  6 20:38:07 optimator 0000000000000000 0000000000000000
Jun  6 20:38:07 optimator Call Trace:<ffffffff8018f9a3>{poll_freewait+67} <ffffffff8018feae>{do_select+1038}
Jun  6 20:38:07 optimator <ffffffff8018f9b0>{__pollwait+0} <ffffffff801901bf>{sys_select+735}
Jun  6 20:38:07 optimator <ffffffff8010eb36>{system_call+126}
Jun  6 20:38:07 optimator
Jun  6 20:38:07 optimator Code: 0f 0b 61 af 3f 80 ff ff ff ff cc 03 48 b8 ff ff ff 7f ff ff
Jun  6 20:38:07 optimator RIP <ffffffff8015dd4c>{free_pages+268} RSP <ffff81011c273dd0>



===================================================================================================================================================

Jun  6 23:44:30 optimator Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  6 23:44:30 optimator <ffffffff80160baa>{cache_grow+666}
Jun  6 23:44:30 optimator PGD 136ee3067 PUD 136ee8067 PMD 0
Jun  6 23:44:30 optimator Oops: 0000 [1] PREEMPT SMP
Jun  6 23:44:30 optimator CPU 1
Jun  6 23:44:30 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  6 23:44:30 optimator Pid: 8629, comm: emerge Tainted: P      2.6.12-rc5
Jun  6 23:44:30 optimator RIP: 0010:[<ffffffff80160baa>] <ffffffff80160baa>{cache_grow+666}
Jun  6 23:44:30 optimator RSP: 0018:ffff810129e17a68  EFLAGS: 00010093
Jun  6 23:44:30 optimator RAX: ffffffff7fffffff RBX: 0000000000000038 RCX: 0000000000000000
Jun  6 23:44:30 optimator RDX: ffff810107c03000 RSI: 0000000000000001 RDI: 0000000000000001
Jun  6 23:44:30 optimator RBP: ffff810107c03000 R08: ffff81000000e000 R09: 0000000000000000
Jun  6 23:44:30 optimator R10: 00000000000c1783 R11: 0000000000000000 R12: ffff81013ffd4cc0
Jun  6 23:44:30 optimator R13: ffff810107c03000 R14: 0000000000000000 R15: 00000000ffffffff
Jun  6 23:44:30 optimator FS:  00002aaaab8afb00(0000) GS:ffffffff805c2f40(0000) knlGS:0000000000000000
Jun  6 23:44:30 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  6 23:44:30 optimator CR2: 00000000000025b0 CR3: 000000012cf23000 CR4: 00000000000006e0
Jun  6 23:44:30 optimator Process emerge (pid: 8629, threadinfo ffff810129e16000, task ffff81013d8f80f0)
Jun  6 23:44:30 optimator Stack: ffff81013ffd4d68 0000000000000003 00000020082cfdf0 000000000000001b
Jun  6 23:44:30 optimator ffff81013ffcc800 ffff81013ffd4cc0 ffff81013ffd4d08 ffff81013ffc9800
Jun  6 23:44:30 optimator ffff81013ffd4d68 ffffffff80160e92
Jun  6 23:44:30 optimator Call Trace:<ffffffff80160e92>{cache_alloc_refill+450} <ffffffff80160906>{kmem_cache_alloc+54}
Jun  6 23:44:30 optimator <ffffffff802505a3>{radix_tree_node_alloc+19} <ffffffff80250803>{radix_tree_insert+307}
Jun  6 23:44:30 optimator <ffffffff80158a96>{add_to_page_cache+86} <ffffffff8015a954>{generic_file_buffered_write+420}
Jun  6 23:44:30 optimator <ffffffff801bfa34>{ext3_add_entry+1588} <ffffffff8013a7f5>{current_fs_time+85}
Jun  6 23:44:30 optimator <ffffffff8015ce50>{__rmqueue+192} <ffffffff8019656e>{inode_update_time+62}
Jun  6 23:44:30 optimator <ffffffff8015b348>{__generic_file_aio_write_nolock+968}
Jun  6 23:44:30 optimator <ffffffff8015b3ff>{generic_file_aio_write+127} <ffffffff801b8493>{ext3_file_write+35}
Jun  6 23:44:30 optimator <ffffffff8017bfed>{do_sync_write+173} <ffffffff80121437>{do_page_fault+1159}
Jun  6 23:44:30 optimator <ffffffff8014b680>{autoremove_wake_function+0} <ffffffff8017c0e4>{vfs_write+196}
Jun  6 23:44:30 optimator <ffffffff8017c243>{sys_write+83} <ffffffff8010eb36>{system_call+126}
Jun  6 23:44:30 optimator
Jun  6 23:44:30 optimator
Jun  6 23:44:30 optimator Code: 48 8b 91 b0 25 00 00 76 07 b8 00 00 00 80 eb 0a 48 b8 00 00
Jun  6 23:44:30 optimator RIP <ffffffff80160baa>{cache_grow+666} RSP <ffff810129e17a68>
Jun  6 23:44:30 optimator CR2: 00000000000025b0
Jun  6 23:44:30 optimator <6>note: emerge[8629] exited with preempt_count 2
Jun  6 23:44:30 optimator scheduling while atomic: emerge/0x10000002/8629
Jun  6 23:44:30 optimator
Jun  6 23:44:30 optimator Call Trace:<ffffffff803d8d8d>{schedule+125} <ffffffff80130ac0>{__wake_up_common+64}
Jun  6 23:44:30 optimator <ffffffff803da448>{cond_resched+56} <ffffffff801688c9>{unmap_vmas+1897}
Jun  6 23:44:30 optimator <ffffffff8016e193>{exit_mmap+163} <ffffffff80132cc1>{mmput+49}
Jun  6 23:44:30 optimator <ffffffff80137c2a>{do_exit+346} <ffffffff80298e97>{do_unblank_screen+119}
Jun  6 23:44:30 optimator <ffffffff801216d2>{do_page_fault+1826} <ffffffff801bb413>{ext3_mark_inode_dirty+51}
Jun  6 23:44:30 optimator <ffffffff8010f565>{error_exit+0} <ffffffff80160baa>{cache_grow+666}
Jun  6 23:44:30 optimator <ffffffff80160ad3>{cache_grow+451} <ffffffff80160e92>{cache_alloc_refill+450}
Jun  6 23:44:30 optimator <ffffffff80160906>{kmem_cache_alloc+54} <ffffffff802505a3>{radix_tree_node_alloc+19}
Jun  6 23:44:30 optimator <ffffffff80250803>{radix_tree_insert+307} <ffffffff80158a96>{add_to_page_cache+86}
Jun  6 23:44:30 optimator <ffffffff8015a954>{generic_file_buffered_write+420}
Jun  6 23:44:30 optimator <ffffffff801bfa34>{ext3_add_entry+1588} <ffffffff8013a7f5>{current_fs_time+85}
Jun  6 23:44:30 optimator <ffffffff8015ce50>{__rmqueue+192} <ffffffff8019656e>{inode_update_time+62}
Jun  6 23:44:30 optimator <ffffffff8015b348>{__generic_file_aio_write_nolock+968}
Jun  6 23:44:30 optimator <ffffffff8015b3ff>{generic_file_aio_write+127} <ffffffff801b8493>{ext3_file_write+35}
Jun  6 23:44:30 optimator <ffffffff8017bfed>{do_sync_write+173} <ffffffff80121437>{do_page_fault+1159}
Jun  6 23:44:30 optimator <ffffffff8014b680>{autoremove_wake_function+0} <ffffffff8017c0e4>{vfs_write+196}
Jun  6 23:44:30 optimator <ffffffff8017c243>{sys_write+83} <ffffffff8010eb36>{system_call+126}
Jun  6 23:44:30 optimator
Jun  6 23:44:30 optimator scheduling while atomic: emerge/0x10000002/8629
Jun  6 23:44:30 optimator
Jun  6 23:44:30 optimator Call Trace:<ffffffff803d8d8d>{schedule+125} <ffffffff803c04e0>{unix_poll+0}
Jun  6 23:44:30 optimator <ffffffff803c04e0>{unix_poll+0} <ffffffff803da448>{cond_resched+56}
Jun  6 23:44:30 optimator <ffffffff801688c9>{unmap_vmas+1897} <ffffffff8016e193>{exit_mmap+163}
Jun  6 23:44:30 optimator <ffffffff80132cc1>{mmput+49} <ffffffff80137c2a>{do_exit+346}
Jun  6 23:44:30 optimator <ffffffff80298e97>{do_unblank_screen+119} <ffffffff801216d2>{do_page_fault+1826}
Jun  6 23:44:30 optimator <ffffffff801bb413>{ext3_mark_inode_dirty+51} <ffffffff8010f565>{error_exit+0}
Jun  6 23:44:30 optimator <ffffffff80160baa>{cache_grow+666} <ffffffff80160ad3>{cache_grow+451}
Jun  6 23:44:30 optimator <ffffffff80160e92>{cache_alloc_refill+450} <ffffffff80160906>{kmem_cache_alloc+54}
Jun  6 23:44:30 optimator <ffffffff802505a3>{radix_tree_node_alloc+19} <ffffffff80250803>{radix_tree_insert+307}
Jun  6 23:44:30 optimator <ffffffff80158a96>{add_to_page_cache+86} <ffffffff8015a954>{generic_file_buffered_write+420}
Jun  6 23:44:30 optimator <ffffffff801bfa34>{ext3_add_entry+1588} <ffffffff8013a7f5>{current_fs_time+85}
Jun  6 23:44:30 optimator <ffffffff8015ce50>{__rmqueue+192} <ffffffff8019656e>{inode_update_time+62}
Jun  6 23:44:30 optimator <ffffffff8015b348>{__generic_file_aio_write_nolock+968}
Jun  6 23:44:30 optimator <ffffffff8015b3ff>{generic_file_aio_write+127} <ffffffff801b8493>{ext3_file_write+35}
Jun  6 23:44:30 optimator <ffffffff8017bfed>{do_sync_write+173} <ffffffff80121437>{do_page_fault+1159}
Jun  6 23:44:30 optimator <ffffffff8014b680>{autoremove_wake_function+0} <ffffffff8017c0e4>{vfs_write+196}
Jun  6 23:44:30 optimator <ffffffff8017c243>{sys_write+83} <ffffffff8010eb36>{system_call+126}
Jun  6 23:44:30 optimator
Jun  6 23:45:05 optimator Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  6 23:45:05 optimator <ffffffff8016794a>{pte_alloc_map+170}
Jun  6 23:45:05 optimator PGD 12e7ca067 PUD 12ff93067 PMD 0
Jun  6 23:45:05 optimator Oops: 0000 [2] PREEMPT SMP
Jun  6 23:45:05 optimator CPU 0
Jun  6 23:45:05 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  6 23:45:05 optimator Pid: 8639, comm: emerge Tainted: P      2.6.12-rc5
Jun  6 23:45:05 optimator RIP: 0010:[<ffffffff8016794a>] <ffffffff8016794a>{pte_alloc_map+170}
Jun  6 23:45:05 optimator RSP: 0000:ffff81013a75bdb8  EFLAGS: 00010293
Jun  6 23:45:05 optimator RAX: ffffffff7fffffff RBX: 00002aaaabc00020 RCX: 0000000000000018
Jun  6 23:45:05 optimator RDX: ffff810107d90000 RSI: 0000000000000000 RDI: ffff81000000e6c0
Jun  6 23:45:05 optimator RBP: ffff810113339af0 R08: ffff81000000e000 R09: 0000000000000000
Jun  6 23:45:05 optimator R10: 00000000000c162c R11: 0000000000000000 R12: 0000000000000000
Jun  6 23:45:05 optimator R13: ffff81013ea78040 R14: ffff81013ea780b0 R15: ffff810113339af0
Jun  6 23:45:05 optimator FS:  00002aaaab8afb00(0000) GS:ffffffff805c2ec0(0000) knlGS:0000000000000000
Jun  6 23:45:05 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  6 23:45:05 optimator CR2: 00000000000025b0 CR3: 000000012fa55000 CR4: 00000000000006e0
Jun  6 23:45:05 optimator Process emerge (pid: 8639, threadinfo ffff81013a75a000, task ffff81013d8f87d0)
Jun  6 23:45:05 optimator Stack: ffff81012fa552a8 00002aaaabc00020 ffff81012a533d88 ffff81013ea78040
Jun  6 23:45:05 optimator 0000000000000001 ffffffff8016a545 0000000000000000 ffff81013ea780b0
Jun  6 23:45:05 optimator 00002aaaabc3f000 00002aaaab8aa000
Jun  6 23:45:05 optimator Call Trace:<ffffffff8016a545>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  6 23:45:05 optimator <ffffffff802516e1>{__up_write+49} <ffffffff8010f565>{error_exit+0}
Jun  6 23:45:05 optimator
Jun  6 23:45:05 optimator
Jun  6 23:45:05 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  6 23:45:05 optimator RIP <ffffffff8016794a>{pte_alloc_map+170} RSP <ffff81013a75bdb8>
Jun  6 23:45:05 optimator CR2: 00000000000025b0
Jun  6 23:45:06 optimator <1>Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  6 23:45:06 optimator <ffffffff8016794a>{pte_alloc_map+170}
Jun  6 23:45:06 optimator PGD 11d529067 PUD 0
Jun  6 23:45:06 optimator Oops: 0000 [3] PREEMPT SMP
Jun  6 23:45:06 optimator CPU 0
Jun  6 23:45:06 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  6 23:45:06 optimator Pid: 8607, comm: java Tainted: P      2.6.12-rc5
Jun  6 23:45:06 optimator RIP: 0010:[<ffffffff8016794a>] <ffffffff8016794a>{pte_alloc_map+170}
Jun  6 23:45:06 optimator RSP: 0000:ffff81012014bdb8  EFLAGS: 00010293
Jun  6 23:45:06 optimator RAX: ffffffff7fffffff RBX: 00002aab117a9498 RCX: 0000000000000018
Jun  6 23:45:06 optimator RDX: ffff810107df5000 RSI: 0000000000000000 RDI: ffff81000000e6c0
Jun  6 23:45:06 optimator RBP: ffff81012c30c458 R08: ffff81000000e000 R09: 0000000000000000
Jun  6 23:45:06 optimator R10: 00000000000c168b R11: 0000000000000000 R12: 0000000000000000
Jun  6 23:45:06 optimator R13: ffff81013e897b40 R14: ffff81013e897bb0 R15: ffff81012c30c458
Jun  6 23:45:06 optimator FS:  00000000403bc960(0063) GS:ffffffff805c2ec0(0000) knlGS:0000000000000000
Jun  6 23:45:06 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  6 23:45:06 optimator CR2: 00000000000025b0 CR3: 000000011c620000 CR4: 00000000000006e0
Jun  6 23:45:06 optimator Process java (pid: 8607, threadinfo ffff81012014a000, task ffff81013f4cd030)
Jun  6 23:45:06 optimator Stack: ffff81011c6202a8 00002aab117a9498 ffff81011ffbc7c8 ffff81013e897b40
Jun  6 23:45:06 optimator 0000000000000001 ffffffff8016a545 ffff81013e897b94 ffff81013e897bb0
Jun  6 23:45:06 optimator ffffffff80585bc0 ffffffff80585bc0
Jun  6 23:45:06 optimator Call Trace:<ffffffff8016a545>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  6 23:45:06 optimator <ffffffff80130a70>{default_wake_function+0} <ffffffff8010f565>{error_exit+0}
Jun  6 23:45:06 optimator
Jun  6 23:45:06 optimator
Jun  6 23:45:06 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  6 23:45:06 optimator RIP <ffffffff8016794a>{pte_alloc_map+170} RSP <ffff81012014bdb8>
Jun  6 23:45:06 optimator CR2: 00000000000025b0


=========================================================================================================================================

un  7 00:15:54 optimator Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  7 00:15:54 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 00:15:54 optimator PGD 13c83f067 PUD 13d26b067 PMD 0
Jun  7 00:15:54 optimator Oops: 0000 [1] PREEMPT SMP
Jun  7 00:15:54 optimator CPU 1
Jun  7 00:15:54 optimator Modules linked in: nvidia smsc47b397 i2c_sensor i2c_isa i2c_core
Jun  7 00:15:54 optimator Pid: 11612, comm: X Tainted: P      2.6.12-rc6
Jun  7 00:15:54 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 00:15:54 optimator RSP: 0000:ffff81013ae99db8  EFLAGS: 00013293
Jun  7 00:15:54 optimator RAX: ffffffff7fffffff RBX: 0000000004400000 RCX: 0000000000000018
Jun  7 00:15:54 optimator RDX: ffff810107d4a000 RSI: 0000000000000000 RDI: ffff81000000e740
Jun  7 00:15:54 optimator RBP: ffff81013d26b110 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 00:15:54 optimator R10: 00000000000c1660 R11: 0000000000000000 R12: 0000000000000000
Jun  7 00:15:54 optimator R13: ffff81013f440940 R14: ffff81013f4409b0 R15: ffff81013d26b110
Jun  7 00:15:54 optimator FS:  00002aaaab287e60(0000) GS:ffffffff805c26c0(0000) knlGS:0000000000000000
Jun  7 00:15:54 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jun  7 00:15:54 optimator CR2: 00000000000025b0 CR3: 0000000131725000 CR4: 00000000000006e0
Jun  7 00:15:54 optimator Process X (pid: 11612, threadinfo ffff81013ae98000, task ffff81013f0062f0)
Jun  7 00:15:54 optimator Stack: ffff810131725000 0000000004400000 ffff81013ea1f280 ffff81013f440940
Jun  7 00:15:54 optimator 0000000000000001 ffffffff8016a575 0000000000000c80 ffff81013f4409b0
Jun  7 00:15:54 optimator 0000000000000000 ffffffff80141f8e
Jun  7 00:15:54 optimator Call Trace:<ffffffff8016a575>{handle_mm_fault+293} <ffffffff80141f8e>{get_signal_to_deliver+1422}
Jun  7 00:15:54 optimator <ffffffff801213e9>{do_page_fault+1081} <ffffffff8010f565>{error_exit+0}
Jun  7 00:15:54 optimator <ffffffff8010e959>{sys_rt_sigreturn+553} <ffffffff8010e9e1>{sys_rt_sigreturn+689}
Jun  7 00:15:54 optimator <ffffffff8010f565>{error_exit+0}
Jun  7 00:15:54 optimator
Jun  7 00:15:54 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  7 00:15:54 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff81013ae99db8>
Jun  7 00:15:54 optimator CR2: 00000000000025b0
Jun  7 00:16:06 optimator sshd: warning: /etc/hosts.allow, line 1: missing ":" separator
Jun  7 00:16:09 optimator sshd[12005]: Accepted keyboard-interactive/pam for martin from 192.168.1.101 port 35319 ssh2
Jun  7 00:16:09 optimator sshd[12001]: Accepted keyboard-interactive/pam for martin from 192.168.1.101 port 35319 ssh2
Jun  7 00:16:09 optimator sshd(pam_unix)[12007]: session opened for user martin by (uid=0)
Jun  7 00:16:18 optimator su(pam_unix)[12015]: session opened for user root by martin(uid=1000)
Jun  7 00:17:54 optimator <1>Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  7 00:17:54 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 00:17:54 optimator PGD 1181c6067 PUD 13d4f5067 PMD 0
Jun  7 00:17:54 optimator Oops: 0000 [2] PREEMPT SMP
Jun  7 00:17:54 optimator CPU 1
Jun  7 00:17:54 optimator Modules linked in: nvidia smsc47b397 i2c_sensor i2c_isa i2c_core
Jun  7 00:17:54 optimator Pid: 12026, comm: emerge Tainted: P      2.6.12-rc6
Jun  7 00:17:54 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 00:17:54 optimator RSP: 0018:ffff81012211fd18  EFLAGS: 00010293
Jun  7 00:17:54 optimator RAX: ffffffff7fffffff RBX: 00002aaaaba00000 RCX: 0000000000000018
Jun  7 00:17:54 optimator RDX: ffff810107d4b000 RSI: 0000000000000000 RDI: ffff81000000e740
Jun  7 00:17:54 optimator RBP: ffff8101289a2ae8 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 00:17:54 optimator R10: 00000000000e6723 R11: 0000000000000000 R12: 0000000000000000
Jun  7 00:17:54 optimator R13: ffff81013ef00040 R14: ffff81013ef000b0 R15: 00002aaaabc00000
Jun  7 00:17:54 optimator FS:  00002aaaab8afb00(0000) GS:ffffffff805c26c0(0000) knlGS:0000000000000000
Jun  7 00:17:54 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  7 00:17:54 optimator CR2: 00000000000025b0 CR3: 000000010d17c000 CR4: 00000000000006e0
Jun  7 00:17:54 optimator Process emerge (pid: 12026, threadinfo ffff81012211e000, task ffff81013fde6910)
Jun  7 00:17:54 optimator Stack: 00002aaaaba00000 ffff81012bd89000 00002aaaaba00000 ffff81013ceaa000
Jun  7 00:17:54 optimator 0000000000000a8d ffffffff80167eb5 ffff81013f4620b8 ffff81013f4620b0
Jun  7 00:17:54 optimator ffff81013ef000b8 00002aaaabd42fff
Jun  7 00:17:54 optimator Call Trace:<ffffffff80167eb5>{copy_page_range+805} <ffffffff801331ac>{copy_mm+812}
Jun  7 00:17:54 optimator <ffffffff80134171>{copy_process+2561} <ffffffff80134913>{do_fork+227}
Jun  7 00:17:54 optimator <ffffffff80251731>{__up_write+49} <ffffffff8010eb36>{system_call+126}
Jun  7 00:17:54 optimator <ffffffff8010eea7>{ptregscall_common+103}
Jun  7 00:17:54 optimator
Jun  7 00:17:54 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  7 00:17:54 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff81012211fd18>
Jun  7 00:17:54 optimator CR2: 00000000000025b0
====================================================================================================================================================
Jun  7 01:17:21 optimator Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  7 01:17:21 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 01:17:21 optimator PGD 136dac067 PUD 136dad067 PMD 0
Jun  7 01:17:21 optimator Oops: 0000 [1] PREEMPT SMP
Jun  7 01:17:21 optimator CPU 1
Jun  7 01:17:21 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  7 01:17:21 optimator Pid: 6635, comm: kdesktop Tainted: P      2.6.12-rc6
Jun  7 01:17:21 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 01:17:21 optimator RSP: 0000:ffff810136ee3db8  EFLAGS: 00010293
Jun  7 01:17:21 optimator RAX: ffffffff7fffffff RBX: 00002aaab0c00000 RCX: 0000000000000018
Jun  7 01:17:21 optimator RDX: ffff810107d12000 RSI: 0000000000000000 RDI: ffff81000000e740
Jun  7 01:17:21 optimator RBP: ffff810136db1c30 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 01:17:21 optimator R10: 00000000000c16ad R11: 0000000000000000 R12: 0000000000000000
Jun  7 01:17:21 optimator R13: ffff81013ed00940 R14: ffff81013ed009b0 R15: ffff810136db1c30
Jun  7 01:17:21 optimator FS:  00002aaaaeb90020(0000) GS:ffffffff805c26c0(0000) knlGS:0000000000000000
Jun  7 01:17:21 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  7 01:17:21 optimator CR2: 00000000000025b0 CR3: 0000000136dab000 CR4: 00000000000006e0
Jun  7 01:17:21 optimator Process kdesktop (pid: 6635, threadinfo ffff810136ee2000, task ffff81013bdc2df0)
Jun  7 01:17:21 optimator Stack: ffff810136dab2a8 00002aaab0c00000 ffff810121834150 ffff81013ed00940
Jun  7 01:17:21 optimator 0000000000000001 ffffffff8016a575 0000000000000000 ffff81013ed009b0
Jun  7 01:17:21 optimator ffff81013bdc2df0 ffff81013e9c5d31
Jun  7 01:17:21 optimator Call Trace:<ffffffff8016a575>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  7 01:17:21 optimator <ffffffff803d93cf>{thread_return+154} <ffffffff8010f565>{error_exit+0}
Jun  7 01:17:21 optimator
Jun  7 01:17:21 optimator
Jun  7 01:17:21 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  7 01:17:21 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff810136ee3db8>
Jun  7 01:17:21 optimator CR2: 00000000000025b0
Jun  7 01:17:49 optimator <1>Unable to handle kernel paging request at 00000000000025b0 RIP:
Jun  7 01:17:49 optimator <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 01:17:49 optimator PGD 1221c4067 PUD 0
Jun  7 01:17:49 optimator Oops: 0000 [2] PREEMPT SMP
Jun  7 01:17:49 optimator CPU 1
Jun  7 01:17:49 optimator Modules linked in: smsc47b397 i2c_sensor i2c_isa i2c_core nvidia
Jun  7 01:17:49 optimator Pid: 28278, comm: java Tainted: P      2.6.12-rc6
Jun  7 01:17:49 optimator RIP: 0010:[<ffffffff8016797a>] <ffffffff8016797a>{pte_alloc_map+170}
Jun  7 01:17:49 optimator RSP: 0000:ffff8101218b3db8  EFLAGS: 00010293
Jun  7 01:17:49 optimator RAX: ffffffff7fffffff RBX: 00002aaba3800000 RCX: 0000000000000018
Jun  7 01:17:49 optimator RDX: ffff810107d42000 RSI: 0000000000000000 RDI: ffff81000000e740
Jun  7 01:17:49 optimator RBP: ffff8101227238e0 R08: ffff81000000e000 R09: 0000000000000000
Jun  7 01:17:49 optimator R10: 00000000000c1978 R11: 0000000000000000 R12: 0000000000000000
Jun  7 01:17:49 optimator R13: ffff81013e0096c0 R14: ffff81013e009730 R15: ffff8101227238e0
Jun  7 01:17:49 optimator FS:  00000000403bc960(0063) GS:ffffffff805c26c0(0000) knlGS:0000000000000000
Jun  7 01:17:49 optimator CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jun  7 01:17:49 optimator CR2: 00000000000025b0 CR3: 0000000121066000 CR4: 00000000000006e0
Jun  7 01:17:49 optimator Process java (pid: 28278, threadinfo ffff8101218b2000, task ffff81013e4c8710)
Jun  7 01:17:49 optimator Stack: ffff8101210662a8 00002aaba3800000 ffff81012cfef098 ffff81013e0096c0
Jun  7 01:17:49 optimator 0000000000000001 ffffffff8016a575 ffff81013e009714 ffff81013e009730
Jun  7 01:17:49 optimator ffffffff80584ba8 ffffffff80584ba8
Jun  7 01:17:49 optimator Call Trace:<ffffffff8016a575>{handle_mm_fault+293} <ffffffff801213e9>{do_page_fault+1081}
Jun  7 01:17:49 optimator <ffffffff803d9335>{thread_return+0} <ffffffff803d938d>{thread_return+88}
Jun  7 01:17:49 optimator <ffffffff80130a70>{default_wake_function+0} <ffffffff8010f565>{error_exit+0}
Jun  7 01:17:49 optimator
Jun  7 01:17:49 optimator
Jun  7 01:17:49 optimator Code: 48 8b 8e b0 25 00 00 76 0d b8 00 00 00 80 eb 10 66 66 90 66
Jun  7 01:17:49 optimator RIP <ffffffff8016797a>{pte_alloc_map+170} RSP <ffff8101218b3db8>
Jun  7 01:17:49 optimator CR2: 00000000000025b0







--Boundary-00=_JpUpCEzogqkVgLz--
