Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318255AbSGRQ03>; Thu, 18 Jul 2002 12:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSGRQ03>; Thu, 18 Jul 2002 12:26:29 -0400
Received: from web01.mailshell.com ([209.157.66.231]:59312 "HELO mailshell.com")
	by vger.kernel.org with SMTP id <S318255AbSGRQ0Y>;
	Thu, 18 Jul 2002 12:26:24 -0400
Message-ID: <1027009764.3d36ece430d75@www.mailshell.com>
Date: Thu, 18 Jul 2002 09:29:24 -0700
X-Priority: 3 (Normal)
From: <linux@davidtrott.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PPP_DEFLATE and CONFIG_ZLIB_FS_INFLATE cannot both be compiled directly into the kernel.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Mailshell.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

CONFIG_PPP_DEFLATE and CONFIG_ZLIB_FS_INFLATE cannot both be compiled
directly into the kernel.

[2.] Full description of the problem/report:

There are at least two (almost identical) instances of the file zlib.c
fs/jffs2/zlib.c
drivers/net/zlib.c

The jffs2 version actually creates a .o file but the net version is
#include'd into ppp_deflate.c

Because the code is compiled twice multiple definitions result:

drivers/net/net.o: In function `deflate':
drivers/net/net.o(.text+0x4abc): multiple definition of `deflate'
fs/fs.o(.text+0x2ee5c): first defined here
drivers/net/net.o: In function `_tr_flush_block':
drivers/net/net.o(.text+0x703c): multiple definition of `_tr_flush_block'
fs/fs.o(.text+0x313dc): first defined here
drivers/net/net.o: In function `zlibVersion':
drivers/net/net.o(.text+0xa8d0): multiple definition of `zlibVersion'
fs/fs.o(.text+0x34c70): first defined here
drivers/net/net.o: In function `inflate_trees_free':
drivers/net/net.o(.text+0x9aec): multiple definition of `inflate_trees_free'
fs/fs.o(.text+0x33e8c): first defined here
drivers/net/net.o: In function `inflate':
drivers/net/net.o(.text+0x7b98): multiple definition of `inflate'
fs/fs.o(.text+0x31f38): first defined here
...
... Other similar errors cut
...
make: *** [vmlinux] Error 1


[3.] Keywords (i.e., modules, networking, kernel):
CONFIG_PPP_DEFLATE, CONFIG_ZLIB_FS_INFLATE

[4.] Kernel version (from /proc/version):

Linux version 2.4.19-rc2 (root@delta) (gcc version 2.95.3 20010315
(release)) #1 Wed Jul 17 21:37:46 PDT 2002

[5.] Output of Oops.. message (if applicable) with symbolic information resolved 
N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

Attached .config file

[7.] Environment

As I can't use the sample .config file for a pratical application here is
the environment on my build machine.

[7.1.] Software (add the output of the ver_linux script here)

Linux delta 2.4.19-rc2 #1 Wed Jul 17 21:37:46 PDT 2002 i686 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.19
util-linux             2.11f
mount                  2.11b
modutils               2.4.6
e2fsprogs              1.27
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.26
PPP                    2.4.1
Linux C Library        2.2.3
Dynamic linker (ldd)   2.2.3
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         iptable_filter ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack ip_tables apm ppp_deflate ppp_async ppp_generic slhc rtc nls_iso8859-1 nls_cp437 vfat fat


[7.2.] Processor information (from /proc/cpuinfo):

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 2
model name	: AMD Athlon(tm) Processor
stepping	: 1
cpu MHz		: 800.047
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1595.80


[7.3.] Module information (from /proc/modules):

iptable_filter          1760   0 (autoclean) (unused)
ip_nat_ftp              2944   0 (unused)
iptable_nat            12880   1 [ip_nat_ftp]
ip_conntrack_ftp        3184   0 (unused)
ip_conntrack           13392   2 [ip_nat_ftp iptable_nat ip_conntrack_ftp]
ip_tables              10560   4 [iptable_filter iptable_nat]
apm                     9440   1
ppp_deflate            40160   0 (unused)
ppp_async               6544   0 (unused)
ppp_generic            15744   0 [ppp_deflate ppp_async]
slhc                    4624   0 [ppp_generic]
rtc                     6016   0 (autoclean)
nls_iso8859-1           2880   1 (autoclean)
nls_cp437               4384   1 (autoclean)
vfat                    9456   1 (autoclean)
fat                    29504   0 (autoclean) [vfat]


