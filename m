Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUDDTvA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 15:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbUDDTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 15:50:59 -0400
Received: from linux-bt.org ([217.160.111.169]:48811 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S262709AbUDDTu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 15:50:57 -0400
Subject: No interrupts for PCMCIA cards
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081108265.5533.17.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Apr 2004 21:51:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

while trying to fix a problem with a Bluetooth PCMCIA card I faced the
problem that my Cardbus controller don't give out any interrupts. I
tried it with 2.6.5 and this is my PCMCIA bridge:

0000:02:0e.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, Cache Line Size: 0x20 (128 bytes)
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at 20000000 (32-bit, non-prefetchable)
        Bus: primary=02, secondary=04, subordinate=07, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

And this is how /proc/interrupts look like:

           CPU0       
  0:    7241752    IO-APIC-edge  timer
  1:      10923    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  8:          4    IO-APIC-edge  rtc
 12:         94    IO-APIC-edge  i8042
 14:     134100    IO-APIC-edge  ide0
 15:          1    IO-APIC-edge  ide1
 18:          0   IO-APIC-level  yenta
 19:     120010   IO-APIC-level  uhci_hcd
 20:          0   IO-APIC-level  ohci_hcd
 21:     231886   IO-APIC-level  ohci1394, ohci_hcd, eth0
 22:        297   IO-APIC-level  acpi, ehci_hcd
 23:         57   IO-APIC-level  aic7xxx, uhci_hcd
NMI:          0 
LOC:    7241898 
ERR:          0
MIS:          0

The count for interrupt 18 is still zero every time, but on my Sony C1VE
laptop the PCMCIA cards get their interrupts.

Regards

Marcel


