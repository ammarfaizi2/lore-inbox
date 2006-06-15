Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030796AbWFOQ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030796AbWFOQ3E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 12:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030794AbWFOQ3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 12:29:01 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:43100 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1030795AbWFOQ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 12:29:00 -0400
Date: Thu, 15 Jun 2006 09:28:59 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: 2.6.17-rc[56]-mm*: pcmcia "I/O resource not free"
Message-ID: <20060615162859.GA1520@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PCMCIA slot on my Thinkpad X40 stopped working sometime between
2.6.17-rc4-mm3 and 2.6.17-rc5-mm3, and is still not working as of
2.6.17-rc6-mm2.  There's one diff early in dmesg that looks interesting:

 ACPI: PCI Interrupt 0000:00:1f.6[B] -> GSI 17 (level, low) -> IRQ 177
 PCI: Setting latency timer of device 0000:00:1f.6 to 64
 MC'97 1 converters and GPIO not ready (0xff00)
 PM: Adding info for ac97:1-1:unknown codec
-ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
 Yenta: CardBus bridge found at 0000:02:00.0 [1014:0555]
-Yenta: ISA IRQ mask 0x04b8, PCI irq 169
+Yenta: ISA IRQ mask 0x0cb8, PCI irq 169
 Socket status: 30000006
 pcmcia: parent PCI bridge I/O window: 0x3000 - 0x7fff
 cs: IO port probe 0x3000-0x7fff: clean.
 pcmcia: parent PCI bridge Memory window: 0xd0200000 - 0xdfffffff
 pcmcia: parent PCI bridge Memory window: 0xf0000000 - 0xf7ffffff

Then when I insert the card, instead of

 pccard: PCMCIA card inserted into slot 0
 cs: memory probe 0xf0000000-0xf7ffffff: excluding 0xf0000000-0xf7ffffff
 cs: memory probe 0xd0200000-0xdfffffff: excluding 0xd0200000-0xd11fffff
    0xd1a00000-0xd41fffff 0xd4a00000-0xd51fffff 0xd5a00000-0xd61fffff
    0xd6a00000-0xd71fffff 0xd7a00000-0xd81fffff 0xd8a00000-0xd91fffff
    0xd9a00000-0xda1fffff 0xdaa00000-0xdb1fffff 0xdba00000-0xdc1fffff
    0xdca00000-0xdd1fffff 0xdda00000-0xde1fffff 0xdea00000-0xdf1fffff
    0xdfa00000-0xe01fffff
 pcmcia: registering new device pcmcia0.0
 PM: Adding info for pcmcia:0.0
-Probing IDE interface ide2...
-hde: CF Card, CFA DISK drive
-PM: Adding info for No Bus:ide2
-hdf: probing with STATUS(0x50) instead of ALTSTATUS(0x0a)

I get

 pccard: PCMCIA card inserted into slot 0
 cs: memory probe 0xf0000000-0xf7ffffff: excluding 0xf0000000-0xf7ffffff
 cs: memory probe 0xd0200000-0xdfffffff: excluding 0xd0200000-0xd11fffff
     0xd1a00000-0xd41fffff 0xd4a00000-0xd51fffff 0xd5a00000-0xd61fffff
     0xd6a00000-0xd71fffff 0xd7a00000-0xd81fffff 0xd8a00000-0xd91fffff
     0xd9a00000-0xda1fffff 0xdaa00000-0xdb1fffff 0xdba00000-0xdc1fffff
     0xdca00000-0xdd1fffff 0xdda00000-0xde1fffff 0xdea00000-0xdf1fffff
     0xdfa00000-0xe01fffff
 pcmcia: registering new device pcmcia0.0
 PM: Adding info for pcmcia:0.0
+ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
+ide2: ports already in use, skipping probe
+ide2: I/O resource 0xF8A8A01E-0xF8A8A01E not free.
+ide2: ports already in use, skipping probe
+ide2: I/O resource 0xF8A8A00E-0xF8A8A00E not free.
+ide2: ports already in use, skipping probe

With 2.6.17-rc6-mm2 I have

           CPU0       
  0:     188343   IO-APIC-edge     timer
  1:       2685   IO-APIC-edge     i8042
  9:        393   IO-APIC-fasteoi  acpi
 12:      17840   IO-APIC-edge     i8042
 14:       4616   IO-APIC-edge     ide0
169:          1   IO-APIC-fasteoi  uhci_hcd:usb1, yenta
177:          0   IO-APIC-fasteoi  Intel 82801DB-ICH4, Intel 82801DB-ICH4 Modem
185:          0   IO-APIC-fasteoi  uhci_hcd:usb3
193:          0   IO-APIC-fasteoi  uhci_hcd:usb2
201:          0   IO-APIC-fasteoi  ehci_hcd:usb4
209:       2524   IO-APIC-fasteoi  eth0
217:      43647   IO-APIC-fasteoi  ipw2200
NMI:          0 
LOC:     175985 
ERR:          0
MIS:          0

The card I'm trying to use is a "PQI Compact Flash Adapter", which
appears to just be some wires connecting the PCMCIA pins to the CF pins.
The CF card is a "TwinMOS Ultra-X 140X 1GB" card, part number
FCF1GBUPS-K W543F5TM0832.

dmesgs at

http://web.hexapodia.org/~adi/tmp/dmesg.2.6.17-rc4-mm3.txt
http://web.hexapodia.org/~adi/tmp/dmesg.2.6.17-rc6-mm2.txt

(although the rc4-mm3 one is truncated, sorry.)

-andy
