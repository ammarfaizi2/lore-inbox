Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLIAEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLIAEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:04:10 -0500
Received: from skol.horny-viking.org ([202.59.106.20]:13316 "HELO
	skol.horny-viking.org") by vger.kernel.org with SMTP
	id S262129AbTLIAD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:03:58 -0500
Date: Tue, 9 Dec 2003 11:04:46 +1100
From: raven <raven@skol.horny-viking.org>
To: linux-kernel@vger.kernel.org
Subject: problems with 3c59x in 2.6.0-test11
Message-Id: <20031209110446.5dcf234c.raven@skol.horny-viking.org>
Organization: none
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am having trouble with my 3com905B in 2.6.0-test11.  It is only detected successfully by the kernel if I had rebooted from a known good kernel (eg 2.4.23-xfs).  If I boot 2.6.0-test11 twice or more times in a row, if fails to detect in all but the first boot.  

(Note that I have renamed the interface from eth0 to 3com with nameif.)  

dmesg (when working):
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xe800. Vers LK1.1.19

dmesg (when not working):
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
0000:00:0d.0: 3Com PCI 3c905B Cyclone 100baseTx at 0x1000. Vers LK1.1.19
PCI: Setting latency timer of device 0000:00:0d.0 to 64
  ***WARNING*** No MII transceivers found!

lspci -vx (when working):
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at e800 [size=128]
        Memory at da101000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 24 00 00 02 08 20 00 00
10: 01 e8 00 00 00 10 10 da 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0a 0a

lspci -vx (when not working):
00:0d.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 1000 [size=128]
        [virtual] Memory at 20000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
00: b7 10 55 90 07 00 10 02 24 00 00 02 00 40 00 00
10: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 0a 0a

vortex-diag -aaee (when working):
vortex-diag.c:v2.14 12/28/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0xe800.
 Station address 00:50:04:c2:60:2a.
  Receive mode is 0x07: Normal unicast and all multicast.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: 0000 0000 0000 0000 f5f5 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 0000 0000 0000 0000 2000.
  Window 2: 5000 c204 2a60 0000 0000 0000 000a 4000.
  Window 3: 0000 0180 05ea 0020 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd2 0003 8880 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0000 0000 0000 0000 c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0002 e000.
Vortex chip registers at 0xe800
  0xE810: **FIFO** 00000000 00000010 *STATUS*
  0xE820: 00000020 00000000 00080000 00000004
  0xE830: 00000000 36bbc945 1fdf60c0 00080004
  0xE840: 0060785e 00000000 00000000 00000000
  0xE850: 00000000 00000000 00000000 00000000
  0xE860: 00000000 00000000 00000000 00000000
  0xE870: 00001000 00000000 00000000 00000000
  DMA control register is 00000020.
   Tx list starts at 00000000.
   Tx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to empty.
   Rx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to full.
   Poll period Tx 00 ns.,  Rx 0 ns.
   Maximum burst recorded Tx 0,  Rx 0.
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: full-duplex.
 Station address set to 00:50:04:c2:60:2a.
 Configuration options 000a.
EEPROM format 64x16, configuration table at offset 0:
    00: 0050 04c2 602a 9055 c787 0036 5054 6d50
  0x08: 2979 0000 0050 04c2 602a 0010 0000 002a
  0x10: 32a2 0000 0000 0180 0000 0000 0000 10b7
  0x18: 9055 000a 0000 0000 0000 0000 0000 0000
  0x20: 0099 0000 0000 0000 0000 0000 0000 0000
  0x28: 0000 0000 0000 0000 0000 0000 0000 0000
      ...

 The word-wide EEPROM checksum is 0xdfb2.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address 00:50:04:C2:60:2A (used as a unique ID only).
 OEM Station address 00:50:04:C2:60:2A (used as the ethernet address).
  Device ID 9055,  Manufacturer ID 6d50.
  Manufacture date (MM/DD/YYYY) 12/7/1999, division 6, product TP.
  No BIOS ROM is present.
 Transceiver selection: Autonegotiate.
   Options: negotiated duplex, link beat required.
 PCI Subsystem IDs: Vendor 10b7 Device 9055.
 100baseTx 10baseT.
  Vortex format checksum is incorrect (f1 vs. 10b7).
  Cyclone format checksum is correct (0x99 vs. 0x99).
  Hurricane format checksum is correct (0x99 vs. 0x99).

vortex-diag -aaee (when not working):
vortex-diag.c:v2.14 12/28/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0x1000.
 Station address ff:ff:ff:ff:ff:ff.
  Receive mode is 0xff: Promiscuous.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 1: FIFO FIFO ffff ffff ffff ffff ffff ffff.
  Window 2: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 3: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 4: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 5: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 6: ffff ffff ffff ffff ffff ffff ffff ffff.
  Window 7: ffff ffff ffff ffff ffff ffff ffff ffff.
Vortex chip registers at 0x1000
  0x1010: **FIFO** ffffffff ffffffff *STATUS*
  0x1020: ffffffff ffffffff ffffffff ffffffff
  0x1030: ffffffff ffffffff ffffffff ffffffff
  0x1040: ffffffff ffffffff ffffffff ffffffff
  0x1050: ffffffff ffffffff ffffffff ffffffff
  0x1060: ffffffff ffffffff ffffffff ffffffff
  0x1070: ffffffff ffffffff ffffffff ffffffff
  DMA control register is ffffffff.
   DMA control register is ffffffff (during Tx Stall).
   Tx list starts at ffffffff.
   Tx FIFO thresholds: min. burst 8160 bytes, priority with 8160 bytes to empty.
   Rx FIFO thresholds: min. burst 8160 bytes, priority with 8160 bytes to full.
   Poll period Tx 81600 ns.,  Rx 8160 ns.
   Maximum burst recorded Tx 65535,  Rx 65535.
 Indication enable is ffff, interrupt enable is ffff.
 Interrupt sources are pending.
   Interrupt latch indication.
   Adapter Failure indication.
   Tx Complete indication.
   Tx Available indication.
   Rx Complete indication.
   Rx Early Notice indication.
   Driver Intr Request indication.
   Statistics Full indication.
   DMA Done indication.
   Download Complete indication.
   Upload Complete indication.
   DMA in Progress indication.
   Command in Progress indication.
 Transceiver/media interfaces available:  100baseT4 100baseTx 100baseFx 10baseT 
10base2 AUI MII .
Transceiver type in use:  undefined-15.
 MAC settings: full-duplex, Large packets permitted, 802.1Q flow control, VLT VL
AN enabled.
Maximum packet size is 65535.
 Station address set to ff:ff:ff:ff:ff:ff.
 Configuration options ffff.
EEPROM format 64x16, configuration table at offset 0:
    00: ffff ffff ffff ffff ffff ffff ffff ffff
      ...

 The word-wide EEPROM checksum is 0xfff8.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address FF:FF:FF:FF:FF:FF (used as a unique ID only).
 OEM Station address FF:FF:FF:FF:FF:FF (used as the ethernet address).
  Device ID ffff,  Manufacturer ID ffff.
  Manufacture date (MM/DD/YYYY) 15/31/2027, division <FF>, product <FF><FF>.
  A BIOS ROM of size 960Kx8 is expected.
 Transceiver selection: undefined-15.
   Options: force full duplex, link beat check disabled.
 PCI Subsystem IDs: Vendor ffff Device ffff.
 100baseT4 100baseTx 100baseFx 10baseT 10base2 AUI MII .
  Vortex format checksum is incorrect (00 vs. ffff).
  Cyclone format checksum is incorrect (00 vs. 0xff).
  Hurricane format checksum is incorrect (00 vs. 0xff).

mii-diag -v 3com (when working):
mii-diag.c:v2.07 11/15/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0x3000).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-
FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

libmii.c:v2.10 4/22/2003  Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
 MII PHY #24 transceiver registers:
   3000 786d 0000 0000 01e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   8000 0afb f5ff 0000 0000 0005 2001 0000
   0000 2053 0007 1c11 001a 1000 0000 0000.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 Basic mode status register 0x786d ... 786d.
   Link status: established.
   Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 This transceiver has no vendor identification.
 I'm advertising 01e1: 100baseTx-FD 100baseTx 10baseT-FD 10baseT
   Advertising no additional info pages.
   IEEE 802.3 CSMA/CD protocol.
 Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD
 10baseT.
   Negotiation  completed.

mii-diag -v 3com (when not working):
mii-diag.c:v2.07 11/15/2002 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
SIOCGMIIPHY on 3com failed: No such device

Thanks, 


Mostyn. 
-- 
raven@skol.horny-viking.org
