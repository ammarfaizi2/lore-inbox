Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSHTSas>; Tue, 20 Aug 2002 14:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317024AbSHTSar>; Tue, 20 Aug 2002 14:30:47 -0400
Received: from murphys.services.quay.plus.net ([212.159.14.225]:21909 "HELO
	murphys.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S316997AbSHTSam>; Tue, 20 Aug 2002 14:30:42 -0400
Message-Id: <5.1.1.6.1.20020820113309.00aa7370@mail.force9.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Tue, 20 Aug 2002 12:17:44 +0100
To: linux-kernel@vger.kernel.org
From: Darkhorse WinterWolf <dh@winterwolf.co.uk>
Subject: PROBLEM: Devfs root breaks with some devices in 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll follow the suggested reporting format as closely as possible to give 
as much information as possible in a common format:

[2.] Full description of the problem:
When passing "root=" parameters to the kernel, certain device strings 
referring to devfs devices that used to work in 2.4.18 now no longer work 
in 2.4.19. For example, using "root=/dev/discs/disc2/part6" worked as 
expected in 2.4.18, and allowed me to move my discs around on the 
controllers so long as I maintained the order. However, using the same 
command line in 2.4.19 fails completely.

[3.] Keywords:
devfs, root, kernel, boot parameters, init

[4.] Kernel version:
Linux version 2.4.19 (dh@scrat) (gcc version 2.95.4 20011002 (Debian 
prerelease)) #1 Mon Aug 19 22:25:45 BST 2002

[5.] Output (no oops, but I can give the appropriate panic):
This is the panic on trying to boot the kernel with the parameter 
"root=/dev/discs/disc2/part6". It appears just after the NET4 
initialisation message in my configuration:
 >>>
VFS: Cannot open root device "discs/disc2/part6" or 00:0d
Please append the correct "root=" boot option
Kernel Panic: VFS: Unable to mount root fs on 00:0d
<<<

[6.] Example:
Try using "root=/dev/discs/disc<d>/part<p>" with <d> and <p> set 
appropriately for your configulation. This should be easily reproducable. 
Using something like "root=/dev/hdg6" works fine, however.

[7.] Environment
[7.1] Software
Most of this is probably irrelavent at this stage, but I'll include it in 
case anyone finds it useful:
 >>>
Linux scrat 2.4.19 #1 Mon Aug 19 22:25:45 BST 2002 i686 unknown

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
Modules Loaded         smbfs snd-seq-midi snd-seq-oss snd-pcm-oss 
snd-mixer-oss mousedev snd-emu10k1-synth snd-emux-synth snd-seq-midi-emul 
snd-seq-virmidi snd-seq-midi-event snd-seq snd-ens1371 snd-emu10k1 snd-pcm 
snd-timer snd-hwdep snd-util-mem snd-rawmidi snd-seq-device snd-ac97-codec 
snd soundcore hid irtty irda 3c59x nls_iso8859-1 nls_cp437 vfat fat floppy 
serial md lvm-mod eeprom lm75 lm80 i2c-proc i2c-viapro i2c-core analog 
emu10k1-gp gameport joydev input ipv6
<<<

[7.2.] Processor information:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 1800+
stepping	: 2
cpu MHz		: 1541.242
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3073.63

[7.3.] Module information:
Probably not required at this stage since none will be loaded, but I'll 
include it for completeness:
 >>>
smbfs                  32512   0 (autoclean)
snd-seq-midi            3232   0 (autoclean) (unused)
snd-seq-oss            24608   0 (unused)
snd-pcm-oss            36032   2
snd-mixer-oss           9088   1 (autoclean) [snd-pcm-oss]
mousedev                3904   1
snd-emu10k1-synth       3808   0 (unused)
snd-emux-synth         24224   0 [snd-emu10k1-synth]
snd-seq-midi-emul       4304   0 [snd-emux-synth]
snd-seq-virmidi         2632   0 [snd-emux-synth]
snd-seq-midi-event      2712   0 [snd-seq-midi snd-seq-oss snd-seq-virmidi]
snd-seq                37164   2 [snd-seq-midi snd-seq-oss snd-emux-synth 
snd-seq-midi-emul snd-seq-virmidi snd-seq-midi-event]
snd-ens1371             9792   0
snd-emu10k1            55456   3 [snd-emu10k1-synth]
snd-pcm                47680   0 [snd-pcm-oss snd-ens1371 snd-emu10k1]
snd-timer              10272   0 [snd-seq snd-pcm]
snd-hwdep               3776   0 [snd-emu10k1]
snd-util-mem            1120   0 [snd-emux-synth snd-emu10k1]
snd-rawmidi            12096   0 [snd-seq-midi snd-seq-virmidi snd-ens1371 
snd-emu10k1]
snd-seq-device          4016   0 [snd-seq-midi snd-seq-oss 
snd-emu10k1-synth snd-emux-synth snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         22560   0 [snd-ens1371 snd-emu10k1]
snd                    25064   0 [snd-seq-midi snd-seq-oss snd-pcm-oss 
snd-mixer-oss snd-emux-synth snd-seq-virmidi snd-seq-midi-event snd-seq 
snd-ens1371 snd-emu10k1 snd-pcm snd-timer snd-hwdep snd-util-mem 
snd-rawmidi snd-seq-device snd-ac97-codec]
soundcore               3460  16 [snd]
hid                    13248   0 (unused)
irtty                   5568   2 (autoclean)
irda                   81580   1 (autoclean) [irtty]
3c59x                  25064   1 (autoclean)
nls_iso8859-1           2848   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9468   1 (autoclean)
fat                    29496   0 (autoclean) [vfat]
floppy                 45920   0 (autoclean)
serial                 44128   1 (autoclean)
md                     57344   0 (autoclean)
lvm-mod                61312   0 (unused)
eeprom                  3072   0
lm75                    3232   0
lm80                    5472   0
i2c-proc                6272   0 [eeprom lm75 lm80]
i2c-viapro              3752   0 (unused)
i2c-core               12416   0 [eeprom lm75 lm80 i2c-proc i2c-viapro]
analog                  7520   0 (unused)
emu10k1-gp              1248   0 (unused)
gameport                1356   0 [analog emu10k1-gp]
joydev                  6848   0 (unused)
input                   3232   0 [mousedev hid analog joydev]
ipv6                  124256  -1
<<<

[7.4.] Loaded driver and hardware information
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
02f8-02ff : serial(set)
0376-0376 : ide1
03c0-03df : vga+
   03c0-03df : matrox
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
   5000-5007 : via2-smbus
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
a000-a003 : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller
a400-a40f : VIA Technologies, Inc. Bus Master IDE
   a400-a407 : ide0
   a408-a40f : ide1
a800-a81f : VIA Technologies, Inc. UHCI USB
   a800-a81f : usb-uhci
ac00-ac1f : VIA Technologies, Inc. UHCI USB (#2)
   ac00-ac1f : usb-uhci
c000-c01f : Creative Labs SB Live! EMU10k1
   c000-c01f : EMU10K1
c400-c407 : Creative Labs SB Live! MIDI/Game Port
   c400-c407 : emu10k1-gp
c800-c87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
   c800-c87f : 00:0d.0
cc00-cc3f : Ensoniq 5880 AudioPCI
   cc00-cc3f : Ensoniq AudioPCI
d000-d0ff : Adaptec AHA-7850
d400-d407 : Promise Technology, Inc. PDC20276 IDE
   d400-d407 : ide2
d800-d803 : Promise Technology, Inc. PDC20276 IDE
   d802-d802 : ide2
dc00-dc07 : Promise Technology, Inc. PDC20276 IDE
   dc00-dc07 : ide3
e000-e003 : Promise Technology, Inc. PDC20276 IDE
   e002-e002 : ide3
e400-e40f : Promise Technology, Inc. PDC20276 IDE
   e400-e407 : ide2
   e408-e40f : ide3
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000ca7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-00254ae7 : Kernel code
   00254ae8-002d4d83 : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e3ffffff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
e4000000-e5ffffff : PCI Bus #01
   e4000000-e5ffffff : Matrox Graphics, Inc. MGA G400 AGP
     e4000000-e5ffffff : matroxfb FB
e6000000-e8ffffff : PCI Bus #01
   e6000000-e6003fff : Matrox Graphics, Inc. MGA G400 AGP
     e6000000-e6003fff : matroxfb MMIO
   e7000000-e77fffff : Matrox Graphics, Inc. MGA G400 AGP
ea000000-ea003fff : Promise Technology, Inc. PDC20276 IDE
ea004000-ea004fff : Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System 
Controller
ea005000-ea005fff : Adaptec AHA-7850
   ea005000-ea005fff : aic7xxx
ea006000-ea00607f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ea007000-ea007fff : NEC Corporation USB
   ea007000-ea007fff : usb-ohci
ea008000-ea008fff : NEC Corporation USB (#2)
   ea008000-ea008fff : usb-ohci
ea009000-ea0090ff : NEC Corporation USB 2.0
   ea009000-ea0090ff : ehci-hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] System 
Controller (rev 14)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at ea004000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at a000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP 
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: e6000000-e8ffffff
	Prefetchable memory behind bridge: e4000000-e5ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at a400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 
00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a) (prog-if 
00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ac00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
	Subsystem: Creative Labs: Unknown device 8064
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at c000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0c.1 Input device controller: Creative Labs SB Live! (rev 07)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at c400 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] 
(rev 30)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at c800 [size=128]
	Region 1: Memory at ea006000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00:0e.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 04)
	Subsystem: Giga-byte Technology: Unknown device a000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at cc00 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:0f.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d000 [disabled] [size=256]
	Region 1: Memory at ea005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:10.0 RAID bus controller: Promise Technology, Inc.: Unknown device 5275 
(rev 01) (prog-if 85)
	Subsystem: Giga-byte Technology: Unknown device b001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at d400 [size=8]
	Region 1: I/O ports at d800 [size=4]
	Region 2: I/O ports at dc00 [size=8]
	Region 3: I/O ports at e000 [size=4]
	Region 4: I/O ports at e400 [size=16]
	Region 5: Memory at ea000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at ea007000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (250ns min, 10500ns max), cache line size 08
	Interrupt: pin B routed to IRQ 10
	Region 0: Memory at ea008000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00:11.2 USB Controller: NEC Corporation: Unknown device 00e0 (rev 02) 
(prog-if 20)
	Subsystem: Giga-byte Technology: Unknown device 5004
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8500ns max), cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 0: Memory at ea009000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 
04) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 16Mb SDRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 12
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1

