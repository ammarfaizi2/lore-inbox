Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318485AbSGaUJ1>; Wed, 31 Jul 2002 16:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSGaUJ1>; Wed, 31 Jul 2002 16:09:27 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:53159 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id <S318485AbSGaUJL>; Wed, 31 Jul 2002 16:09:11 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Kathy Frazier <kfrazier@daetwyler.com>
Subject: Interrupt trouble due to IRQ router VIA?
Date: Wed, 31 Jul 2002 16:15:15 -0400
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Message-Id: <200207311615.15896.kfrazier@daetwyler.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am developing a driver for a proprietary board and have run into some 
problems.  I am developing with Linux kernel version 2.4.18 and I have used 
this board and driver successfully in my developement system.  However, I 
just installed the exact same linux kernel and tested this board/driver on 
another system.  In this system, the driver times out on the 
interruptible_sleep_on_timeout waiting for the interrupt.  One thing that I 
noticed is that this second system uses a VIA IRQ router (vs a PIIX IRQ 
router in my developement system).  Are there some problems in the way Linux 
uses the VIA one?  I have searched through some of the mailing lists and have 
seen indications that there may be a problem with it.  I even saw a patch for 
2.4's pci-irq.c  However, these changes do not appear in 2.4.18, 2.4.18-3 or 
2.4.18-5.  I would appreciate any insight you have concerning this.  If there 
is a legitimate patch, would someone send it to me?  

I have enabled the debug in /arch/i386/kernel/pci-i386.h.  What follows below 
are the results of lspci -vvxxx and a portion of the messages file.

Thanks in advance for your help!
Regards,
Kathy

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] 
(rev c4)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR+
	Latency: 0
	Region 0: Memory at fc000000 (32-bit, prefetchable) [size=32M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 91 06 06 00 10 a2 c4 00 00 06 00 00 00 00
10: 08 00 00 fc 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: fd d8 c8 f6 04 00 08 08 80 00 08 08 08 08 08 08
60: 03 aa 00 a0 e6 95 95 95 41 7c 86 2f 08 5f 00 00
70: c0 88 4c 0c 0e a1 d2 00 01 b4 01 02 00 00 00 00
80: 0f 41 00 00 e0 00 00 00 02 00 00 00 8b 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 03 02 00 1f 00 00 00 00 6b 02 00 00
b0: 7f 63 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 01 00 00 00 00 00 00 0e 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x 
AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: f9800000-fbdfffff
	Prefetchable memory behind bridge: fbf00000-fbffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 98 85 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 00
20: 80 f9 d0 fb f0 fb f0 fb 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00
40: c8 cd 00 44 04 72 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
40)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 08 41 00 00 00 80 60 a0 01 00 84 00 00 00 00 f3
50: 0e 76 34 00 00 b0 a0 50 00 04 ff 08 40 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 27 00 40 82 00 00 60 00 00 00 00 00
80: 00 00 00 00 00 0d 00 00 00 60 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 41 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 
8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 71 05 87 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 0b c2 09 05 1c 10 c0 00 a8 20 a8 20 33 00 20 20
50: 07 07 17 e0 04 00 00 00 a8 a8 a8 a8 00 00 00 00
60: 00 02 00 00 00 00 00 00 00 02 00 00 00 00 00 00
70: 02 01 00 00 00 00 00 00 02 01 00 00 00 00 00 00
80: 00 90 f9 07 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 06 00 71 05 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at b400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00
40: 00 02 07 00 c6 00 20 c0 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 
[UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID): Unknown device 1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at b000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 17 00 10 02 16 00 03 0c 08 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 25 09 34 12
30: 00 00 00 00 80 00 00 00 00 00 00 00 0a 04 00 00
40: 00 02 07 00 c6 00 10 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 57 30 00 00 90 02 40 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
40: 20 80 40 00 1a 10 00 00 01 e4 00 00 48 08 00 00
50: 00 ff af 04 10 00 00 00 00 ff ff 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 01 00 02 00 00 00 00 00
70: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 40 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: Asustek Computer, Inc.: Unknown device 80e7
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 85 00 10 02 10 00 01 04 00 20 00 00
10: 01 a8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e7 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0a 01 02 18
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:09.0 Communication controller: Altera Corporation: Unknown device 0320 (rev 
02)
	Subsystem: Unknown device 444d:0001
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at f9000000 (32-bit, non-prefetchable) [size=4K]
00: 72 11 20 03 17 00 00 04 02 00 80 07 08 20 00 00
10: 00 00 00 f9 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 4d 44 01 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 
30)
	Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at a400 [size=128]
	Region 1: Memory at f8800000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: b7 10 55 90 17 00 10 02 30 00 00 02 08 20 00 00
