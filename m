Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWI3Rmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWI3Rmz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWI3Rmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:42:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:44186 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751335AbWI3Rmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:42:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=molAhrxNqtMYSMdqX2omZvw8vY2Q0Sx16oJePiEyXdI9IFOcNbVz/mDkixWQu7jBq9ePZFpwxgfpgYifGWD5rHMdVCLkjafdtcn/K/sLpZbuC238GeB9gQhQ+rixaB6i+UEBf6AATzWIRIWmdwcxKciUh7bI39w6ZyKsgR4OAnI=
Date: Sat, 30 Sep 2006 19:42:47 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.18-git] Lost all PCI devices
Message-ID: <20060930174247.GA31793@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andi,
I'm testing current git on my notebook, but kernel doesn't find any
PCI device: no video card, no IDE, nothing.

Using git bisect I've tracked down the commit that broke my machine:

5e544d618f0fb21011f36f28d5e3952b9dc109d2 is first bad commit
commit 5e544d618f0fb21011f36f28d5e3952b9dc109d2
Author: Andi Kleen <ak@suse.de>
Date:   Tue Sep 26 10:52:40 2006 +0200

    [PATCH] i386/x86-64: PCI: split probing and initialization of type 1 config space access

    First probe if type1/2 accesses work, but then only initialize them at the end.

    This is useful for a later patch that needs this information inbetween.

    Signed-off-by: Andi Kleen <ak@suse.de>

:040000 040000 5340a14d6abcce04258ce42d99bdb9dba59b0806 14fc88c780f388f70159ee7bdd2b50e7a7ceff3e M      arch

I also tried pci=routeirq without success. I'm not using
PCI_MULTITHREAD_PROBE. This is lspci of the machine:

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 740 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 04)
00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97 Sound Controller (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller
00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 90)
00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 65x/M650/740 PCI/AGP VGA Display Adapter
02:00.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01)

I'm attaching the output of lspci -vvxxx, and dmesg of working and non
working system (with CONFIG_PCI_DEBUG). Tell me if you need further
information.

