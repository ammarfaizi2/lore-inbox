Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbTJLBpp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 21:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTJLBpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 21:45:45 -0400
Received: from [143.233.176.22] ([143.233.176.22]:14549 "EHLO oslab.teipir.gr")
	by vger.kernel.org with ESMTP id S262359AbTJLBpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 21:45:04 -0400
Message-ID: <000901c39062$802a5ac0$0200000a@euler>
From: "Papadomitsos Panagiotis" <panos@oslab.teipir.gr>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: syslog outputs kernel errors when pppd is transfering data and system/connection performance is low
Date: Sun, 12 Oct 2003 04:45:16 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0006_01C3907B.A1C78310"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1209
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0006_01C3907B.A1C78310
Content-Type: text/plain;
	charset="iso-8859-7"
Content-Transfer-Encoding: 7bit

Whenever I connect to the internet via dial-up (ISDN USB TA) I get the
following syslog output (continuesely) whenever there is ppp I/O activity :

Badness in local_bh_enable at kernel/softirq.c:121 Call Trace:
[<c01220ec>] local_bh_enable+0x8c/0x90
[<c02a4852>] ppp_asynctty_receive+0x62/0xb0
[<c026df27>] flush_to_ldisc+0xa7/0x120
[<c02fadcf>] acm_read_bulk+0xbf/0x140
[<c02eb6f9>] usb_hcd_giveback_urb+0x29/0x50
[<c02f9a1c>] dl_done_list+0x11c/0x130
[<c02fa41f>] ohci_irq+0xef/0x160
[<c02eb756>] usb_hcd_irq+0x36/0x60
[<c010b62a>] handle_IRQ_event+0x3a/0x70
[<c010b9b7>] do_IRQ+0x97/0x140
[<c0106ef0>] default_idle+0x0/0x30
[<c0105000>] _stext+0x0/0x60
[<c0109ce4>] common_interrupt+0x18/0x20
[<c0106ef0>] default_idle+0x0/0x30
[<c0105000>] _stext+0x0/0x60
[<c0106f14>] default_idle+0x24/0x30
[<c0106f90>] cpu_idle+0x30/0x40
[<c04c66f5>] start_kernel+0x155/0x170
[<c04c6460>] unknown_bootoption+0x0/0x100

The system becomes very slow (almost unresponsive) and the connection speed
is very low (instead of 7.5 kb/s I am getting aroun 2-3 kb/s). I tried to
disable acpi but the results where the same. pppd worked perfectly with my
USB-ISDN-TA on 2.4.22-ac4 (but that doesn't say much anyway). If I close the
pppd the system returns to a stable state and the syslog no more outputs
kernel errors. I include my kernel configuration file as an attachment (the
message is long enough; we don't need more lines ;-) ).

Installed software (maybe relative to the problem): pppd 2.4.1, acpid 1.0.2,
devfsd 1.3.25

/proc/version: Linux version 2.6.0-test7 (root@euler) (gcc version 3.2.3) #1
Sat Oct 11 17:39:26 EEST 2003
#Note : I had the same problem with 2.6.0-test6

part of my dmesg (the only thing that seems as an error):

hub 2-0:1.0: new USB device on port 1, assigned address 2
drivers/usb/class/cdc-acm.c: ttyACM0: USB ACM device
drivers/usb/core/usb.c: acm driver booted <NULL> off interface dfafa740
acm: probe of 2-1:1.1 failed with error -5

/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2087.865
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
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4120.57

/proc/modules:

nvidia 1706156 0 - Live 0xe0b26000
nls_utf8 1984 2 - Live 0xe091f000

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
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5000-5007 : nForce2 SMBus
5500-5507 : nForce2 SMBus
c000-cfff : PCI Bus #01
  c000-c03f : 0000:01:09.0
    c000-c01f : EMU10K1
  c400-c407 : 0000:01:09.1
d000-dfff : PCI Bus #02
  d000-d07f : 0000:02:01.0
    d000-d07f : 0000:02:01.0
e000-e01f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000d4000-000d47ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-003d7204 : Kernel code
  003d7205-004c353f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d7ffffff : 0000:00:00.0
d8000000-dfffffff : PCI Bus #03
  d8000000-dfffffff : 0000:03:00.0
e0000000-e1ffffff : PCI Bus #02
  e1000000-e100007f : 0000:02:01.0
e2000000-e3ffffff : PCI Bus #03
  e2000000-e2ffffff : 0000:03:00.0
e4000000-e4ffffff : PCI Bus #01
  e4000000-e4003fff : 0000:01:09.2
  e4004000-e40047ff : 0000:01:09.2
    e4004000-e40047ff : ohci1394
e5000000-e5000fff : 0000:00:02.1
  e5000000-e5000fff : ohci-hcd
e5001000-e50010ff : 0000:00:02.2
  e5001000-e50010ff : ehci_hcd
e5002000-e5002fff : 0000:00:02.0
  e5002000-e5002fff : ohci-hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

lspci -vvv:

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev a2)
 Subsystem: Asustek Computer, Inc.: Unknown device 80ac
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
 Capabilities: [40] AGP version 3.0
  Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3+ Rate=x4,x8
  Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x4
 Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev a2)
 Subsystem: nVidia Corporation: Unknown device 0c17
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev a2)
 Subsystem: nVidia Corporation: Unknown device 0c17
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev a2)
 Subsystem: nVidia Corporation: Unknown device 0c17
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev a2)
 Subsystem: nVidia Corporation: Unknown device 0c17
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev a2)
 Subsystem: nVidia Corporation: Unknown device 0c17
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a3)
 Subsystem: Asustek Computer, Inc. A7N8X Mainboard
 Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
 Subsystem: Asustek Computer, Inc.: Unknown device 0c11
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 23
 Region 0: I/O ports at e000 [size=32]
 Capabilities: [44] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
