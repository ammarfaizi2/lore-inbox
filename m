Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWFJN7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFJN7Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFJN7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:59:16 -0400
Received: from cernmx06.cern.ch ([137.138.166.160]:38066 "EHLO
	cernmxlb.cern.ch") by vger.kernel.org with ESMTP id S1750751AbWFJN7P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:59:15 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; s=beta; d=cern.ch; q=dns; 
	h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding;
	b=QtKeEWWbWNB37Ov4udoFDP0+JO8xOAaACw1iiiwnABrr/wl0AlrzneF+TlExLawWx8BIG3qugToPiHtfKKB5sKVVVNdh1a6HvaTuMM9Mg7BLiv2O0lRIwZBWIn3P+iqI;
Keywords: CERN SpamKiller Note: -49 Charset: west-latin
X-Filter: CERNMX06 CERN MX v2.0 051012.1312 Release
Message-ID: <448AD022.2070004@cern.ch>
Date: Sat, 10 Jun 2006 15:58:58 +0200
From: Stijn De Weirdt <Stijn.De.Weirdt@cern.ch>
Organization: CERN
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: lsot pci devices after bios upgrade
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2006 13:59:01.0122 (UTC) FILETIME=[06A6DE20:01C68C96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,

i have the following issue:
between two bios versions i've lost 2 pci devices. is there anyway to 
tell the kernel to look for these devices using info obtained with the 
working older bios version?

i'm not entirely sure this is the correct place to ask. i ran into this 
using lots of 2.6.1[567]-<some patch> versions, so maybe it's not kernel 
related.

more system and problem details at the end.

any help or suggestions are welcome (and yes, i contacted the 
manufacturer, but they don't care (didn't even want to provide other 
older bios versions. and i need the bios for newer release of the video 
card driver.))

(i'm not on the list, so please CC me in replies)

many thanks,

stijn

------------------------------------------------------------------
the difference is in probing the pci:

with working bios i get
[root@localhost ~]# lspci -x -t
-[0000:00]-+-00.0
	   +-01.0-[0000:01]----00.0
	   +-1b.0
	   +-1c.0-[0000:02]----00.0
	   +-1c.1-[0000:03]----00.0
	   +-1c.2-[0000:04-05]--
	   +-1c.3-[0000:06]--
	   +-1d.0
   	   +-1d.1
	   +-1d.2
	   +-1d.3
	   +-1d.7
  	   +-1e.0-[0000:07]--+-01.0
	   |		     +-01.1
	   | 		     +-01.2
	   | 		     +-01.3
	   | 		     \-01.4
	   +-1f.0
	   \-1f.1

with the bad bios 0000:00:1c isn't found at all. (ofcourse 0000:02 and 
0000:03 are my network devices.)

the pci detecting part of dmesg with working bios:
(output of 2.6.17-rc6-mm1, but it's not -mm or -rc related)

ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI: Scanning bus 0000:00
PCI: Found 0000:00:00.0 [8086/27a0] 000600 00
PCI: Calling quirk c01d784b for 0000:00:00.0
PCI: Calling quirk c01d73a4 for 0000:00:00.0
PCI: Calling quirk c026ee00 for 0000:00:00.0
PCI: Calling quirk c026eebe for 0000:00:00.0
PCI: Calling quirk c026f271 for 0000:00:00.0
PCI: Found 0000:00:01.0 [8086/27a1] 000604 01
PCI: Calling quirk c01d784b for 0000:00:01.0
PCI: Calling quirk c01d73a4 for 0000:00:01.0
PCI: Calling quirk c026ee00 for 0000:00:01.0
PCI: Calling quirk c026eebe for 0000:00:01.0
PCI: Calling quirk c026f271 for 0000:00:01.0
PCI: Found 0000:00:1b.0 [8086/27d8] 000403 00
PCI: Calling quirk c01d784b for 0000:00:1b.0
PCI: Calling quirk c01d73a4 for 0000:00:1b.0
PCI: Calling quirk c026ee00 for 0000:00:1b.0
PCI: Calling quirk c026eebe for 0000:00:1b.0
PCI: Calling quirk c026f271 for 0000:00:1b.0
PCI: Found 0000:00:1c.0 [8086/27d0] 000604 01
PCI: Calling quirk c01d784b for 0000:00:1c.0
PCI: Calling quirk c01d73a4 for 0000:00:1c.0
PCI: Calling quirk c026ee00 for 0000:00:1c.0
PCI: Calling quirk c026eebe for 0000:00:1c.0
PCI: Calling quirk c026f271 for 0000:00:1c.0
PCI: Found 0000:00:1c.1 [8086/27d2] 000604 01
PCI: Calling quirk c01d784b for 0000:00:1c.1
PCI: Calling quirk c01d73a4 for 0000:00:1c.1
PCI: Calling quirk c026ee00 for 0000:00:1c.1
PCI: Calling quirk c026eebe for 0000:00:1c.1
PCI: Calling quirk c026f271 for 0000:00:1c.1
PCI: Found 0000:00:1c.2 [8086/27d4] 000604 01
PCI: Calling quirk c01d784b for 0000:00:1c.2
PCI: Calling quirk c01d73a4 for 0000:00:1c.2
PCI: Calling quirk c026ee00 for 0000:00:1c.2
PCI: Calling quirk c026eebe for 0000:00:1c.2
PCI: Calling quirk c026f271 for 0000:00:1c.2
PCI: Found 0000:00:1c.3 [8086/27d6] 000604 01
PCI: Calling quirk c01d784b for 0000:00:1c.3
PCI: Calling quirk c01d73a4 for 0000:00:1c.3
PCI: Calling quirk c026ee00 for 0000:00:1c.3
PCI: Calling quirk c026eebe for 0000:00:1c.3
PCI: Calling quirk c026f271 for 0000:00:1c.3
PCI: Found 0000:00:1d.0 [8086/27c8] 000c03 00
PCI: Calling quirk c01d784b for 0000:00:1d.0
PCI: Calling quirk c01d73a4 for 0000:00:1d.0
PCI: Calling quirk c026ee00 for 0000:00:1d.0
PCI: Calling quirk c026eebe for 0000:00:1d.0
PCI: Calling quirk c026f271 for 0000:00:1d.0
PCI: Found 0000:00:1d.1 [8086/27c9] 000c03 00
PCI: Calling quirk c01d784b for 0000:00:1d.1
PCI: Calling quirk c01d73a4 for 0000:00:1d.1
PCI: Calling quirk c026ee00 for 0000:00:1d.1
PCI: Calling quirk c026eebe for 0000:00:1d.1
PCI: Calling quirk c026f271 for 0000:00:1d.1
PCI: Found 0000:00:1d.2 [8086/27ca] 000c03 00
PCI: Calling quirk c01d784b for 0000:00:1d.2
PCI: Calling quirk c01d73a4 for 0000:00:1d.2
PCI: Calling quirk c026ee00 for 0000:00:1d.2
PCI: Calling quirk c026eebe for 0000:00:1d.2
PCI: Calling quirk c026f271 for 0000:00:1d.2
PCI: Found 0000:00:1d.3 [8086/27cb] 000c03 00
PCI: Calling quirk c01d784b for 0000:00:1d.3
PCI: Calling quirk c01d73a4 for 0000:00:1d.3
PCI: Calling quirk c026ee00 for 0000:00:1d.3
PCI: Calling quirk c026eebe for 0000:00:1d.3
PCI: Calling quirk c026f271 for 0000:00:1d.3
PCI: Found 0000:00:1d.7 [8086/27cc] 000c03 00
PCI: Calling quirk c01d784b for 0000:00:1d.7
PCI: Calling quirk c01d73a4 for 0000:00:1d.7
PCI: Calling quirk c026ee00 for 0000:00:1d.7
PCI: Calling quirk c026eebe for 0000:00:1d.7
PCI: Calling quirk c026f271 for 0000:00:1d.7
PCI: Found 0000:00:1e.0 [8086/2448] 000604 01
PCI: Calling quirk c01d784b for 0000:00:1e.0
PCI: Calling quirk c01d73a4 for 0000:00:1e.0
PCI: Calling quirk c026ee00 for 0000:00:1e.0
PCI: Calling quirk c026eebe for 0000:00:1e.0
PCI: Calling quirk c026f271 for 0000:00:1e.0
PCI: Found 0000:00:1f.0 [8086/27b9] 000601 00
PCI: Calling quirk c01d784b for 0000:00:1f.0
PCI: Calling quirk c01d73a4 for 0000:00:1f.0
PCI: Calling quirk c026ee00 for 0000:00:1f.0
PCI: Calling quirk c026eebe for 0000:00:1f.0
PCI: Calling quirk c026f271 for 0000:00:1f.0
PCI: Found 0000:00:1f.1 [8086/27df] 000101 00
PCI: Calling quirk c01d784b for 0000:00:1f.1
PCI: Calling quirk c01d73a4 for 0000:00:1f.1
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Calling quirk c026ee00 for 0000:00:1f.1
PCI: Calling quirk c026eebe for 0000:00:1f.1
PCI: Calling quirk c026f271 for 0000:00:1f.1
PCI: Fixups for bus 0000:00
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 0
PCI: Scanning bus 0000:01
PCI: Found 0000:01:00.0 [10de/01d8] 000300 00
PCI: Calling quirk c01d73a4 for 0000:01:00.0
PCI: Calling quirk c026ee00 for 0000:01:00.0
PCI: Calling quirk c026f271 for 0000:01:00.0
Boot video device is 0000:01:00.0
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 0
PCI: Scanning bus 0000:02
PCI: Found 0000:02:00.0 [10ec/8168] 000200 00
PCI: Calling quirk c01d73a4 for 0000:02:00.0
PCI: Calling quirk c026ee00 for 0000:02:00.0
PCI: Calling quirk c026f271 for 0000:02:00.0
PCI: Fixups for bus 0000:02
PCI: Bus scan for 0000:02 returning with max=02
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 030300, pass 0
PCI: Scanning bus 0000:03
PCI: Found 0000:03:00.0 [8086/4222] 000280 00
PCI: Calling quirk c01d784b for 0000:03:00.0
PCI: Calling quirk c01d73a4 for 0000:03:00.0
PCI: Calling quirk c026ee00 for 0000:03:00.0
PCI: Calling quirk c026eebe for 0000:03:00.0
PCI: Calling quirk c026f271 for 0000:03:00.0
PCI: Fixups for bus 0000:03
PCI: Bus scan for 0000:03 returning with max=03
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 050400, pass 0
PCI: Scanning bus 0000:04
PCI: Fixups for bus 0000:04
PCI: Bus scan for 0000:04 returning with max=04
PCI: Scanning behind PCI bridge 0000:00:1c.3, config 060600, pass 0
PCI: Scanning bus 0000:06
PCI: Fixups for bus 0000:06
PCI: Bus scan for 0000:06 returning with max=06
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070700, pass 0
PCI: Scanning bus 0000:07
PCI: Found 0000:07:01.0 [1180/0832] 000c00 00
PCI: Calling quirk c01d73a4 for 0000:07:01.0
PCI: Calling quirk c026ee00 for 0000:07:01.0
PCI: Calling quirk c026f271 for 0000:07:01.0
PCI: Found 0000:07:01.1 [1180/0822] 000805 00
PCI: Calling quirk c01d73a4 for 0000:07:01.1
PCI: Calling quirk c026ee00 for 0000:07:01.1
PCI: Calling quirk c026f271 for 0000:07:01.1
PCI: Found 0000:07:01.2 [1180/0843] 000880 00
PCI: Calling quirk c01d73a4 for 0000:07:01.2
PCI: Calling quirk c026ee00 for 0000:07:01.2
PCI: Calling quirk c026f271 for 0000:07:01.2
PCI: Found 0000:07:01.3 [1180/0592] 000880 00
PCI: Calling quirk c01d73a4 for 0000:07:01.3
PCI: Calling quirk c026ee00 for 0000:07:01.3
PCI: Calling quirk c026f271 for 0000:07:01.3
PCI: Found 0000:07:01.4 [1180/0852] 000880 00
PCI: Calling quirk c01d73a4 for 0000:07:01.4
PCI: Calling quirk c026ee00 for 0000:07:01.4
PCI: Calling quirk c026f271 for 0000:07:01.4
PCI: Fixups for bus 0000:07
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus scan for 0000:07 returning with max=07
PCI: Scanning behind PCI bridge 0000:00:01.0, config 010100, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.0, config 020200, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.1, config 030300, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.2, config 050400, pass 1
PCI: Scanning behind PCI bridge 0000:00:1c.3, config 060600, pass 1
PCI: Scanning behind PCI bridge 0000:00:1e.0, config 070700, pass 1
PCI: Bus scan for 0000:00 returning with max=07
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1b.0
PM: Adding info for pci:0000:00:1c.0
PM: Adding info for pci:0000:00:1c.1
PM: Adding info for pci:0000:00:1c.2
PM: Adding info for pci:0000:00:1c.3
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.3
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:03:00.0
PM: Adding info for pci:0000:07:01.0
PM: Adding info for pci:0000:07:01.1
PM: Adding info for pci:0000:07:01.2
PM: Adding info for pci:0000:07:01.3
PM: Adding info for pci:0000:07:01.4

------
system details
it's an asus laptop v6j, the working bios version is 208, the failing 
one 212.

this is output of lspci:
[root@localhost ~]# lspci -vvv
00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 
945GT Express Memory Controller Hub (rev 03)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 
945GT Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: f9f00000-fdffffff
         Prefetchable memory behind bridge: 
00000000bdf00000-00000000dde00000
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [88] #0d [0000]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [90] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [a0] Express Root Port (Slot+) IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s <64ns, L1 <1us
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                 Device: MaxPayload 128 bytes, MaxReadReq 128 bytes
                 Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 2
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM L0s L1 Enabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x16
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug- 
Surpise-
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                 Slot: AttnInd Off, PwrInd On, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
Definition Audio Controller (rev 02)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1213
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at febfc000 (64-bit, non-prefetchable) [size=16K]
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
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: fe000000-fe0fffff
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
                 Link: Speed 2.5Gb/s, Width x1
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
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
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fe100000-fe1fffff
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
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
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
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fe200000-fe9fffff
         Prefetchable memory behind bridge: 
00000000ddf00000-00000000dfe00000
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
Port 3
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [90] #0d [0000]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1c.3 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express 
Port 4 (rev 02) (prog-if 00 [Normal decode])
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
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
Port 4
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM Disabled RCB 64 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x1
                 Slot: AtnBtn- PwrCtrl- MRL- AtnInd- PwrInd- HotPlug+ 
Surpise+
                 Slot: Number 0, PowerLimit 0.000000
                 Slot: Enabled AtnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq-
                 Slot: AttnInd Unknown, PwrInd Unknown, Power-
                 Root: Correctable- Non-Fatal- Fatal- PME-
         Capabilities: [80] Message Signalled Interrupts: 64bit- 
Queue=0/0 Enable-
                 Address: 00000000  Data: 0000
         Capabilities: [90] #0d [0000]
         Capabilities: [a0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 20
         Region 4: I/O ports at ec00 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 19
         Region 4: I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin C routed to IRQ 18
         Region 4: I/O ports at e800 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI 
#4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin D routed to IRQ 16
         Region 4: I/O ports at e480 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 20
         Region 0: Memory at febfbc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2) 
(prog-if 01 [Subtractive decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=07, subordinate=07, sec-latency=32
         I/O behind bridge: 0000f000-00000fff
         Memory behind bridge: fea00000-feafffff
         Prefetchable memory behind bridge: 
00000000fff00000-0000000000000000
         Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface 
Bridge (rev 02)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [e0] Vendor Specific Information

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
Controller (rev 02) (prog-if 8a [Master SecP PriP])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 18
         Region 0: I/O ports at <unassigned>
         Region 1: I/O ports at <unassigned>
         Region 2: I/O ports at <ignored>
         Region 3: I/O ports at <ignored>
         Region 4: I/O ports at ffa0 [size=16]

01:00.0 VGA compatible controller: nVidia Corporation GeForce Go 7400 
(rev a1) (prog-if 00 [VGA])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1211
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Region 1: Memory at c0000000 (64-bit, prefetchable) [size=256M]
         Region 3: Memory at fc000000 (64-bit, non-prefetchable) [size=16M]
         [virtual] Expansion ROM at fbfe0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [68] Message Signalled Interrupts: 64bit+ 
Queue=0/0 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [78] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 128 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s <256ns, L1 <4us
                 Device: AtnBtn- AtnInd- PwrInd-
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x16, ASPM L0s L1, 
Port 0
                 Link: Latency L0s <256ns, L1 <4us
                 Link: ASPM L0s L1 Enabled RCB 128 bytes CommClk+ ExtSynch-
                 Link: Speed 2.5Gb/s, Width x16

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Unknown 
device 8168 (rev 01)
         Subsystem: ASUSTeK Computer Inc. Unknown device 11f5
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0, Cache Line Size 08
         Interrupt: pin A routed to IRQ 16
         Region 0: I/O ports at c800 [size=256]
         Region 2: Memory at fe0ff000 (64-bit, non-prefetchable) [size=4K]
         Expansion ROM at fe0e0000 [disabled] [size=64K]
         Capabilities: [40] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
         Capabilities: [48] Vital Product Data
         Capabilities: [50] Message Signalled Interrupts: 64bit+ 
Queue=0/1 Enable-
                 Address: 0000000000000000  Data: 0000
         Capabilities: [60] Express Endpoint IRQ 0
                 Device: Supported: MaxPayload 1024 bytes, PhantFunc 0, 
ExtTag-
                 Device: Latency L0s unlimited, L1 unlimited
                 Device: AtnBtn+ AtnInd+ PwrInd+
                 Device: Errors: Correctable- Non-Fatal- Fatal- Unsupported-
                 Device: RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                 Device: MaxPayload 128 bytes, MaxReadReq 512 bytes
                 Link: Supported Speed 2.5Gb/s, Width x4, ASPM L0s L1, 
Port 0
                 Link: Latency L0s unlimited, L1 unlimited
                 Link: ASPM Disabled RCB 64 bytes CommClk- ExtSynch-
                 Link: Speed 2.5Gb/s, Width x4
         Capabilities: [84] Vendor Specific Information

03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG 
Network Connection (rev 02)
         Subsystem: Intel Corporation Unknown device 1001
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 17
         Region 0: Memory at fe1ff000 (32-bit, non-prefetchable) [size=4K]
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

07:01.0 FireWire (IEEE 1394): Ricoh Co Ltd Unknown device 0832 (prog-if 
10 [OHCI])
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64 (500ns min, 1000ns max)
         Interrupt: pin A routed to IRQ 16
         Region 0: Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
         Capabilities: [dc] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME+

07:01.1 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host 
Adapter (rev 19)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 64
         Interrupt: pin B routed to IRQ 17
         Region 0: Memory at feaff400 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

07:01.2 System peripheral: Ricoh Co Ltd Unknown device 0843 (rev 01)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at feaff000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

07:01.3 System peripheral: Ricoh Co Ltd R5C592 Memory Stick Bus Host 
Adapter (rev 0a)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at feafec00 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-

07:01.4 System peripheral: Ricoh Co Ltd xD-Picture Card Controller (rev 05)
         Subsystem: ASUSTeK Computer Inc. Unknown device 1217
         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin B routed to IRQ 11
         Region 0: Memory at feafe800 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=2 PME-



