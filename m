Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbUCVTHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCVTHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:07:24 -0500
Received: from imo-d01.mx.aol.com ([205.188.157.33]:60390 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S262263AbUCVTG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:06:57 -0500
Message-ID: <405F3948.7040901@netscape.net>
Date: Mon, 22 Mar 2004 13:06:48 -0600
From: "Eric G. Stern" <egstern1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Martin Mares <mj@ucw.cz>
Subject: [PATCH] handle Toshiba deskstation PCI-PCI bridge
Content-Type: multipart/mixed;
 boundary="------------050308060207060501060506"
X-AOL-IP: 69.17.21.202
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------050308060207060501060506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a Toshiba Tecra 750 CDM laptop mounted in a Toshiba docking 
station which has PCI slots.  In all recent kernels the PCI-PCI bridge 
is not handled correctly and the PCI cards in the docking station are 
inaccessable because of PCI conflicts.  The enclosed patch against 
kernel 2.6.4 fixes this in a manner similar to the fix for a PCMCIA 
issue in this device discussed here about a year ago.

These are the messages I get without this patch:

PCI: PCI BIOS revision 2.10 entry at 0xfd506, last bus=21
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Cannot allocate resource region 0 of device 01:01.0
PCI: Cannot allocate resource region 0 of device 01:0d.0
PCI: Cannot allocate resource region 1 of device 01:0d.0
PCI: Failed to allocate resource 0(0-7f) for 01:01.0
PCI: Failed to allocate resource 0(0-fff) for 01:04.0
PCI: Failed to allocate resource 0(0-fff) for 01:04.1
PCI: Failed to allocate resource 0(0-ff) for 01:0d.0
PCI: Failed to allocate resource 1(0-ff) for 01:0d.0

This is my lspci -v -v -v

>00:00.0 Host bridge: Toshiba America Info Systems 601 (rev 2c)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
>   Latency: 0, Cache Line Size: 0x08 (32 bytes)
>
>00:02.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 03)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0
>   Interrupt: pin A routed to IRQ 0
>   Region 0: Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
>   Bus: primary=00, secondary=14, subordinate=14, sec-latency=0
>   Memory window 0: 00000000-00000000
>   Memory window 1: 00000000-00000000
>   I/O window 0: 00000000-00000003
>   I/O window 1: 00000000-00000003
>   BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
>   16-bit legacy interface ports at 0001
>
>00:02.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 03)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0
>   Interrupt: pin B routed to IRQ 0
>   Region 0: Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
>   Bus: primary=00, secondary=15, subordinate=15, sec-latency=0
>   Memory window 0: 00000000-00000000
>   Memory window 1: 00000000-00000000
>   I/O window 0: 00000000-00000003
>   I/O window 1: 00000000-00000003
>   BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
>   16-bit legacy interface ports at 0001
>
>00:03.0 ISA bridge: Toshiba America Info Systems: Unknown device 060e (rev 02)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>
>00:04.0 VGA compatible controller: S3 Inc. ViRGE/MX (rev 06) (prog-if 00 [VGA])
>   Subsystem: Toshiba America Info Systems ViRGE/MX
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0 (1000ns min, 63750ns max)
>   Region 0: Memory at f8000000 (32-bit, non-prefetchable) [size=64M]
>   Expansion ROM at 000c0000 [disabled] [size=64K]
>
>00:06.0 PCI bridge: Toshiba America Info Systems: Unknown device 0609 (rev 04) (prog-if 00 [Normal decode])
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0
>   Bus: primary=00, secondary=01, subordinate=13, sec-latency=0
>   I/O behind bridge: 00000000-00000fff
>   Memory behind bridge: 00000000-000fffff
>   Prefetchable memory behind bridge: 00000000-000fffff
>   BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>
>00:0a.0 Communication controller: Toshiba America Info Systems FIR Port (rev 13)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64
>   Interrupt: pin A routed to IRQ 11
>   Region 0: I/O ports at dfe0 [size=32]
>
>00:0b.0 USB Controller: NEC Corporation USB (rev 02) (prog-if 10 [OHCI])
>   Subsystem: Toshiba America Info Systems USB
>   Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64 (250ns min, 5250ns max)
>   Interrupt: pin A routed to IRQ 11
>   Region 0: Memory at f7eff000 (32-bit, non-prefetchable) [size=4K]
>
>00:0c.0 Multimedia video controller: Toshiba America Info Systems Tecra Video Capture device (rev 04)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64
>   Interrupt: pin A routed to IRQ 11
>   Region 0: Memory at f7efef00 (32-bit, non-prefetchable) [size=256]
>
>00:0d.0 Multimedia controller: Toshiba America Info Systems DVD Decoder card (Version 2) (rev 02)
>   Subsystem: Toshiba America Info Systems: Unknown device 0001
>   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64 (1000ns min, 32000ns max)
>   Interrupt: pin A routed to IRQ 11
>   Region 0: I/O ports at de00 [size=256]
>
>01:01.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
>   Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64 (1000ns min, 10000ns max)
>   Interrupt: pin A routed to IRQ 11
>   Region 0: I/O ports at <ignored> [size=128]
>
>01:04.0 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 87)
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0
>   Interrupt: pin A routed to IRQ 0
>   Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=4K]
>   Bus: primary=01, secondary=12, subordinate=12, sec-latency=0
>   Memory window 0: 00000000-00000000
>   Memory window 1: 00000000-00000000
>   I/O window 0: 00000000-00000003
>   I/O window 1: 00000000-00000003
>   BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
>
>01:04.1 CardBus bridge: Toshiba America Info Systems ToPIC95 (rev 87)
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 0
>   Interrupt: pin B routed to IRQ 0
>   Region 0: Memory at <unassigned> (32-bit, non-prefetchable) [size=4K]
>   Bus: primary=01, secondary=13, subordinate=13, sec-latency=0
>   Memory window 0: 00000000-00000000
>   Memory window 1: 00000000-00000000
>   I/O window 0: 00000000-00000003
>   I/O window 1: 00000000-00000003
>   BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt- PostWrite-
>
>01:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>   Subsystem: Realtek Semiconductor Co., Ltd. RT8139
>   Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>   Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>   Latency: 64 (8000ns min, 16000ns max)
>   Interrupt: pin A routed to IRQ 11
>   Region 0: I/O ports at <ignored> [size=256]
>   Region 1: Memory at <ignored> (32-bit, non-prefetchable) [size=256]
>   Expansion ROM at f7fe0000 [disabled] [size=64K]
>   Capabilities: [50] Power Management version 2
>       Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
>       Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>
>  
>
The unknown device 0609 is the one responsible for the problem.

             Eric Stern


