Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSLWLjg>; Mon, 23 Dec 2002 06:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbSLWLjf>; Mon, 23 Dec 2002 06:39:35 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:12305 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id <S263279AbSLWLjc>; Mon, 23 Dec 2002 06:39:32 -0500
Date: Mon, 23 Dec 2002 12:47:33 +0100
Mime-Version: 1.0 (Apple Message framework v548)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Fwd: [Asterisk] intermittent i4l problems
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <52FFAC74-166C-11D7-A27C-000393950CC2@karlsbakk.net>
X-Mailer: Apple Mail (2.548)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I keep having problems dialing out of my asterisk system with i4l. the
problems are not, however, constant. mostly, I can call out without no
problems, but the, suddenly, I get this 'Everyone is busy at this time'
message. below is a test where I call into the system first and then 
try to
dial out. no lines are in use at this point.

the problem can _sometimes_ be solved by restarting asterisk, or 
restarting linux with a cold reboot.

the problem arises in all kernels I've tried; from 2.4.18 to 2.4.20 
(now dtmf-patched).
lspci -vvv output is pasted below the asterisk output.


----------- asterisk output
pbx*CLI>
   == Accepting call on 'Modem[i4l]/ttyI20' (98013356)
     -- Executing Dial("Modem[i4l]/ttyI20", "MGCP/aaln/1@iptlf01") in 
new stack
     -- Called aaln/1@iptlf01
     -- MGCP/aaln/1@iptlf01 is ringing
     -- /dev/ttyI20 was hung up on before we answered
   == Spawn extension (roy, s, 1) exited non-zero on 'Modem[i4l]/ttyI20'
     -- Hungup 'Modem[i4l]/ttyI20'
   == Accepting call on 'MGCP/aaln/1@iptlf01'
     -- Executing Goto("MGCP/aaln/1@iptlf01", "ringring|BYEXTENSION|1") 
in new
stack
     -- Goto (ringring,98013356,1)
     -- Executing Dial("MGCP/aaln/1@iptlf01", 
"Modem/ttyI0:BYEXTENSION|120|r")
in new stack
     -- Called ttyI0:98013356
     -- Modem[i4l]/ttyI0 is busy
   == Everyone is busy at this time
     -- Hungup 'Modem[i4l]/ttyI0'
     -- Executing Dial("MGCP/aaln/1@iptlf01", 
"Modem/ttyI1:BYEXTENSION|120|r")
in new stack
     -- Called ttyI1:98013356
     -- Modem[i4l]/ttyI1 is busy
   == Everyone is busy at this time
     -- Hungup 'Modem[i4l]/ttyI1'
     -- Executing Dial("MGCP/aaln/1@iptlf01", 
"Modem/ttyI2:BYEXTENSION|120|r")
in new stack
     -- Called ttyI2:98013356
     -- Hungup 'Modem[i4l]/ttyI2'
   == Spawn extension (ringring, 98013356, 3) exited non-zero on
'MGCP/aaln/1@iptlf01'



---------- lsci -vvv
root@pbx ~># lspci -vvv
00:00.0 Host bridge: Intel Corp. 82820 820 (Camino) Chipset Host Bridge 
(MCH) (rev 03)
         Subsystem: Asustek Computer, Inc.: Unknown device 801a
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 82820 820 (Camino) Chipset AGP Bridge 
(rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         I/O behind bridge: 0000e000-0000dfff
         Memory behind bridge: c7f00000-c7efffff
         Prefetchable memory behind bridge: d0000000-cfffffff
         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:1e.0 PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 02) (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000b000-0000dfff
         Memory behind bridge: c5000000-c7efffff
         Prefetchable memory behind bridge: c7f00000-cfffffff
         BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 02)
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801AA IDE (rev 02) (prog-if 80 
[Master])
         Subsystem: Intel Corp. 82801AA IDE
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 4: I/O ports at a800 [size=16]

00:1f.2 USB Controller: Intel Corp. 82801AA USB (rev 02) (prog-if 00 
[UHCI])
         Subsystem: Intel Corp. 82801AA USB
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 19
         Region 4: I/O ports at a400 [size=32]

00:1f.3 SMBus: Intel Corp. 82801AA SMBus (rev 02)
         Subsystem: Intel Corp. 82801AA SMBus
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 17
         Region 4: I/O ports at e800 [size=16]

02:06.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C (rev 10)
         Subsystem: Realtek Semiconductor Co., Ltd. RT8139
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (8000ns min, 16000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at d800 [size=256]
         Region 1: Memory at c7000000 (32-bit, non-prefetchable) 
[size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE/SG 
(prog-if 00 [VGA])
         Subsystem: ATI Technologies Inc Rage 128 AIW
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 128 (2000ns min), cache line size 08
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at c8000000 (32-bit, prefetchable) [size=64M]
         Region 1: I/O ports at d400 [size=256]
         Region 2: Memory at c6800000 (32-bit, non-prefetchable) 
[size=16K]
         Expansion ROM at c7fe0000 [disabled] [size=128K]
         Capabilities: [5c] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Network controller: Cologne Chip Designs GmbH ISDN network 
controller [HFC-PCI] (rev 02)
         Subsystem: Cologne Chip Designs GmbH ISDN Board
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (4000ns max)
         Interrupt: pin A routed to IRQ 17
         Region 0: I/O ports at d000 [disabled] [size=8]
         Region 1: Memory at c6000000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0a.0 Network controller: Cologne Chip Designs GmbH ISDN network 
controller [HFC-PCI] (rev 02)
         Subsystem: Cologne Chip Designs GmbH ISDN Board
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (4000ns max)
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at b800 [disabled] [size=8]
         Region 1: Memory at c5800000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:0b.0 Network controller: Cologne Chip Designs GmbH ISDN network 
controller [HFC-PCI] (rev 02)
         Subsystem: Cologne Chip Designs GmbH ISDN Board
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (4000ns max)
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at b400 [disabled] [size=8]
         Region 1: Memory at c5000000 (32-bit, non-prefetchable) 
[size=256]
         Capabilities: [40] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+


-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

