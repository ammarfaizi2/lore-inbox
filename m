Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSHWHBV>; Fri, 23 Aug 2002 03:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSHWHBV>; Fri, 23 Aug 2002 03:01:21 -0400
Received: from [213.191.86.30] ([213.191.86.30]:64464 "EHLO nox.lemuria.org")
	by vger.kernel.org with ESMTP id <S318252AbSHWHBS>;
	Fri, 23 Aug 2002 03:01:18 -0400
Date: Fri, 23 Aug 2002 09:05:27 +0200
From: Tom <tom@lemuria.org>
To: linux-kernel@vger.kernel.org
Subject: page_alloc bug
Message-ID: <20020823090527.A7715@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-message-flag: Outlook: A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first time reporting a kernel bug, so please tell me if you need any
other details. I'm following the instructions on kernel.org as closely
as I can.


(1) Problem Summary:
console display of "kernel BUG".


(2) Problem:
For about a week now, the machine displays the bug below in the
morning. The machine runs 24/7, and this bug appears to be happening in
the nighttime. Not every day, not reliably, but occasionally.
I have not yet spotted any ill effects, except that I do not know
whether or not this is caused by this bug, the source of it, or
unrelated. Since the bug is in page_alloc, it may be related:
    4 ?        Z      0:12 [kswapd <defunct>]

Note that all the information below (/proc/...) may be from well past
the time of the bug. There is no timestamp or other indication as to
when exactly the bug occured, and the machine kept on running.


(3) Keywords:
page_alloc ?


(4) Kernel version:
Linux version 2.4.19 (root@nox.lemuria.org) (gcc version 2.95.4 20011002 (Debian prerelease)) #2 Thu Aug 8 12:05:11 CEST 2002


(5) Output of oops:
not sure if this is it, but here is what is displayed on the console:
kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c012b96d>] Tainted: P
EFLAGS: 00010282
eax: c1009a38  ebx: c103f20c  ecx: c103f20c  edx: c020657c
esi: 00000000  edi: 00000004  ebp: 00000175  esp: cfaf9da8
ds: 0018 es: 0018 ss: 0018

Code: 0f 0b 5b 00 53 eb 1d c0 89 d8 2b 05 10 26 26 c0 69 c0 a3 8b

I left out the stack trace. I'm not sure if it is important and there's
no way to cut/paste it. if it's important, I will write it down.


(6) not possible


(7) 
tom@nox:/usr/src/linux-2.4.19$ sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux nox.lemuria.org 2.4.19 #2 Thu Aug 8 12:05:11 CEST 2002 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         tun NVdriver ipt_state ipt_LOG ipt_limit ip_conntrack es1371 soundcore ac97_codec

tom@nox:/usr/src/linux-2.4.19$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 1005.036
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
bogomips        : 2005.40

tom@nox:/usr/src/linux-2.4.19$ cat /proc/modules
tun                     3616   1 (autoclean)
NVdriver              942016  10
ipt_state                576  18 (autoclean)
ipt_LOG                 3072   8 (autoclean)
ipt_limit                960   9 (autoclean)
ip_conntrack           13228   1 [ipt_state]
es1371                 26624   0
soundcore               3492   4 [es1371]
ac97_codec              9856   0 [es1371]

tom@nox:/usr/src/linux-2.4.19$ cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
b000-b01f : Intel Corp. 82801BA/BAM USB (Hub #2)
b400-b41f : Intel Corp. 82801BA/BAM USB (Hub #1)
b800-b80f : Intel Corp. 82801BA IDE U100
d000-dfff : PCI Bus #02
  d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    d400-d4ff : 8139too
  d800-d83f : Ensoniq 5880 AudioPCI
    d800-d83f : es1371
e800-e80f : Intel Corp. 82801BA/BAM SMBus

tom@nox:/usr/src/linux-2.4.19$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffeafff : System RAM
  00100000-001d5d60 : Kernel code
  001d5d61-00213cff : Kernel data
0ffeb000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
ed800000-edffffff : PCI Bus #02
  ed800000-ed8000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
    ed800000-ed8000ff : 8139too
ee000000-efefffff : PCI Bus #01
  ee000000-eeffffff : nVidia Corporation NV11 (GeForce2 MX)
eff00000-f7ffffff : PCI Bus #01
  f0000000-f7ffffff : nVidia Corporation NV11 (GeForce2 MX)
f8000000-fbffffff : Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub
ffff0000-ffffffff : reserved

lspci -vvv:
00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller Hub (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8027
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [88] #09 [f104]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp.: Unknown device 1131 (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: ee000000-efefffff
	Prefetchable memory behind bridge: eff00000-f7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: ed800000-edffffff
	Prefetchable memory behind bridge: eff00000-efefffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 02) (prog-if 80 [Master])
	Subsystem: Asustek Computer, Inc.: Unknown device 8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at b800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at b400 [size=32]

00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8027
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at e800 [size=16]

00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B) (rev 02) (prog-if 00 [UHCI])
	Subsystem: Asustek Computer, Inc.: Unknown device 8027
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 9
	Region 4: I/O ports at b000 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev a1) (prog-if 00 [VGA])
	Subsystem: Elsa AG: Unknown device 0c60
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at efff0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=31 SBA- AGP+ 64bit- FW- Rate=<none>

02:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d800 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=256]
	Region 1: Memory at ed800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


(no SCSI)



I hope this is useful. If I left anything important out, please tell me
and I'll be happy to add it.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5
