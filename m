Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267778AbTBRMxe>; Tue, 18 Feb 2003 07:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267780AbTBRMxe>; Tue, 18 Feb 2003 07:53:34 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:58769 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267778AbTBRMx2>; Tue, 18 Feb 2003 07:53:28 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.62]: 1/3: Make Ethernet 1000Mbit also a seperate, complete selectable submenu
Date: Tue, 18 Feb 2003 14:02:12 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>
MIME-Version: 1.0
Message-Id: <200302181350.49492.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_OJ9IQFDUVOKMM25XMVFB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OJ9IQFDUVOKMM25XMVFB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

so you can disable all 1000Mbit NICs at once.

--------------Boundary-00=_OJ9IQFDUVOKMM25XMVFB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ethernet-1000mbit-menu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ethernet-1000mbit-menu.patch"

diff -Naurp linux-2.5.62-vanilla/drivers/net/Kconfig linux-2.5.62-mcp1/drivers/net/Kconfig
--- linux-2.5.62-vanilla/drivers/net/Kconfig	2003-02-18 13:36:43.000000000 +0100
+++ linux-2.5.62-mcp1/drivers/net/Kconfig	2003-02-18 13:40:18.000000000 +0100
@@ -1839,12 +1839,38 @@ endmenu
 #	Gigabit Ethernet
 #
 
-menu "Ethernet (1000 Mbit)"
+menu "Ethernet (1000Mbit)"
 	depends on NETDEVICES
 
+config NET_ETHERNETGBIT
+        bool "Ethernet (1000Mbit)"
+        ---help---
+          Ethernet (also called IEEE 802.3 or ISO 8802-2) is the most common
+          type of Local Area Network (LAN) in universities and companies.
+          
+          Common varieties of Ethernet are: 10BASE-2 or Thinnet (10 Mbps over
+          coaxial cable, linking computers in a chain), 10BASE-T or twisted
+          pair (10 Mbps over twisted pair cable, linking computers to central
+          hubs), 10BASE-F (10 Mbps over optical fiber links, using hubs),
+          100BASE-TX (100 Mbps over two twisted pair cables, using hubs),
+          100BASE-T4 (100 Mbps over 4 standard voice-grade twisted pair
+          cables, using hubs), 100BASE-FX (100 Mbps over optical fiber links)
+          [the 100BASE varieties are also known as Fast Ethernet], and Gigabit
+          Ethernet (1 Gbps over optical fiber or short copper links).
+          
+          If your Linux machine will be connected to an Ethernet and you have
+          an Ethernet network interface card (NIC) installed in your computer,
+          say Y here and read the Ethernet-HOWTO, available from
+          <http://www.linuxdoc.org/docs.html#howto>. You will then also have
+          to say Y to the driver for your particular NIC.
+        
+          Note that the answer to this question won't directly affect the
+          kernel: saying N will just cause the configurator to skip all 
+          the questions about Ethernet network cards. If unsure, say N.
+
 config ACENIC
 	tristate "Alteon AceNIC/3Com 3C985/NetGear GA620 Gigabit support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	---help---
 	  Say Y here if you have an Alteon AceNIC, 3Com 3C985(B), NetGear
 	  GA620, SGI Gigabit or Farallon PN9000-SX PCI Gigabit Ethernet
@@ -1860,7 +1886,7 @@ config ACENIC
 
 config ACENIC_OMIT_TIGON_I
 	bool "Omit support for old Tigon I based AceNICs"
-	depends on ACENIC
+	depends on ACENIC && NET_ETHERNETGBIT
 	help
 	  Say Y here if you only have Tigon II based AceNICs and want to leave
 	  out support for the older Tigon I based cards which are no longer
@@ -1873,7 +1899,7 @@ config ACENIC_OMIT_TIGON_I
 
 config DL2K
 	tristate "D-Link DL2000-based Gigabit Ethernet support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	help
 	  This driver supports D-Link 2000-based gigabit ethernet cards, which
 	  includes
@@ -1887,7 +1913,7 @@ config DL2K
 
 config E1000
 	tristate "Intel(R) PRO/1000 Gigabit Ethernet support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	---help---
 	  This driver supports Intel(R) PRO/1000 gigabit ethernet family of
 	  adapters, which includes:
@@ -1935,7 +1961,7 @@ config E1000_NAPI
 
 config MYRI_SBUS
 	tristate "MyriCOM Gigabit Ethernet support"
-	depends on SBUS
+	depends on SBUS && NET_ETHERNETGBIT
 	help
 	  This driver supports MyriCOM Sbus gigabit Ethernet cards.
 
@@ -1946,7 +1972,7 @@ config MYRI_SBUS
 
 config NS83820
 	tristate "National Semiconduct DP83820 support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	help
 	  This is a driver for the National Semiconductor DP83820 series
 	  of gigabit ethernet MACs.  Cards using this chipset include
@@ -1956,7 +1982,7 @@ config NS83820
 
 config HAMACHI
 	tristate "Packet Engines Hamachi GNIC-II support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	help
 	  If you have a Gigabit Ethernet card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1970,7 +1996,7 @@ config HAMACHI
 
 config YELLOWFIN
 	tristate "Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)"
-	depends on PCI && EXPERIMENTAL
+	depends on PCI && NET_ETHERNETGBIT && EXPERIMENTAL
 	---help---
 	  Say Y here if you have a Packet Engines G-NIC PCI Gigabit Ethernet
 	  adapter or the SYM53C885 Ethernet controller. The Gigabit adapter is
@@ -1985,7 +2011,7 @@ config YELLOWFIN
 
 config R8169
 	tristate "Realtek 8169 gigabit ethernet support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	---help---
 	  Say Y here if you have a Realtek 8169 PCI Gigabit Ethernet adapter.
 
@@ -1996,7 +2022,7 @@ config R8169
 
 config SK98LIN
 	tristate "SysKonnect SK-98xx support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	---help---
 	  Say Y here if you have a SysKonnect SK-98xx Gigabit Ethernet Server
 	  Adapter. The following adapters are supported by this driver:
@@ -2024,7 +2050,7 @@ config SK98LIN
 
 config TIGON3
 	tristate "Broadcom Tigon3 support"
-	depends on PCI
+	depends on PCI && NET_ETHERNETGBIT
 	help
 	  This driver supports Broadcom Tigon3 based gigabit Ethernet cards.
 

--------------Boundary-00=_OJ9IQFDUVOKMM25XMVFB--


