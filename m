Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263130AbRFECey>; Mon, 4 Jun 2001 22:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263134AbRFECeo>; Mon, 4 Jun 2001 22:34:44 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:51972 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S263130AbRFECel>; Mon, 4 Jun 2001 22:34:41 -0400
Date: Mon, 4 Jun 2001 20:34:37 -0600
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Tulip 0.9.15-pre3 - still no dice
Message-ID: <20010604203437.A674@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A tulip driver 0.9.15-pre3, as included in 2.4.5-ac8, still does not
work for me and I have to replace it with 0.9.14d (April 3, 2001) to
get a functional network.

Trying it with 'tulip_debug=3' option I see this:


Linux Tulip driver version 0.9.15-pre3 (June 1, 2001)
00:0b.0: MWI config mwi=0, cacheline=16, csr0=00a0d000
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
tulip0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
tulip0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
eth0: Digital DS21143 Tulip rev 65 at 0x8800, 00:00:F0:51:00:72, IRQ 11.
eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: tulip_up(), irq==11.
eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: Done tulip_open(), CSR0 f8a0d000, CSR5 f0160000 CSR6 b2422202.
eth0: 21143 link status interrupt 000050ca, CSR5 f0668010, fffbffff.
eth0: Autonegotiation failed, using 10baseT, link beat status 50ca.
eth0: 21143 non-MII 10baseT transceiver control 08af/0005.
eth0:  Setting CSR15 to 08af0008/00050008.
eth0: Using media type 10baseT, CSR12 is c6.
eth0:  Setting CSR6 82420000/b2422002 CSR12 000010c6.
eth0: 21143 negotiation status 000010c6, 10baseT.
eth0: 21143 negotiation failed, status 000010c6.
eth0: Testing new 21143 media 100baseTx.
eth0: The transmitter stopped.  CSR5 is f0008102, CSR6 b2420000, new CSR6 83860000.
eth0: 21143 link status interrupt 000002ca, CSR5 f0668010, fffbff7f.
eth0: 21143 100baseTx link beat failed.
eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: 21143 link status interrupt 000050ca, CSR5 f0008010, fffbffff.
eth0: Autonegotiation failed, using 10baseT, link beat status 50ca.
.....
(and a loop with at "Autonegotiation failed" until 'ifdown eth0')
.....
eth0: Shutting down ethercard, status was f0000102.

There was a variation once. A status changed to this:

eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: 21143 link status interrupt 000052ca, CSR5 f0008010, fffbffff.
eth0: Autonegotiation failed, using 10baseT, link beat status 52ca.

but it went back to the same loop:

This is, for a comparison, the same level of debug with 0.9.14d working 
driver.  Note different values for CSR0 and CSR5 on tulip_open().

