Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262102AbSI1Qbk>; Sat, 28 Sep 2002 12:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262119AbSI1Qbk>; Sat, 28 Sep 2002 12:31:40 -0400
Received: from www.safe-mail.net ([206.25.186.68]:49824 "EHLO
	www.safe-mail.net") by vger.kernel.org with ESMTP
	id <S262102AbSI1Qbf>; Sat, 28 Sep 2002 12:31:35 -0400
Subject: PROBLEM: 2.4.19, ASUS A7M266-D, USB keyboard and RTC
Date: Sat, 28 Sep 2002 12:36:53 -0400
From: "Luca Salgarelli" <salga@SAFe-mail.net>
To: linux-kernel@vger.kernel.org
X-SMType: Regular
X-SMRef: N1-czndXukU
Message-Id: <N1-czndXukU@SAFe-mail.net>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's the description of a problem I'm having with kernels >= 2.4.19 on my ASUS A7M266-D.

PROBLEM: with RedHat 7.2, on a ASUS A7M266-D, dual Athlon MP1500+, kernel 2.4.19, right at the beginning of rc.sysconfig during boot hwclock reports wrong time. Usually the time that is reported is the nearest 20th minute of the hour.

The problem *does not* occurr if instead of a USB keyboard a PS2 keyboard is attached, OR with kernels <= 2.4.18, OR if a key is pressed right after POST and before GRUB loads its stage1.

Could please someone direct me to the right person to help me debug this? I can't figure out if it is a problem with the USB drivers, the RTC code, or something else.

Here below is the information on my system.

Thanks
Luca

=============================
 salga@gandalf:/usr/src/linux/scripts>sh ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux gandalf 2.4.19 #2 SMP Sat Sep 28 11:52:17 EDT 2002 i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11f
mount                  2.11g
modutils               2.4.13
e2fsprogs              1.26
reiserfsprogs          3.x.0j
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded         sr_mod cmpci soundcore vmnet vmmon NVdriver ipt_limit iptable_mangle ipt_REJECT ipt_REDIRECT ipt_MASQUERADE ipt_LOG ip_nat_ftp iptable_nat ip_conntrack_ftp ipt_state ip_conntrack iptable_filter ip_tables eepro100 ide-scsi ide-cd cdrom mousedev keybdev hid usb-ohci usbcore
==============================
salga@gandalf:/usr/src/linux/scripts>cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1500+
stepping	: 2
cpu MHz		: 1333.405
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2660.76

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(TM) MP 1500+
stepping	: 2
cpu MHz		: 1333.405
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 2660.76
====================================
salga@gandalf:/usr/src/linux/scripts>cat /proc/modules 
sr_mod                 13368   0 (autoclean)
cmpci                  31516   1 (autoclean)
soundcore               4004   4 (autoclean) [cmpci]
vmnet                  18496   3
vmmon                  19188   0 (unused)
NVdriver              821056  14
ipt_limit                992  47 (autoclean)
iptable_mangle          2048   0 (autoclean) (unused)
ipt_REJECT              2752   1
ipt_REDIRECT             704   0 (unused)
ipt_MASQUERADE          1312   1
ipt_LOG                 3424   4
ip_nat_ftp              3136   0 (unused)
iptable_nat            14548   2 [ipt_REDIRECT ipt_MASQUERADE ip_nat_ftp]
ip_conntrack_ftp        3488   0 [ip_nat_ftp]
ipt_state                576  80 (autoclean)
ip_conntrack           15468   3 (autoclean) [ipt_REDIRECT ipt_MASQUERADE ip_nat_ftp iptable_nat ip_conntrack_ftp ipt_state]
iptable_filter          1664   1 (autoclean)
ip_tables              11456  11 [ipt_limit iptable_mangle ipt_REJECT ipt_REDIRECT ipt_MASQUERADE ipt_LOG iptable_nat ipt_state iptable_filter]
eepro100               17936   2
ide-scsi                7776   0
ide-cd                 27072   0
cdrom                  27968   0 [sr_mod ide-cd]
mousedev                4032   1
keybdev                 1632   0 (unused)
hid                    18176   0 (unused)
usb-ohci               18816   0 (unused)
usbcore                58272   1 [hid usb-ohci]
=================================
salga@gandalf:/usr/src/linux/scripts>cat /proc/ioports 
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
0378-037a : parport0
037b-037f : parport0
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
9000-afff : PCI Bus #02
  9000-9fff : PCI Bus #03
    9400-941f : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
      9400-941f : eepro100
    9800-981f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
      9800-981f : eepro100
  a400-a4ff : Adaptec AHA-2940U2/U2W
  a800-a8ff : C-Media Electronics Inc CM8738
    a800-a8ff : cmpci
b000-b00f : Promise Technology, Inc. 20269
  b000-b007 : ide2
  b008-b00f : ide3
b400-b403 : Promise Technology, Inc. 20269
b800-b807 : Promise Technology, Inc. 20269
d000-d003 : Promise Technology, Inc. 20269
  d002-d002 : ide2
d400-d407 : Promise Technology, Inc. 20269
  d400-d407 : ide2
d800-d80f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  d800-d807 : ide0
  d808-d80f : ide1
e800-e803 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
===========================
salga@gandalf:/usr/src/linux/scripts>cat /proc/iomem 
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d27ff : Extension ROM
000d4000-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffebfff : System RAM
  00100000-002670ee : Kernel code
  002670ef-002d3d9f : Kernel data
3ffec000-3ffeefff : ACPI Tables
3ffef000-3fffefff : reserved
3ffff000-3fffffff : ACPI Non-volatile Storage
e0000000-e37fffff : PCI Bus #02
  e0000000-e0ffffff : PCI Bus #03
    e0000000-e00fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
    e0800000-e08fffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  e1000000-e1000fff : Adaptec AHA-2940U2/U2W
    e1000000-e1000fff : aic7xxx
  e1800000-e18000ff : NEC Corporation USB 2.0
  e2000000-e2000fff : NEC Corporation USB (#2)
    e2000000-e2000fff : usb-ohci
  e2800000-e2800fff : NEC Corporation USB
    e2800000-e2800fff : usb-ohci
  e3000000-e3000fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
    e3000000-e3000fff : usb-ohci
e3800000-e3803fff : Promise Technology, Inc. 20269
e4000000-e5efffff : PCI Bus #01
  e4000000-e4ffffff : nVidia Corporation NV15 DDR (GeForce2 GTS)
e5f00000-e7dfffff : PCI Bus #02
  e5f00000-e7cfffff : PCI Bus #03
    e6000000-e6000fff : Intel Corp. 82557/8/9 [Ethernet Pro 100] (#2)
      e6000000-e6000fff : eepro100
    e7000000-e7000fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
      e7000000-e7000fff : eepro100
e7f00000-f77fffff : PCI Bus #01
  e8000000-efffffff : nVidia Corporation NV15 DDR (GeForce2 GTS)
f7800000-f7800fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
f8000000-fbffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved
==========
ROOT@gandalf:~>lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD]: Unknown device 700c (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f7800000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at e800 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 700d (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: e4000000-e5efffff
	Prefetchable memory behind bridge: e7f00000-f77fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD]: Unknown device 7440 (rev 05)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD]: Unknown device 7441 (rev 04) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 7441
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD]: Unknown device 7443 (rev 03)
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:09.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at b800 [size=8]
	Region 3: I/O ports at b400 [size=4]
	Region 4: I/O ports at b000 [size=16]
	Region 5: Memory at e3800000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD]: Unknown device 7448 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=02, subordinate=03, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: e0000000-e37fffff
	Prefetchable memory behind bridge: e5f00000-e7dfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV15 DDR (Geforce2 GTS) (rev a4) (prog-if 00 [VGA])
	Subsystem: CardExpert Technology: Unknown device 0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at e7ff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=15 SBA- AGP+ 64bit- FW- Rate=<none>

02:00.0 USB Controller: Advanced Micro Devices [AMD]: Unknown device 7449 (rev 07) (prog-if 10 [OHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8044
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at e3000000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 8077
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at a800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 18
	Region 0: Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: Unknown device 807d:0035
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 19
	Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) (prog-if 20)
	Subsystem: Unknown device 807d:1043
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 16
	Region 0: Memory at e1800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device a180
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 17
	BIST result: 00
	Region 0: I/O ports at a400 [disabled] [size=256]
	Region 1: Memory at e1000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=02, secondary=03, subordinate=03, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e0000000-e0ffffff
	Prefetchable memory behind bridge: 00000000e5f00000-00000000e7c00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

03:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)	Subsystem: Intel Corporation EtherExpress PRO/100+ Dual Port Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at 9800 [size=32]
	Region 2: Memory at e0800000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

03:05.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)	Subsystem: Intel Corporation EtherExpress PRO/100+ Dual Port Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=4K]
	Region 1: I/O ports at 9400 [size=32]
	Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
==============================

