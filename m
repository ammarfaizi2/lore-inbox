Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319448AbSH3Glr>; Fri, 30 Aug 2002 02:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319451AbSH3Glr>; Fri, 30 Aug 2002 02:41:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:58895
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S319448AbSH3Glq>; Fri, 30 Aug 2002 02:41:46 -0400
Date: Thu, 29 Aug 2002 23:41:29 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Sergio Bruder <sergio@bruder.net>
cc: Anssi Saari <as@sci.fi>, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: CD burning at 12x uses excessive CPU, although DMA is
 enabled
In-Reply-To: <20020830043346.GA5793@bruder.net>
Message-ID: <Pine.LNX.4.10.10208292336130.7329-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sergio,

Okay the newest code attempt to tune the system before subdrivers are
loaded.  This ensures that DMA is valid.

See latency comments below.

Andre Hedrick
LAD Storage Consulting Group

On Fri, 30 Aug 2002, Sergio Bruder wrote:

> lspci -vvv
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
> 	Subsystem: Elitegroup Computer Systems: Unknown device 0987
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
> 	Latency: 8
^^^^^^^^^^^^^^^^^^
This tends to really roto-til things.

This needs to be "0" in may tests systems observed.

> 	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [a0] AGP version 2.0
> 		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
> 		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x4
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR+
> 	Latency: 0
^^^^^^^^^^^^^^^^^^

Bet you have nice video performance


> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 0000f000-00000fff
> 	Memory behind bridge: dc000000-ddffffff
> 	Prefetchable memory behind bridge: d0000000-d7ffffff
> 	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
> 	Capabilities: [80] Power Management version 2
> 		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
> 	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 0
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
> 	Subsystem: VIA Technologies, Inc. Bus Master IDE
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32
> 	Region 4: I/O ports at d000 [size=16]
> 	Capabilities: [c0] Power Management version 2
> 		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