--------------050308060207060501060506
Content-Type: text/plain;
 name="patch.toshiba"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.toshiba"

diff -rup linux-2.6.4.orig/drivers/pci/quirks.c linux/drivers/pci/quirks.c
--- linux-2.6.4.orig/drivers/pci/quirks.c   2004-03-18 12:14:29.000000000 -0600
+++ linux/drivers/pci/quirks.c  2004-03-18 12:16:58.000000000 -0600
@@ -957,6 +957,11 @@ static struct pci_fixup pci_fixups[] __d
     */
    { PCI_FIXUP_HEADER, PCI_VENDOR_ID_INTEL,    PCI_DEVICE_ID_INTEL_82380FB,    quirk_transparent_bridge },
    { PCI_FIXUP_HEADER, PCI_VENDOR_ID_TOSHIBA,  0x605,  quirk_transparent_bridge },
+   /* The PCI-PCI bridge in the toshiba deskstation needs to
+    * be marked transparent for PCI cards to be usable.  The
+    * bridge ID is 0x609.
+    */
+   { PCI_FIXUP_HEADER, PCI_VENDOR_ID_TOSHIBA,  0x609,  quirk_transparent_bridge },
 
    { PCI_FIXUP_FINAL,  PCI_VENDOR_ID_CYRIX,    PCI_DEVICE_ID_CYRIX_PCI_MASTER, quirk_mediagx_master },
 

--------------050308060207060501060506--
