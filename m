Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262767AbUBZK40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 05:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUBZK40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 05:56:26 -0500
Received: from eufemia.signoff.com.pl ([80.55.253.54]:8322 "EHLO
	eufemia.signoff.com.pl") by vger.kernel.org with ESMTP
	id S262767AbUBZK4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 05:56:19 -0500
Date: Thu, 26 Feb 2004 11:56:16 +0100
From: "Michal 'Orr' Daszkowski" <midas@signoff.com.pl>
To: linux-kernel@vger.kernel.org
Subject: 2 PROBLEMS: Cyclades PC300 driver in 2.4.25 hangs machine and SiS 5513 driver causes disk errors
Message-ID: <20040226105616.GE1066@eufemia.signoff.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Problem - Cyclades PC300

I was tried to use Cyclades PC300 driver from 2.4.25. But after
loading module 'pc300.o', my machine completely hangs. Hard reset
is necessary to restart a computer.

In previous kernel versions, I was using drivers from page:
http://hq.pm.waw.pl/hdlc/, which works OK. And also 2.4.25
with patch from this page (module pc300too.o) is OK and stable.

2. Problem - SiS 5513 (kernel 2.4.25 too)

When I compiled in SiS 5513 IDE driver, there was a lot of
such error messages:

hda: task_no_data_intr: error=0x04 { DriveStatusError }

and machine hangs for a while. It happens very often.

These problems disappeared, when I turned off this driver in
menuconfig.

Maybe, there is a hardware problem with this machine, but now
this computer working OK as router and firewall. :)

I hope this mail helps. :)))

Some informations about this machine:

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 5
model           : 4
model name      : WinChip C6
stepping        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de msr mce cx8 mmx centaur_mcr pni est cid
bogomips        : 448.92

# cat /proc/ioports 
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial(set)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-400f : Silicon Integrated Systems [SiS] 5513 [IDE]
f000-f07f : 3Com Corporation 3c905B 100BaseTX [Cyclone]
  f000-f07f : 00:0f.0
f080-f0ff : 3Com Corporation 3c905C-TX/TX-M [Tornado]
  f080-f0ff : 00:0d.0
f400-f47f : Cyclades Corporation PC300/RSV or /X21 (1 port)
  f400-f47f : PC300
f480-f4ff : Silicon Integrated Systems [SiS] 5597/5598/6326 VGA

# cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d07ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07bfffff : System RAM
  00100000-001ec336 : Kernel code
  001ec337-0024fda3 : Kernel data
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ff400000-ff7fffff : Silicon Integrated Systems [SiS] 5597/5598/6326 VGA
ff980000-ff9fffff : Cyclades Corporation PC300/RSV or /X21 (1 port)
  ff980000-ff9fffff : PC300
ffae7800-ffae7bff : Cyclades Corporation PC300/RSV or /X21 (1 port)
  ffae7800-ffae7bff : PC300
ffae7e80-ffae7eff : 3Com Corporation 3c905B 100BaseTX [Cyclone]
ffae7f00-ffae7f7f : 3Com Corporation 3c905C-TX/TX-M [Tornado]
ffae7f80-ffae7fff : Cyclades Corporation PC300/RSV or /X21 (1 port)
  ffae7f80-ffae7fff : PC300
ffaf0000-ffafffff : Silicon Integrated Systems [SiS] 5597/5598/6326 VGA
fffe0000-ffffffff : reserved

# lspci -vvv
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 5597 [SiS5582] (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 4008:0a00
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 128
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at 4000 [size=16]

00:0b.0 Communication controller: Cyclades Corporation PC300 RX 1 (rev 01)
	Subsystem: Cyclades Corporation PC300 RX 1
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ffae7f80 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at f400 [size=128]
	Region 2: Memory at ffae7800 (32-bit, non-prefetchable) [size=1K]
	Region 3: Memory at ff980000 (32-bit, prefetchable) [size=512K]

00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at f080 [size=128]
	Region 1: Memory at ffae7f00 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ffac0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at f000 [size=128]
	Region 1: Memory at ffae7e80 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at ffaa0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 VGA compatible controller: Silicon Integrated Systems [SiS] 5597/5598 VGA (rev 65) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] 5597/5598 VGA
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at ff400000 (32-bit, prefetchable) [size=4M]
	Region 1: Memory at ffaf0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at f480 [size=128]
	Expansion ROM at ffae8000 [disabled] [size=32K]

Regards,
Orr
