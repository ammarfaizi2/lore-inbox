Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQL2Cx4>; Thu, 28 Dec 2000 21:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbQL2Cxg>; Thu, 28 Dec 2000 21:53:36 -0500
Received: from natmail2.webmailer.de ([192.67.198.65]:18577 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S129485AbQL2CxY>; Thu, 28 Dec 2000 21:53:24 -0500
From: Stefan Hoffmeister <Stefan.Hoffmeister@Econos.de>
To: linux-kernel@vger.kernel.org
Subject: NIC + PCI busmaster problems? (2.2, 2.4) - Was: Re: 8139too driver broken? (2.4-test12)
Date: Fri, 29 Dec 2000 03:23:46 +0100
Organization: Econos
Message-ID: <7dtn4tcuo14d2ktt049a7f3aqik5b6u5nq@4ax.com>
In-Reply-To: <vb074t8d27bdedg6m7pv4c4qqu1f8324cq@4ax.com> <E149X1l-00051k-00@the-village.bc.nu> <6kn94tohu3v901eeod2nf94ish0ct33cci@4ax.com>
In-Reply-To: <6kn94tohu3v901eeod2nf94ish0ct33cci@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Sat, 23 Dec 2000 18:50:53 +0100, Stefan Hoffmeister wrote:

>: On Fri, 22 Dec 2000 18:34:46 +0000 (GMT), Alan Cox wrote:
>
>>2.2.18 might help and also as an '8139too' driver rewrite which may work 
>
>Advancing further to a 2.4-test12 kernel (with the latest available
>8139too driver - 0.9.12) improves the situation even further, but doesn't
>solve it.

Cool, I am talking to myself again.

Is it possible that problems in busmastering support cause these problems
(2.2 + 2.4)?

There has been a bit of "swap the nic" fun, some work with Manfred on the
Realtek, and it seems as if the Realtek 8139 drivers are not to blame,
because a 3com 509C-TX exhibits even worse problems in the same system,
while both the Realtek 8139 and the 3com 509C-TX perform fine (8 MB/s)
when dropped into a different system.

Due to that, I believe that the Realtek itself is not to blame, but the
system it is stuck in :-)

  HP Omnibook 800, P133, 48 MB, in the docking station

  00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
  00:01.0 PCI bridge: VLSI Technology Inc 82C534 (rev 03)
  00:02.0 Class ff00: VLSI Technology Inc 82C532 (rev 02)

  Complete lspci -vv at end of message.

In total, I have tried three different NICs (Realtek 8029(AS), Realtek
8129B, 3com 905C-TX). Of these, only the Realtek 8029(AS) performs as
expected:

* Realtek 8029(AS), ne2k-pci: 
   1100+-1 KB/s send; 1000+-30 KB/s receive (netperf)
   "ping -s 65000" works

but

* Realtek 8139B, 8139too:
   3500+-10 KB/s send; 1300 +-400(!) KB/s receive (netperf)
   "ping -s 4433" (>3 packets) - 100% packet loss at the Realtek

* 3com 905C-TX, 3c59x:
   3500+-10 KB/s send; 400 (!) +-300(!) KB/s receive (netperf)
   "ping -s 2593" (>2 packets) - 100% packet loss at the 3com 905C-TX

* 3com 905C-TX, 3c90x:
   3500+-10 KB/s send; 400 (!) +-300(!) KB/s receive (netperf)
   "ping -s 3300" (>2.5 packets) - 100% packet loss at the 3com 905C-TX

I find it interesting that only the card that *doesn't* do busmastering
(Realtek 8029(AS), according to lspci -vv) performs in an acceptable
manner.

Could busmastering problems be responsible for this?

TIA!
Stefan

**********************************
00:00.0 Host bridge: VLSI Technology Inc 82C535 (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.0 PCI bridge: VLSI Technology Inc 82C534 (rev 03) (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00004000-00007fff
	Memory behind bridge: 20000000-2fffffff
	Prefetchable memory behind bridge: 30000000-3fffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-

00:02.0 Class ff00: VLSI Technology Inc 82C532 (rev 02)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:03.0 VGA compatible controller: Neomagic Corporation NM2070 [MagicGraph
NM2070] (rev 01) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at c0000000 (32-bit, prefetchable)

00:04.0 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin A routed to IRQ 0
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=00, secondary=20, subordinate=22, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1130 (rev 04)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 08
	Interrupt: pin B routed to IRQ 0
	Region 0: Memory at <ignored> (32-bit, non-prefetchable)
	Bus: primary=00, secondary=23, subordinate=25, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite-
	16-bit legacy interface ports at 0001

00:06.0 IRDA controller: VLSI Technology Inc 82C147 (rev 02)
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at 1000

01:00.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810
(rev 11)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2000ns min, 16000ns max), cache line size 04
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 4100
	Region 1: Memory at 20000100 (32-bit, non-prefetchable)

01:05.0 ISA bridge: VLSI Technology Inc 82C538
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

01:06.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
(rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management
NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 128 (2500ns min, 2500ns max), cache line size 04
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 4000
	Region 1: Memory at 20000000 (32-bit, non-prefetchable)
	Expansion ROM at 21f00000
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable+ DSel=0 DScale=2 PME-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