10: 01 a4 00 00 00 00 80 f8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0a 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 01 76
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X 
(rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Pro Turbo AGP 2X
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at fa000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at f9800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at fbfe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
00: 02 10 42 47 87 00 90 02 5c 00 00 03 08 40 00 00
10: 00 00 00 fa 01 d8 00 00 00 00 80 f9 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 02 10 84 00
30: 00 00 fe fb 50 00 00 00 00 00 00 00 0b 01 08 00
40: 0c 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 10 00 03 02 00 ff 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00




Jul 31 14:59:41 dhcp25 kernel: Linux version 2.4.18 (gcc version 2.96 20000731 
(Red Hat Linux 7.3 2.96-110)) #12 Wed Jul 31 14:56:37 EDT 2002
Jul 31 14:59:41 dhcp25 kernel: BIOS-provided physical RAM map:
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 
(usable)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 
(reserved)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 
(reserved)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 0000000000100000 - 0000000007fec000 
(usable)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 0000000007fec000 - 0000000007fef000 
(ACPI data)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 0000000007fef000 - 0000000007fff000 
(reserved)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 0000000007fff000 - 0000000008000000 
(ACPI NVS)
Jul 31 14:59:41 dhcp25 kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 
(reserved)
Jul 31 14:59:41 dhcp25 kernel: On node 0 totalpages: 32748
Jul 31 14:59:41 dhcp25 kernel: zone(0): 4096 pages.
Jul 31 14:59:41 dhcp25 kernel: zone(1): 28652 pages.
Jul 31 14:59:41 dhcp25 kernel: zone(2): 0 pages.
Jul 31 14:59:41 dhcp25 kernel: Local APIC disabled by BIOS -- reenabling.
Jul 31 14:59:41 dhcp25 kernel: Found and enabled local APIC!
Jul 31 14:59:41 dhcp25 kernel: Kernel command line: ro root=/dev/hda2 
hdc=ide-scsi
Jul 31 14:59:41 dhcp25 kernel: ide_setup: hdc=ide-scsi
Jul 31 14:59:41 dhcp25 kernel: Initializing CPU#0
Jul 31 14:59:41 dhcp25 kernel: Detected 601.385 MHz processor.
Jul 31 14:59:41 dhcp25 kernel: Console: colour VGA+ 80x25
Jul 31 14:59:41 dhcp25 kernel: Calibrating delay loop... 1199.30 BogoMIPS
Jul 31 14:59:41 dhcp25 kernel: Memory: 126604k/130992k available (1058k kernel 
code, 4000k reserved, 296k data, 244k init, 0k highmem)
Jul 31 14:59:41 dhcp25 kernel: Dentry-cache hash table entries: 16384 (order: 
5, 131072 bytes)
Jul 31 14:59:41 dhcp25 kernel: Inode-cache hash table entries: 8192 (order: 4, 
65536 bytes)
Jul 31 14:59:41 dhcp25 kernel: Mount-cache hash table entries: 2048 (order: 2, 
16384 bytes)
Jul 31 14:59:41 dhcp25 kernel: Buffer-cache hash table entries: 4096 (order: 
2, 16384 bytes)
Jul 31 14:59:41 dhcp25 kernel: Page-cache hash table entries: 32768 (order: 5, 
131072 bytes)
Jul 31 14:59:41 dhcp25 kernel: dump: Registering dump compression type 0x0
Jul 31 14:59:41 dhcp25 kernel: dump: mbank[0]: type:1, phys_addr: 0 ... 
7febfff
Jul 31 14:59:41 dhcp25 kernel: dump: Crash dump driver initialized.
Jul 31 14:59:41 dhcp25 kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Jul 31 14:59:41 dhcp25 kernel: CPU: L2 cache: 256K
Jul 31 14:59:41 dhcp25 kernel: Intel machine check architecture supported.
Jul 31 14:59:41 dhcp25 kernel: Intel machine check reporting enabled on CPU#0.
Jul 31 14:59:41 dhcp25 kernel: CPU: Intel Pentium III (Coppermine) stepping 06
Jul 31 14:59:41 dhcp25 kernel: Enabling fast FPU save and restore... done.
Jul 31 14:59:41 dhcp25 kernel: Enabling unmasked SIMD FPU exception support... 
done.
Jul 31 14:59:41 dhcp25 kernel: Checking 'hlt' instruction... OK.
Jul 31 14:59:41 dhcp25 kernel: POSIX conformance testing by UNIFIX
Jul 31 14:59:41 dhcp25 kernel: enabled ExtINT on CPU#0
Jul 31 14:59:41 dhcp25 kernel: ESR value before enabling vector: 00000000
Jul 31 14:59:41 dhcp25 kernel: ESR value after enabling vector: 00000000
Jul 31 14:59:41 dhcp25 kernel: Using local APIC timer interrupts.
Jul 31 14:59:41 dhcp25 kernel: calibrating APIC timer ...
Jul 31 14:59:41 dhcp25 kernel: ..... CPU clock speed is 601.3531 MHz.
Jul 31 14:59:41 dhcp25 kernel: ..... host bus clock speed is 100.2254 MHz.
Jul 31 14:59:41 dhcp25 kernel: cpu: 0, clocks: 1002254, slice: 501127
Jul 31 14:59:41 dhcp25 kernel: 
CPU0<T0:1002240,T1:501104,D:9,S:501127,C:1002254>
Jul 31 14:59:41 dhcp25 portmap: portmap startup succeeded
Jul 31 14:59:41 dhcp25 kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Jul 31 14:59:42 dhcp25 kernel: mtrr: detected mtrr type: Intel
Jul 31 14:59:42 dhcp25 kernel: PCI: BIOS32 Service Directory structure at 
0xc00f1370
Jul 31 14:59:42 dhcp25 kernel: PCI: BIOS32 Service Directory entry at 0xf0b00
Jul 31 14:59:42 dhcp25 kernel: PCI: BIOS probe returned s=00 hw=11 ver=02.10 
l=01
Jul 31 14:59:42 dhcp25 kernel: PCI: PCI BIOS revision 2.10 entry at 0xf0d00, 
last bus=1
Jul 31 14:59:42 dhcp25 kernel: PCI: Using configuration type 1
Jul 31 14:59:42 dhcp25 kernel: PCI: Probing PCI hardware
Jul 31 14:59:42 dhcp25 kernel: PCI: IDE base address fixup for 00:04.1
Jul 31 14:59:42 dhcp25 kernel: PCI: Scanning for ghost devices on bus 0
Jul 31 14:59:42 dhcp25 kernel: PCI: Scanning for ghost devices on bus 1
Jul 31 14:59:42 dhcp25 kernel: PCI: IRQ init
Jul 31 14:59:42 dhcp25 kernel: PCI: Interrupt Routing Table found at 
0xc00f12b0
Jul 31 14:59:42 dhcp25 kernel: 00:04 slot=00<2> 0:05/1eb8<2> 1:01/1eb8<2> 
2:02/1eb8<2> 3:03/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:0b slot=01<2> 0:02/1eb8<2> 1:03/1eb8<2> 
2:05/1eb8<2> 3:01/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:0a slot=02<2> 0:03/1eb8<2> 1:05/1eb8<2> 
2:01/1eb8<2> 3:02/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:09 slot=03<2> 0:05/1eb8<2> 1:01/1eb8<2> 
2:02/1eb8<2> 3:03/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:08 slot=04<2> 0:01/1eb8<2> 1:02/1eb8<2> 
2:03/1eb8<2> 3:05/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:07 slot=05<2> 0:02/1eb8<2> 1:03/1eb8<2> 
2:05/1eb8<2> 3:01/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:06 slot=06<2> 0:03/1eb8<2> 1:05/1eb8<2> 
2:01/1eb8<2> 3:02/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 00:05 slot=00<2> 0:03/1eb8<2> 1:00/1eb8<2> 
2:00/1eb8<2> 3:00/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: 01:00 slot=07<2> 0:01/1eb8<2> 1:02/1eb8<2> 
2:00/1eb8<2> 3:00/1eb8<2>
Jul 31 14:59:42 dhcp25 kernel: PCI: Attempting to find IRQ router for 
1106:0586
Jul 31 14:59:42 dhcp25 kernel: PCI: Using IRQ router VIA [1106/0686] at 
00:04.0
Jul 31 14:59:42 dhcp25 kernel: PCI: IRQ fixup
Jul 31 14:59:42 dhcp25 kernel: PCI: Allocating resources
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource fc000000-fdffffff (f=1208, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000b800-0000b80f (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000b400-0000b41f (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000b000-0000b01f (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000a800-0000a8ff (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource f9000000-f9000fff (f=200, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000a400-0000a47f (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource f8800000-f880007f (f=200, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource fa000000-faffffff (f=200, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource 0000d800-0000d8ff (f=101, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Resource f9800000-f9800fff (f=200, d=0, 
p=0)
Jul 31 14:59:42 dhcp25 kernel: PCI: Sorting device list...
Jul 31 14:59:42 dhcp25 kernel: PCI: Disabling Via external APIC routing
Jul 31 14:59:42 dhcp25 kernel: isapnp: Scanning for PnP cards...
Jul 31 14:59:42 dhcp25 kernel: isapnp: No Plug & Play device found
Jul 31 14:59:42 dhcp25 kernel: Linux NET4.0 for Linux 2.4
Jul 31 14:59:42 dhcp25 kernel: Based upon Swansea University Computer Society 
NET3.039
Jul 31 14:59:42 dhcp25 kernel: Initializing RT netlink socket
Jul 31 14:59:42 dhcp25 kernel: apm: BIOS version 1.2 Flags 0x03 (Driver 
version 1.16)
Jul 31 14:59:42 dhcp25 kernel: Starting kswapd
Jul 31 14:59:42 dhcp25 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Jul 31 14:59:42 dhcp25 kernel: pty: 2048 Unix98 ptys configured
Jul 31 14:59:42 dhcp25 kernel: Serial driver version 5.05c (2001-07-08) with 
MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 31 14:59:42 dhcp25 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 31 14:59:42 dhcp25 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jul 31 14:59:42 dhcp25 kernel: Real Time Clock Driver v1.10e
Jul 31 14:59:42 dhcp25 kernel: block: 128 slots per queue, batch=32
Jul 31 14:59:42 dhcp25 kernel: Uniform Multi-Platform E-IDE driver Revision: 
6.31
Jul 31 14:59:42 dhcp25 kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Jul 31 14:59:42 dhcp25 kernel: VP_IDE: IDE controller on PCI bus 00 dev 21
Jul 31 14:59:42 dhcp25 kernel: VP_IDE: chipset revision 6
Jul 31 14:59:42 dhcp25 kernel: VP_IDE: not 100%% native mode: will probe irqs 
later
Jul 31 14:59:42 dhcp25 kernel: VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 
controller on pci00:04.1
Jul 31 14:59:42 dhcp25 kernel:     ide0: BM-DMA at 0xb800-0xb807, BIOS 
settings: hda:DMA, hdb:pio
Jul 31 14:59:42 dhcp25 kernel:     ide1: BM-DMA at 0xb808-0xb80f, BIOS 
settings: hdc:DMA, hdd:pio
Jul 31 14:59:42 dhcp25 kernel: hda: ST320414A, ATA DISK drive
Jul 31 14:59:42 dhcp25 kernel: hdc: PLEXTOR CD-R PX-W1210A, ATAPI CD/DVD-ROM 
drive
Jul 31 14:59:42 dhcp25 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Jul 31 14:59:42 dhcp25 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Jul 31 14:59:42 dhcp25 kernel: hda: 39102336 sectors (20020 MB) w/2048KiB 
Cache, CHS=2434/255/63, UDMA(100)
Jul 31 14:59:42 dhcp25 kernel: ide-floppy driver 0.97.sv
Jul 31 14:59:42 dhcp25 kernel: Partition check:
Jul 31 14:59:42 dhcp25 kernel:  hda: hda1 hda2 hda3
Jul 31 14:59:42 dhcp25 kernel: Floppy drive(s): fd0 is 1.44M
Jul 31 14:59:42 dhcp25 kernel: FDC 0 is a post-1991 82077
Jul 31 14:59:42 dhcp25 kernel: ide-floppy driver 0.97.sv
Jul 31 14:59:42 dhcp25 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Jul 31 14:59:42 dhcp25 kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Jul 31 14:59:42 dhcp25 kernel: IP: routing cache hash table of 512 buckets, 
4Kbytes
Jul 31 14:59:42 dhcp25 kernel: TCP: Hash tables configured (established 8192 
bind 8192)
Jul 31 14:59:42 dhcp25 kernel: Linux IP multicast router 0.06 plus PIM-SM
Jul 31 14:59:42 dhcp25 kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Jul 31 14:59:42 dhcp25 kernel: VFS: Mounted root (ext2 filesystem) readonly.
Jul 31 14:59:42 dhcp25 kernel: Freeing unused kernel memory: 244k freed
Jul 31 14:59:42 dhcp25 kernel: Adding Swap: 257032k swap-space (priority -1)
Jul 31 14:59:42 dhcp25 kernel: usb.c: registered new driver usbdevfs
Jul 31 14:59:42 dhcp25 nfslock: rpc.statd startup succeeded
Jul 31 14:59:42 dhcp25 kernel: usb.c: registered new driver hub
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: $Revision: 1.275 $ time 14:33:38 
Jul 31 2002
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: High bandwidth mode enabled
Jul 31 14:59:42 dhcp25 kernel: IRQ for 00:04.2:3<2> -> PIRQ 03, mask 1eb8, 
excl 0000<2> -> newirq=10<2> -> got IRQ 10
Jul 31 14:59:42 dhcp25 kernel: PCI: Found IRQ 10 for device 00:04.2
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.3
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:05.0
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:0a.0
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 10
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: Detected 2 ports
Jul 31 14:59:42 dhcp25 kernel: usb.c: new USB bus registered, assigned bus 
number 1
Jul 31 14:59:42 dhcp25 kernel: hub.c: USB hub found
Jul 31 14:59:42 dhcp25 kernel: hub.c: 2 ports detected
Jul 31 14:59:42 dhcp25 kernel: IRQ for 00:04.3:3<2> -> PIRQ 03, mask 1eb8, 
excl 0000<2> -> newirq=10<2> -> got IRQ 10
Jul 31 14:59:42 dhcp25 kernel: PCI: Found IRQ 10 for device 00:04.3
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.2
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:05.0
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:0a.0
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: USB UHCI at I/O 0xb000, IRQ 10
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: Detected 2 ports
Jul 31 14:59:42 dhcp25 kernel: usb.c: new USB bus registered, assigned bus 
number 2
Jul 31 14:59:42 dhcp25 kernel: hub.c: USB hub found
Jul 31 14:59:42 dhcp25 kernel: hub.c: 2 ports detected
Jul 31 14:59:42 dhcp25 kernel: usb-uhci.c: v1.275:USB Universal Host 
Controller Interface driver
Jul 31 14:59:42 dhcp25 kernel: Journalled Block Device driver loaded
Jul 31 14:59:42 dhcp25 kernel: kjournald starting.  Commit interval 5 seconds
Jul 31 14:59:42 dhcp25 rpc.statd[658]: Version 0.3.3 Starting
Jul 31 14:59:42 dhcp25 kernel: EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), 
internal journal
Jul 31 14:59:42 dhcp25 kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Jul 31 14:59:42 dhcp25 kernel: SCSI subsystem driver Revision: 1.00
Jul 31 14:59:42 dhcp25 kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
Jul 31 14:59:42 dhcp25 kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210A  
Rev: 1.07
Jul 31 14:59:42 dhcp25 kernel:   Type:   CD-ROM                             
ANSI SCSI revision: 02
Jul 31 14:59:42 dhcp25 kernel: hdc: DMA disabled
Jul 31 14:59:42 dhcp25 kernel: parport0: PC-style at 0x378 (0x778) 
[PCSPP,TRISTATE]
Jul 31 14:59:42 dhcp25 kernel: parport_pc: Via 686A parallel port: io=0x378
Jul 31 14:59:42 dhcp25 kernel: IRQ for 00:0a.0:0<2> -> PIRQ 03, mask 1eb8, 
excl 0000<2> -> newirq=10<2> -> got IRQ 10
Jul 31 14:59:42 dhcp25 kernel: PCI: Found IRQ 10 for device 00:0a.0
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.2
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.3
Jul 31 14:59:42 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:05.0
Jul 31 14:59:42 dhcp25 kernel: 3c59x: Donald Becker and others. 
www.scyld.com/network/vortex.html
Jul 31 14:59:42 dhcp25 kernel: 00:0a.0: 3Com PCI 3c905B Cyclone 100baseTx at 
0xa400. Vers LK1.1.16
Jul 31 14:59:42 dhcp25 keytable: Loading keymap:  succeeded
Jul 31 14:59:42 dhcp25 keytable: Loading system font:  succeeded
Jul 31 14:59:42 dhcp25 random: Initializing random number generator:  
succeeded
Jul 31 14:59:44 dhcp25 netfs: Mounting other filesystems:  succeeded
Jul 31 14:59:44 dhcp25 apmd[771]: Version 3.0.2 (APM BIOS 1.2, Linux driver 
1.16)
Jul 31 14:59:44 dhcp25 apmd: apmd startup succeeded
Jul 31 14:59:22 dhcp25 rc.sysinit: Mounting proc filesystem:  succeeded 
Jul 31 14:59:22 dhcp25 sysctl: net.ipv4.ip_forward = 0 
Jul 31 14:59:22 dhcp25 sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 31 14:59:22 dhcp25 sysctl: kernel.sysrq = 0 
Jul 31 14:59:22 dhcp25 sysctl: kernel.core_uses_pid = 1 
Jul 31 14:59:22 dhcp25 rc.sysinit: Configuring kernel parameters:  succeeded 
Jul 31 14:59:22 dhcp25 date: Wed Jul 31 14:59:16 EDT 2002 
Jul 31 14:59:22 dhcp25 rc.sysinit: Setting clock  (localtime): Wed Jul 31 
14:59:16 EDT 2002 succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Loading default keymap succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Setting default font (lat0-sun16):  
succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Activating swap partitions:  succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Setting hostname localhost.localdomain:  
succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Mounting USB filesystem:  succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Initializing USB controller (usb-uhci):  
succeeded 
Jul 31 14:59:22 dhcp25 fsck: /: clean, 151894/2408448 files, 641507/4811467 
blocks 
Jul 31 14:59:22 dhcp25 rc.sysinit: Checking root filesystem succeeded 
Jul 31 14:59:22 dhcp25 rc.sysinit: Remounting root filesystem in read-write 
mode:  succeeded 
Jul 31 14:59:25 dhcp25 rc.sysinit: Finding module dependencies:  succeeded 
Jul 31 14:59:25 dhcp25 fsck: /boot: clean, 45/12048 files, 12964/48163 blocks 
Jul 31 14:59:25 dhcp25 rc.sysinit: Checking filesystems succeeded 
Jul 31 14:59:25 dhcp25 rc.sysinit: Mounting local filesystems:  succeeded 
Jul 31 14:59:25 dhcp25 rc.sysinit: Enabling local filesystem quotas:  
succeeded 
Jul 31 14:59:26 dhcp25 rc.sysinit: Enabling swap space:  succeeded 
Jul 31 14:59:28 dhcp25 init: Entering runlevel: 5 
Jul 31 14:59:29 dhcp25 kudzu: Updating /etc/fstab succeeded 
Jul 31 14:59:40 dhcp25 kudzu:  succeeded 
Jul 31 14:59:40 dhcp25 sysctl: net.ipv4.ip_forward = 0 
Jul 31 14:59:40 dhcp25 sysctl: net.ipv4.conf.default.rp_filter = 1 
Jul 31 14:59:40 dhcp25 sysctl: kernel.sysrq = 0 
Jul 31 14:59:40 dhcp25 sysctl: kernel.core_uses_pid = 1 
Jul 31 14:59:40 dhcp25 network: Setting network parameters:  succeeded 
Jul 31 14:59:41 dhcp25 network: Bringing up loopback interface:  succeeded 
Jul 31 14:59:41 dhcp25 ifup: Determining IP information for eth0... 
Jul 31 14:59:41 dhcp25 ifup:  done. 
Jul 31 14:59:41 dhcp25 network: Bringing up interface eth0:  succeeded 
Jul 31 14:59:44 dhcp25 ypbind: Setting NIS domain name software.ohio.com:  
succeeded
Jul 31 14:59:44 dhcp25 ypbind: ypbind startup succeeded
Jul 31 14:59:44 dhcp25 ypbind: bound to NIS server minx
Jul 31 14:59:44 dhcp25 autofs: automount startup succeeded
Jul 31 14:59:44 dhcp25 automount[865]: starting automounter version 3.1.7, 
path = /home, maptype = program, mapname = /etc/auto.home
Jul 31 14:59:44 dhcp25 sshd: Starting sshd:
Jul 31 14:59:44 dhcp25 automount[865]: using kernel protocol version 3
Jul 31 14:59:45 dhcp25 apmd[771]: Charge: * * * (-1% unknown)
Jul 31 14:59:45 dhcp25 sshd:  succeeded
Jul 31 14:59:45 dhcp25 sshd: 
Jul 31 14:59:45 dhcp25 rc: Starting sshd:  succeeded
Jul 31 14:59:46 dhcp25 xinetd[920]: xinetd Version 2002.03.28 started with 
libwrap options compiled in.
Jul 31 14:59:46 dhcp25 xinetd[920]: Started working: 1 available service
Jul 31 14:59:48 dhcp25 xinetd: xinetd startup succeeded
Jul 31 14:59:50 dhcp25 lpd: lpd startup succeeded
Jul 31 14:59:50 dhcp25 sendmail: sendmail startup succeeded
Jul 31 14:59:50 dhcp25 gpm: gpm startup succeeded
Jul 31 14:59:51 dhcp25 crond: crond startup succeeded
Jul 31 14:59:52 dhcp25 xfs: xfs startup succeeded
Jul 31 14:59:52 dhcp25 xfs: listening on port 7100 
Jul 31 14:59:52 dhcp25 anacron: anacron startup succeeded
Jul 31 14:59:52 dhcp25 atd: atd startup succeeded
Jul 31 14:59:52 dhcp25 wine: Registering binary handler for Windows 
applications
Jul 31 14:59:53 dhcp25 rc: Starting wine:  succeeded
Jul 31 14:59:53 dhcp25 xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/cyrillic (unreadable) 
Jul 31 14:59:53 dhcp25 xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/CID (unreadable) 
Jul 31 14:59:53 dhcp25 xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/local (unreadable) 
Jul 31 14:59:53 dhcp25 xfs: ignoring font path element 
/usr/X11R6/lib/X11/fonts/latin2/Type1 (unreadable) 
Jul 31 15:00:09 dhcp25 automount[865]: attempting to mount entry 
/home/kfrazier
Jul 31 15:00:10 dhcp25 kde(pam_unix)[1139]: session opened for user kfrazier 
by (uid=0)
Jul 31 15:00:12 dhcp25 automount[865]: attempting to mount entry /home/lib
Jul 31 15:00:12 dhcp25 automount[1240]: lookup(program): lookup for lib failed
Jul 31 15:00:19 dhcp25 kernel: cmpci: version $Revision: 5.64 $ time 14:32:08 
Jul 31 2002
Jul 31 15:00:19 dhcp25 kernel: IRQ for 00:05.0:0<2> -> PIRQ 03, mask 1eb8, 
excl 0000<2> -> newirq=10<2> -> got IRQ 10
Jul 31 15:00:19 dhcp25 kernel: PCI: Found IRQ 10 for device 00:05.0
Jul 31 15:00:19 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.2
Jul 31 15:00:19 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:04.3
Jul 31 15:00:19 dhcp25 kernel: PCI: Sharing IRQ 10 with 00:0a.0
Jul 31 15:00:19 dhcp25 kernel: cmpci: found CM8738 adapter at io 0xa800 irq 10
Jul 31 15:00:19 dhcp25 kernel: cmpci: chip version = 037
Jul 31 15:00:19 dhcp25 kernel: cmpci: Enable SPDIF loop
Jul 31 15:00:19 dhcp25 modprobe: modprobe: Can't locate module 
sound-service-0-0
Jul 31 15:00:20 dhcp25 modprobe: modprobe: Can't locate module sound-slot-1
Jul 31 15:00:20 dhcp25 modprobe: modprobe: Can't locate module 
sound-service-1-0
Jul 31 15:00:20 dhcp25 modprobe: modprobe: Can't locate module sound-slot-1
Jul 31 15:00:20 dhcp25 modprobe: modprobe: Can't locate module 
sound-service-1-0
Jul 31 15:00:44 dhcp25 automount[865]: attempting to mount entry 
/home/linux-serve
Jul 31 15:00:56 dhcp25 automount[865]: attempting to mount entry /home/lib
Jul 31 15:00:57 dhcp25 automount[1412]: lookup(program): lookup for lib failed