[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
7800-7807 : Creative Labs SB Live! MIDI/Game Port
8000-801f : Creative Labs SB Live! EMU10k1
8400-8407 : Lucent Microelectronics Venus Modem (V90, 56KFlex)
8800-88ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
9000-90ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
  9000-9007 : serial(auto)
9400-947f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  9400-947f : 00:09.0
b000-b01f : VIA Technologies, Inc. UHCI USB (#2)
  b000-b01f : usb-uhci
b400-b41f : VIA Technologies, Inc. UHCI USB
  b400-b41f : usb-uhci
b800-b80f : VIA Technologies, Inc. Bus Master IDE
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 3Dfx Interactive, Inc. Voodoo 3
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]


00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0fffbfff : System RAM
  00100000-00260f95 : Kernel code
  00260f96-002ccaf7 : Kernel data
0fffc000-0fffefff : ACPI Tables
0ffff000-0fffffff : ACPI Non-volatile Storage
dc800000-dc8000ff : Lucent Microelectronics Venus Modem (V90, 56KFlex)
dd000000-dd0fffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder
dd800000-dd80007f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
de000000-e1dfffff : PCI Bus #01
  de000000-dfffffff : 3Dfx Interactive, Inc. Voodoo 3
e1f00000-e3ffffff : PCI Bus #01
  e2000000-e3ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e7ffffff : VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x]
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev 02)
	Subsystem: Asustek Computer, Inc.: Unknown device 8023
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: de000000-e1dfffff
	Prefetchable memory behind bridge: e1f00000-e3ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 22)
	Subsystem: Asustek Computer, Inc.: Unknown device 8023
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 7
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at 9400 [size=128]
	Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus DVD Decoder (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at dd000000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Communication controller: Lucent Microelectronics Venus Modem (V90, 56KFlex)
	Subsystem: Action Tec Electronics Inc: Unknown device 0500
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 (63000ns min, 3500ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at dc800000 (32-bit, non-prefetchable) [size=256]
	Region 1: I/O ports at 9000 [size=256]
	Region 2: I/O ports at 8800 [size=256]
	Region 3: I/O ports at 8400 [size=8]
	Capabilities: [f8] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 05)
	Subsystem: Creative Labs CT4620 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 7
	Region 0: I/O ports at 8000 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.1 Input device controller: Creative Labs SB Live! (rev 05)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 7800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d800 [size=256]
	Expansion ROM at e1ff0000 [disabled] [size=64K]
	Capabilities: [54] AGP version 1.0
		Status: RQ=7 SBA+ 64bit+ FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



[7.6.] SCSI information (from /proc/scsi/scsi)

Attached devices: none


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

/proc/tty/driver/serial
serinfo:1.0 driver:5.05c revision:2001-07-08
0: uart:16550A port:3F8 irq:4 baud:9600 tx:0 rx:0
1: uart:16550A port:2F8 irq:3 baud:9600 tx:0 rx:0
4: uart:16550A port:9000 irq:5 baud:9600 tx:0 rx:0 CTS|DSR

/proc/tty/drivers
serial               /dev/cua        5  64-127 serial:callout
serial               /dev/ttyS       4  64-127 serial
pty_slave            /dev/pts      136   0-255 pty:slave
pty_master           /dev/ptm      128   0-255 pty:master
pty_slave            /dev/ttyp       3   0-255 pty:slave
pty_master           /dev/pty        2   0-255 pty:master
/dev/vc/0            /dev/vc/0       4       0 system:vtmaster
/dev/ptmx            /dev/ptmx       5       2 system
/dev/console         /dev/console    5       1 system:console
/dev/tty             /dev/tty        5       0 system:/dev/tty
unknown              /dev/vc/%d      4    1-63 console



[X.] Other notes, patches, fixes, workarounds:

None
