Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbTE0KdM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 06:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTE0KdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 06:33:12 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:31373 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263206AbTE0Kcq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 06:32:46 -0400
Message-ID: <20030527104652.23033.qmail@operamail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Simon Kofod" <skofod@operamail.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 27 May 2003 11:46:52 +0100
Subject: PROBLEM: Can't mount a SCSI emulated IDE cd-rom
X-Originating-Ip: 80.208.213.46
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I will try to follow the suggested procedure for reporting kernel bugs (http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html).

1) I can't mount a SCSI emulated IDE cd-rom.

2) When trying to mount the cdrom it writes the error:
"mount: wrong fs type, bad option, bad superblock on /dev/sr0, or too many mounted file systems"

then I run dmesg, and it writes a lot of lines with:

"ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 63 0 0 1 0 0 0 ]
]"

The number 63 is changing. It starts with:
ide-scsi: [[ 28 0 0 0 0 10 0 0 1 0 0 0 ]

and stops at 63.

At last dmesg writes:

"ide-scsi: expected 2048 got 4096 limit 2048
Unable to identify CD-ROM format."

(You can see the entire output of dmesg at the end of this mail).

There is no problem with my IDE CD-Writer. Only the IDE CD-ROM is unmountable. By the way, the CD-ROM is able to play audio-cd's.


4)$> cat /proc/version:

"Linux version 2.4.21-rc4 (root@skofod) (gcc version 3.2.3 20030415 (Debian prerelease)) #1 Tue May 27 10:41:45 CEST 2003"

7.1)$> ./ver_linux:

Linux skofod 2.4.21-rc4 #1 Tue May 27 10:41:45 CEST 2003 i686 GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.33
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.8
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         uhci

7.2)$> cat /proc/cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) XP 2100+
stepping	: 2
cpu MHz		: 1739.273
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips	: 3473.40

7.3)$> cat /proc/modules

tuner                  10848   1 (autoclean)
tvaudio                13276   0 (autoclean) (unused)
bttv                   76960   0 (autoclean)
i2c-algo-bit            7528   1 (autoclean) [bttv]
i2c-core               12964   0 (autoclean) [tuner tvaudio bttv i2c-algo-bit]
videodev                6080   2 (autoclean) [bttv]
uhci                   25584   0 (unused)

7.4)$> cat /proc/ioports

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
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
  c000-c0ff : PCI device 1002:4966 (ATI Technologies Inc)
d000-d00f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d000-d007 : ide0
  d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
  d400-d41f : usb-uhci
d800-d81f : VIA Technologies, Inc. USB (#2)
  d800-d81f : usb-uhci
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  dc00-dcff : via82cxxx_audio
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e000-e003 : via82cxxx_audio
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
  e400-e403 : via82cxxx_audio
e800-e87f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  e800-e87f : 00:09.0


   $> cat /proc/iomem 

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0029a4aa : Kernel code
  0029a4ab-0033099f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
e4000000-ebffffff : PCI Bus #01
  e4000000-e7ffffff : PCI device 1002:4966 (ATI Technologies Inc)
  e8000000-ebffffff : PCI device 1002:496e (ATI Technologies Inc)
ec000000-edffffff : PCI Bus #01
  ed000000-ed00ffff : PCI device 1002:4966 (ATI Technologies Inc)
  ed010000-ed01ffff : PCI device 1002:496e (ATI Technologies Inc)
ef000000-ef00007f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ef001000-ef001fff : Brooktree Corporation Bt878 Video Capture
  ef001000-ef001fff : bttv
ef002000-ef002fff : Brooktree Corporation Bt878 Audio Capture
ffff0000-ffffffff : reserved


7.5) $> lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: ec000000-edffffff
	Prefetchable memory behind bridge: e4000000-ebffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 5
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
	Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 9
	Region 0: I/O ports at dc00 [size=256]
	Region 1: I/O ports at e000 [size=4]
	Region 2: I/O ports at e400 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=128]
	Region 1: Memory at ef000000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ef001000 (32-bit, prefetchable) [size=4K]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
	Subsystem: Avermedia Technologies Inc: Unknown device 0002
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at ef002000 (32-bit, prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If [Radeon 9000] (rev 01) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0002
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at ed000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 9000] (Secondary) (rev 01)
	Subsystem: ATI Technologies Inc: Unknown device 0003
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e8000000 (32-bit, prefetchable) [disabled] [size=64M]
	Region 1: Memory at ed010000 (32-bit, non-prefetchable) [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


7.6) $> cat /proc/scsi/scsi

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-ROM SC-148B   Rev: BS10
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: LITE-ON  Model: LTR-48125S       Rev: 1S05
  Type:   CD-ROM                           ANSI SCSI revision: 02


7.7) $> cat /proc/ide/drivers

ide-scsi version 0.93
ide-cdrom version 4.59-ac1
ide-disk version 1.17
ide-default version 0.9.newide


  $> dmesg

ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 10 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 11 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 12 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 13 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 14 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 15 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 16 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 17 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 18 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 19 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 1f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 20 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 21 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 22 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 23 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 24 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 25 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 26 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 27 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 28 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 29 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 2f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 30 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 31 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 32 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 33 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 34 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 35 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 36 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 37 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 38 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 39 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 3f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 40 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 41 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 42 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 43 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 44 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 45 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 46 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 47 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 48 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 49 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 4f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 50 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 51 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 52 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 53 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 54 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 55 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 56 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 57 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 58 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 59 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5a 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5b 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5c 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5d 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5e 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 5f 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 60 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 61 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 62 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
ide-scsi: The scsi wants to send us more data than expected - discarding data
ide-scsi: [[ 28 0 0 0 0 63 0 0 1 0 0 0 ]
]
ide-scsi: expected 2048 got 4096 limit 2048
Unable to identify CD-ROM format.


I hope this can be helpful.
\Simon
-- 
____________________________________________
http://www.operamail.com
Get OperaMail Premium today - USD 29.99/year


Powered by Outblaze
