Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUH2IBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUH2IBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 04:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUH2IBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 04:01:07 -0400
Received: from main.gmane.org ([80.91.224.249]:28291 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267341AbUH2IAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 04:00:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Marc_Str=E4mke?= <marcstraemke.work@gmx.net>
Subject: Problem accessing Sandisk CompactFlash Cards (Connected to the IDE
 bus)
Date: Sun, 29 Aug 2004 10:01:33 +0200
Message-ID: <cgs2c1$ccg$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030904060904020702030704"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95f8c6b.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030904060904020702030704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello all,

Iam running an embedded system out of Compactflash. Kernel version is 
2.4.27 (happens with all version i tried, 2.4.21-2.4.27).
The system is in use for a few month already, but i started to 
experience problems with a newer revision of the Compactflash Cards from 
Sandisk, when reading or writing to the device data gets corrupted and 
the following message is written to the logfiles:

hdb: drive not ready for command
hdb: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hdb: drive not ready for command
hdb: irq timeout: status=0xd0 { Busy }

ide0: reset: master: error (0x0a?)


I tried setting a longer WAIT_DRQ timeout in ide.h, but that doesnt 
solve the problem (even with really large values, about 10 times the 
default).
One thing which is interesting about the new card is that it isnt 
detected by the kernel as a CFA device, but just a regular ATA device.

I attached the output of hdparm -I for both cards if that helps.
The IDE controller is a VIA VT82C586A/B/VT82C686/A/B/VT823x/A/C 
(according to /proc/pci).
lspci -vv output is attached too.

Thanks in Advance for any suggestions to this problem.

Marc Strämke



--------------030904060904020702030704
Content-Type: text/plain;
 name="CF_CARD_IDS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CF_CARD_IDS"

Works: 
CompactFlash ATA device, with removable media
        Model Number:       SanDisk SDCFB-128
        Serial Number:      101913J0803Q3424
        Firmware Revision:  Vdi 1.24
Standards:
        Likely used: 4
Configuration:
        Logical         max     current
        cylinders       980     497
        heads           8       8
        sectors/track   32      63
        --
        bytes/track: 0  bytes/sector: 576
        CHS current addressable sectors:     250488
        LBA    user addressable sectors:     250880
        device size with M = 1024*1024:         122 MBytes
        device size with M = 1000*1000:         128 MBytes
Capabilities:
        LBA, IORDY(may be)(cannot be disabled)
        Buffer size: 1.0kB      bytes avail on r/w long: 4      Queue depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 1   Current = 1
        DMA: not supported
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns


does not works:

ATA device, with non-removable media
        Model Number:       SanDisk SDCFB-128
        Serial Number:      109909E2004C5801
        Firmware Revision:  HDX 2.15
Standards:
        Supported: 10
        Likely used: 10
Configuration:
        Logical         max     current
        cylinders       980     980
        heads           8       8
        sectors/track   32      32
        --
        CHS current addressable sectors:     250880
        LBA    user addressable sectors:     250880
        device size with M = 1024*1024:         122 MBytes
        device size with M = 1000*1000:         128 MBytes
Capabilities:
        LBA, IORDY(may be)(cannot be disabled)
        Queue depth: 1
        Standby timer values: spec'd by Vendor
        R/W multiple sector transfer: Max = 1   Current = 1
        DMA: mdma0 mdma1 *mdma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

--------------030904060904020702030704
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

00:00.0 Class 0600: 1106:0691 (rev c4)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 Class 0604: 1106:8598
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e4000000-e5ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 Class 0601: 1106:0686 (rev 40)
	Subsystem: 1106:0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 Class 0101: 1106:0571 (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: 1106:0571
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 Class 0c03: 1106:3038 (rev 1a)
	Subsystem: 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 12
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Class 0680: 1106:3057 (rev 40)
	Subsystem: 1106:3057
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Class 0200: 10ec:8139 (rev 10)
	Subsystem: 10ec:8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at d800 [size=256]
	Region 1: Memory at e7042000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Class 0200: 10ec:8139 (rev 10)
	Subsystem: 10ec:8139
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at dc00 [size=256]
	Region 1: Memory at e7040000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:13.0 Class ff00: 10b5:9050 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Region 0: Memory at e7041000 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at e000 [size=128]
	Region 2: Memory at e7000000 (32-bit, non-prefetchable) [size=256K]

01:00.0 Class 0300: 102c:00c0 (rev 64)
	Subsystem: 102c:00c0
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=16M]
	Expansion ROM at <unassigned> [disabled] [size=256K]


--------------030904060904020702030704--