[7.6.] SCSI information
Attached devices:
Host: scsi0 Channel: 00 Id: 04 Lun: 00
   Vendor: YAMAHA   Model: CRW2100S         Rev: 1.0H
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 05 Lun: 00
   Vendor: RICOH    Model: CD-R/RW MP7040S  Rev: 1.20
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
   Vendor: CREATIVE Model: DVD-ROM DVD2240E Rev: 1.7A
   Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
   Vendor: TOSHIBA  Model: DVD-ROM SD-M1102 Rev: 1426
   Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information
In case it's of any use, the /dev/discs/disc2/part6 example used above is 
normally referring to the non-devfs device /dev/hdg6, but I prefer the 
/dev/discs/... format because of the ease of moving drives through the 
busses should I need to temporarily add drives to the system.

Looking at the kernel panic, I'd noticed that the "/dev/" part of the 
"root=" parameter had been stripped, so I decided to try 
"root=/dev//dev/discs/disc2/part6", which does work correctly, as the 
kernel strips the first "/dev/" and then proceeds as expected.

I'm assuming the problem lies somewhere in init/do_mounts.c, as this seems 
to be where the mangling and processing of the "root=" parameter takes 
place, but I am unsure as to who is currently maintaining this particular 
section of the kernel, so I have posted here for help.

Currently, circumstances dictate that I cannot gain a cheap, realiable 
Internet connection, so I am unable to subscribe to this list. As such, if 
replies could by CCd to me, it'd be very much appreciated.

Thanks for your time,
-David Headland.

