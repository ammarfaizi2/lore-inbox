Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288914AbSBMUkS>; Wed, 13 Feb 2002 15:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288923AbSBMUkM>; Wed, 13 Feb 2002 15:40:12 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:10625 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S288914AbSBMUkF>; Wed, 13 Feb 2002 15:40:05 -0500
Message-Id: <200202131952.MAA03108@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: "David S. Miller" <davem@redhat.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: [PATCH] 2.5.4, add 8 help texts to drivers/net/Config.help
Date: Wed, 13 Feb 2002 13:38:50 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The drivers/net/Config.in file contains 11 options which do not have any 
help text in drivers/net/Config.help (or anywhere else).

The following patch provides help texts for the 8 of those 11 marked by
asterisks in the list below. I inserted the help texts in Config.help 
in the same order that the option appears in Config.in.

   CONFIG_8139_NEW_RX_RESET
*  CONFIG_DE2104X
*  CONFIG_LASI_82596
*  CONFIG_LP486E
*  CONFIG_MIPS_AU1000_ENET
   CONFIG_NE2K_ZORRO
*  CONFIG_PPPOATM
*  CONFIG_TULIP_MMIO
*  CONFIG_TULIP_MWI
   CONFIG_VETH
*  CONFIG_VIA_RHINE_MMIO

Steven

--- linux-2.5.4/drivers/net/Config.help.orig	Wed Feb 13 11:18:09 2002
+++ linux-2.5.4/drivers/net/Config.help	Wed Feb 13 13:15:58 2002
@@ -3,6 +3,10 @@
   MIPS-32-based Baget embedded system.  This chipset is better known
   via the NE2100 cards.
 
+CONFIG_LASI_82596
+  Say Y here to support the on-board Intel 82596 ethernet controller
+  built into Hewlett-Packard PA-RISC machines.
+
 CONFIG_MIPS_JAZZ_SONIC
   This is the driver for the onboard card of MIPS Magnum 4000,
   Acer PICA, Olivetti M700-10 and a few other identical OEM systems.
@@ -214,6 +218,12 @@
   pppd, along with binaries of a patched pppd package can be found at:
   <http://www.shoshin.uwaterloo.ca/~mostrows/>.
 
+CONFIG_PPPOATM
+  Support PPP (Point to Point Protocol) encapsulated in ATM frames.
+  This implementation does not yet comply with section 8 of RFC2364,
+  which can lead to bad results if the ATM peer loses state and
+  changes its encapsulation unilaterally.
+
 CONFIG_NET_RADIO
   Support for wireless LANs and everything having to do with radio,
   but not with amateur radio or FM broadcasting.
@@ -817,6 +827,10 @@
   say M here and read <file:Documentation/modules.txt>.  This is
   recommended.  The module will be called lance.o.
 
+CONFIG_MIPS_AU1000_ENET
+  If you have an Alchemy Semi AU1000 ethernet controller
+  on an SGI MIPS system, say Y.  Otherwise, say N.
+
 CONFIG_SGI_IOC3_ETH
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
@@ -1290,6 +1304,24 @@
   module, say M here and read <file:Documentation/modules.txt> as well
   as <file:Documentation/networking/net-modules.txt>.
 
+CONFIG_DE2104X
+  This driver is developed for the SMC EtherPower series Ethernet
+  cards and also works with cards based on the DECchip
+  21040 (Tulip series) chips.  Some LinkSys PCI cards are
+  of this type.  (If your card is NOT SMC EtherPower 10/100 PCI
+  (smc9332dst), you can also try the driver for "Generic DECchip"
+  cards, above.  However, most people with a network card of this type
+  will say Y here.) Do read the Ethernet-HOWTO, available from
+  <http://www.linuxdoc.org/docs.html#howto>.  More specific
+  information is contained in
+  <file:Documentation/DocBook/tulip-user.tmpl>.
+
+  This driver is also available as a module ( = code which can be
+  inserted in and removed from the running kernel whenever you want).
+  The module will be called tulip.o.  If you want to compile it as a
+  module, say M here and read <file:Documentation/modules.txt> as well
+  as <file:Documentation/networking/net-modules.txt>.
+
 CONFIG_TULIP
   This driver is developed for the SMC EtherPower series Ethernet
   cards and also works with cards based on the DECchip 
@@ -1308,6 +1340,20 @@
   module, say M here and read <file:Documentation/modules.txt> as well
   as <file:Documentation/networking/net-modules.txt>.
 
+CONFIG_TULIP_MWI
+  This configures your Tulip card specifically for the card and
+  system cache line size type you are using.
+
+  This is experimental code, not yet tested on many boards.
+
+  If unsure, say N.
+
+CONFIG_TULIP_MMIO
+  Use PCI shared memory for the NIC registers, rather than going through
+  the Tulip's PIO (programmed I/O ports).  Faster, but could produce
+  obscure bugs if your mainboard has memory controller timing issues.
+  If in doubt, say N.
+
 CONFIG_DGRS
   This is support for the Digi International RightSwitch series of
   PCI/EISA Ethernet switch cards. These include the SE-4 and the SE-6
@@ -1338,6 +1384,11 @@
   cards. Specifications and data at
   <http://www.myson.com.hk/mtd/datasheet/>.
 
+CONFIG_LP486E
+  Say Y here to support the 82596-based on-board Ethernet controller
+  for the Panther motherboard, which is one of the two shipped in the
+  Intel Professional Workstation.
+
 CONFIG_ETH16I
   If you have a network (Ethernet) card of this type, say Y and read
   the Ethernet-HOWTO, available from
@@ -1377,6 +1428,16 @@
   a module, say M here and read <file:Documentation/modules.txt> as
   well as <file:Documentation/networking/net-modules.txt>.
 
+CONFIG_VIA_RHINE_MMIO
+  This instructs the driver to use PCI shared memory (MMIO) instead of
+  programmed I/O ports (PIO). Enabling this gives an improvement in
+  processing time in parts of the driver.
+
+  It is not known if this works reliably on all "rhine" based cards,
+  but it has been tested successfully on some DFE-530TX adapters.
+
+  If unsure, say N.
+
 CONFIG_DM9102
   This driver is for DM9102(A)/DM9132/DM9801 compatible PCI cards from
   Davicom (<http://www.davicom.com.tw/>).  If you have such a network
