Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129076AbQKPV3Z>; Thu, 16 Nov 2000 16:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130522AbQKPV3Q>; Thu, 16 Nov 2000 16:29:16 -0500
Received: from ALyon-201-1-3-226.abo.wanadoo.fr ([193.253.188.226]:35588 "EHLO
	kaboum.unstable.org") by vger.kernel.org with ESMTP
	id <S129076AbQKPV3D>; Thu, 16 Nov 2000 16:29:03 -0500
Message-Id: <200011162058.eAGKwmg05992@kaboum.unstable.org>
Subject: PROBLEM: Bad PCI detection of a sound card
From: Frederic LESPEZ <frederic.lespez@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 16 Nov 2000 19:58:47 -0100
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please bear with me, it's my first bug report and my first post to this
list.
Bear with my english too.

[1.] One line summary of the problem:
Bad PCI detection of a sound card     

[2.] Full description of the problem/report:
I think the problem is due to a bad PCI detection but i let you judge.
Here is a description of the problem :
I'm under X (Xfree 4.0.1).
I switch to a VT (virtual terminal).
I load my sound module (modprobe emu10k1).
Dmesg says :
Creative EMU10K1 PCI Audio Driver, version 0.7, 19:07:50 Nov 15 2000
PCI: Enabling device 00:0a.0 (0000 -> 0001)
PCI: Setting latency timer of device 00:0a.0 to 64
emu10k1: EMU10K1 rev 8 model 0x8040 found, IO at 0xb400-0xb41f, IRQ 5
I try to play a sound (play some.wav). It works.
I switch to X. In a xterm, i try to play a sound. The "Play" command
hangs...
I switch back to a VT.
I unload sound modules (rmmod emu10k1 soundcore).
I reload them.
Dmesg says:
Creative EMU10K1 PCI Audio Driver, version 0.7, 19:07:50 Nov 15 2000
emu10k1: EMU10K1 rev 8 model 0x8040 found, IO at 0xb400-0xb41f, IRQ 5
"Play" command works in the VT but not under X (same as before).
Now i unload sound modules.
I reload them under X.
Dmesg says:
Creative EMU10K1 PCI Audio Driver, version 0.7, 19:07:50 Nov 15 2000
PCI: Enabling device 00:0a.0 (0000 -> 0001)
emu10k1: EMU10K1 rev 8 model 0x8040 found, IO at 0xb400-0xb41f, IRQ 5
Now "Play" command works under X and in the VT.

In brief : To be able to have sound working properly, i must load sound
modules
under X *and* load them in a VT. Order is not important, i can do:
load from console/unload/load under X
or
load under X/unload/load in a VT
it gives the same.

Other observations:
If i load sound modules *only* in a VT, play a lengthy sound and switch
to 
X while sound is playing, everything locks (I must use MagicSysKey to
reboot), 
but nothing appears in logs.
With kernel 2.2 (Debian 2.2.17, Mandrake 7.2 2.2.17 or 2.2.18pre21
compiled by 
myself), i cannot load module under X (device or ressource is busy) but
i can 
load modules and play sounds in a VT (even if X is running). 

[3.] Keywords (i.e., modules, networking, kernel):
Sound PCI
[4.] Kernel version (from /proc/version):
2.4.0-test11pre5 Compiled by myself
cat /proc/version
Linux version 2.4.0-test11 (root@kaboum) (gcc version 2.95.2 20000220
(Debian GNU/Linux)) #1 Wed Nov 15 18:54:48 CET 2000
[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
[6.] A small shell script or example program which triggers the
     problem (if possible)
[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Linux kaboum 2.4.0-test11 #1 Wed Nov 15 18:54:48 CET 2000 i686 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79.1
Binutils               2.10.91
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Procps                 2.0.6
Mount                  2.10p
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0i
Modules Loaded         emu10k1 soundcore parport_pc lp parport serial sg
3c59x ppp_deflate ppp_generic slhc unix

[7.2.] Processor information (from /proc/cpuinfo):processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 0
cpu MHz		: 300.000687
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
features	: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat
pse36 mmx fxsr
bogomips	: 599.65

[7.3.] Module information (from /proc/modules):
emu10k1                42816   0
soundcore               3888   4 [emu10k1]
parport_pc             13360   1 (autoclean)
lp                      4496   0 (autoclean)
parport                14880   1 (autoclean) [parport_pc lp]
serial                 41104   0 (autoclean)
sg                     21056   0 (unused)
3c59x                  22160   1
ppp_deflate            39168   0 (unused)
ppp_generic            13024   0 [ppp_deflate]
slhc                    4560   0 [ppp_generic]
unix                   14320 112 (autoclean)
[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)
/proc/ioports
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
0378-037a : parport0
03c0-03df : vga+
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
b000-b007 : Creative Labs SB Live!
b400-b41f : Creative Labs SB Live! EMU10000
  b400-b41f : EMU10K1
b800-b87f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  b800-b87f : eth0
d000-d0ff : Adaptec AHA-2940U2/W / 7890
  d000-d0fe : aic7xxx
d400-d41f : Intel Corporation 82371AB PIIX4 USB
d800-d80f : Intel Corporation 82371AB PIIX4 IDE
e400-e43f : Intel Corporation 82371AB PIIX4 ACPI
e800-e81f : Intel Corporation 82371AB PIIX4 ACPI

/proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cd7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffcfff : System RAM
  00100000-001f791f : Kernel code
  001f7920-00206df7 : Kernel data
07ffd000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
dc000000-dc0fffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD
Decoder
dc800000-dc80007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
dd000000-dd000fff : Adaptec AHA-2940U2/W / 7890
dd800000-dedfffff : PCI Bus #01
  dd800000-ddffffff : Matrox Graphics, Inc. MGA G200 AGP
  de000000-de003fff : Matrox Graphics, Inc. MGA G200 AGP
def00000-dfffffff : PCI Bus #01
  df000000-dfffffff : Matrox Graphics, Inc. MGA G200 AGP
e0000000-e7ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)
Notice the output for 00:0a.0 device : "VGA compatible unclassified
device" for a sound card !

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000dfff
	Memory behind bridge: dd800000-dedfffff
	Prefetchable memory behind bridge: def00000-dfffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W / 7890
	Subsystem: Adaptec 2940U2W SCSI Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (9750ns min, 6250ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	BIST result: 00
	Region 0: I/O ports at d000 [size=256]
	Region 1: Memory at dd000000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
(rev 64)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [size=128]
	Region 1: Memory at dc800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 VGA compatible unclassified device: Creative Labs SB Live!
EMU10000 (rev 08)
	Subsystem: Creative Labs CT4760 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: I/O ports at b000 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood
Plus DVD Decoder (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 01) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. MGA-G200 AGP
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at df000000 (32-bit, prefetchable) [size=16M]
	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at dd800000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at deff0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x2

[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DDRS-34560D      Rev: DC1B
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: YAMAHA   Model: CRW8424S         Rev: 1.0j
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-ROM CD-532S   Rev: 3.0A
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
Motherboard : ASUS P2B-S BIOS 1012
SoundCard : SB Live! Platinum


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
