Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTIKNkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTIKNkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 09:40:55 -0400
Received: from nat-ph3-wh.rz.uni-karlsruhe.de ([129.13.73.33]:58243 "EHLO
	phoenix.hadiko.de") by vger.kernel.org with ESMTP id S261283AbTIKNkh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 09:40:37 -0400
Date: Thu, 11 Sep 2003 15:40:41 +0200
From: Andreas Bulling <andreas@phoenix.hadiko.de>
To: linux-kernel@vger.kernel.org
Subject: Re: fatal errors in test4/5 with APIC and IRQ routing in Acer 1310LC laptop
Message-ID: <20030911134041.GA25896@phoenix.hadiko.de>
Reply-To: Andreas Bulling <andreas@phoenix.hadiko.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: Linux 2.4.21-xfs i686
X-PGP-Fingerprint: 2507 6CA9 1FA8 619E 7C81  3B3D 2823 45CB 5CCF 7DA9
X-PGP-Info: http://search.keyserver.net:11371/pks/lookup?op=get&search=0x5CCF7DA9
X-PGP-Version: GnuPG 1.2.3 (GNU/Linux)
X-PGP-Key: 1024D/5CCF7DA9
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 September 2003 11:38, Pau Aliagas wrote:
> First of all, I have to boot with pci=noacpi pci=usepirqmask pci=biosirq,
> otherwise, when ifuping the integrated Ethernet controller: VIA
> Technologies, Inc.  VT6102 [Rhine-II], the system freezes with the floppy 
> light on.

> But this is only the first of a set of problems due to IRQs. With this 
> kernel parametres, neither the PCMCIA Cardbus nor the USB are properly 
> configured, resulting in freezes when inserting or ejecting pcmcia cards, 
> or a bluetooth usb device.

> If I use a stock redhat 2.4.20 kernel USB+bluetooh are properly detected 
> and PCMCIA does not hang the computer.

> [...]

I have a similar problem with exactly the same via rhine card:

Under FreeBSD 5.1 everything is working fine, but under
Linux (2.4.21, 2.6.0-test5) scp'ing a file can't be done with more than 40KB/s
(in a 100MBit network).
First the card sends with nearly 130KB/s (also not the expected maximum)
but then pretty fast the transmission falls down to 40KB/s.
I didn't recognize this for a long time because speed of downloading
a file is not affected. 

I tried pci=noacpi and also acpi=off with no effect.

lspci output:
------------------------
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
   Subsystem: Unknown device 1849:3099
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
   Latency: 0
   Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
   Capabilities: [a0] AGP version 2.0
      Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
      Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
   Capabilities: [c0] Power Management version 2
      Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal 
decode])
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
   Latency: 0
   Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
   I/O behind bridge: 0000b000-0000bfff
   Memory behind bridge: dfe00000-dfefffff
   Prefetchable memory behind bridge: bfd00000-dfcfffff
   BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
   Capabilities: [80] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
   Subsystem: Realtek Semiconductor Co., Ltd. RT8139
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (8000ns min, 16000ns max)
   Interrupt: pin A routed to IRQ 10
   Region 0: I/O ports at ec00 [size=256]
   Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=256]
   Expansion ROM at ffff0000 [disabled] [size=64K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
   Subsystem: Realtek Semiconductor Co., Ltd. RT8139
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (8000ns min, 16000ns max)
   Interrupt: pin A routed to IRQ 5
   Region 0: I/O ports at e800 [size=256]
   Region 1: Memory at dffffe00 (32-bit, non-prefetchable) [size=256]
   Expansion ROM at ffff0000 [disabled] [size=64K]

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
   Subsystem: Hauppauge computer works Inc. WinTV Series
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (4000ns min, 10000ns max)
   Interrupt: pin A routed to IRQ 3
   Region 0: Memory at dfdfe000 (32-bit, prefetchable) [size=4K]
   Capabilities: [44] Vital Product Data
   Capabilities: [4c] Power Management version 2
      Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
   Subsystem: Hauppauge computer works Inc. WinTV Series
   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (1000ns min, 63750ns max)
   Interrupt: pin A routed to IRQ 3
   Region 0: Memory at dfdff000 (32-bit, prefetchable) [size=4K]
   Capabilities: [44] Vital Product Data
   Capabilities: [4c] Power Management version 2
      Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
   Subsystem: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
   Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Interrupt: pin A routed to IRQ 11
   Region 0: I/O ports at e400 [size=32]
   Expansion ROM at ffff8000 [disabled] [size=32K]

00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
   Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (3000ns min, 32000ns max)
   Interrupt: pin A routed to IRQ 10
   Region 0: I/O ports at e000 [size=64]
   Capabilities: [dc] Power Management version 1
      Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32, cache line size 08
   Interrupt: pin A routed to IRQ 11
   Region 4: I/O ports at d400 [size=32]
   Capabilities: [80] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32, cache line size 08
   Interrupt: pin B routed to IRQ 10
   Region 4: I/O ports at d800 [size=32]
   Capabilities: [80] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
   Subsystem: VIA Technologies, Inc. USB
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32, cache line size 08
   Interrupt: pin C routed to IRQ 5
   Region 4: I/O ports at dc00 [size=32]
   Capabilities: [80] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
   Subsystem: VIA Technologies, Inc. USB 2.0
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32, cache line size 10
   Interrupt: pin D routed to IRQ 3
   Region 0: Memory at dffffd00 (32-bit, non-prefetchable) [size=256]
   Capabilities: [80] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
   Subsystem: Unknown device 1849:3177
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 0
   Capabilities: [c0] Power Management version 2
      Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master 
IDE (rev 06) (prog-if 8a [Master SecP PriP])
   Subsystem: Unknown device 1849:0571
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32
   Interrupt: pin A routed to IRQ 14
   Region 4: I/O ports at fc00 [size=16]
   Capabilities: [c0] Power Management version 2
      Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
   Subsystem: Unknown device 1849:3065
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
   Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (750ns min, 2000ns max), cache line size 08
   Interrupt: pin A routed to IRQ 11
   Region 0: I/O ports at d000 [size=256]
   Region 1: Memory at dffffc00 (32-bit, non-prefetchable) [size=256]
   Capabilities: [40] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
   Subsystem: ATI Technologies Inc Radeon RV200 QW [Radeon 7500]
   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
   Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
   Latency: 32 (2000ns min), cache line size 08
   Interrupt: pin A routed to IRQ 11
   Region 0: Memory at c0000000 (32-bit, prefetchable) [size=256M]
   Region 1: I/O ports at b800 [size=256]
   Region 2: Memory at dfef0000 (32-bit, non-prefetchable) [size=64K]
   Expansion ROM at dfec0000 [disabled] [size=128K]
   Capabilities: [58] AGP version 2.0
      Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
      Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
   Capabilities: [50] Power Management version 2
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
      Status: D0 PME-Enable- DSel=0 DScale=0 PME-
------------------------

Andreas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