Luca
-- 
Home: http://kronoz.cjb.net
"L'ottimista pensa che questo sia il migliore dei mondi possibili. 
 Il pessimista sa che e` vero" -- J. Robert Oppenheimer

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci-vvxxx

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 740 Host (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=17 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 39 10 40 07 07 00 10 22 01 00 00 06 00 20 80 00
10: 00 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 11 77 00 00
50: 87 20 f7 77 f0 f0 f0 f0 86 2a 3d 00 12 d5 03 00
60: 67 67 6d 6d a3 00 16 00 01 e4 18 00 03 00 9a 00
70: 3f 9f 00 00 00 00 00 00 00 00 00 00 1a 08 00 00
80: 02 00 10 00 85 00 04 0b ff 0c 00 04 80 00 00 1f
90: 00 00 2a 1e 43 00 00 05 00 06 b5 02 00 00 00 15
a0: 22 f6 44 22 03 03 01 3f 00 a0 02 22 c4 00 f0 01
b0: 0f 00 00 a0 01 30 00 00 5a 54 48 8e 29 95 25 00
c0: 02 00 20 00 17 02 00 10 00 00 00 00 c9 c9 79 88
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: e7800000-e7ffffff
	Prefetchable memory behind bridge: f0000000-febfffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
00: 39 10 01 00 07 00 00 00 00 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 d0 d0 00 20
20: 80 e7 f0 e7 00 f0 b0 fe 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 08 00
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

00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS962 [MuTIOL Media IO] (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
00: 39 10 62 09 0f 00 00 02 04 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: d9 0b 05 0b 0b 20 3c 50 10 00 00 00 11 20 04 01
50: 11 28 02 01 60 0a 63 00 a5 12 12 00 d3 8b b0 00
60: 80 80 80 09 ff c1 0c 12 09 80 00 66 80 00 00 00
70: 00 00 ff ff 00 e4 00 08 00 00 00 00 00 00 00 04
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 40 00 00 00 42 00 04 00 00 00 00 00 00 00 00 00
f0: 09 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.1 SMBus: Silicon Integrated Systems [SiS] SiS961/2 SMBus Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 0
	Region 4: I/O ports at e800 [size=32]
00: 39 10 16 00 01 00 80 02 00 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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

00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (prog-if 80 [Master])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1658
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at b800 [size=16]
	Capabilities: [58] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 13 55 05 00 10 02 00 80 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 58 16
30: 00 00 00 00 58 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 06 00 00 00 00 00
50: f2 07 f2 07 2a 96 d5 d0 01 00 02 80 00 00 00 00
60: f4 aa f4 aa 00 00 00 00 00 00 00 00 00 00 00 00
70: 16 21 06 04 02 00 00 00 56 23 06 04 02 60 1c 1e
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.6 Modem: Silicon Integrated Systems [SiS] AC'97 Modem Controller (rev a0) (prog-if 00 [Generic])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1696
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at b400 [size=256]
	Region 1: I/O ports at b000 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 13 70 05 00 90 02 a0 00 03 07 00 20 00 00
10: 01 b4 00 00 01 b0 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 96 16
30: 00 00 00 00 48 00 00 00 00 00 00 00 09 03 34 0b
40: 02 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
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
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] AC'97 Sound Controller (rev a0)
	Subsystem: ASUSTeK Computer Inc. Unknown device 1653
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: I/O ports at a800 [size=256]
	Region 1: I/O ports at a400 [size=128]
	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 12 70 05 00 90 02 a0 00 01 04 00 20 00 00
10: 01 a8 00 00 01 a4 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 53 16
30: 00 00 00 00 48 00 00 00 00 00 00 00 09 03 34 0b
40: 04 00 00 00 00 00 00 00 01 00 42 c6 00 00 00 00
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
f0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1659
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at e7000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 08 20 80 00
10: 00 00 00 e7 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 59 16
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1659
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 9
	Region 0: Memory at e6800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 08 20 00 00
10: 00 00 80 e6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 59 16
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 02 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 Controller (rev 0f) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1659
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max), Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 9
	Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 01 70 17 00 90 02 0f 10 03 0c 08 20 00 00
10: 00 00 00 e6 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 59 16
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 03 00 50
40: 00 00 00 00 5c bc 01 00 7f 02 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 c2 c9
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 Controller (prog-if 20 [EHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 165a
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (20000ns max)
	Interrupt: pin D routed to IRQ 9
	Region 0: Memory at e5800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 02 70 06 00 90 02 00 20 03 0c 00 20 00 00
10: 00 00 80 e5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 5a 16
30: 00 00 00 00 50 00 00 00 00 00 00 00 09 04 00 50
40: 80 00 00 08 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 00 21 00 00 00 00
60: 20 20 7f 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 01 00 00 00 00 00 08 c0 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 PCI Fast Ethernet (rev 90)
	Subsystem: ASUSTeK Computer Inc. Unknown device 1455
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at a000 [size=256]
	Region 1: Memory at e5000000 (32-bit, non-prefetchable) [size=4K]
	[virtual] Expansion ROM at 28000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 39 10 00 09 07 00 90 02 90 00 00 02 00 20 00 00
10: 01 a0 00 00 00 00 00 e5 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 55 14
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 34 0b
40: 01 00 02 fe 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: ASUSTeK Computer Inc. Unknown device 1654
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e4800000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 20000000-21fff000 (prefetchable)
	Memory window 1: 22000000-23fff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 aa 00 07 06 00 a8 82 00
10: 00 00 80 e4 dc 00 00 22 00 02 05 b0 00 00 00 20
20: 00 f0 ff 21 00 00 00 22 00 f0 ff 23 00 10 00 00
30: fc 10 00 00 00 14 00 00 fc 14 00 00 05 01 00 05
40: 43 10 54 16 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 a0 20 00 03 00 00 63 04 63 04 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 80 00 00 02 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 43 10 54 16 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0a fe
e0: 00 c0 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: ASUSTeK Computer Inc. Unknown device 1654
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at e2800000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
	Memory window 0: 24000000-25fff000 (prefetchable)
	Memory window 1: 26000000-27fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001
00: 80 11 76 04 07 00 10 02 aa 00 07 06 00 a8 82 00
10: 00 00 80 e2 dc 00 00 02 00 06 09 b0 00 00 00 24
20: 00 f0 ff 25 00 00 00 26 00 f0 ff 27 00 18 00 00
30: fc 18 00 00 00 1c 00 00 fc 1c 00 00 09 02 80 05
40: 43 10 54 16 01 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 a0 20 00 03 00 00 63 04 63 04 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 80 00 00 02 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 43 10 54 16 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 0a fe
e0: 00 40 c0 24 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1657
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at e0800000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+
00: 80 11 52 05 06 00 10 02 02 10 00 0c 00 20 80 00
10: 00 00 80 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 57 16
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 03 02 04
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 80 80 16 00 00 00 00 00 20 00 00 66 66 32 12
90: 48 60 66 10 00 00 02 00 50 80 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 80 00 00 00 43 10 57 16
b0: 00 00 00 00 00 00 00 00 00 30 00 00 00 00 02 04
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 c8
e0: 00 c0 00 48 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 65x/M650/740 PCI/AGP VGA Display Adapter (prog-if 00 [VGA])
	Subsystem: ASUSTeK Computer Inc. Unknown device 1612
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	BIST result: 00
	Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e7800000 (32-bit, non-prefetchable) [size=128K]
	Region 2: I/O ports at d800 [size=128]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 39 10 25 63 03 00 b0 02 00 00 00 03 00 00 00 80
10: 08 00 00 f0 00 00 80 e7 01 d8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 12 16
30: 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00 00
40: 01 50 02 06 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 00 20 00 07 02 00 0f 00 00 00 00 00 00 00 00
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

02:00.0 Network controller: RaLink RT2500 802.11g Cardbus/mini-PCI (rev 01)
	Subsystem: CNet Technology Inc CWP-854 Wireless-G PCI Adapter
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at 22000000 (32-bit, non-prefetchable) [disabled] [size=8K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 14 18 01 02 00 00 10 04 01 00 80 02 00 00 00 00
10: 00 00 00 22 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 01 06 00 00 71 13 20 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 05 01 00 00
40: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-good.txt"

 Linux version 2.6.18-ga15da49d (kronos@dreamland.darkstar.lan) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #14 PREEMPT Sat Sep 30 19:07:31 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001efea000 (usable)
 BIOS-e820: 000000001efea000 - 000000001efef000 (ACPI data)
 BIOS-e820: 000000001efef000 - 000000001efff000 (reserved)
 BIOS-e820: 000000001efff000 - 000000001f000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126954
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 122858 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6e30
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 20000000 (gap: 1f000000:e0ff0000)
Detected 1874.737 MHz processor.
Built 1 zonelists.  Total pages: 126954
Kernel command line: BOOT_IMAGE=linux-2.6.18-b ro root=305 lapic noinitrd console=ttyS0,57600 debug
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c038a000 soft=c0389000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 500164k/507816k available (1691k kernel code, 7124k reserved, 487k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3751.52 BogoMIPS (lpj=7503055)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 60071263. Reprogramming to 20071263
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: AMD mobile AMD Athlon(tm) XP-M 2500+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI (tbget-0289): Table [DSDT] replaced by host OS [20060707]
ACPI: setting ELCR to 0200 (from 0a20)
ACPI: bus type pci registered
spurious 8259A interrupt: IRQ7.
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15) *9
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [1039/0740] 000600 00
PCI: Calling quirk c01fd3a0 for 0000:00:00.0
PCI: Calling quirk c02a15f0 for 0000:00:00.0
PCI: Calling quirk c02a1bf0 for 0000:00:00.0
PCI: Found 0000:00:01.0 [1039/0001] 000604 01
PCI: Calling quirk c01fd3a0 for 0000:00:01.0
PCI: Calling quirk c02a15f0 for 0000:00:01.0
PCI: Calling quirk c02a1bf0 for 0000:00:01.0
PCI: Found 0000:00:02.0 [1039/0008] 000601 00
PCI: Calling quirk c01fd3a0 for 0000:00:02.0
PCI: Calling quirk c036f140 for 0000:00:02.0
Uncovering SIS962 that hid as a SIS503 (compatible=0)
PCI: Calling quirk c036efa0 for 0000:00:02.0
Enabling SiS 96x SMBus.
PCI: Calling quirk c02a15f0 for 0000:00:02.0
PCI: Calling quirk c02a1bf0 for 0000:00:02.0
PCI: Found 0000:00:02.1 [1039/0016] 000c05 00
PCI: Calling quirk c01fd3a0 for 0000:00:02.1
PCI: Calling quirk c02a15f0 for 0000:00:02.1
PCI: Calling quirk c02a1bf0 for 0000:00:02.1
PCI: Found 0000:00:02.5 [1039/5513] 000101 00
PCI: Calling quirk c01fd3a0 for 0000:00:02.5
PCI: Calling quirk c02a15f0 for 0000:00:02.5
PCI: Calling quirk c02a1650 for 0000:00:02.5
PCI: Calling quirk c02a1bf0 for 0000:00:02.5
PCI: Found 0000:00:02.6 [1039/7013] 000703 00
PCI: Calling quirk c01fd3a0 for 0000:00:02.6
PCI: Calling quirk c02a15f0 for 0000:00:02.6
PCI: Calling quirk c02a1bf0 for 0000:00:02.6
PCI: Found 0000:00:02.7 [1039/7012] 000401 00
PCI: Calling quirk c01fd3a0 for 0000:00:02.7
PCI: Calling quirk c02a15f0 for 0000:00:02.7
PCI: Calling quirk c02a1bf0 for 0000:00:02.7
PCI: Found 0000:00:03.0 [1039/7001] 000c03 00
PCI: Calling quirk c01fd3a0 for 0000:00:03.0
PCI: Calling quirk c02a15f0 for 0000:00:03.0
PCI: Calling quirk c02a1bf0 for 0000:00:03.0
PCI: Found 0000:00:03.1 [1039/7001] 000c03 00
PCI: Calling quirk c01fd3a0 for 0000:00:03.1
PCI: Calling quirk c02a15f0 for 0000:00:03.1
PCI: Calling quirk c02a1bf0 for 0000:00:03.1
PCI: Found 0000:00:03.2 [1039/7001] 000c03 00
PCI: Calling quirk c01fd3a0 for 0000:00:03.2
PCI: Calling quirk c02a15f0 for 0000:00:03.2
PCI: Calling quirk c02a1bf0 for 0000:00:03.2
PCI: Found 0000:00:03.3 [1039/7002] 000c03 00
PCI: Calling quirk c01fd3a0 for 0000:00:03.3
PCI: Calling quirk c02a15f0 for 0000:00:03.3
PCI: Calling quirk c02a1bf0 for 0000:00:03.3
PCI: Found 0000:00:04.0 [1039/0900] 000200 00
PCI: Calling quirk c01fd3a0 for 0000:00:04.0
PCI: Calling quirk c02a15f0 for 0000:00:04.0
PCI: Calling quirk c02a1bf0 for 0000:00:04.0
PCI: Found 0000:00:0a.0 [1180/0476] 000607 02
PCI: Calling quirk c01fd3a0 for 0000:00:0a.0
PCI: Calling quirk c02a15f0 for 0000:00:0a.0
PCI: Calling quirk c02a1bf0 for 0000:00:0a.0
PCI: Found 0000:00:0a.1 [1180/0476] 000607 02
PCI: Calling quirk c01fd3a0 for 0000:00:0a.1
PCI: Calling quirk c02a15f0 for 0000:00:0a.1
PCI: Calling quirk c02a1bf0 for 0000:00:0a.1
PCI: Found 0000:00:0a.2 [1180/0552] 000c00 00
PCI: Calling quirk c01fd3a0 for 0000:00:0a.2
PCI: Calling quirk c02a15f0 for 0000:00:0a.2
PCI: Calling quirk c02a1bf0 for 0000:00:0a.2
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [1039/6325] 000300 00
PCI: Calling quirk c01fd3a0 for 0000:01:00.0
PCI: Calling quirk c02a15f0 for 0000:01:00.0
PCI: Calling quirk c02a1bf0 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:0a.0, config 000000, pass 0
PCI: Scanning behind PCI bridge 0000:00:0a.1, config 000000, pass 0
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:0a.0, config 000000, pass 1
PCI: Scanning behind PCI bridge 0000:00:0a.1, config 000000, pass 1
PCI: Bus scan for 0000:00 returning with max=09
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe480-0xe4ff has been reserved
pnp: 00:02: ioport range 0xe800-0xe87f could not be reserved
pnp: 00:02: ioport range 0x480-0x48f has been reserved
  got res [28000000:2801ffff] bus [28000000:2801ffff] flags 7200 for BAR 6 of 0000:00:04.0
PCI: Ignore bogus resource 6 [0:0] of 0000:01:00.0
PCI: Bridge: 0000:00:01.0
  IO window: d000-dfff
  MEM window: e7800000-e7ffffff
  PREFETCH window: f0000000-febfffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 20000000-21ffffff
  MEM window: 22000000-23ffffff
PCI: Bus 6, cardbus bridge: 0000:00:0a.1
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 24000000-25ffffff
  MEM window: 26000000-27ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:0a.1[B] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
Simple Boot Flag at 0x3a set to 0x1
SGI XFS with no debug enabled
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Calling quirk c036ebc0 for 0000:00:00.0
PCI: Calling quirk c01fe330 for 0000:00:00.0
PCI: Calling quirk c0299ba0 for 0000:00:00.0
PCI: Calling quirk c036ebc0 for 0000:00:01.0
PCI: Calling quirk c01fe330 for 0000:00:01.0
PCI: Calling quirk c0299ba0 for 0000:00:01.0
PCI: Calling quirk c036ebc0 for 0000:00:02.0
PCI: Calling quirk c01fe330 for 0000:00:02.0
PCI: Calling quirk c0299ba0 for 0000:00:02.0
PCI: Calling quirk c036ebc0 for 0000:00:02.1
PCI: Calling quirk c01fe330 for 0000:00:02.1
PCI: Calling quirk c0299ba0 for 0000:00:02.1
PCI: Calling quirk c036ebc0 for 0000:00:02.5
PCI: Calling quirk c01fe330 for 0000:00:02.5
PCI: Calling quirk c0299ba0 for 0000:00:02.5
PCI: Calling quirk c036ebc0 for 0000:00:02.6
PCI: Calling quirk c01fe330 for 0000:00:02.6
PCI: Calling quirk c0299ba0 for 0000:00:02.6
PCI: Calling quirk c036ebc0 for 0000:00:02.7
PCI: Calling quirk c01fe330 for 0000:00:02.7
PCI: Calling quirk c0299ba0 for 0000:00:02.7
PCI: Calling quirk c036ebc0 for 0000:00:03.0
PCI: Calling quirk c01fe330 for 0000:00:03.0
PCI: Calling quirk c0299ba0 for 0000:00:03.0
PCI: Calling quirk c036ebc0 for 0000:00:03.1
PCI: Calling quirk c01fe330 for 0000:00:03.1
PCI: Calling quirk c0299ba0 for 0000:00:03.1
PCI: Calling quirk c036ebc0 for 0000:00:03.2
PCI: Calling quirk c01fe330 for 0000:00:03.2
PCI: Calling quirk c0299ba0 for 0000:00:03.2
PCI: Calling quirk c036ebc0 for 0000:00:03.3
PCI: Calling quirk c01fe330 for 0000:00:03.3
PCI: Calling quirk c0299ba0 for 0000:00:03.3
PCI: Calling quirk c036ebc0 for 0000:00:04.0
PCI: Calling quirk c01fe330 for 0000:00:04.0
PCI: Calling quirk c0299ba0 for 0000:00:04.0
PCI: Calling quirk c01fe330 for 0000:00:0a.0
PCI: Calling quirk c0299ba0 for 0000:00:0a.0
PCI: Calling quirk c01fe330 for 0000:00:0a.1
PCI: Calling quirk c0299ba0 for 0000:00:0a.1
PCI: Calling quirk c01fe330 for 0000:00:0a.2
PCI: Calling quirk c0299ba0 for 0000:00:0a.2
PCI: Calling quirk c036ebc0 for 0000:01:00.0
PCI: Calling quirk c01fe330 for 0000:01:00.0
PCI: Calling quirk c0299ba0 for 0000:01:00.0
sisfb: Video ROM found
sisfb: Identified [Asus L3000D/L3500D], special timing applies
sisfb: [specialtiming parameter name: ASUS_L3X00]
sisfb: Video RAM at 0xf0000000, mapped to 0xdf880000, size 16384k
sisfb: MMIO at 0xe7800000, mapped to 0xdf840000, size 128k
sisfb: Memory heap starting at 15776K, size 32K
sisfb: Detected LVDS transmitter
sisfb: Detected Chrontel TV encoder
sisfb: Detected 1024x768 flat panel
sisfb: Default mode is 1024x768x8 (60Hz)
sisfb: Initial vbflags 0x3000022
Console: switching to colour frame buffer device 128x48
sisfb: 2D acceleration is enabled, y-panning enabled (auto-max)
fb0: SiS 740 frame buffer device version 1.8.9
sisfb: Copyright (C) 2001-2005 Thomas Winischhofer
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
libata version 2.00 loaded.
pata_sis 0000:00:02.5: version 0.4.3
ata1: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xB800 irq 14
ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xB808 irq 15
scsi0 : pata_sis
ata1.00: ATA-5, max UDMA/100, 78140160 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : pata_sis
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      IC25N040ATCS04-0 CA4O PQ: 0 ANSI: 5
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA740 DVD/CDRW 1.01 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
ACPI: (supports<6>Time: tsc clocksource has been installed.
 S0 S1 S3 S4 S5)
VFS: Cannot open root device "305" or unknown-block(3,5)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,5)

--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-bad.txt"

Linux version 2.6.18-gbf603625 (kronos@dreamland.darkstar.lan) (gcc version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #15 PREEMPT Sat Sep 30 19:30:42 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001efea000 (usable)
 BIOS-e820: 000000001efea000 - 000000001efef000 (ACPI data)
 BIOS-e820: 000000001efef000 - 000000001efff000 (reserved)
 BIOS-e820: 000000001efff000 - 000000001f000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
495MB LOWMEM available.
Entering add_active_range(0, 0, 126954) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   126954
early_node_map[1] active PFN ranges
    0:        0 ->   126954
On node 0 totalpages: 126954
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 959 pages used for memmap
  Normal zone: 121899 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6e30
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1efea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Allocating PCI resources starting at 20000000 (gap: 1f000000:e0ff0000)
Detected 1874.735 MHz processor.
Built 1 zonelists.  Total pages: 125963
Kernel command line: BOOT_IMAGE=linux-2.6.18-b ro root=305 lapic noinitrd console=ttyS0,57600 debug initcall_debug
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0389000 soft=c0388000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 500168k/507816k available (1689k kernel code, 7120k reserved, 481k data, 160k init, 0k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffb7000 - 0xfffff000   ( 288 kB)
    vmalloc : 0xdf800000 - 0xfffb5000   ( 519 MB)
    lowmem  : 0xc0000000 - 0xdefea000   ( 495 MB)
      .init : 0xc035b000 - 0xc0383000   ( 160 kB)
      .data : 0xc02a65e2 - 0xc031ea28   ( 481 kB)
      .text : 0xc0100000 - 0xc02a65e2   (1689 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3751.56 BogoMIPS (lpj=7503121)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1cbfbff 00000000 00000000 00000000 00000000 00000000
CPU: CLK_CTL MSR was 60071263. Reprogramming to 20071263
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1cbfbff 00000000 00000420 00000000 00000000 00000000
Compat vDSO mapped to ffffe000.
CPU: AMD mobile AMD Athlon(tm) XP-M 2500+ stepping 00
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI (tbget-0289): Table [DSDT] replaced by host OS [20060707]
ACPI: setting ELCR to 0200 (from 0a20)
Calling initcall 0xc0364370<7>spurious 8259A interrupt: IRQ7.
: acpisleep_dmi_init+0x0/0x20()
Calling initcall 0xc0364530: reboot_init+0x0/0x20()
Calling initcall 0xc0369b40: helper_init+0x0/0x30()
Calling initcall 0xc0369e60: pm_init+0x0/0x10()
Calling initcall 0xc036c6b0: filelock_init+0x0/0x40()
Calling initcall 0xc036cee0: init_script_binfmt+0x0/0x10()
Calling initcall 0xc036cef0: init_elf_binfmt+0x0/0x10()
Calling initcall 0xc036d6c0: pcibus_class_init+0x0/0x10()
Calling initcall 0xc036dce0: pci_driver_init+0x0/0x10()
Calling initcall 0xc0370a00: tty_class_init+0x0/0x30()
Calling initcall 0xc03712d0: vtconsole_class_init+0x0/0xe0()
Calling initcall 0xc036ddb0: acpi_pci_init+0x0/0x30()
ACPI: bus type pci registered
Calling initcall 0xc036f66f: init_acpi_device_notify+0x0/0x43()
Calling initcall 0xc03733e0: pci_access_init+0x0/0x40()
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
PCI: Using configuration type 0
Calling initcall 0xc035f1f0: request_standard_resources+0x0/0x320()
Setting up standard PCI resources
Calling initcall 0xc0360240: topology_init+0x0/0x10()
Calling initcall 0xc0362fb0: mtrr_init_finialize+0x0/0x40()
Calling initcall 0xc03698f0: param_sysfs_init+0x0/0x1c0()
Calling initcall 0xc0133b90: pm_sysrq_init+0x0/0x20()
Calling initcall 0xc036c460: init_bio+0x0/0x110()
Calling initcall 0xc036d3b0: genhd_device_init+0x0/0x60()
Calling initcall 0xc036de80: fbmem_init+0x0/0x80()
Calling initcall 0xc036f3c4: acpi_init+0x0/0x1a1()
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Calling initcall 0xc036f897: acpi_ec_init+0x0/0x1f()
Calling initcall 0xc036fbcc: acpi_pci_root_init+0x0/0x25()
Calling initcall 0xc036fc19: acpi_pci_link_init+0x0/0x43()
Calling initcall 0xc036fd9b: acpi_power_init+0x0/0x33()
Calling initcall 0xc036fe0b: acpi_system_init+0x0/0x11()
initcall at 0xc036fe0b: acpi_system_init+0x0/0x11(): returned with error code -14
Calling initcall 0xc036fe1c: acpi_event_init+0x0/0x11()
Calling initcall 0xc036fe2d: acpi_scan_init+0x0/0x16c()
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 11 14 15) *0, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI: Scanning bus 0000:00
PCI: Fixups for bus 0000:00
PCI: Bus scan for 0000:00 returning with max=00
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Calling initcall 0xc03700e7: acpi_cm_sbs_init+0x0/0x9()
Calling initcall 0xc03700f0: pnp_init+0x0/0x20()
Linux Plug and Play Support v0.97 (c) Adam Belay
Calling initcall 0xc0370390: pnpacpi_init+0x0/0x80()
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
Calling initcall 0xc0370dd0: misc_init+0x0/0x70()
Calling initcall 0xc03720b0: init_scsi+0x0/0xa0()
SCSI subsystem initialized
Calling initcall 0xc0372540: serio_init+0x0/0xd0()
Calling initcall 0xc03729a0: input_init+0x0/0x70()
Calling initcall 0xc0373bf0: pci_acpi_init+0x0/0xb0()
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Calling initcall 0xc0373ca0: pci_legacy_init+0x0/0x110()
Calling initcall 0xc0374240: pcibios_irq_init+0x0/0x510()
Calling initcall 0xc0374750: pcibios_init+0x0/0x87()
Calling initcall 0xc036c620: init_pipe_fs+0x0/0x50()
Calling initcall 0xc036ffee: acpi_motherboard_init+0x0/0xf9()
Calling initcall 0xc0370210: pnp_system_init+0x0/0x10()
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe480-0xe4ff has been reserved
pnp: 00:02: ioport range 0xe800-0xe87f has been reserved
pnp: 00:02: ioport range 0x480-0x48f has been reserved
Calling initcall 0xc0370710: chr_dev_init+0x0/0xa0()
Calling initcall 0xc03730f0: pcibios_assign_resources+0x0/0x80()
Calling initcall 0xc01067a0: time_init_device+0x0/0x30()
Calling initcall 0xc035edb0: add_pcspkr+0x0/0x60()
Calling initcall 0xc035ffb0: i8259A_init_sysfs+0x0/0x30()
Calling initcall 0xc03600f0: sbf_init+0x0/0x120()
Simple Boot Flag at 0x3a set to 0x1
Calling initcall 0xc0360210: i8237A_init_sysfs+0x0/0x30()
Calling initcall 0xc0360300: init_pit_clocksource+0x0/0x70()
Calling initcall 0xc03603c0: init_tsc_clocksource+0x0/0x130()
Calling initcall 0xc03657f0: init_lapic_sysfs+0x0/0x40()
Calling initcall 0xc0367700: ioapic_init_sysfs+0x0/0xe0()
Calling initcall 0xc0369270: timekeeping_init_device+0x0/0x30()
Calling initcall 0xc0369520: uid_cache_init+0x0/0xa0()
Calling initcall 0xc0369ab0: init_posix_timers+0x0/0x90()
Calling initcall 0xc0369b70: init_posix_cpu_timers+0x0/0xa0()
Calling initcall 0xc0369d30: init_clocksource_sysfs+0x0/0x50()
Calling initcall 0xc0369d80: init_jiffies_clocksource+0x0/0x10()
Calling initcall 0xc0369d90: init+0x0/0x50()
Calling initcall 0xc0369de0: kallsyms_init+0x0/0x10()
Calling initcall 0xc036b050: init_per_zone_pages_min+0x0/0x60()
Calling initcall 0xc036bc60: pdflush_init+0x0/0x20()
Calling initcall 0xc036bca0: kswapd_init+0x0/0x20()
Calling initcall 0xc036bd20: init_tmpfs+0x0/0xd0()
Calling initcall 0xc036bdf0: cpucache_init+0x0/0x10()
Calling initcall 0xc036c670: fasync_init+0x0/0x40()
Calling initcall 0xc036cda0: aio_setup+0x0/0x80()
Calling initcall 0xc036ce20: eventpoll_init+0x0/0xc0()
Calling initcall 0xc036cf00: init_devpts_fs+0x0/0x30()
Calling initcall 0xc036cf40: init_ramfs_fs+0x0/0x10()
Calling initcall 0xc036d010: init_xfs_fs+0x0/0x120()
SGI XFS with no debug enabled
Calling initcall 0xc036d130: ipc_init+0x0/0x20()
Calling initcall 0xc036d410: noop_init+0x0/0x10()
io scheduler noop registered
Calling initcall 0xc036d420: as_init+0x0/0x70()
io scheduler anticipatory registered (default)
Calling initcall 0xc036d490: deadline_init+0x0/0x70()
io scheduler deadline registered
Calling initcall 0xc036d500: cfq_init+0x0/0x100()
io scheduler cfq registered
Calling initcall 0xc01fc1b0: pci_init+0x0/0x30()
Calling initcall 0xc036dcf0: pci_sysfs_init+0x0/0x40()
Calling initcall 0xc036df20: fb_console_init+0x0/0xf0()
Calling initcall 0xc036e300: sisfb_init+0x0/0x77a()
Calling initcall 0xc036fc5c: irqrouter_init_sysfs+0x0/0x33()
Calling initcall 0xc036fdce: acpi_processor_init+0x0/0x29()
Calling initcall 0xc036fdf7: acpi_thermal_init+0x0/0x14()
Calling initcall 0xc03707c0: rand_initialize+0x0/0x30()
Calling initcall 0xc03707f0: tty_init+0x0/0x210()
Calling initcall 0xc0370a70: pty_init+0x0/0x360()
Calling initcall 0xc03713b0: rtc_init+0x0/0x110()
initcall at 0xc03713b0: rtc_init+0x0/0x110(): returned with error code -12
Calling initcall 0xc0371850: serial8250_init+0x0/0x110()
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Calling initcall 0xc0372380: init_sd+0x0/0x50()
Calling initcall 0xc03723d0: init_sr+0x0/0x30()
Calling initcall 0xc0372400: init_sg+0x0/0x90()
Calling initcall 0xc0372490: ata_init+0x0/0x80()
libata version 2.00 loaded.
Calling initcall 0xc0372510: sis_init+0x0/0x20()
Calling initcall 0xc0372530: cdrom_init+0x0/0x10()
Calling initcall 0xc0372610: i8042_init+0x0/0x390()
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Calling initcall 0xc0372a10: atkbd_init+0x0/0x20()
Calling initcall 0xc0372fd0: init_acpi_pm_clocksource+0x0/0x120()
Calling initcall 0xc0361390: amd_exit_cpu+0x0/0x20()
Calling initcall 0xc0361860: cyrix_exit_cpu+0x0/0x20()
Calling initcall 0xc03618a0: nsc_exit_cpu+0x0/0x20()
Calling initcall 0xc0361ed0: centaur_exit_cpu+0x0/0x20()
Calling initcall 0xc0362210: transmeta_exit_cpu+0x0/0x20()
Calling initcall 0xc0362e40: rise_exit_cpu+0x0/0x20()
Calling initcall 0xc0362f50: nexgen_exit_cpu+0x0/0x20()
Calling initcall 0xc0362f90: umc_exit_cpu+0x0/0x20()
Calling initcall 0xc0365df0: check_nmi_watchdog+0x0/0x1e0()
Testing NMI watchdog ... OK.
Calling initcall 0xc0365d40: init_lapic_nmi_sysfs+0x0/0x40()
Calling initcall 0xc0366170: io_apic_bug_finalize+0x0/0x20()
Calling initcall 0xc03687a0: print_ipi_mode+0x0/0x30()<6>input: AT Translated Set 2 keyboard as /class/input/input0

Using IPI Shortcut mode
Calling initcall 0xc0369c40: clocksource_done_booting+0x0/0x20()
Calling initcall 0xc0249c08<6>Time: tsc clocksource has been installed.
: acpi_poweroff_init+0x0/0x4f()
Calling initcall 0xc036f248: acpi_wakeup_device_init+0x0/0xcc()
Calling initcall 0xc036f332: acpi_sleep_init+0x0/0x92()
ACPI: (supports S0 S1 S3 S4 S5)
Calling initcall 0xc03707b0: seqgen_init+0x0/0x10()
Calling initcall 0xc0371ae0: early_uart_console_switch+0x0/0x90()
VFS: Cannot open root device "305" or unknown-block(3,5)
Please append a correct "root=" boot option
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,5)
 

--LZvS9be/3tNcYl/X--