(prog-if 10 [OHCI])
 Subsystem: Asustek Computer, Inc. A7N8X Mainboard
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0 (750ns min, 250ns max)
 Interrupt: pin A routed to IRQ 20
 Region 0: Memory at e5002000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [44] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
(prog-if 10 [OHCI])
 Subsystem: Asustek Computer, Inc. A7N8X Mainboard
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0 (750ns min, 250ns max)
 Interrupt: pin B routed to IRQ 22
 Region 0: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
 Capabilities: [44] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a3)
(prog-if 20 [EHCI])
 Subsystem: Asustek Computer, Inc. A7N8X Mainboard
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0 (750ns min, 250ns max)
 Interrupt: pin C routed to IRQ 21
 Region 0: Memory at e5001000 (32-bit, non-prefetchable) [size=256]
 Capabilities: [44] #0a [2080]
 Capabilities: [80] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3)
(prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
 I/O behind bridge: 0000c000-0000cfff
 Memory behind bridge: e4000000-e4ffffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a
[Master SecP PriP])
 Subsystem: Asustek Computer, Inc.: Unknown device 0c11
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0 (750ns min, 250ns max)
 Region 4: I/O ports at f000 [size=16]
 Capabilities: [44] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 PCI bridge: nVidia Corporation: Unknown device 006d (rev a3)
(prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
 I/O behind bridge: 0000d000-0000dfff
 Memory behind bridge: e0000000-e1ffffff
 Prefetchable memory behind bridge: fff00000-000fffff
 BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev a2) (prog-if 00
[Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
 Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32
 Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: e2000000-e3ffffff
 Prefetchable memory behind bridge: d8000000-dfffffff
 BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:09.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
 Subsystem: Creative Labs: Unknown device 1002
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (500ns min, 5000ns max)
 Interrupt: pin A routed to IRQ 17
 Region 0: I/O ports at c000 [size=64]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev
04)
 Subsystem: Creative Labs: Unknown device 0060
 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32
 Region 0: I/O ports at c400 [size=8]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04)
(prog-if 10 [OHCI])
 Subsystem: Creative Labs SB Audigy FireWire Port
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (500ns min, 1000ns max), cache line size 08
 Interrupt: pin B routed to IRQ 18
 Region 0: Memory at e4004000 (32-bit, non-prefetchable) [size=2K]
 Region 1: Memory at e4000000 (32-bit, non-prefetchable) [size=16K]
 Capabilities: [44] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated Fast
