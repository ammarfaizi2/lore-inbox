Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTI3PFv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbTI3PFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:05:51 -0400
Received: from rat-3.inet.it ([213.92.5.93]:58854 "EHLO rat-3.inet.it")
	by vger.kernel.org with ESMTP id S261571AbTI3PFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:05:31 -0400
From: Paolo Ornati <ornati@despammed.com>
To: linux-usb-devel@lists.sourceforge.net
Subject: USB-Problems with uhci_hcd + V4L + stv680 driver
Date: Tue, 30 Sep 2003 17:03:53 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZtZe/PMT2KssYHH"
Message-Id: <200309301703.53359.ornati@despammed.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ZtZe/PMT2KssYHH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

	[1.] One line summary of the problem:
Problems with USB (uhci_hcd) + V4L + stv680 driver

	 [2.] Full description of the problem/report:
The problem is quite simple: when I use  UHCI_HDC + V4L + stv680
drivers and the program "Camorama" to see the video "produced" by my
Web-Cam (OREGON Scientific DS-3868) all seem to work fine...
but after some time (that is variable) the video stops on a frame!
Then If I unplug and then replug my Web-Cam I get an Oops!

Kernel config attached.
Any idea?

(PLEASE CC me, I'm not subscribed to the USB-DEVEL mailing list)

	[4.] Kernel version (from /proc/version):
Linux version 2.6.0-test6 (javaman@paolo) (gcc version 3.2.3) #7 Sun Sep 28 12:03:56 CEST 2003

      [5.] Output of Oops:
Unable to handle kernel NULL pointer dereference at virtual address 00000005
 printing eip:
cf92f2d4
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<cf92f2d4>]    Not tainted
EFLAGS: 00010292
EIP is at stv_set_config+0x24/0xd0 [stv680]
eax: 00000000   ebx: 00000001   ecx: 00000000   edx: c1347800
esi: c27d1200   edi: 00000000   ebp: c5b81b40   esp: c5bc5e08
ds: 007b   es: 007b   ss: 0068
Process camorama (pid: 686, threadinfo=c5bc4000 task=c0c68040)
Stack: c4cedb80 00000002 000003e8 c4cedb80 c4cedb80 c27d1200 c5b8426c cf92f40a 
       c27d1200 00000001 00000000 00000000 c4cedb80 00000002 c27d1200 c670e7c0 
       c5b8426c cf931756 c27d1200 c0326e50 c670e8c0 c670e7c0 c7fe02c0 c014ecf3 
Call Trace:
 [<cf92f40a>] stv_stop_video+0x8a/0x2c0 [stv680]
 [<cf931756>] stv_close+0x36/0xd0 [stv680]
 [<c014ecf3>] __fput+0xb3/0xd0
 [<c014d399>] filp_close+0x59/0x90
 [<c011c497>] put_files_struct+0x57/0xc0
 [<c011d11f>] do_exit+0x15f/0x340
 [<c011d3db>] do_group_exit+0x7b/0xb0
 [<c01263a1>] get_signal_to_deliver+0x1f1/0x380
 [<c010914e>] do_signal+0xce/0x100
 [<c0160e1a>] do_poll+0x6a/0xd0
 [<cf931d7f>] stv680_ioctl+0x2f/0x40 [stv680]
 [<cf9317f0>] stv680_do_ioctl+0x0/0x560 [stv680]
 [<c015fb7d>] sys_ioctl+0xbd/0x280
 [<c01091d6>] do_notify_resume+0x56/0x58
 [<c01093b2>] work_notifysig+0x13/0x15

Code: 0f b6 40 05 39 c3 74 46 8b 0d ac 55 93 cf 85 c9 75 1a ba ff 

	 [7.] Environment
      [7.1.] Software (add the output of the ver_linux script here)
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.33
jfsutils               1.1.1
reiserfsprogs          3.6.4
xfsprogs               2.3.5
quota-tools            3.08.
PPP                    2.4.1
isdn4k-utils           3.2p1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.3
Procps                 2.0.13
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         stv680 uhci_hcd

	[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 1
cpu MHz         : 756.826
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1490.94

	[7.3.] Module information (from /proc/modules):
stv680 27264 - - Live 0xcf92f000
uhci_hcd 30216 - - Live 0xcb91b000

	 [7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports:
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
6800-683f : 0000:00:11.0
7000-7003 : 0000:00:11.0
7400-7407 : 0000:00:11.0
7800-7803 : 0000:00:11.0
8000-8007 : 0000:00:11.0
8400-8407 : 0000:00:0d.0
8800-880f : 0000:00:0b.1
9000-907f : 0000:00:0b.0
  9000-907f : FM801
9400-94ff : 0000:00:09.0
b000-b01f : 0000:00:04.3
  b000-b01f : uhci-hcd
b400-b41f : 0000:00:04.2
  b400-b41f : uhci-hcd
b800-b80f : 0000:00:04.1
  b800-b807 : ide0
  b808-b80f : ide1
d000-dfff : PCI Bus #01
  d800-d8ff : 0000:01:00.0
    d800-d8ff : tdfx iobase
e200-e27f : 0000:00:04.4
e400-e4ff : 0000:00:04.4
e800-e80f : 0000:00:04.4

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07febfff : System RAM
  00100000-002df106 : Kernel code
  002df107-0038e0ff : Kernel data
07fec000-07feefff : ACPI Tables
07fef000-07ffefff : reserved
07fff000-07ffffff : ACPI Non-volatile Storage
de800000-de81ffff : 0000:00:11.0
df000000-df0000ff : 0000:00:0d.0
df800000-df8000ff : 0000:00:09.0
e0000000-e3dfffff : PCI Bus #01
  e0000000-e1ffffff : 0000:01:00.0
    e0000000-e1ffffff : tdfx regbase
e3f00000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : 0000:01:00.0
    e4000000-e5ffffff : tdfx smem
e6000000-e7ffffff : 0000:00:00.0
ffff0000-ffffffff : reserved

		  [7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e0000000-e3dfffff
	Prefetchable memory behind bridge: e3f00000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
	Subsystem: Asustek Computer, Inc. A7V Mainboard
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9400 [size=256]
	Region 1: Memory at df800000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Fortemedia, Inc Xwave QS3000A [FM801] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 9000 [size=128]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Fortemedia, Inc Xwave QS3000A [FM801 game port] (rev b2)
	Subsystem: Fortemedia, Inc: Unknown device 1319
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 10000ns max)
	Region 0: I/O ports at 8800 [size=16]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1+,D2-,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Network controller: Cologne Chip Designs GmbH ISDN network controller [HFC-PCI] (rev 02)
	Subsystem: Cologne Chip Designs GmbH ISDN Board
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (4000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 8400 [size=8]
	Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
	Subsystem: Promise Technology, Inc. Ultra100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 8000 [size=8]
	Region 1: I/O ports at 7800 [size=4]
	Region 2: I/O ports at 7400 [size=8]
	Region 3: I/O ports at 7000 [size=4]
	Region 4: I/O ports at 6800 [size=64]
	Region 5: Memory at de800000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [58] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if 00 [VGA])
	Subsystem: Creative Labs 3D Blaster Banshee VE
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at d800 [size=256]
	Expansion ROM at e3ff0000 [disabled] [size=64K]
	Capabilities: [54] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit+ FW- AGP3- Rate=x1
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

-- 
	Paolo Ornati
	Linux v2.4.22

--Boundary-00=_ZtZe/PMT2KssYHH
Content-Type: application/x-gzip;
  name="config-2.6.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="config-2.6.gz"

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

--Boundary-00=_ZtZe/PMT2KssYHH--

