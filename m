Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSCRUUR>; Mon, 18 Mar 2002 15:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292780AbSCRUUK>; Mon, 18 Mar 2002 15:20:10 -0500
Received: from web13503.mail.yahoo.com ([216.136.175.82]:41480 "HELO
	web13503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292730AbSCRUT5>; Mon, 18 Mar 2002 15:19:57 -0500
Message-ID: <20020318201957.67592.qmail@web13503.mail.yahoo.com>
Date: Mon, 18 Mar 2002 12:19:57 -0800 (PST)
From: Dual Mobius <dualmobius@yahoo.com>
Subject: Intel PII machine hangs with MCE enabled in linux-2.4.19-pre3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intel PII machine hangs with MCE enabled in
linux-2.4.19-pre3

Under linux 2.4.19-pre3, my Intel Pentium II system
hangs with the "machine check" turned on
(CONFIG_X86_MCE=y).  The same machine booted correctly
under 2.4.19-pre2 with MCE enabled.

I get the following output from the kernel when
booting, and then it freezes:

Linux version 2.4.19-pre3 (root@stooges) (gcc version
2.95.4 20011002 (Debian prerelease)) #1 Mon Mar 18
11:55:10 MST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00
(usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000
(reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000
(reserved)
 BIOS-e820: 0000000000100000 - 000000000fffd000
(usable)
 BIOS-e820: 000000000fffd000 - 000000000ffff000 (ACPI
data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI
NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000
(reserved)
On node 0 totalpages: 65533
zone(0): 4096 pages.
zone(1): 61437 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: root=/dev/hda7 ro
Initializing CPU#0
Detected 451.032 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 897.84 BogoMIPS
Memory: 256656k/262132k available (1385k kernel code,
5088k reserved, 417k data, 212k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6,
262144 bytes)
Inode-cache hash table entries: 16384 (order: 5,
131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768
bytes)
Buffer-cache hash table entries: 16384 (order: 4,
65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144
bytes)
CPU: Before vendor init, caps: 0183fbff 00000000
00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.


The kernel halts and freezes at that point.

If I specify the "nomce" option when booting the
kernel, it boots correctly.


Here is the relevant system info that might be useful:

$ cat /proc/version 
Linux version 2.4.19-pre3 (root@stooges) (gcc version
2.95.4 20011002
(Debian prerelease)) #1 Mon Mar 18 11:55:10 MST 2002


$ sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have
an old version.
Compare to the current minimal requirements in
Documentation/Changes.
 
Linux stooges 2.4.19-pre3 #1 Mon Mar 18 11:55:10 MST
2002 i686 unknown
 
Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.13
e2fsprogs              1.27
reiserfsprogs          3.x.1a
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         radeon snd-pcm-oss
snd-mixer-oss snd-sbawe snd-sb16-dsp snd-pcm
snd-opl3-lib snd-timer snd-sb16-csp snd-sb-common
snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device
snd soundcore ipt_MASQUERADE iptable_nat ipt_state
ip_conntrack ipt_limit ipt_REJECT ipt_ULOG
iptable_filter ip_tables ov518_decomp ov511 videodev
analog bsd_comp ppp_deflate ppp_async ppp_generic slhc
tulip tun ns558 gameport isa-pnp joydev mousedev
keybdev evdev hid input usb-uhci usbcore sg sr_mod
ide-cd cdrom loop agpgart


$ cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 2
cpu MHz		: 451.032
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep
mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 897.84



$ cat /proc/modules 
radeon                 86488   1
snd-pcm-oss            34656   0 (unused)
snd-mixer-oss           8576   1 [snd-pcm-oss]
snd-sbawe              16064   1
snd-sb16-dsp            5312   0 [snd-sbawe]
snd-pcm                46912   0 [snd-pcm-oss
snd-sb16-dsp]
snd-opl3-lib            5088   0 [snd-sbawe]
snd-timer               9152   0 [snd-pcm
snd-opl3-lib]
snd-sb16-csp           15072   0 [snd-sbawe]
snd-sb-common           5992   0 [snd-sbawe
snd-sb16-dsp snd-sb16-csp]
snd-hwdep               3520   0 [snd-opl3-lib
snd-sb16-csp]
snd-mpu401-uart         2592   0 [snd-sbawe
snd-sb16-dsp]
snd-rawmidi            11648   0 [snd-mpu401-uart]
snd-seq-device          3920   0 [snd-sbawe
snd-opl3-lib snd-rawmidi]
snd                    24136   0 [snd-pcm-oss
snd-mixer-oss snd-sbawe snd-sb16-dsp snd-pcm
snd-opl3-lib snd-timer snd-sb16-csp snd-sb-common
snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3556   6 [snd]
ipt_MASQUERADE          1184   1 (autoclean)
iptable_nat            12756   1 (autoclean)
[ipt_MASQUERADE]
ipt_state                608   6 (autoclean)
ip_conntrack           12748   2 (autoclean)
[ipt_MASQUERADE iptable_nat ipt_state]
ipt_limit                960   9 (autoclean)
ipt_REJECT              2784   7 (autoclean)
ipt_ULOG                3392  25 (autoclean)
iptable_filter          1728   1 (autoclean)
ip_tables              10304   9 [ipt_MASQUERADE
iptable_nat ipt_state ipt_limit ipt_REJECT ipt_ULOG
iptable_filter]
ov518_decomp           15564   0 (unused)
ov511                  65632   1 [ov518_decomp]
videodev                4576   1 [ov511]
analog                  7392   0 (unused)
bsd_comp                3968   0
ppp_deflate            39040   0
ppp_async               6240   1
ppp_generic            16108   3 [bsd_comp ppp_deflate
ppp_async]
slhc                    4352   1 [ppp_generic]
tulip                  36416   1
tun                     3424   0 (unused)
ns558                   2092   0 (unused)
gameport                1500   0 [analog ns558]
isa-pnp                27752   0 [snd-sbawe ns558]
joydev                  5696   0 (unused)
mousedev                3808   1
keybdev                 1664   0 (unused)
evdev                   3904   0 (unused)
hid                    17696   0 (unused)
input                   3328   0 [analog joydev
mousedev keybdev evdev hid]
usb-uhci               21028   0 (unused)
usbcore                55552   1 [ov511 hid usb-uhci]
sg                     23812   0 (unused)
sr_mod                 11512   0 (unused)
ide-cd                 26560   0
cdrom                  27136   0 [sr_mod ide-cd]
loop                    8144   0 (unused)
agpgart                29120   3



$ cat /proc/ioports 
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
0200-0207 : ns558-pnp
0213-0213 : isapnp read
0220-022f : SoundBlaster
02f8-02ff : serial(set)
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0620-0623 : Emu8000-1
0a20-0a23 : Emu8000-2
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
0e20-0e23 : Emu8000-3
a400-a407 : US Robotics/3Com 56K FaxModem Model 5610
  a400-a407 : serial(auto)
a800-a8ff : Macronix, Inc. [MXIC] MX987x5
  a800-a8ff : tulip
b000-b0ff : Adaptec AHA-2940U2/W / 7890
  b000-b0ff : aic7xxx
b400-b41f : Intel Corp. 82371AB PIIX4 USB
  b400-b41f : usb-uhci
b800-b80f : Intel Corp. 82371AB PIIX4 IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc Radeon VE QY
e400-e43f : Intel Corp. 82371AB PIIX4 ACPI
e800-e81f : Intel Corp. 82371AB PIIX4 ACPI



$ cat /proc/iomem   
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d4fff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffcfff : System RAM
  00100000-0025a684 : Kernel code
  0025a685-002c2b1f : Kernel data
0fffd000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
d6000000-d60000ff : Macronix, Inc. [MXIC] MX987x5
  d6000000-d60000ff : tulip
d6800000-d6800fff : Adaptec AHA-2940U2/W / 7890
  d6800000-d6800fff : aic7xxx
d7000000-d7dfffff : PCI Bus #01
  d7000000-d700ffff : ATI Technologies Inc Radeon VE
QY
d7f00000-e3ffffff : PCI Bus #01
  d8000000-dfffffff : ATI Technologies Inc Radeon VE
QY
e4000000-e7ffffff : Intel Corp. 440BX/ZX - 82443BX/ZX
Host bridge
ffff0000-ffffffff : reserved



# lspci -vvv
00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX
Host bridge (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e4000000 (32-bit, prefetchable)
[size=64M]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX
AGP bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01,
sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: d7000000-d7dfffff
	Prefetchable memory behind bridge: d7f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset-
FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev
02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE
(rev 01) (prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB
(rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin D routed to IRQ 9
	Region 4: I/O ports at b400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev
02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9

00:06.0 SCSI storage controller: Adaptec AHA-2940U2/W
/ 7890
	Subsystem: Adaptec 2940U2W SCSI Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (9750ns min, 6250ns max), cache line size
08
	Interrupt: pin A routed to IRQ 9
	BIST result: 00
	Region 0: I/O ports at b000 [disabled] [size=256]
	Region 1: Memory at d6800000 (64-bit,
non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Macronix, Inc. [MXIC]
MX987x5 (rev 25)
	Subsystem: Unknown device 2078:0540
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min, 14000ns max), cache line
size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a800 [size=256]
	Region 1: Memory at d6000000 (32-bit,
non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Serial controller: US Robotics/3Com 56K
FaxModem Model 5610 (rev 01) (prog-if 02 [16550])
	Subsystem: US Robotics/3Com USR 56k Internal FAX
Modem (Model 2977)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

01:00.0 VGA compatible controller: ATI Technologies
Inc Radeon VE QY (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 013a
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr-
DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable)
[size=128M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at d7000000 (32-bit,
non-prefetchable) [size=64K]
	Expansion ROM at d7fe0000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0c
  Type:   CD-ROM                           ANSI SCSI
revision: 02


__________________________________________________
Do You Yahoo!?
Yahoo! Sports - live college hoops coverage
http://sports.yahoo.com/