Ethernet Controller (rev 40)
 Subsystem: Asustek Computer, Inc.: Unknown device 80ab
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (2500ns min, 2500ns max), cache line size 08
 Interrupt: pin A routed to IRQ 21
 Region 0: I/O ports at d000 [size=128]
 Region 1: Memory at e1000000 (32-bit, non-prefetchable) [size=128]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti 4200
AGP 8x] (rev a1) (prog-if 00 [VGA])
 Subsystem: Asustek Computer, Inc.: Unknown device 808f
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
 Latency: 32 (1250ns min, 250ns max)
 Interrupt: pin A routed to IRQ 19
 Region 0: Memory at e2000000 (32-bit, non-prefetchable) [size=16M]
 Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [60] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 Capabilities: [44] AGP version 3.0
  Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+
AGP3+ Rate=x4,x8
  Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>

/proc/scsi/scsi:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W4012A Rev: 1.05
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0119
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0119
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 02
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0119
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 03
  Vendor: Generic  Model: STORAGE DEVICE   Rev: 0119
  Type:   Direct-Access                    ANSI SCSI revision: 02

/proc/interrupts:

           CPU0
  0:     996928          XT-PIC  timer
  1:       8950    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          1    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:       1510    IO-APIC-edge  ide0
 15:         23    IO-APIC-edge  ide1
 17:          0   IO-APIC-level  EMU10K1
 18:          3   IO-APIC-level  ohci1394
 20:         99   IO-APIC-level  ohci-hcd
 21:        167   IO-APIC-level  ehci_hcd, eth0
 22:       1313   IO-APIC-level  ohci-hcd
NMI:          0
LOC:     996844
ERR:          0
MIS:          0

lsusb -vvv:

Bus 003 Device 003: ID 0df7:0620
  Language IDs: none (invalicannot get string descriptor 1, error = Broken
pipe(32)
cannot get string descriptor 2, error = Broken pipe(32)

  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0df7
  idProduct          0x0620
  bcdDevice            0.10
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         10
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: none (invalid length string descriptor 63; len=7)

Bus 003 Device 002: ID 045e:0039 Microsoft Corp. IntelliMouse Optical
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x0039 IntelliMouse Optical
  bcdDevice            3.00
  iManufacturer           1 Microsoft
  iProduct                3 Microsoft 5-Button Mouse with IntelliEye(TM)
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      72
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          4
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 003 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test7 ohci-hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 003: ID 045e:000e Microsoft Corp.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x045e Microsoft Corp.
  idProduct          0x000e
  bcdDevice            0.99
  iManufacturer           1
  iProduct                2
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower               64mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     136
cannot get report descriptor
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          6
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 002: ID 0bf1:0001
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            2 Communications
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        16
  idVendor           0x0bf1
  idProduct          0x0001
  bcdDevice            1.00
  iManufacturer           1 Intracom S.A.
  iProduct                2 NetMod USB
  iSerial                 3 Firmware Ver 1.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           67
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      1 AT-commands
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         16
        bInterval              10
  unknown descriptor type: 05 24 00 10 01
  unknown descriptor type: 04 24 02 07
  unknown descriptor type: 05 24 06 00 01
  unknown descriptor type: 05 24 01 03 01
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval              10
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval              10
  Language IDs: (length=4)
     0409 English(US)

Bus 002 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test7 ohci-hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval             255
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 002: ID 05dc:b018 Lexar Media, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x05dc Lexar Media, Inc.
  idProduct          0xb018
  bcdDevice            1.19
  iManufacturer           2 Lexar Media
  iProduct                3 Multi-Card Reader
  iSerial                 4 0000019587
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize        512
        bInterval               0
  Language IDs: (length=4)
     0409 English(US)

Bus 001 Device 001: ID 0000:0000 Virtual Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0
  bDeviceProtocol         1
  bMaxPacketSize0         8
  idVendor           0x0000 Virtual
  idProduct          0x0000 Hub
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.0-test7 ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:02.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          2
        bInterval              12
  Language IDs: (length=4)
     0409 English(US)

------=_NextPart_000_0006_01C3907B.A1C78310
Content-Type: application/octet-stream;
	name="config.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.tar.bz2"

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

------=_NextPart_000_0006_01C3907B.A1C78310--


