Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWKHQds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWKHQds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 11:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161205AbWKHQds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 11:33:48 -0500
Received: from smtpout05-04.prod.mesa1.secureserver.net ([64.202.165.221]:59094
	"HELO smtpout05-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S1161179AbWKHQdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 11:33:46 -0500
Message-ID: <455206E7.2050104@seclark.us>
Date: Wed, 08 Nov 2006 11:33:43 -0500
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Abysmal PATA IDE performance
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I just purchased a VBI-Asus S96F laptop Intel 945GM &  ICH7, with a Core
2 Duo T560,0 2gb pc5400 memory.
  From checking around it appeared all the
hardware was well supported by linux - but I am having major problems.

  the disk which is a 7200rpm Hitachi travelmate pata drive transfers 
data at 1.xx
mb/sec
     according to hdparm. This same drive in my old laptop an HP n5430 
with a
     850 duron the rate was 12-14 mb/sec.

Attached are the output of lspci -vvv, dmesg and hdparm
Any insight would be greatly appreciated.

lspci -vvv:
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub (rev 03)
         Subsystem: Intel Corporation Mobile 945GM/PM/GMS/940GML and
945GT Express Memory Controller Hub
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03)
(prog-if 00 [VGA])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1252
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 5
         Region 0: Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
         Region 1: I/O ports at ec00 [size=8]
         Region 2: Memory at d0000000 (32-bit, prefetchable) [size=256M]
         Region 3: Memory at feb40000 (32-bit, non-prefetchable) [size=256K]
         Capabilities: [90] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/940GML
