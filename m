Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314283AbSEIUD6>; Thu, 9 May 2002 16:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314285AbSEIUD5>; Thu, 9 May 2002 16:03:57 -0400
Received: from [62.98.138.11] ([62.98.138.11]:640 "EHLO linux.local")
	by vger.kernel.org with ESMTP id <S314283AbSEIUDz>;
	Thu, 9 May 2002 16:03:55 -0400
Message-Id: <200205092005.g49K57301283@linux.local>
Content-Type: text/plain; charset=US-ASCII
From: Gianni <jumpyj@libero.it>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: maybe bug in timer with kernel 2.4.18-ac3
Date: Thu, 9 May 2002 22:03:12 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I report execution of scripts/ver_linux of the kernel source directory:

(root@linux:/usr/src/linux/scripts >sh ver_linux)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux linux 2.4.18-ac3 #1 Sat Mar 9 19:27:26 CET 2002 i686 unknown

Gnu C                  2.95.2
Gnu make               3.79.1
binutils               2.10.0.33
util-linux             2.11n
mount                  2.11n
modutils               2.4.14
e2fsprogs              1.27-WIP
pcmcia-cs              3.1.22
PPP                    2.4.1b2
Linux C Library        x    1 root     root      1382179 dic 18 16:32 
/lib/libc.so.6
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-pcm-plugin snd-mixer-oss ipv6 
snd-seq-midi snd-seq-midi-event snd-seq snd-card-emu10k1 snd-emu10k1 
snd-emux-mem snd-pcm snd-timer snd-rawmidi snd-ac97-codec snd-mixer 
snd-seq-device snd soundcore mousedev hid input usb-ohci ipt_limit ipt_state 
iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables usbcore 
aic7xxx_old

(Well, there's an error because I used gcc 2.95.3: I compiled it form sources 
with gcc-2.95.2).

The problem is with CMOS clock.

I have this problem: the kernel doesn't match the right clock time. I have to 
set my CMOS clock with 2 hours first to view the right clock with: 'date', 
but if I use date -u it response exactly. How ever when I shutdown machine 
and I get power on after a bit, for example 15 minutes, I view the clock is 
10 minutes back. A time I shuted-down machine I get power on and the clock 
was very mistakes. About 12 hours back.

********** less /proc/version gives:
Linux version 2.4.18-ac3 (root@linux) (gcc version 2.95.3 20010315 (release)) 
#1

********** less /proc/cpuinfo gives:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 4
cpu MHz         : 1410.312
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
cmov
bogomips        : 2811.49

********** less /proc/modules gives:
snd-pcm-oss            18540   1 (autoclean)
snd-pcm-plugin         14864   0 (autoclean) [snd-pcm-oss]
snd-mixer-oss           4924   1 (autoclean) [snd-pcm-oss]
ipv6                  126100  -1 (autoclean)
snd-seq-midi            3136   0 (unused)
snd-seq-midi-event      3040   0 [snd-seq-midi]
snd-seq                41488   0 [snd-seq-midi snd-seq-midi-event]
snd-card-emu10k1        2208   2
snd-emu10k1            21216   0 [snd-card-emu10k1]
snd-emux-mem            1216   0 [snd-emu10k1]
snd-pcm                30720   0 [snd-pcm-oss snd-pcm-plugin snd-emu10k1]
snd-timer               8980   0 [snd-seq snd-pcm]
snd-rawmidi            10208   0 [snd-seq-midi snd-emu10k1]
snd-ac97-codec         23528   0 [snd-emu10k1]
snd-mixer              27524   0 [snd-mixer-oss snd-emu10k1 snd-ac97-codec]
snd-seq-device          3788   0 [snd-seq-midi snd-seq snd-card-emu10k1 
snd-rawmidi]
snd                    33056   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss 
snd-seq-midi snd-seq-midi-event snd-seq snd-card-emu10k1 snd-emu10k1 
snd-emux-mem snd-pcm snd-timer snd-rawmidi snd-ac97-codec snd-mixer 
snd-seq-device]
soundcore               3588   5 [snd]
mousedev                3864   0 (unused)
hid                    12904   0 (unused)
input                   3392   0 [mousedev hid]
usb-ohci               17896   0 (unused)
ipt_limit                952   1 (autoclean)
ipt_state                600   2 (autoclean)
iptable_mangle          2132   0 (autoclean) (unused)
iptable_nat            12952   0 (autoclean) (unused)
ip_conntrack           13240   2 (autoclean) [ipt_state iptable_nat]
iptable_filter          1704   1 (autoclean)
ip_tables              10616   7 [ipt_limit ipt_state iptable_mangle 
iptable_nat iptable_filter]
usbcore                48896   1 [hid usb-ohci]
aic7xxx_old           109632   0 (unused)

