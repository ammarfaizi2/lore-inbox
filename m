Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUAPCN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbUAPCN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:13:58 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:59061 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263185AbUAPCNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:13:52 -0500
To: linux-kernel@vger.kernel.org
Subject: Bug? 2.4.24 module/networking Kernel driver/net/r8169.c freeze
From: Mathias.Beilstein@t-online.de
Cc: realtek@scyld.com
Date: Fri, 16 Jan 2004 03:13:29 +0100 (CET)
Message-ID: <1074217033.400740491d6ff@webmail.t-online.de>
X-Mailer: T-Online WebMail 3.10
X-Complaints-To: abuse#webmail@t-online.com
X-Seen: false
X-ID: SybTweZGQe6JnGpK+v4FvELfQil78NHf+1HMCbMB4Kc9nuVuCARh8o@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Maintainer:

1. short: smb over tcp delays > 5 sec; flood ping to machine --> machine 
freeze

2. detailed 

Machine is an Intel-Triton II Chipset (Tulip TC48) with an Pentium 233 MMX
Distribution is Suse 8.0 with selfcompiled 2.4.24 kernel
Machine runs for weeks stable with an rtl8139c with the rtl8139too driver.
Now I upgraded to a RTL8169s (32bit) GigEth.
First I recognised reread delay using samba. Analysing using ethereal --> the
tulip does not anser for 4 or 5 seconds.
So I did some stress using flood ping and the machine crashed with no reaction
at all. No OOPS or so.
I would say it looks like dma-buffer, irq-handling?

Enviroment 2 machine (Linux) and a level-one Fastethernet switch in between.
Autonegotiation works (sure). Links are on switch and NIC 100Mbit full duplex.

Output from the second machine about the link:
 mii-diag 
Using the default interface 'eth0'.
Basic registers of MII PHY #1:  3100 786d 0101 8f25 01e1 45e1 0007 2801.
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3100: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

Any Information needed ??? Please ask for that.

Thanx Mathias

Greetings from Berlin


Output was made with the rtl8139C back in place to have network connectivity.
With the 8169s the same IRQ9 is used.




Output from 
 cat /proc/cpuinfo 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 3
cpu MHz		: 232.108
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 463.66
 
cat /proc/interrupts 
           CPU0       
  0:     429475          XT-PIC  timer
  1:        287          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      38415          XT-PIC  ide2
  7:          1          XT-PIC  parport0
  8:          2          XT-PIC  rtc
  9:     832321          XT-PIC  eth0
 10:         22          XT-PIC  aha1542
 11:          0          XT-PIC  usb-uhci
 14:       4605          XT-PIC  ide0
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0



lspci -vvv
00:00.0 Host bridge: Intel Corp. 430VX - 82437VX TVX [Triton VX] (rev 02)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort+ >SERR- <PERR-
	Latency: 32

00:07.0 ISA bridge: Intel Corp. 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Intel Corp. 82371SB PIIX3 IDE [Natoma/Triton II]
(prog-if 80 [Master])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at ecd0 [size=16]00:07.2 USB Controller: Intel Corp.
82371SB PIIX3 USB [Natoma/Triton II] (rev 01) (prog-if 00 [UHCI])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at ece0 [size=32]

00:0b.0 Unknown mass storage controller: Promise Technology, Inc. 20268 (rev
02) (prog-if 85)
	Subsystem: Promise Technology, Inc. Ultra100TX2
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping-
SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec98 [size=8]
	Region 1: I/O ports at eca8 [size=4]
	Region 2: I/O ports at eca0 [size=8]
	Region 3: I/O ports at ecac [size=4]
	Region 4: I/O ports at ecc0 [size=16]
	Region 5: Memory at fedfc000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot
-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-00:0d.0 Ethernet controller:
Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
	Subsystem: Surecom Technology EP-320X-R
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
	Latency: 64 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e800 [size=256]
	Region 1: Memory at fedfbc00 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot
+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 VGA compatible controller: Alliance Semiconductor Corporation ProVideo
6
424 (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: I/O ports at ecb0 [size=16]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:12.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE]
(
rev 16)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Step
ping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort
- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec60 [disabled] [size=32]
	Region 1: Memory at fedfb800 (32-bit, non-prefetchable) [disabled] [size
=32]
	Expansion ROM at <unassigned> [disabled] [size=64K]
