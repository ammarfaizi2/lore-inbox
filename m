Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129165AbRBWSKZ>; Fri, 23 Feb 2001 13:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129261AbRBWSKN>; Fri, 23 Feb 2001 13:10:13 -0500
Received: from dyn545.dhcp.lancs.ac.uk ([148.88.245.69]:6148 "EHLO
	dyn545.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S129165AbRBWSKD>; Fri, 23 Feb 2001 13:10:03 -0500
Date: Fri, 23 Feb 2001 18:06:53 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
X-X-Sender: <torri@dyn545.dhcp.lancs.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PCMCIA CARDBUS detection incorrect.
Message-ID: <Pine.LNX.4.33.0102231739320.4623-101000@dyn545.dhcp.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1486112245-1664086563-982950386=:4623"
Content-ID: <Pine.LNX.4.33.0102231801180.2031@dyn545.dhcp.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1486112245-1664086563-982950386=:4623
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.33.0102231801181.2031@dyn545.dhcp.lancs.ac.uk>


using the following:

kernel-2.4.2 (linus release - no patches added)
kernel-2.2.17-4 (RedHat 7 release - no patches added)
kgcc-2.96.66
(kernel config - see compressed text file)

I have a Xircom Realport2 10/100 Card that uses the tulip_cb driver.

In kernel-2.2.17-4 (from RedHat with pcmcia installed) the card is
detected as:


----------------
/sbin/cardctl ident
----------------
Socket 0:
  product info: "Xircom", "RealPort2 CardBus Ethernet 10/100", "R2BE-100BTX", "1.00"
  manfid: 0x0105, 0x0103
  function: 6 (network)
Socket 1:
  no product info available

----------------
/sbin/cardctl status
----------------
Socket 0:
  3.3V CardBus card
  function 0: [ready]
Socket 1:
  no card

----------------
cat /proc/pci
----------------

PCI devices found:
  Bus 32, device   0, function  0:
    Ethernet controller: Unknown vendor Unknown device (rev 3).
      Vendor id=115d. Device id=3.
      Medium devsel.  IRQ 3.
      I/O at 0x100 [0x101].
      Non-prefetchable 32 bit memory at 0x6000d000 [0x6000d000].
      Non-prefetchable 32 bit memory at 0x6000c000 [0x6000c000].
  Bus  0, device   0, function  0:
    Host bridge: Intel 440BX - 82443BX Host (rev 3).
      Medium devsel.  Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe8000000 [0xe8000008].
  Bus  0, device   1, function  0:
    PCI bridge: Intel 440BX - 82443BX AGP (rev 3).
      Medium devsel.  Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   3, function  0:
    ISA bridge: Intel 82371AB PIIX4 ISA (rev 2).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  No bursts.
  Bus  0, device   3, function  1:
    IDE interface: Intel 82371AB PIIX4 IDE (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=64.
      I/O at 0xfc60 [0xfc61].
  Bus  0, device   3, function  2:
    USB Controller: Intel 82371AB PIIX4 USB (rev 1).
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  No bursts.
      I/O at 0xfca0 [0xfca1].
  Bus  0, device   3, function  3:
    Bridge: Intel 82371AB PIIX4 ACPI (rev 2).
      Medium devsel.  Fast back-to-back capable.
  Bus  0, device   6, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 0).
      Vendor id=1102. Device id=8938.
      Slow devsel.  IRQ 5.  Master Capable.  Latency=96.  Min Gnt=12.Max Lat=128.
      I/O at 0xfcc0 [0xfcc1].
      I/O at 0xfc40 [0xfc41].
  Bus  0, device   7, function  0:
    Communication controller: Unknown vendor Unknown device (rev 1).
      Vendor id=134d. Device id=7890.
      Medium devsel.  IRQ 11.
      I/O at 0xfc00 [0xfc01].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments Unknown device (rev 1).
      Vendor id=104c. Device id=ac1c.
      Medium devsel.  Master Capable.  Latency=168.  Min Gnt=128.Max Lat=7.
  Bus  0, device  10, function  1:
    CardBus bridge: Texas Instruments Unknown device (rev 1).
      Vendor id=104c. Device id=ac1c.
      Medium devsel.  Master Capable.  Latency=168.  Min Gnt=192.Max Lat=7.
  Bus  1, device   0, function  0:
    VGA compatible controller: Trident Unknown device (rev 73).
      Vendor id=1023. Device id=9525.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xfe400000 [0xfe400000].
      Non-prefetchable 32 bit memory at 0xfedc0000 [0xfedc0000].
      Non-prefetchable 32 bit memory at 0xfe800000 [0xfe800000].

The problem is that when I run kernel-2.4.2 the pcmcia does start when
compiled as modules (just so that it keeps the RH7 scripts happy). Yet the
cardctl reports:

----------------
/sbin/cardctl ident
----------------

Socket 0:
  no product info available
Socket 1:
  no product info available

----------------
/sbin/cardctl status
----------------

Socket 0:
  5V 16-bit PC Card
  function 0: [busy], [bat dead], [bat low]
Socket 1:
  no card

------------
cat /proc/pci
------------

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=64.
      Prefetchable 32 bit memory at 0xe8000000 [0xebffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=128.  Min Gnt=140.
  Bus  0, device   3, function  0:
    ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   3, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=64.
      I/O at 0xfc60 [0xfc6f].
  Bus  0, device   3, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=64.
      I/O at 0xfca0 [0xfcbf].
  Bus  0, device   3, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 2).
  Bus  0, device   6, function  0:
    Multimedia audio controller: PCI device 1102:8938 (Creative Labs) (rev 0).
      IRQ 5.
      Master Capable.  Latency=96.  Min Gnt=12.Max Lat=128.
      I/O at 0xfcc0 [0xfcff].
      I/O at 0xfc40 [0xfc5f].
  Bus  0, device   7, function  0:
    Communication controller: PCTel Inc HSP MicroModem 56 (rev 1).
      IRQ 11.
      I/O at 0xfc00 [0xfc3f].
  Bus  0, device  10, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      Master Capable.  No bursts.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device  10, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      Master Capable.  No bursts.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Trident Microsystems Cyber 9525 (rev 73).
      IRQ 11.
      Master Capable.  Latency=64.
      Non-prefetchable 32 bit memory at 0xfe400000 [0xfe7fffff].
      Non-prefetchable 32 bit memory at 0xfedc0000 [0xfeddffff].
      Non-prefetchable 32 bit memory at 0xfe800000 [0xfebfffff].

Stephen
s.torri@lancaster.ac.uk
-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

--1486112245-1664086563-982950386=:4623
Content-Type: APPLICATION/X-GZIP; NAME="defconfig.tar.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0102231746260.4623@dyn545.dhcp.lancs.ac.uk>
Content-Description: Kernel Config
Content-Disposition: ATTACHMENT; FILENAME="defconfig.tar.gz"

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
23t7b+/tvb239/be3tt7e2//bPsfFhvxYgBQAAA=
--1486112245-1664086563-982950386=:4623--