Express Integrated Graphics Controller (rev 03)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1252
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at fea80000 (32-bit, non-prefetchable) [size=512K]
         Capabilities: [d0] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1343
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 169
         Region 0: Memory at feb38000 (64-bit, non-prefetchable) [size=16K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [70] Express Unknown type IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed unknown, Width x0, ASPM unknown,
Port 0
                 Link: Latency L0s <64ns, L1 <1us
                 Link: ASPM Disabled CommClk- ExtSynch-
                 Link: Speed unknown, Width x0

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 1 (rev 02) (prog-if 00 [Normal decode])
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fff00000-000fffff
         Prefetchable memory behind bridge: 
00000000fff00000-0000000000000000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [40] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, 
Port 1
                 Link: Latency L0s <1us, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x0
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
                 Address: fee00000  Data: 40c9
         Capabilities: [90] #0d [0000]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 2 (rev 02) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fe700000-fe7fffff
         Prefetchable memory behind bridge: 
00000000fff00000-0000000000000000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [40] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, 
Port 2
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
                 Address: fee00000  Data: 40d1
         Capabilities: [90] #0d [0000]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express
Port 3 (rev 02) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 32 bytes
         Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fdf00000-fe6fffff
         Prefetchable memory behind bridge: 
00000000bdf00000-00000000bfe00000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [40] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, 
Port 3
                 Link: Latency L0s <1us, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x0
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn+ PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit-
Queue=0/0 Enable+
                 Address: fee00000  Data: 40d9
         Capabilities: [90] #0d [0000]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 225
         Region 4: I/O ports at e400 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 233
         Region 4: I/O ports at e480 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 185
         Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI
#4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 169
         Region 4: I/O ports at e880 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI
Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 225
         Region 0: Memory at feb3fc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
(prog-if 01 [Subtractive decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fe800000-fe8fffff
         Prefetchable memory behind bridge: 
0000000080000000-0000000080000000
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface
Bridge (rev 02)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family)
Serial ATA Storage Controller IDE (rev 02) (prog-if 80 [Master])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 233
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <unassigned>
         Region 3: I/O ports at <unassigned>
         Region 4: I/O ports at ffa0 [size=16]
         Capabilities: [70] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller
(rev 02)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 233
         Region 4: I/O ports at 0400 [size=32]

03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
Network Connection (rev 02)
         Subsystem: Intel Corporation Unknown device 1000
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at fe7ff000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [c8] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [d0] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [e0] Express Legacy Endpoint IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0,
ExtTag-
                 Device: Latency L0s <512ns, L1 unlimited
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x1, ASPM L0s L1, 
Port 0
                 Link: Latency L0s <128ns, L1 <64us
                 Link: ASPM L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1

05:01.0 FireWire (IEEE 1394): Ricoh Co Ltd Unknown device 0832 (prog-if
10 [OHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max)
         Interrupt: pin A routed to IRQ 169
         Region 0: Memory at fe8fe800 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME+

05:01.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
Adapter (rev 19)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin B routed to IRQ 177
         Region 0: Memory at fe8ff000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

05:01.2 System peripheral: Ricoh Co Ltd Unknown device 0843 (rev 01)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at fe8ff400 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

05:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host
Adapter (rev 0a)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1347
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 10
         Region 0: Memory at fe8ff800 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

05:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169SC
Gigabit Ethernet (rev 10)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1345
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at d800 [size=256]
         Region 1: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=256]
         Expansion ROM at 80000000 [disabled] [size=128K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

dmesg:
Linux version 2.6.18-1.2798.fc6
(brewbuilder@hs20-bc2-4.build.redhat.com) (gcc version 4.1.1 20061011
(Red Hat 4.1.1-30)) #1 SMP Mon Oct 16 14:37:32 EDT 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007f7b0000 (usable)
  BIOS-e820: 000000007f7b0000 - 000000007f7be000 (ACPI data)
  BIOS-e820: 000000007f7be000 - 000000007f7f0000 (ACPI NVS)
  BIOS-e820: 000000007f7f0000 - 000000007f800000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
1143MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
Using x86 segment limits to approximate NX protection
On node 0 totalpages: 522160
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
   HighMem zone: 292784 pages, LIFO batch:31
DMI present.
Using APIC driver default
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000fb700
ACPI: RSDT (v001 A M I  OEMRSDT  0x08000629 MSFT 0x00000097) @ 0x7f7b0000
ACPI: FADT (v002 A M I  OEMFACP  0x08000629 MSFT 0x00000097) @ 0x7f7b0200
ACPI: MADT (v001 A M I  OEMAPIC  0x08000629 MSFT 0x00000097) @ 0x7f7b0390
ACPI: MCFG (v001 A M I  OEMMCFG  0x08000629 MSFT 0x00000097) @ 0x7f7b03f0
ACPI: OEMB (v001 A M I  AMI_OEM  0x08000629 MSFT 0x00000097) @ 0x7f7be040
ACPI: DSDT (v001  A0544 A0544000 0x00000000 INTL 0x20060113) @ 0x00000000
ACPI: PM-Timer IO Port: 0x808
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:15 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 6:15 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 7f800000:7f600000)
Detected 1828.934 MHz processor.
Built 1 zonelists.  Total pages: 522160
Kernel command line: ro root=/dev/VolGroup00/LogVol00 ide1=dma ide1=ata66
ide_setup: ide1=dma -- OBSOLETE OPTION, WILL BE REMOVED SOON!
ide_setup: ide1=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c07ae000 soft=c078e000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2063528k/2088640k available (2138k kernel code, 23752k reserved,
868k data, 240k init, 1171136k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3661.90 BogoMIPS
(lpj=7323807)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
monitor/mwait feature present.
using mwait in idle threads.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000140 0000e3bd
00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
ACPI Warning (utinit-0077): Invalid FADT value PM2_CNT_LEN=0 at offset
5A FADT=f7ff8780 [20060707]
CPU0: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz stepping 06
SMP alternatives: switching to SMP code
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c07af000 soft=c078f000
Initializing CPU#1
Calibrating delay using timer specific routine.. 3657.79 BogoMIPS
(lpj=7315581)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000
0000e3bd 00000000 00000001
monitor/mwait feature present.
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebf3ff 20100000 00000000 00000140 0000e3bd
00000000 00000001
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel(R) Core(TM)2 CPU         T5600  @ 1.83GHz stepping 06
Total of 2 processors activated (7319.69 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
sizeof(vma)=84 bytes
sizeof(page)=32 bytes
sizeof(inode)=424 bytes
sizeof(dentry)=148 bytes
sizeof(ext3inode)=600 bytes
sizeof(buffer_head)=52 bytes
sizeof(skbuff)=172 bytes
sizeof(task_struct)=1392 bytes
migration_cost=43
checking if image is initramfs... it is
Freeing initrd memory: 2119k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: PCI BIOS revision 3.00 entry at 0xf0031, last bus=5
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: Embedded Controller [EC0] (gpe 28) interrupt mode.
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P5._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P6._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs *3 4 5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
PCI: Ignore bogus resource 6 [0:0] of 0000:00:02.0
PCI: Bridge: 0000:00:1c.0
   IO window: disabled.
   MEM window: disabled.
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
   IO window: disabled.
   MEM window: fe700000-fe7fffff
   PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.2
   IO window: c000-cfff
   MEM window: fdf00000-fe6fffff
   PREFETCH window: bdf00000-bfefffff
PCI: Bridge: 0000:00:1e.0
   IO window: d000-dfff
   MEM window: fe800000-fe8fffff
   PREFETCH window: 80000000-800fffff
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1c.0 to 64
ACPI: PCI Interrupt 0000:00:1c.1[B] -> GSI 17 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.1 to 64
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
apm: BIOS not found.
audit: initializing netlink socket (disabled)
audit(1163021534.932:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 8BDC589434DBC709
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.0:pcie00]
Allocate Port Service[0000:00:1c.0:pcie02]
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.1:pcie00]
Allocate Port Service[0000:00:1c.1:pcie02]
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:1c.2:pcie00]
Allocate Port Service[0000:00:1c.2:pcie02]
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [
CPU1PM] [20060707]
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI (exconfig-0455): Dynamic SSDT Load - OemId [   AMI] OemTableId [
CPU2PM] [20060707]
ACPI: CPU1 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU2] (supports 8 throttling states)
ACPI: Thermal Zone [TZ00] (58 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 945GM Chipset.
agpgart: Detected 7932K stolen memory.
agpgart: AGP aperture is 256M @ 0xd0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: HTS721060G9AT00, ATA DISK drive
hdd: HL-DT-ST DVDRAM GMA-4082N, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ide1 at 0x170-0x177,0x376 on irq 15
hdc: max request size: 512KiB
hdc: 117210240 sectors (60011 MB) w/7539KiB Cache, CHS=16383/255/63
hdc: cache flushes supported
  hdc: hdc1 hdc2
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 240k freed
Write protecting the kernel read-only data: 386k
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
input: AT Translated Set 2 keyboard as /class/input/input0
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 225, io base 0x0000e400
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 233, io base 0x0000e480
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 185, io base 0x0000e800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 169, io base 0x0000e880
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt 0000:00:1d.7[A] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 225, io mem 0xfeb3fc00
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usb 2-2: new low speed USB device using uhci_hcd and address 2
Synaptics Touchpad, model: 1, fw: 6.1, id: 0xa3a0b3, caps: 0xa04713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
device-mapper: ioctl: 4.7.0-ioctl (2006-06-24) initialised:
dm-devel@redhat.com
usb 2-2: new low speed USB device using uhci_hcd and address 3
usb 2-2: configuration #1 chosen from 1 choice
input: Logitech USB-PS/2 Trackball as /class/input/input2
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on
usb-0000:00:1d.1-2
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1560 types, 166 bools, 1 sens, 1024 cats
security:  58 classes, 48173 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
audit(1163021543.452:2): policy loaded auid=4294967295
input: PC Speaker as /class/input/input3
ACPI: PCI Interrupt 0000:00:1f.3[B] -> GSI 19 (level, low) -> IRQ 233
sdhci: Secure Digital Host Controller Interface driver, 0.12
sdhci: Copyright(c) Pierre Ossman
sdhci: SDHCI controller found at 0000:05:01.1 [1180:0822] (rev 19)
ACPI: PCI Interrupt 0000:05:01.1[B] -> GSI 17 (level, low) -> IRQ 177
mmc0: SDHCI at 0xfe8ff000 irq 177 DMA
SCSI subsystem initialized
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:05:01.0[A] -> GSI 16 (level, low) -> IRQ 169
libata version 2.00 loaded.
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[169]
MMIO=[fe8fe800-fe8fefff]  Max Packet=[2048]  IR/IT contexts=[4/4]
ata_piix 0000:00:1f.2: version 2.00
ata_piix 0000:00:1f.2: MAP [ P0 P2 IDE IDE ]
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 233
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
scsi0 : ata_piix
ATA: abnormal status 0x7F on port 0x1F7
hdd: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:1b.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1b.0 to 64
hda_codec: Unknown model for ALC882, trying auto-probe from BIOS...
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e01800035ad155]
floppy0: no floppy controllers found
lp: driver loaded but no devices found
ACPI: AC Adapter [AC0] (on-line)
Asus Laptop ACPI Extras version 0.30
   Error calling BSTS
   unsupported model Z96F, trying default values
   send /proc/acpi/dsdt to the developers
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hdc1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1
across:1048568k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses
genfs_contexts
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.10
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack
usb 5-2: new high speed USB device using ehci_hcd and address 3
usb 5-2: configuration #1 chosen from 1 choice
Initializing USB Mass Storage driver...
scsi1 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
   Vendor: Ut161     Model: USB2FlashStorage  Rev: 0.00
   Type:   Direct-Access                      ANSI SCSI revision: 02
usb-storage: device scan complete
scsi 1:0:0:0: Attached scsi generic sg0 type 0
SCSI device sda: 1003520 512-byte hdwr sectors (514 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 1003520 512-byte hdwr sectors (514 MB)
sda: Write Protect is off
sda: Mode Sense: 00 00 00 00
sda: assuming drive cache: write through
  sda: unknown partition table
sd 1:0:0:0: Attached scsi removable disk sda
SELinux: initialized (dev sda, type vfat), uses genfs_contexts

hdparm:

/dev/hdc:
  multcount    = 16 (on)
  IO_support   =  1 (32-bit)
  unmaskirq    =  1 (on)
  using_dma    =  0 (off)
  keepsettings =  0 (off)
  readonly     =  0 (off)
  readahead    = 256 (on)
  geometry     = 16383/255/63, sectors = 117210240, start = 0

/dev/hdc:
  setting using_dma to 1 (on)
  using_dma    =  0 (off)
  HDIO_SET_DMA failed: Operation not permitted

/dev/hdc:
  setting using_dma to 1 (on)
  using_dma    =  0 (off)

/dev/hdc:
  Timing cached reads:   3928 MB in  2.00 seconds = 1964.91 MB/sec
  Timing buffered disk reads:    6 MB in  3.25 seconds =   1.85 MB/sec

-- 

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)




