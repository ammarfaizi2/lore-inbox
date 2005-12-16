Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVLPV0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVLPV0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVLPV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:26:04 -0500
Received: from smtp04.wanadoo.nl ([194.134.35.144]:10023 "EHLO
	smtp04.wanadoo.nl") by vger.kernel.org with ESMTP id S932447AbVLPV0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:26:02 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <A77AD032-AA74-4F2E-B393-F18528BBEC81@lazarenko.net>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: LKML <linux-kernel@vger.kernel.org>
From: Vladimir Lazarenko <vlad@lazarenko.net>
Subject: tulip on alpha ds10l 100MbpsFD problem
Date: Fri, 16 Dec 2005 22:25:59 +0100
X-Mailer: Apple Mail (2.746.2)
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "dinosaur.lazarenko.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hello, I'm trying to get this DS 10L going with Linux,
	and I hit the ceiling with the onboard ethernet. Whenever the device is
	in 10Mbps, and switch is in 10 Mbps, everything works ok (half-duplex
	mode). Whenever I switch to 100Mbps, I'm not able to receive packets. At
	all. Sending goes ok, i.e. I see DHCP requests on another server, but
	nothing reaches the box when data is sent to it. [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to get this DS 10L going with Linux, and I hit the ceiling  
with the onboard ethernet.
Whenever the device is in 10Mbps, and switch is in 10 Mbps,  
everything works ok (half-duplex mode). Whenever I switch to 100Mbps,  
I'm not able to receive packets. At all. Sending goes ok, i.e. I see  
DHCP requests on another server, but nothing reaches the box when  
data is sent to it.

Similar behaviour with both de4x5 and tulip drivers.

lspci -vvv:

0000:00:09.0 Ethernet controller: Digital Equipment Corporation  
DECchip 21142/4)        Subsystem: Digital Equipment Corporation  
DE500B Fast Ethernet
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Ste-        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-  
DEVSEL=medium >TAbort- <TAbor-        Latency: 255 (5000ns min,  
10000ns max), Cache Line Size: 0x10 (64 bytes)        Interrupt: pin  
A routed to IRQ 29
         Region 0: I/O ports at 8000 [size=128]
         Region 1: Memory at 0000000009080000 (32-bit, non- 
prefetchable) [size=1]        Expansion ROM at 0000000009000000  
[disabled] [size=256K]

0000:00:0b.0 Ethernet controller: Digital Equipment Corporation  
DECchip 21142/4)        Subsystem: Digital Equipment Corporation  
DE500B Fast Ethernet
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Ste-        Status: Cap- 66MHz- UDF- FastB2B+ ParErr-  
DEVSEL=medium >TAbort- <TAbor-        Latency: 255 (5000ns min,  
10000ns max), Cache Line Size: 0x10 (64 bytes)        Interrupt: pin  
A routed to IRQ 30
         Region 0: I/O ports at 8080 [size=128]
         Region 1: Memory at 0000000009081000 (32-bit, non- 
prefetchable) [size=1]        Expansion ROM at 0000000009040000  
[disabled] [size=256K]


tulip-diag -aem:

da-ds10-l:~# tulip-diag -aem
tulip-diag.c:v2.17 5/6/2003 Donald Becker (becker@scyld.com)
http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0x8000.
Digital DS21143 Tulip chip registers at 0x8000:
0x00: f8a0e000 ffffffff ffffffff 9c2d6000 9c2d6800 f0000000 b2420200  
fbfffbff
0x40: e0000000 ffffcbf8 ffffffff 00000000 000012ce ffff0001 fffbffff  
8ff00000
Port selection is 10mpbs-serial, full-duplex.
Transmit stopped, Receive stopped.
   The Rx process state is 'Stopped'.
   The Tx process state is 'Stopped'.
   The transmit threshold is 72.
   The NWay status register is 000012ce.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 1011, device 500b.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:10:64:30:44:55.
EEPROM transceiver/media description table.
Leaf node at offset 46, default media type 0800 (Autosense).
4 transceiver description blocks:
   Media 10baseT, block type 2, length 6.
    Serial transceiver for 10baseT (media type 0).
     GP pin direction 08af  GP pin data 00a0.
   Media 10baseT-Full Duplex, block type 2, length 6.
    Serial transceiver for 10baseT-Full Duplex (media type 4).
     GP pin direction 08af  GP pin data 00a0.
   Media 100baseTx, block type 4, length 8.
    SYM transceiver for 100baseTx (media type 3).
     GP pin direction 08af  GP pin data 00a0.
     No media detection indication (command 80 61).
   Media 100baseTx Full Duplex, block type 4, length 8.
    SYM transceiver for 100baseTx Full Duplex (media type 5).
     GP pin direction 08af  GP pin data 00a0.
     No media detection indication (command 80 61).
    No MII transceivers found!
   Internal autonegotiation state is 'Ability detect'.
Index #2: Found a Digital DS21143 Tulip adapter at 0x8080.
Digital DS21143 Tulip chip registers at 0x8080:
0x00: f8004800 ffffffff ffffffff 9faf0000 9faf0080 f0000000 b2420200  
f3fe0000
0x40: e0000000 ffffcbf8 ffffffff 00000000 000021c6 ffff0001 fffbffff  
8ff00000
Port selection is 10mpbs-serial, full-duplex.
Transmit stopped, Receive stopped.
   The Rx process state is 'Stopped'.
   The Tx process state is 'Stopped'.
   The transmit threshold is 72.
   The NWay status register is 000021c6.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 1011, device 500b.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:10:64:30:44:56.
EEPROM transceiver/media description table.
Leaf node at offset 46, default media type 0800 (Autosense).
4 transceiver description blocks:
   Media 10baseT, block type 2, length 6.
    Serial transceiver for 10baseT (media type 0).
     GP pin direction 08af  GP pin data 00a0.
   Media 10baseT-Full Duplex, block type 2, length 6.
    Serial transceiver for 10baseT-Full Duplex (media type 4).
     GP pin direction 08af  GP pin data 00a0.
   Media 100baseTx, block type 4, length 8.
    SYM transceiver for 100baseTx (media type 3).
     GP pin direction 08af  GP pin data 00a0.
     No media detection indication (command 80 61).
   Media 100baseTx Full Duplex, block type 4, length 8.
    SYM transceiver for 100baseTx Full Duplex (media type 5).
     GP pin direction 08af  GP pin data 00a0.
     No media detection indication (command 80 61).
    No MII transceivers found!
   Internal autonegotiation state is 'Ability detect'.


Note, that it thinks that the device is in 10mbps full duplex mode,  
however when i force 10mbps on the switch, it will report 10mbps half- 
duplex, and that's the only configuration it works properly in.

SRM ewa0_mode is set to FastFD. It doesn't work with Auto-Negotiate  
either.

Any ideas would be very welcome. I'd be very happy to get this baby  
going in 100Mbps mode.
As a sidenote, alphaserver800 which is next to it, works in 100MbpsFD  
perfectly.

Regards,
Vladimir
