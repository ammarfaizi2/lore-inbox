Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbUEMMyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbUEMMyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 08:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUEMMyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 08:54:14 -0400
Received: from zork.zork.net ([64.81.246.102]:29838 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263169AbUEMMyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 08:54:05 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: i810 AGP fails to initialise (was Re: 2.6.6-mm2)
References: <20040513032736.40651f8e.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org
Date: Thu, 13 May 2004 13:54:03 +0100
In-Reply-To: <20040513032736.40651f8e.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 13 May 2004 03:27:36 -0700")
Message-ID: <6usme4v66s.fsf@zork.zork.net>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> bk-agpgart.patch
>

With this patch applied, agpgart doesn't initialise on my Dell
OptiPlex GX110, causing drm to fail to initialise.

  Linux agpgart interface v0.100 (c) Dave Jones
  [drm:i810_probe] *ERROR* Cannot initialize the agpgart module.

Here are the messages from successful initialisation with the patch
reverted.

  Linux agpgart interface v0.100 (c) Dave Jones
  agpgart: Detected an Intel i810 E Chipset.
  agpgart: Maximum main memory to use for agp memory: 320M
  agpgart: detected 4MB dedicated video ram.
  agpgart: AGP aperture is 64M @ 0xf8000000
  [drm] Initialized i810 1.4.0 20030605 on minor 0: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller]


Here is the lspci -vvvv output:

0000:00:00.0 Host bridge: Intel Corp. 82810E DC-133 GMCH [Graphics Memory Controller Hub] (rev 03)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0

0000:00:01.0 VGA compatible controller: Intel Corp. 82810E DC-133 CGC [Chipset Graphics Controller] (rev 03) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at f8000000 (32-bit, prefetchable)
	Region 1: Memory at ff000000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd000000-feffffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-

0000:00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 [Master])
	Subsystem: Intel Corp. 82801AA IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 4: I/O ports at ffa0 [size=16]

0000:00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 [UHCI])
	Subsystem: Intel Corp. 82801AA USB
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ff80 [size=32]

0000:00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
	Subsystem: Intel Corp. 82801AA SMBus
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 10
	Region 4: I/O ports at dcd0 [size=16]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 02)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at d800
	Region 1: I/O ports at dc80 [size=64]

0000:01:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 78)
	Subsystem: Dell Computer Corporation: Unknown device 00b4
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at e480 [size=fe000000]
	Region 1: Memory at fdffe400 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at 00020000 [disabled]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

