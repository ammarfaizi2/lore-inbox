Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272439AbRH3Umf>; Thu, 30 Aug 2001 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272438AbRH3UmZ>; Thu, 30 Aug 2001 16:42:25 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:14345 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S272434AbRH3UmO>;
	Thu, 30 Aug 2001 16:42:14 -0400
To: <linux-kernel@vger.kernel.org>
Subject: OHCI1394 hangs
From: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Date: 30 Aug 2001 22:32:34 +0200
Message-ID: <m31yltl259.fsf@intrepid.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.4.9 UP kernel here, OHCI 1394 Exsys card + Sony DCR-TRV110E Digital8
camcorder. 440BX mobo.

The problem manifests itselt when I turn the camera off and then try
to load the ohci1394 driver. It halts with the following messages
(debugging on, hand-edited):

devctl: Bus reset requested
Get PHY Req timeout [0x0/0x0/100]
IntEvent: 20010
irq_handler: Bus reset requested
Cancel request received
IntEvent: 20000
IntEvent: 20000
(this message loops here)

The driver loads and works correctly when the camera is on or when nothing
is connected to 1394 bus.



00:0d.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 32 (750ns min, 1000ns max), cache line size 08
  Interrupt: pin A routed to IRQ 10
  Region 0: Memory at d9004000 (32-bit, non-prefetchable) [size=2K]
  Region 1: Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
  Capabilities: [44] Power Management version 1
  Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-


The IRQ is being shared with (inactive) SB Live:

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
  Subsystem: Creative Labs CT4832 SBLive! Value
  Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
  Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
  Latency: 32 (500ns min, 5000ns max)
  Interrupt: pin A routed to IRQ 10
  Region 0: I/O ports at d800 [size=32]
  Capabilities: [dc] Power Management version 1
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Any ideas?
-- 
Krzysztof Halasa
Network Administrator
