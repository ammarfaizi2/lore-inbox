Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUDEOMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 10:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDEOMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 10:12:49 -0400
Received: from 66.Red-80-38-104.pooles.rima-tde.net ([80.38.104.66]:42624 "HELO
	fulanito.nisupu.com") by vger.kernel.org with SMTP id S262608AbUDEOMW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 10:12:22 -0400
Message-ID: <003301c41b18$38ff7f90$1530a8c0@HUSH>
From: "Carlos Fernandez Sanz" <cfs-lk@nisupu.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3com issues in 2.6.5
Date: Mon, 5 Apr 2004 16:13:51 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to track down my problems with my NIC in 2.6.5 (worked fine in
2.4.22). The network "works" but very very slow, and ifconfig shows almost
the same count in the Tx packet and carrier count:

TX packets:23818 errors:0 dropped:0 overruns:0 carrier:23817

dmesg for 2.4.22 and 2.6.5 are almost identical, except for the last lines
in 2.4.22 (vortex_up, etc). There are no (apparently important) different in
vortex-diag. mii-diag, however, fails to run in 2.6.5 while it works in
2.4.22.

 Dumps follow, in case someone can shed light.

(BTW: lsmod in 2.4.22 shows the module as busy (used twice, because I have
two identical NICs, while in 2.6.5 it seems to be unused - I can unload the
module with both interfaces up, but obviously as soon as I do that they
dissapear - I assume this is the intended 2.6 behaviour).

*****
dmesg
*****
2.4.22:
PCI: Found IRQ 9 for device 02:0b.0
PCI: Sharing IRQ 9 with 00:1f.4
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
02:0b.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.18-ac
00:01:03:27:81:75, IRQ 9
product code 4a45 rev 00.12 date 10-15-00
Internal config register is 1800000, transceivers 0xa.
8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
MII transceiver found at address 24, status 786d.
Enabling bus-master transmits and whole-frame receives.
02:0b.0: scatter/gather enabled. h/w checksums enabled
divert: allocating divert_blk for eth0
eth0: using NWAY device table, not 8
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 786d, link partner capability 45e1, info1 0010, setting
full-duplex.
eth0: vortex_up() InternalConfig 01800000.
eth0: vortex_up() irq 9 media status 8880.

2.6.5:
PCI: Found IRQ 9 for device 0000:02:0b.0
PCI: Sharing IRQ 9 with 0000:00:1f.4
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
See Documentation/networking/vortex.txt
0000:02:0b.0: 3Com PCI 3c905C Tornado at 0xd800. Vers LK1.1.19
00:01:03:27:81:75, IRQ 9
product code 4a45 rev 00.12 date 10-15-00
Internal config register is 1800000, transceivers 0xa.
8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
MII transceiver found at address 24, status 786d.
Enabling bus-master transmits and whole-frame receives.
0000:02:0b.0: scatter/gather enabled. h/w checksums enabled
*********
vortex-diag
*********

2.4.22:
Index #1: Found a 3c920 Series NIC adapter at 0xd800.
Station address 00:01:03:27:81:75.
Receive mode is 0x07: Normal unicast and all multicast.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
Window 0: 0000 0000 d93f 0000 e3e3 00bf ffff 0000.
Window 1: FIFO FIFO 0700 0000 0000 007e 0000 2000.
Window 2: 0100 2703 7581 0000 0000 0000 0042 4000.
Window 3: 0000 0180 05ea 0020 000a 0800 0800 6000.
Window 4: 0000 0000 0000 0cd8 0001 8880 0000 8000.
Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
Window 6: 0000 0000 0000 0a00 0000 02e2 0000 c000.
Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0xd800
0xD810: **FIFO** 00000000 0000000a *STATUS*
0xD820: 00000020 00000000 00080000 00000004
0xD830: 00000000 44aebb52 03f58180 00080004
0xD840: 003eb253 00000000 000000b7 00000000
0xD850: 00000000 00000000 00000000 00000000
0xD860: 00000000 00000000 00000000 00000000
0xD870: 00009800 00000000 01600000 00000000
DMA control register is 00000020.
Tx list starts at 00000000.
Tx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to empty.
Rx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to full.
Poll period Tx 00 ns., Rx 0 ns.
Maximum burst recorded Tx 0, Rx 352.
Indication enable is 06c6, interrupt enable is 06ce.
No interrupt sources are pending.
Transceiver/media interfaces available: 100baseTx 10baseT.
Transceiver type in use: Autonegotiate.
MAC settings: full-duplex.
Station address set to 00:01:03:27:81:75.
Configuration options 0042.
EEPROM format 64x16, configuration table at offset 0:
00: 0001 0327 8175 9200 014f 0048 454a 6d50
0x08: 2940 0800 0001 0327 8175 0010 0000 00aa
0x10: 72a2 0000 0000 0180 0000 0000 0429 10b7
0x18: 1000 000a 0002 6300 ffb7 b7b7 0000 0000
0x20: 00ba 1234 5600 0000 0000 0000 0000 0000
0x28: 0000 0000 0000 0000 0000 0000 0000 0000
0x30: ffff ffff ffff ffff ffff ffff ffff ffff
...
The word-wide EEPROM checksum is 0x9dc7.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
3Com Node Address 00:01:03:27:81:75 (used as a unique ID only).
OEM Station address 00:01:03:27:81:75 (used as the ethernet address).
Device ID 9200, Manufacturer ID 6d50.
Manufacture date (MM/DD/YYYY) 10/15/2000, division H, product JE.
A BIOS ROM of size 0Kx8 is expected.
Transceiver selection: Autonegotiate.
Options: negotiated duplex, link beat required.
PCI bus requested settings -- minimum grant 10, maximum latency 10 (250ns
units).
PCI Subsystem IDs: Vendor 10b7 Device 1000.
100baseTx 10baseT.
Vortex format checksum is incorrect (2c vs. 10b7).
Cyclone format checksum is incorrect (0xbc vs. 0xba).
Hurricane format checksum is incorrect (0x95 vs. 0xba).
MII PHY found at address 24, status 786d.
MII PHY 0 at #24 transceiver registers:
3000 786d 0180 7750 05e1 45e1 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0238 0087 0000 0000 0000 0000 c4c8 0300
0100 0438 2010 2000 0000 0000 0000 0000.

2.6.5:
Index #1: Found a 3c920 Series NIC adapter at 0xd800.
 Station address 00:01:03:27:81:75.
  Receive mode is 0x07: Normal unicast and all multicast.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 7, registers values by window:
  Window 0: 0000 0000 d93f 0000 e3e3 00bf ffff 0000.
  Window 1: FIFO FIFO 0700 0000 0000 007e 0000 2000.
  Window 2: 0100 2703 7581 0000 0000 0000 0042 4000.
  Window 3: 0000 0180 05ea 0000 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd8 0001 8c80 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 0600 0000 0569 018c c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0xd800
  0xD810: **FIFO** 00000000 0000002a *STATUS*
  0xD820: 00000020 00000000 00080000 00000004
  0xD830: 00000000 d03a2fc6 1ce260c0 00080004
  0xD840: 00bb915d 00000000 000000b7 00000000
  0xD850: 00000000 00000000 00000000 00000000
  0xD860: 00000000 00000000 00000000 00000000
  0xD870: 00009800 00000000 01600160 00000000
  DMA control register is 00000020.
   Tx list starts at 00000000.
   Tx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to
empty.
   Rx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to
full.
   Poll period Tx 00 ns.,  Rx 0 ns.
   Maximum burst recorded Tx 352,  Rx 352.
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: half-duplex.
 Station address set to 00:01:03:27:81:75.
 Configuration options 0042.
EEPROM format 64x16, configuration table at offset 0:
    00: 0001 0327 8175 9200 014f 0048 454a 6d50
  0x08: 2940 0800 0001 0327 8175 0010 0000 00aa
  0x10: 72a2 0000 0000 0180 0000 0000 0429 10b7
  0x18: 1000 000a 0002 6300 ffb7 b7b7 0000 0000
  0x20: 00ba 1234 5600 0000 0000 0000 0000 0000
  0x28: 0000 0000 0000 0000 0000 0000 0000 0000
  0x30: ffff ffff ffff ffff ffff ffff ffff ffff
      ...
 The word-wide EEPROM checksum is 0x9dc7.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address 00:01:03:27:81:75 (used as a unique ID only).
 OEM Station address 00:01:03:27:81:75 (used as the ethernet address).
  Device ID 9200,  Manufacturer ID 6d50.
  Manufacture date (MM/DD/YYYY) 10/15/2000, division H, product JE.
  A BIOS ROM of size 0Kx8 is expected.
 Transceiver selection: Autonegotiate.
   Options: negotiated duplex, link beat required.
   PCI bus requested settings --  minimum grant 10, maximum latency 10
(250ns units).
 PCI Subsystem IDs: Vendor 10b7 Device 1000.
 100baseTx 10baseT.
  Vortex format checksum is incorrect (2c vs. 10b7).
  Cyclone format checksum is incorrect (0xbc vs. 0xba).
  Hurricane format checksum is incorrect (0x95 vs. 0xba).
 MII PHY found at address 24, status 786d.
 MII PHY 0 at #24 transceiver registers:
   3000 786d 0180 7750 05e1 45e1 0001 0000
   0000 0000 0000 0000 0000 0000 0000 0000
   0238 0087 0000 0000 0000 0000 c4c8 0300
   0100 0438 2010 2000 8000 0000 0000 0000.

******
mii-diag
******
2.4.22:
mii-diag.c:v2.09 9/06/2003 Donald Becker (becker@scyld.com)
http://www.scyld.com/diag/index.html
Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0x3000).
The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
Basic mode control register 0x3000: Auto-negotiation enabled.
You have link beat, and everything is working OK.
This transceiver is capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
Able to perform Auto-negotiation, negotiation complete.
Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT, w/ 802.3X flow control.
End of basic transceiver information.
libmii.c:v2.10 4/22/2003 Donald Becker (becker@scyld.com)
http://www.scyld.com/diag/index.html
MII PHY #24 transceiver registers:
3000 786d 0180 7750 05e1 45e1 0001 0000
0000 0000 0000 0000 0000 0000 0000 0000
0238 0087 0000 0000 0000 0000 c4c8 0300
0100 0438 2010 2000 0000 0000 0000 0000.
Basic mode control register 0x3000: Auto-negotiation enabled.
Basic mode status register 0x786d ... 786d.
Link status: established.
Capable of 100baseTx-FD 100baseTx 10baseT-FD 10baseT.
Able to perform Auto-negotiation, negotiation complete.
Vendor ID is 00:60:1d:--:--:--, model 53 rev. 0.
No specific information is known about this transceiver type.
I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
Advertising no additional info pages.
IEEE 802.3 CSMA/CD protocol.
Link partner capability is 45e1: Flow-control 100baseTx-FD 100baseTx
10baseT-FD 10baseT.
Negotiation completed.

2.6.5:
root@fulanito root]# mii-diag --force
Using the default interface 'eth0'.
Basic registers of MII PHY #24:  0000 0000 0000 0000 0000 0000 0000 0000.
  No MII transceiver present!.
 Basic mode control register 0x0000: Auto-negotiation disabled, with
 Speed fixed at 10 mbps, half-duplex.
 Basic mode status register 0x0000 ... 0000.
   Link status: not established.
 Link partner information is not exchanged when in fixed speed mode.
   End of basic transceiver information.

Thanks.

