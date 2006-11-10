Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161905AbWKJSBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161905AbWKJSBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 13:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161920AbWKJSBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 13:01:38 -0500
Received: from bay0-omc2-s2.bay0.hotmail.com ([65.54.246.138]:39654 "EHLO
	bay0-omc2-s2.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1161905AbWKJSBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 13:01:37 -0500
Message-ID: <BAY105-F1670EE9E2BA7C5866F5EFDA3F70@phx.gbl>
X-Originating-IP: [82.226.72.184]
X-Originating-Email: [tobiasoed@hotmail.com]
From: "Tobias Oed" <tobiasoed@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com
Subject: pdc202xx_old+suspend+smartctl -> hard lockup
Date: Fri, 10 Nov 2006 13:01:31 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 10 Nov 2006 18:01:36.0539 (UTC) FILETIME=[438EFEB0:01C704F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, if I run
smartctl -s on /dev/hde
after suspending my machine to ram (echo mem > /sys/power/state), it locks 
up with nothing on serial console, and no sysrq.
If I move hde to hdd, I don't have the problem, so I suspect the problem 
comes from my (on board) pdc20265 ide controller and not the drive.
This is a fc6 system running a vanilla 2.6.18 kernel (the fc kernels have 
the same issue) and smartd disabled.
Tobias
========================
tobsbox:~# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Subsystem: ASUSTeK Computer Inc. A7V266-E Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 0
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 
AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ef000000-efdfffff
        Prefetchable memory behind bridge: eff00000-f7ffffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: ASUSTeK Computer Inc. CMI8738 6ch-MX
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at b800 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Mass storage controller: Promise Technology, Inc. PDC20265 
(FastTrak100 Lite/Ultra100) (rev 02)
        Subsystem: ASUSTeK Computer Inc. Unknown device 8042
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b400 [size=8]
        Region 1: I/O ports at b000 [size=4]
        Region 2: I/O ports at a800 [size=8]
        Region 3: I/O ports at a400 [size=4]
        Region 4: I/O ports at a000 [size=64]
        Region 5: Memory at ee800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at 30000000 [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Lite-On Communications Inc Unknown device 3104
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 9000 [disabled] [size=256]
        Region 1: Memory at ee000000 (32-bit, non-prefetchable) [disabled] 
[size=256]

00:0e.0 Ethernet controller: Atheros Communications, Inc. AR5005G 802.11abg 
NIC (rev 01)
        Subsystem: D-Link System Inc D-Link AirPlus G DWL-G510 Wireless PCI 
Adapter(rev.B)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168 (2500ns min, 7000ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at ed800000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:10.0 Serial controller: 3Com Corp, Modem Division 56K FaxModem Model 5610 
(rev 01) (prog-if 02 [16550])
        Subsystem: 3Com Corp, Modem Division USR 56k Internal FAX Modem 
(Model 2977)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 9400 [size=8]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: ASUSTeK Computer Inc. VT8233A
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a 
[Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc. VT8233A Bus Master ATA100/66/33 IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 8800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 8400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size: 32 bytes
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at 8000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY 
[Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited RV100 QY [Sapphire Radeon VE 7000]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at d800 [size=256]
        Region 2: Memory at ef000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at effe0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- 
Rate=x4
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
========================
tobsbox:~# hdparm -I /dev/hde

/dev/hde:

ATA device, with non-removable media
        Model Number:       MAXTOR 6L060L3
        Serial Number:      663128913879
        Firmware Revision:  A93.0500
Standards:
        Used: ATA/ATAPI-5 T13 1321D revision 1
        Supported: 5 4 3 & some of 6
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:   16514064
        LBA    user addressable sectors:  117266688
        device size with M = 1024*1024:       57259 MBytes
        device size with M = 1000*1000:       60040 MBytes (60 GB)
Capabilities:
        LBA, IORDY(can be disabled)
        bytes avail on r/w long: 4
        Standby timer values: spec'd by Vendor, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = 16
        Recommended acoustic management value: 128, current value: 254
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    Automatic Acoustic Management feature set
           *    Device Configuration Overlay feature set
           *    Mandatory FLUSH_CACHE
           *    SMART error logging
           *    SMART self-test
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
        30min for SECURITY ERASE UNIT.
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct

_________________________________________________________________
Try the next generation of search with Windows Live Search today!  
http://imagine-windowslive.com/minisites/searchlaunch/?locale=en-us&source=hmtagline

