Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUETAT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUETAT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 20:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264813AbUETAT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 20:19:58 -0400
Received: from ws3.netA.ort.spb.ru ([195.70.200.211]:51123 "EHLO
	gate-n.ort.spb.ru") by vger.kernel.org with ESMTP id S264704AbUETATA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 20:19:00 -0400
Date: Thu, 20 May 2004 04:00:14 +0400 (MSD)
From: Andrew Shirrayev <andrews@gate.ort.spb.ru>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: SMP kernel freeze on e1000,ipx,ncp complex
Message-ID: <Pine.LNX.4.33.0405200357150.28012-100000@gate.ort.spb.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score-Gate: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. SMP kernel freeze on e1000+ipx+ncp complex
2. see 6.
   Problem on Dual P4 Xeon 2.4GHz with or w/o HT.
   with two on-board e1000 NIC.
   On 8139too NIC problem not found.

3. e1000, ipx, ncpfs, smp
4. Linux version 2.4.26smp.1.1 (root@gate-n) (gcc version 3.3.3 (Debian
   20040401)) #1 SMP Mon May 17 12:20:12 MSD 2004
5. --

6. In start-up scripts add runing /bin/bash,
   after mount all local FS and reboot.
   After bash prompt:

#disconnect LAN cable from e1000
#loading e1000.o for eth0&eth1 (dual e1000 on-board)
ip link set eth0 up
#configure ipx 222 - any random number (network don't connect)
ipx_interface add -p eth0 802.2 222

# Try ncpmount two times server, user and mount point
# not important. Error message of userspace program ignore...
#
ncpmount -S serv -U user -n /mnt
# don't wait, running
ncpmount -S serv -U user -n /mnt

#insert cable to eth0 port:
#Get message from kernel
"e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex"
And stop working... Only <reset> work.

W/o inserting cable kernel freeze by command
ip link set eth0 down


7.
7.1
Linux gate-n 2.4.26smp.1.1 #1 SMP Mon May 17 12:20:12 MSD 2004 i686 GNU/Linux

Gnu C                  3.3.3
Gnu make               3.80
binutils               2.14.90.0.7
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.35
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         ncpfs ipx e1000 lvm-mod dm-mod unix

7.2

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2400.206
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4784.12

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2400.206
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 4797.23

7.3

ppp_deflate             3512   1 (autoclean)
zlib_deflate           18744   0 (autoclean) [ppp_deflate]
zlib_inflate           18660   0 (autoclean) [ppp_deflate]
bsd_comp                4376   0 (autoclean)
ppp_async               8096   1 (autoclean)
ppp_generic            18952   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    5248   0 (autoclean) [ppp_generic]
af_packet              10856   1 (autoclean)
rtc                     7720   0 (autoclean)
nls_koi8-r              3836   6 (autoclean)
ncpfs                  39292   3 (autoclean)
ipx                    22116  10 (autoclean)
e1000                  69156   2 (autoclean)
8139too                15144   1 (autoclean)
mii                     2560   0 (autoclean) [8139too]
lvm-mod                59776   0 (unused)
dm-mod                 30152   5
unix                   17324  65 (autoclean)

7.4

cat /proc/ioports
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
0cf8-0cff : PCI conf1
b800-b8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  b800-b8ff : 8139too
c000-c007 : US Robotics/3Com 56K FaxModem Model 5610
  c000-c007 : serial(auto)
c400-c407 : US Robotics/3Com 56K FaxModem Model 5610 (#2)
  c400-c407 : serial(auto)
c800-c83f : Intel Corp. 82540EM Gigabit Ethernet Controller
  c800-c83f : e1000
d000-d03f : Intel Corp. 82540EM Gigabit Ethernet Controller (#2)
  d000-d03f : e1000
d400-d4ff : Adaptec AIC-7902 U320
d800-d8ff : Adaptec AIC-7902 U320
e000-e0ff : Adaptec AIC-7902 U320 (#2)
e400-e4ff : Adaptec AIC-7902 U320 (#2)
e800-e8ff : ATI Technologies Inc Rage XL
ffa0-ffaf : ServerWorks CSB6 RAID/IDE Controller

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000d0dff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-0027b663 : Kernel code
  0027b664-00301a3f : Kernel data
fd000000-fdffffff : ATI Technologies Inc Rage XL
feb80000-feb9ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  feb80000-feb9ffff : e1000
feba0000-febbffff : Intel Corp. 82540EM Gigabit Ethernet Controller (#2)
  feba0000-febbffff : e1000
febfa000-febfbfff : Adaptec AIC-7902 U320
  febfa000-febfafff : aic79xx
febfc000-febfdfff : Adaptec AIC-7902 U320 (#2)
  febfc000-febfcfff : aic79xx
febfec00-febfecff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  febfec00-febfecff : 8139too
febff000-febfffff : ATI Technologies Inc Rage XL
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

cat /proc/interrupts
           CPU0       CPU1
  0:     484892          0    IO-APIC-edge  timer
  1:          3          0    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          5          0    IO-APIC-edge  serial
  8:          1          0    IO-APIC-edge  rtc
 12:         20          0    IO-APIC-edge  PS/2 Mouse
 20:     657182          0   IO-APIC-level  eth0
 22:      98745          0   IO-APIC-level  serial
 24:     203903          0   IO-APIC-level  serial
 26:       2404          0   IO-APIC-level  eth1
 28:       2404          0   IO-APIC-level  eth2
 30:      50928          0   IO-APIC-level  aic79xx
 31:         30          0   IO-APIC-level  aic79xx
NMI:          0          0
LOC:     484854     484853
ERR:          0
MIS:          0

7.5
0000:00:00.0 Host bridge: ServerWorks GCNB-LE Host Bridge (rev 32)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:00.1 Host bridge: ServerWorks GCNB-LE Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

0000:00:05.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Edimax Computer Co.: Unknown device 9503
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 20
	Region 0: I/O ports at b800 [size=256]
	Region 1: Memory at febfec00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:06.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: 5610 56K FaxModem: Unknown device baba
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 22
	Region 0: I/O ports at c000 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0000:00:07.0 Serial controller: 5610 56K FaxModem 56K FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: 5610 56K FaxModem: Unknown device baba
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 24
	Region 0: I/O ports at c400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

0000:00:08.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at feb80000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at c800 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:00:09.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 004e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 26
	Region 0: Memory at feba0000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [e4] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=2, DMOST=0, DMCRS=1, RSCEM-
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
		Address: 0000000000000000  Data: 0000

0000:00:0a.0 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
	Subsystem: Adaptec: Unknown device 005f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 30
	Region 0: I/O ports at d800 [disabled] [size=256]
	Region 1: Memory at febfa000 (64-bit, non-prefetchable) [size=8K]
	Region 3: I/O ports at d400 [disabled] [size=256]
	Expansion ROM at fea80000 [disabled] [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=4
		Status: Bus=255 Dev=31 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=4, DMCRS=1, RSCEM-

0000:00:0a.1 SCSI storage controller: Adaptec AIC-7902 U320 (rev 03)
	Subsystem: Adaptec: Unknown device 005f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (10000ns min, 6250ns max), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin B routed to IRQ 31
	Region 0: I/O ports at e400 [disabled] [size=256]
	Region 1: Memory at febfc000 (64-bit, non-prefetchable) [size=8K]
	Region 3: I/O ports at e000 [disabled] [size=256]
	Expansion ROM at feb00000 [disabled] [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [a0] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
		Address: 0000000000000000  Data: 0000
	Capabilities: [94] PCI-X non-bridge device.
		Command: DPERE- ERO+ RBC=0 OST=4
		Status: Bus=255 Dev=31 Func=1 64bit+ 133MHz+ SCD- USC-, DC=simple, DMMRBC=0, DMOST=4, DMCRS=1, RSCEM-

0000:00:0b.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size: 0x10 (64 bytes)
	Interrupt: pin A routed to IRQ 29
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at e800 [size=256]
	Region 2: Memory at febff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at febc0000 [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0f.0 Host bridge: ServerWorks CSB6 South Bridge (rev a0)
	Subsystem: Super Micro Computer Inc: Unknown device 4155
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

0000:00:0f.1 IDE interface: ServerWorks CSB6 RAID/IDE Controller (rev a0) (prog-if 82 [Master PriP])
	Subsystem: TEC Corporation: Unknown device 0212
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size: 0x08 (32 bytes)
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at ffa0 [size=16]

0000:00:0f.3 ISA bridge: ServerWorks GCLE-2 Host Bridge
	Subsystem: Super Micro Computer Inc: Unknown device 4155
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

7.6 SCSI information not need. Yes?

X.
 e1000 very long time (>1 sec) detect cable on-line, and
if ncpmount try connect to server before "NIC Link is Up"
server hanged...


