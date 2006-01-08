Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWAHLnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWAHLnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 06:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWAHLnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 06:43:18 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:6613 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1751110AbWAHLnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 06:43:17 -0500
Date: Sun, 8 Jan 2006 12:43:15 +0100
From: Folkert van Heusden <folkert@vanheusden.com>
To: akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-ID: <20060108114305.GA32425@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Mon Jan  9 12:31:33 CET 2006
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My system freezes (crashes) when I run tcpdump on the interface
connected to a 3c905b card. I've tried swapping the card for an other
3c905b card but that did not help. 2 out of 3 times the last message on
the console is "Transmit error, Tx status register 82". sysreq+t doesn't
work. Not only tcpdump, any program which put the interface into
promisques mode makes the system crash. All other interfaces (eth0 and
eth2) are fine. I tried starting the system with 'debug=7' attached to
the modprobe for the module but then the system crashes with a
"vortex_error() status=0x8081".
The tcpdump-problem is reproducable, in fact: the system crashes always
when I run tcpdump on that interface.
This seems to be the only problem with that system: no other crashes or
segfaults or anything out of the ordinary.

kernel 2.6.15
3.2GHz P4, HT enabled, 2GB ram

[   13.422920] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 16
[   13.423004] 3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
[   13.423051] 0000:02:09.0: 3Com PCI 3c905B Cyclone 100baseTx at f8882400. Vers LK1.1.19
[   13.445519] ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 21 (level, low) -> IRQ 16

02:09.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at d880 [size=128]
        Memory at feaff400 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at fe700000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 1
00: b7 10 55 90 17 01 10 02 30 00 00 02 04 40 00 00
10: 81 d8 00 00 00 f4 af fe 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
30: 00 00 ac fe dc 00 00 00 00 00 00 00 05 01 0a 0a

UTP connected to a switching hub

vortex-diag.c:v2.16 1/12/2004 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Index #1: Found a 3c905B Cyclone 100baseTx adapter at 0xd880.
 Station address 00:50:da:df:1d:3a.
  Receive mode is 0x07: Normal unicast and all multicast.
The Vortex chip may be active, so FIFO registers will not be read.
To see all register values use the '-f' flag.
Initial window 4, registers values by window:
  Window 0: 0000 0000 0000 0000 f5f5 00bf 0000 0000.
  Window 1: FIFO FIFO 0000 0000 0000 0000 0000 2000.
  Window 2: 5000 dfda 3a1d 0000 0000 0000 000a 4000.
  Window 3: 0000 0180 05ea 0020 000a 0800 0800 6000.
  Window 4: 0000 0000 0000 0cd8 0003 8880 0000 8000.
  Window 5: 1ffc 0000 0000 0600 0807 06ce 06c6 a000.
  Window 6: 0000 0000 0000 da00 1000 4a47 52cf c000.
  Window 7: 0000 0000 0000 0000 0000 0000 0000 e000.
Vortex chip registers at 0xd880
  0xD890: **FIFO** 00000000 0000001c *STATUS*
  0xD8A0: 00000020 00000000 00080000 00000004
  0xD8B0: 00000000 e7be1842 377a9110 00080004
  0xD8C0: 008b890f 00000000 00000000 00000000
  0xD8D0: 00000000 00000000 00000000 00000000
  0xD8E0: 00000000 00000000 00000000 00000000
  0xD8F0: 00009000 00000000 01600160 00000000
  DMA control register is 00000020.
   Tx list starts at 00000000.
   Tx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to empty.
   Rx FIFO thresholds: min. burst 256 bytes, priority with 128 bytes to full.
   Poll period Tx 00 ns.,  Rx 0 ns.
   Maximum burst recorded Tx 352,  Rx 352.
 Indication enable is 06c6, interrupt enable is 06ce.
 No interrupt sources are pending.
 Transceiver/media interfaces available:  100baseTx 10baseT.
Transceiver type in use:  Autonegotiate.
 MAC settings: full-duplex.
 Station address set to 00:50:da:df:1d:3a.
 Configuration options 000a.
EEPROM format 64x16, configuration table at offset 0:
    00: 0050 dadf 1d3a 9055 002d 0036 4258 6d50
  0x08: 2971 0000 0050 dadf 1d3a 0010 0000 0022
  0x10: 32a2 0000 0000 0180 0000 0000 0000 10b7
  0x18: 9055 000a 0000 0000 0000 0000 0000 0000
  0x20: 00ea 0000 0000 0000 0000 0000 0000 0000
  0x28: 0000 0000 0000 0000 0000 0000 0000 0000
      ...

 The word-wide EEPROM checksum is 0x30f7.
Saved EEPROM settings of a 3Com Vortex/Boomerang:
 3Com Node Address 00:50:DA:DF:1D:3A (used as a unique ID only).
 OEM Station address 00:50:DA:DF:1D:3A (used as the ethernet address).
  Device ID 9055,  Manufacturer ID 6d50.
  Manufacture date (MM/DD/YYYY) 1/13/2000, division 6, product XB.
  No BIOS ROM is present.
 Transceiver selection: Autonegotiate.
   Options: negotiated duplex, link beat required.
   PCI bus requested settings --  minimum grant 10, maximum latency 10 (250ns units).
 PCI Subsystem IDs: Vendor 10b7 Device 9055.
 100baseTx 10baseT.
  Vortex format checksum is incorrect (82 vs. 10b7).
  Cyclone format checksum is correct (0xea vs. 0xea).
  Hurricane format checksum is correct (0xea vs. 0xea).


mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
  Using the new SIOCGMIIPHY value on PHY 24 (BMCR 0x3000).
 The autonegotiated capability is 01e0.
The autonegotiated media type is 100baseTx-FD.
 Basic mode control register 0x3000: Auto-negotiation enabled.
 You have link beat, and everything is working OK.
   This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
   Able to perform Auto-negotiation, negotiation complete.
 Your link partner advertised 45e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
   End of basic transceiver information.

 MII PHY #24 transceiver registers:
   3000 786d 0000 0000 01e1 45e1 0005 2801
   0000 0000 0000 0000 0000 0000 0000 0000
   8000 0afb f5ff 0000 0000 0005 2001 0000
   0000 2050 0003 1c11 019a 1000 0000 0000


           CPU0       CPU1
  0:      39275      36446    IO-APIC-edge  timer
  1:          8          0    IO-APIC-edge  i8042
  4:        375        293    IO-APIC-edge  serial
  7:          0          0    IO-APIC-edge  parport0
  9:          0          0   IO-APIC-level  acpi
 12:        101          0    IO-APIC-edge  i8042
 14:       8133       6029    IO-APIC-edge  ide0
 15:         26          0    IO-APIC-edge  ide1
 16:      59024         10   IO-APIC-level  eth0, eth1
 17:          0          0   IO-APIC-level  uhci_hcd:usb5
 18:     294950     389876   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb8, wcfxo
 19:        841       1620   IO-APIC-level  ehci_hcd:usb2, bttv0
 20:      13095      10832   IO-APIC-level  uhci_hcd:usb3, uhci_hcd:usb6
 21:        125          0   IO-APIC-level  uhci_hcd:usb4
 22:      76446      65337   IO-APIC-level  uhci_hcd:usb7
 23:      92265      73603   IO-APIC-level  Intel ICH5
NMI:          0          0
LOC:      75664      75663
ERR:          0
MIS:         10



Folkert van Heusden

-- 
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
