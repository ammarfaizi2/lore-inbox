Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTAANLQ>; Wed, 1 Jan 2003 08:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbTAANLQ>; Wed, 1 Jan 2003 08:11:16 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:51390 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267221AbTAANLN>; Wed, 1 Jan 2003 08:11:13 -0500
Date: Wed, 1 Jan 2003 14:19:25 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
Message-ID: <20030101131925.GA14184@louise.pinerecords.com>
References: <20021231080146.GQ21097@louise.pinerecords.com> <Pine.LNX.4.44.0212311107480.2697-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212311107480.2697-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [torvalds@transmeta.com]
> 
> On Tue, 31 Dec 2002, Tomas Szepe wrote:
> > 
> > The attached unidiff creates a parent entry for all gigabit ethernet
> > interfaces, making the submenu consistent with that of 10/100.  Suggested
> > by Robert P. J. Day.  Trivial patch against 2.5-bkcurrent.
> 
> Hmm.. Wouldn't it be nicer to instead of :
> [snip]
> have
> [snip]
> so that the you don't even see the things if you don't select for them?
> Untested, but it would seem to be the more natural approach..

Oh yes, definitely, I just wanted to be consistent with 10/100.
So here comes gigabit the way you suggested (tested, seems to work
fine), next I'll be sending a fix for 10/100, then see if there are
any more menus like that left in the current config setup.

-- 
Tomas Szepe <szepe@pinerecords.com>

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-01 14:10:09.000000000 +0100
@@ -1575,12 +1575,40 @@
 #	Gigabit Ethernet
 #
 
-menu "Ethernet (1000 Mbit)"
+config NET_GIGABIT_ETH
 	depends on NETDEVICES
+	bool "Ethernet (1000 Mbit)"
+	---help---
+	  Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
+	  type of Local Area Network (LAN) in universities and companies.
+
+	  Common varieties of Ethernet are: 10BASE-2 or Thinnet (10 Mbps over
+	  coaxial cable, linking computers in a chain), 10BASE-T or twisted
+	  pair (10 Mbps over twisted pair cable, linking computers to central
+	  hubs), 10BASE-F (10 Mbps over optical fiber links, using hubs),
+	  100BASE-TX (100 Mbps over two twisted pair cables, using hubs),
+	  100BASE-T4 (100 Mbps over 4 standard voice-grade twisted pair
+	  cables, using hubs), 100BASE-FX (100 Mbps over optical fiber links)
+	  [the 100BASE varieties are also known as Fast Ethernet], and Gigabit
+	  Ethernet (1 Gbps over optical fiber or short copper links).
+
+	  If your Linux machine will be connected to an Ethernet and you have
+	  a gigabit Ethernet network interface card (NIC) installed in your
+	  computer, say Y here and read the Ethernet-HOWTO, available from
+	  <http://www.linuxdoc.org/docs.html#howto>.  You will then also have
+	  to say Y to the driver for your particular NIC.
+
+	  Note that the answer to this question won't directly affect the
+	  kernel: saying N will just cause the configurator to skip all
+	  the questions about gigabit Ethernet network cards. If unsure,
+	  say N.
+
+menu "Ethernet (1000 Mbit)"
+	depends on NET_GIGABIT_ETH
 
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	---help---
 	  Say Y here if you have an Alteon AceNIC, 3Com 3C985(B), NetGear
 	  GA620, SGI Gigabit or Farallon PN9000-SX PCI Gigabit Ethernet
@@ -1609,7 +1637,7 @@
 
 config DL2K
 	tristate "D-Link DL2000-based Gigabit Ethernet support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	help
 	  This driver supports D-Link 2000-based gigabit ethernet cards, which
 	  includes
@@ -1623,7 +1651,7 @@
 
 config E1000
 	tristate "Intel(R) PRO/1000 Gigabit Ethernet support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	---help---
 	  This driver supports Intel(R) PRO/1000 gigabit ethernet family of
 	  adapters, which includes:
@@ -1671,7 +1699,7 @@
 
 config MYRI_SBUS
 	tristate "MyriCOM Gigabit Ethernet support"
-	depends on SBUS
+	depends on NET_GIGABIT_ETH && SBUS
 	help
 	  This driver supports MyriCOM Sbus gigabit Ethernet cards.
 
@@ -1682,7 +1710,7 @@
 
 config NS83820
 	tristate "National Semiconduct DP83820 support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	help
 	  This is a driver for the National Semiconductor DP83820 series
 	  of gigabit ethernet MACs.  Cards using this chipset include
@@ -1692,7 +1720,7 @@
 
 config HAMACHI
 	tristate "Packet Engines Hamachi GNIC-II support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	help
 	  If you have a Gigabit Ethernet card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1706,7 +1734,7 @@
 
 config YELLOWFIN
 	tristate "Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on NET_GIGABIT_ETH && PCI && EXPERIMENTAL
 	---help---
 	  Say Y here if you have a Packet Engines G-NIC PCI Gigabit Ethernet
 	  adapter or the SYM53C885 Ethernet controller. The Gigabit adapter is
@@ -1721,7 +1749,7 @@
 
 config R8169
 	tristate "Realtek 8169 gigabit ethernet support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	---help---
 	  Say Y here if you have a Realtek 8169 PCI Gigabit Ethernet adapter.
 
@@ -1732,7 +1760,7 @@
 
 config SK98LIN
 	tristate "SysKonnect SK-98xx support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	---help---
 	  Say Y here if you have a SysKonnect SK-98xx Gigabit Ethernet Server
 	  Adapter. The following adapters are supported by this driver:
@@ -1760,7 +1788,7 @@
 
 config TIGON3
 	tristate "Broadcom Tigon3 support"
-	depends on PCI
+	depends on NET_GIGABIT_ETH && PCI
 	help
 	  This driver supports Broadcom Tigon3 based gigabit Ethernet cards.
 
