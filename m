Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267216AbTABVcp>; Thu, 2 Jan 2003 16:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTABVbm>; Thu, 2 Jan 2003 16:31:42 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:10949 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267202AbTABVaS>; Thu, 2 Jan 2003 16:30:18 -0500
From: Tomas Szepe <kala@pinerecords.com>
Date: Thu, 02 Jan 2003 22:38:44 +0100
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [unify netdev config 19/22] net.1-sparc
Message-ID: <3E14B164.mailLYS1115SL@louise.pinerecords.com>
User-Agent: nail 10.3 11/29/02
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
--- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
+++ b/drivers/net/Kconfig	2003-01-02 22:01:16.000000000 +0100
@@ -384,7 +384,7 @@
 
 config NET_VENDOR_3COM
 	bool "3COM cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (ISA || EISA || MCA || PCI)
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -555,7 +555,7 @@
 
 config NET_VENDOR_SMC
 	bool "Western Digital/SMC cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (ISA || MCA || EISA)
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -648,7 +648,7 @@
 
 config NET_VENDOR_RACAL
 	bool "Racal-Interlan (Micom) NI cards"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && ISA
 	help
 	  If you have a network (Ethernet) card belonging to this class, such
 	  as the NI5010, NI5210 or NI6210, say Y and read the Ethernet-HOWTO,
@@ -1459,7 +1459,7 @@
 
 config NET_POCKET
 	bool "Pocket and portable adapters"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && ISA
 	---help---
 	  Cute little network (Ethernet) devices which attach to the parallel
 	  port ("pocket adapters"), commonly used with laptops. If you have
@@ -1777,7 +1777,7 @@
 
 config FDDI
 	bool "FDDI driver support"
-	depends on NETDEVICES
+	depends on NETDEVICES && (PCI || EISA)
 	help
 	  Fiber Distributed Data Interface is a high speed local area network
 	  design; essentially a replacement for high speed Ethernet. FDDI can
@@ -1828,7 +1828,7 @@
 
 config HIPPI
 	bool "HIPPI driver support (EXPERIMENTAL)"
-	depends on NETDEVICES && EXPERIMENTAL && INET
+	depends on NETDEVICES && EXPERIMENTAL && INET && PCI
 	help
 	  HIgh Performance Parallel Interface (HIPPI) is a 800Mbit/sec and
 	  1600Mbit/sec dual-simplex switched or point-to-point network. HIPPI
@@ -2181,7 +2181,7 @@
 
 config AIRONET4500
 	tristate "Aironet 4500/4800 series adapters"
-	depends on NET_RADIO
+	depends on NET_RADIO && (PCI || ISA || PCMCIA)
 	---help---
 	  www.aironet.com (recently bought by Cisco) makes these 802.11 DS
 	  adapters.  Driver by Elmer Joandi (elmer@ylenurme.ee).
@@ -2286,7 +2286,7 @@
 
 config NET_FC
 	bool "Fibre Channel driver support"
-	depends on NETDEVICES
+	depends on NETDEVICES && SCSI && PCI
 	help
 	  Fibre Channel is a high speed serial protocol mainly used to connect
 	  large storage devices to the computer; it is compatible with and
diff -urN a/drivers/net/arcnet/Kconfig b/drivers/net/arcnet/Kconfig
--- a/drivers/net/arcnet/Kconfig	2002-10-31 02:33:49.000000000 +0100
+++ b/drivers/net/arcnet/Kconfig	2003-01-02 22:01:16.000000000 +0100
@@ -3,7 +3,7 @@
 #
 
 menu "ARCnet devices"
-	depends on NETDEVICES
+	depends on NETDEVICES && (ISA || PCI)
 
 config ARCNET
 	tristate "ARCnet support"
diff -urN a/drivers/net/tokenring/Kconfig b/drivers/net/tokenring/Kconfig
--- a/drivers/net/tokenring/Kconfig	2002-12-08 20:06:34.000000000 +0100
+++ b/drivers/net/tokenring/Kconfig	2003-01-02 22:01:16.000000000 +0100
@@ -91,7 +91,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR
+	depends on TR && (PCI || ISA)
 	---help---
 	  This driver provides generic support for token ring adapters
 	  based on the Texas Instruments TMS380 series chipsets.  This
diff -urN a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
--- a/drivers/net/wireless/Kconfig	2002-10-31 02:33:50.000000000 +0100
+++ b/drivers/net/wireless/Kconfig	2003-01-02 22:01:16.000000000 +0100
@@ -2,12 +2,12 @@
 # Wireless LAN device configuration
 #
 comment "Wireless ISA/PCI cards support"
-	depends on NET_RADIO
+	depends on NET_RADIO && (ISA || PCI || ALL_PPC || PCMCIA)
 
 # Good old obsolete Wavelan.
 config WAVELAN
 	tristate "AT&T/Lucent old WaveLAN & DEC RoamAbout DS ISA support"
-	depends on NET_RADIO
+	depends on NET_RADIO && ISA
 	---help---
 	  The Lucent WaveLAN (formerly NCR and AT&T; or DEC RoamAbout DS) is
 	  a Radio LAN (wireless Ethernet-like Local Area Network) using the
@@ -54,7 +54,7 @@
 
 config HERMES
 	tristate "Hermes chipset 802.11b support (Orinoco/Prism2/Symbol)"
-	depends on NET_RADIO
+	depends on NET_RADIO && (ALL_PPC || PCI || PCMCIA)
 	---help---
 	  A driver for 802.11b wireless cards based based on the "Hermes" or
 	  Intersil HFA384x (Prism 2) MAC controller.  This includes the vast
