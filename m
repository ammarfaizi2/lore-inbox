Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317441AbSFHUEn>; Sat, 8 Jun 2002 16:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317443AbSFHUEm>; Sat, 8 Jun 2002 16:04:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:48515 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317441AbSFHUEl>;
	Sat, 8 Jun 2002 16:04:41 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Jun 2002 22:04:42 +0200 (MEST)
Message-Id: <UTC200206082004.g58K4gV27229.aeb@smtp.cwi.nl>
To: jgarzik@mandrakesoft.com
Subject: eth problems
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two flaws and a problem:

Flaw 1:
The boot messages reveal what cards have been assigned what
ethN number for some, but not all cards. E.g.,

# dmesg | grep eth
eth0: 3c5x9 at 0x300, 10baseT port, address ..., IRQ 10.
eth2: RealTek RTL8139 Fast Ethernet at 0xd080d000, ..., IRQ 9
eth2:  Identified 8139 chip type 'RTL-8139A'
eth3: i82596 ...
#

What is eth1? This information seems not easily available.

I once gave a patch - can dig it up again if there is any interest.
The kernel should report, preferably in a uniform way,
ethN: Vendor Model, MAC address, ...

Flaw 2:
Debugging output:

phy=0, phyx=24, mii_status=0xffff
phy=1, phyx=0, mii_status=0xffff
...
phy=24, phyx=23, mii_status=0xffff
phy=25, phyx=25, mii_status=0xffff
...
phy=31, phyx=31, mii_status=0xffff
  ***WARNING*** No MII transceivers found!


Problem:
[The above two flaws apply to many kernel versions.
However, today, upon booting 2.5.20 net connection failed.]

...
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html
00:0d.0: 3Com PCI 3c590 Vortex 10Mbps at 0xb400. Vers LK1.1.17
00:0d.0: Overriding PCI latency timer (CFLT) setting of 32, new value is 248.
...
NETDEV WATCHDOG: eth1: transmit timed out
eth1: transmit timed out, tx_status 00 status e000.
diagnostics: net 0cc0 media 88c0 dma 00000021 fifo 0000
Flags; bus-master 1, dirty 0(0) current 16(0)
...
eth1: Resetting the Tx ring pointer.
...

Andries