Linux Tulip driver version 0.9.14d (April 3, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0x8800, 00:00:F0:51:00:72, IRQ 11.
eth0:  EEPROM default media type Autosense.
eth0:  Index #0 - Media 10baseT (#0) described by a 21142 Serial PHY (2) block.
eth0:  Index #1 - Media 10baseT-FDX (#4) described by a 21142 Serial PHY (2) block.
eth0:  Index #2 - Media 100baseTx (#3) described by a 21143 SYM PHY (4) block.
eth0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21143 SYM PHY (4) block.
eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: tulip_up(), irq==11.
eth0: Restarting 21143 autonegotiation, csr14=0003ffff.
eth0: Done tulip_open(), CSR0 f8a0e000, CSR5 f0720000 CSR6 b2422202.
eth0: 21143 link status interrupt 000050ca, CSR5 f0668010, fffbffff.
eth0: Autonegotiation failed, using 10baseT, link beat status 50ca.
eth0: 21143 non-MII 10baseT transceiver control 08af/0005.
eth0:  Setting CSR15 to 08af0008/00050008.
eth0: Using media type 10baseT, CSR12 is ca.
eth0:  Setting CSR6 82420000/b2422002 CSR12 000050ca.
eth0: 21143 negotiation status 000050ca, 10baseT.

Here is an output of tulip-diag, as much as I can get, in a non-working
state:

tulip-diag.c:v2.06 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a Digital DS21143 Tulip adapter at 0x8800.
Digital DS21143 Tulip chip registers at 0x8800:
 0x00: f8a0d000 ffffffff ffffffff 0efb0000 0efb0200 f0000000 b2420200 fbfffbff
 0x40: e0000000 ffffcbf8 ffffffff 00000000 000010ce ffff0001 fffbffff 8ff50000
 Port selection is 10mpbs-serial, full-duplex.
 Transmit stopped, Receive stopped, full-duplex.
  The Rx process state is 'Stopped'.
  The Tx process state is 'Stopped'.
  The transmit threshold is 72.
  The NWay status register is 000010ce.
EEPROM 64 words, 6 address bits.
PCI Subsystem IDs, vendor 1011, device 500b.
CardBus Information Structure at offset 00000000.
Ethernet MAC Station Address 00:00:F0:51:00:72.
EEPROM transceiver/media description table.
Leaf node at offset 65, default media type 0800 (Autosense).
 4 transceiver description blocks:
  Media 10baseT, block type 2, length 6.
   Serial transceiver for 10baseT (media type 0).
    GP pin direction 08af  GP pin data 0005.
  Media 10baseT-Full Duplex, block type 2, length 6.
   Serial transceiver for 10baseT-Full Duplex (media type 4).
    GP pin direction 08af  GP pin data 0005.
  Media 100baseTx, block type 4, length 8.
   SYM transceiver for 100baseTx (media type 3).
    GP pin direction 08af  GP pin data 0005.
    No media detection indication (command 80 61).
  Media 100baseTx Full Duplex, block type 4, length 8.
   SYM transceiver for 100baseTx Full Duplex (media type 5).
    GP pin direction 08af  GP pin data 0005.
    No media detection indication (command 80 61).
EEPROM contents (64 words):
0x00:  1011 500b 0000 0000 0000 0000 0000 0000
0x08:  00d4 0103 0000 51f0 7200 4100 4400 3545
0x10:  3030 422d 2241 0081 0000 0000 0000 0000
0x18:  ac00 00ac 0000 0000 0000 0000 0000 0000
0x20:  0000 0408 0286 af00 0508 8600 0402 08af
0x28:  0005 0488 af03 0508 6100 8880 0504 08af
0x30:  0005 8061 0000 0000 0000 0000 0000 0000
0x38:  0000 0000 0000 0000 0000 0000 0000 f2ea
 ID block CRC 0xd4 (vs. 0xd4).
  Full contents CRC 0xf2ea (read as 0xf2ea).
   No MII transceivers found!
  Internal autonegotiation state is 'Transmit disabled'.

And here are differences with a similar thing but working
(those lines with '+' are positive :-).

--- out0	Mon Jun  4 18:49:08 2001
+++ out1	Mon Jun  4 19:43:27 2001
@@ -2,14 +2,14 @@
  http://www.scyld.com/diag/index.html
 Index #1: Found a Digital DS21143 Tulip adapter at 0x8800.
 Digital DS21143 Tulip chip registers at 0x8800:
- 0x00: f8a0d000 ffffffff ffffffff 0efb0000 0efb0200 f0000000 b2420200 fbfffbff
- 0x40: e0000000 ffffcbf8 ffffffff 00000000 000010ce ffff0001 fffbffff 8ff50000
- Port selection is 10mpbs-serial, full-duplex.
- Transmit stopped, Receive stopped, full-duplex.
-  The Rx process state is 'Stopped'.
-  The Tx process state is 'Stopped'.
+ 0x00: f8a0e000 ffffffff ffffffff 05d94000 05d94200 f0660000 b2422002 fbfffbff
+ 0x40: e0000000 fff483ff ffffffff 00000000 000052ca ffff0001 fffbffff 8ffd0008
+ Port selection is 10mpbs-serial, half-duplex.
+ Transmit started, Receive started, half-duplex.
+  The Rx process state is 'Waiting for packets'.
+  The Tx process state is 'Idle'.
   The transmit threshold is 72.
-  The NWay status register is 000010ce.
+  The NWay status register is 000052ca.
 EEPROM 64 words, 6 address bits.
 PCI Subsystem IDs, vendor 1011, device 500b.
 CardBus Information Structure at offset 00000000.
@@ -43,4 +43,4 @@
  ID block CRC 0xd4 (vs. 0xd4).
   Full contents CRC 0xf2ea (read as 0xf2ea).
    No MII transceivers found!
-  Internal autonegotiation state is 'Transmit disabled'.
+  Internal autonegotiation state is 'Negotiation complete'.

  Michal
  michal@harddata.com