********** less /proc/ioports gives:
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
a000-a0ff : Adaptec AHA-7850
  a000-a0fe : aic7xxx
a400-a407 : Creative Labs SB Live!
a800-a81f : Creative Labs SB Live! EMU10k1
  a800-a81f : EMU10K1
b400-b40f : Acer Laboratories Inc. [ALi] M5229 IDE
  b400-b407 : ide0
  b408-b40f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Radeon VE QY
e400-e43f : Acer Laboratories Inc. [ALi] M7101 PMU
e800-e81f : Acer Laboratories Inc. [ALi] M7101 PMU

********** less /proc/iomem gives:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-0025fbf0 : Kernel code
  0025fbf1-002cc93f : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
e4800000-e4800fff : Adaptec AHA-7850
e5800000-e5800fff : Acer Laboratories Inc. [ALi] M5237 USB (#2)
  e5800000-e5800fff : usb-ohci
e6800000-e6800fff : Acer Laboratories Inc. [ALi] M5237 USB
  e6800000-e6800fff : usb-ohci
e7000000-e7efffff : PCI Bus #01
  e7000000-e700ffff : ATI Technologies Inc Radeon VE QY
    e7000000-e700ffff : radeonfb
e7f00000-efffffff : PCI Bus #01
  e8000000-efffffff : ATI Technologies Inc Radeon VE QY
    e8000000-efffffff : radeonfb
f0000000-f7ffffff : PCI device 10b9:1647 (Acer Laboratories Inc. [ALi])
ffff0000-ffffffff : reserved

********** llspci -vvv (as root) gives:
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 
04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [b0] AGP version 2.0
		Status: RQ=27 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [a4] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247 (prog-if 00 [Normal 
decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e7000000-e7efffff
	Prefetchable memory behind bridge: e7f00000-efffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4) 
(prog-if fa)
	Subsystem: Asustek Computer, Inc.: Unknown device 8053
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at b400 [size=16]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) 
(prog-if 10 [OHCI])
	Subsystem: Acer Laboratories Inc. [ALi] M5237 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge 
[Aladdin IV]
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1533 Aladdin IV ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [a0] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 07)
	Subsystem: Creative Labs: Unknown device 8061
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a800 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 5159 
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 013a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at e7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=27 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

********** less /proc/scsi/scsi gives:
Attached devices: none

********** less /proc/interrupts gives:
           CPU0
  0:     194878          XT-PIC  timer
  1:       4571          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:          0          XT-PIC  usb-ohci
  9:          0          XT-PIC  usb-ohci
 10:      28029          XT-PIC  EMU10K1
 11:         14          XT-PIC  aic7xxx
 12:      71541          XT-PIC  PS/2 Mouse
 14:      64626          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
LOC:     194848
ERR:        540
MIS:          0

My system is : ASUS A7A266, Athlon 1,4 GHz, 256 MByte DDR SDRAM, PCI Sound 
CARD Sound Blaster Live Player 5.1, Graphic CARD: ATI RADEON VE 32 MByte DDR.
Can you reply and tell me if is the wrong time on my SuSE Linux 7.1 is a 
kernel bug or if it's something else? I thank you for all your work and I 
tell everyone develops Linux kernel: "go on".
Gianni, a Linux User
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82tYAnT2ev4/bQKARAla2AJ9O7+e9EX5mPLqt2VwaAB9fNYQPZQCeNicA
FD188iIf759GA8NCGe2tfTo=
=a4Ao
-----END PGP SIGNATURE-----
