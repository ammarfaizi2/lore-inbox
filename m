Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbTI0Kfo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 06:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTI0Kfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 06:35:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:6368 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261650AbTI0KfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 06:35:17 -0400
Date: Sat, 27 Sep 2003 12:35:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-net@vger.kernel.org, dbrownell@users.sourceforge.net
Cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] select MII
Message-ID: <20030927103511.GL2881@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below switches MII to be select'ed instead of including it in
the Makefile.

Note that this patch requires a recent Linus' tree with the select CRC32
patch included.

diffstat output:

 drivers/net/Kconfig          |   11 +++++++++++
 drivers/net/Makefile         |   28 +++++++++++-----------------
 drivers/net/pcmcia/Kconfig   |    1 +
 drivers/net/tulip/Kconfig    |    1 +
 drivers/usb/net/Kconfig      |    2 ++
 drivers/usb/net/Makefile.mii |    6 ------
 6 files changed, 26 insertions(+), 23 deletions(-)


Tangential to the patch I observed a small problem (not fixed in the patch):
MII depends on NET_ETHERNET, but USB_PEGASUS and USB_USBNET depend 
only on NET.

cu
Adrian

--- linux-2.6.0-test5/drivers/net/Kconfig.old	2003-09-27 12:14:16.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/Kconfig	2003-09-27 12:19:55.000000000 +0200
@@ -1209,8 +1209,9 @@
 config PCNET32
 	tristate "AMD PCnet32 PCI support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  If you have a PCnet32 or PCnetPCI based network (Ethernet) card,
 	  answer Y here and read the Ethernet-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
@@ -1222,8 +1223,9 @@
 config AMD8111_ETH
 	tristate "AMD 8111 (new PCI lance) support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  If you have an AMD 8111-based PCI lance ethernet card,
 	  answer Y here and read the Ethernet-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
@@ -1235,8 +1237,9 @@
 config ADAPTEC_STARFIRE
 	tristate "Adaptec Starfire/DuraLAN support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  Say Y here if you have an Adaptec Starfire (or DuraLAN) PCI network
 	  adapter. The DuraLAN chip is used on the 64 bit PCI boards from
 	  Adaptec e.g. the ANA-6922A. The older 32 bit boards use the tulip
@@ -1329,8 +1332,9 @@
 
 config EEPRO100
 	tristate "EtherExpressPro/100 support (eepro100, original Becker driver)"
 	depends on NET_PCI && PCI
+	select MII
 	help
 	  If you have an Intel EtherExpress PRO/100 PCI network (Ethernet)
 	  card, say Y and read the Ethernet-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
@@ -1441,8 +1445,9 @@
 config FEALNX
 	tristate "Myson MTD-8xx PCI Ethernet support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  Say Y here to support the Mysom MTD-800 family of PCI-based Ethernet
 	  cards. Specifications and data at
 	  <http://www.myson.com.hk/mtd/datasheet/>.
@@ -1508,8 +1513,9 @@
 config 8139CP
 	tristate "RealTek RTL-8139 C+ PCI Fast Ethernet Adapter support (EXPERIMENTAL)"
 	depends on NET_PCI && PCI && EXPERIMENTAL
 	select CRC32
+	select MII
 	help
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the RTL8139C+ chips. If you have one of those, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1521,8 +1527,9 @@
 config 8139TOO
 	tristate "RealTek RTL-8139 PCI Fast Ethernet Adapter support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	---help---
 	  This is a driver for the Fast Ethernet PCI network cards based on
 	  the RTL8139 chips. If you have one of those, say Y and read
 	  <file:Documentation/networking/8139too.txt> as well as the
@@ -1593,8 +1600,9 @@
 config EPIC100
 	tristate "SMC EtherPower II"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  This driver is for the SMC EtherPower II 9432 PCI Ethernet NIC,
 	  which is based on the SMC83c17x (EPIC/100).
 	  More specific information and updates are available from
@@ -1603,8 +1611,9 @@
 config SUNDANCE
 	tristate "Sundance Alta support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  This driver is for the Sundance "Alta" chip.
 	  More specific information and updates are available from
 	  <http://www.scyld.com/network/sundance.html>.
@@ -1641,8 +1650,9 @@
 config VIA_RHINE
 	tristate "VIA Rhine support"
 	depends on NET_PCI && PCI
 	select CRC32
+	select MII
 	help
 	  If you have a VIA "rhine" based network card (Rhine-I (3043) or
 	  Rhine-2 (VT86c100A)), say Y here.
 
@@ -1895,8 +1905,9 @@
 
 config HAMACHI
 	tristate "Packet Engines Hamachi GNIC-II support"
 	depends on PCI
+	select MII
 	help
 	  If you have a Gigabit Ethernet card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
--- linux-2.6.0-test5/drivers/net/Makefile.old	2003-09-27 12:14:23.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/Makefile	2003-09-27 12:23:28.000000000 +0200
@@ -36,37 +36,36 @@
 obj-$(CONFIG_RCPCI) += rcpci.o
 obj-$(CONFIG_VORTEX) += 3c59x.o
 obj-$(CONFIG_TYPHOON) += typhoon.o
 obj-$(CONFIG_NE2K_PCI) += ne2k-pci.o 8390.o
-obj-$(CONFIG_PCNET32) += pcnet32.o mii.o
-obj-$(CONFIG_EEPRO100) += eepro100.o mii.o
+obj-$(CONFIG_PCNET32) += pcnet32.o
+obj-$(CONFIG_EEPRO100) += eepro100.o
 obj-$(CONFIG_TLAN) += tlan.o
-obj-$(CONFIG_EPIC100) += epic100.o mii.o
+obj-$(CONFIG_EPIC100) += epic100.o
 obj-$(CONFIG_SIS190) += sis190.o
 obj-$(CONFIG_SIS900) += sis900.o
 obj-$(CONFIG_YELLOWFIN) += yellowfin.o
 obj-$(CONFIG_ACENIC) += acenic.o
 obj-$(CONFIG_VETH) += veth.o
 obj-$(CONFIG_NATSEMI) += natsemi.o
 obj-$(CONFIG_NS83820) += ns83820.o
 obj-$(CONFIG_STNIC) += stnic.o 8390.o
-obj-$(CONFIG_FEALNX) += fealnx.o mii.o
+obj-$(CONFIG_FEALNX) += fealnx.o
 obj-$(CONFIG_TIGON3) += tg3.o
 obj-$(CONFIG_TC35815) += tc35815.o
 obj-$(CONFIG_SK98LIN) += sk98lin/
 obj-$(CONFIG_SKFP) += skfp/
-obj-$(CONFIG_VIA_RHINE) += via-rhine.o mii.o
-obj-$(CONFIG_ADAPTEC_STARFIRE) += starfire.o mii.o
+obj-$(CONFIG_VIA_RHINE) += via-rhine.o
+obj-$(CONFIG_ADAPTEC_STARFIRE) += starfire.o
 
 #
 # end link order section
 #
 
 obj-$(CONFIG_MII) += mii.o
 
-obj-$(CONFIG_WINBOND_840) += mii.o
-obj-$(CONFIG_SUNDANCE) += sundance.o mii.o
-obj-$(CONFIG_HAMACHI) += hamachi.o mii.o
+obj-$(CONFIG_SUNDANCE) += sundance.o
+obj-$(CONFIG_HAMACHI) += hamachi.o
 obj-$(CONFIG_NET) += Space.o net_init.o loopback.o
 obj-$(CONFIG_SEEQ8005) += seeq8005.o
 obj-$(CONFIG_ETHERTAP) += ethertap.o
 obj-$(CONFIG_NET_SB1000) += sb1000.o
@@ -130,10 +129,10 @@
 obj-$(CONFIG_EL3) += 3c509.o
 obj-$(CONFIG_3C515) += 3c515.o
 obj-$(CONFIG_EEXPRESS) += eexpress.o
 obj-$(CONFIG_EEXPRESS_PRO) += eepro.o
-obj-$(CONFIG_8139CP) += 8139cp.o mii.o
-obj-$(CONFIG_8139TOO) += 8139too.o mii.o
+obj-$(CONFIG_8139CP) += 8139cp.o
+obj-$(CONFIG_8139TOO) += 8139too.o
 obj-$(CONFIG_ZNET) += znet.o
 obj-$(CONFIG_LAN_SAA9730) += saa9730.o
 obj-$(CONFIG_DEPCA) += depca.o
 obj-$(CONFIG_EWRK3) += ewrk3.o
@@ -174,12 +173,9 @@
 obj-$(CONFIG_MAC89x0) += mac89x0.o
 obj-$(CONFIG_TUN) += tun.o
 obj-$(CONFIG_DL2K) += dl2k.o
 obj-$(CONFIG_R8169) += r8169.o
-obj-$(CONFIG_AMD8111_ETH) += amd8111e.o mii.o
-
-# non-drivers/net drivers who want mii lib
-obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
+obj-$(CONFIG_AMD8111_ETH) += amd8111e.o
 
 obj-$(CONFIG_ARM) += arm/
 obj-$(CONFIG_NET_FC) += fc/
 obj-$(CONFIG_DEV_APPLETALK) += appletalk/
@@ -191,6 +187,4 @@
 obj-$(CONFIG_NET_TULIP) += tulip/
 obj-$(CONFIG_HAMRADIO) += hamradio/
 obj-$(CONFIG_IRDA) += irda/
 
-
-include $(TOPDIR)/drivers/usb/net/Makefile.mii
--- linux-2.6.0-test5/drivers/net/tulip/Kconfig.old	2003-09-27 12:18:27.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/tulip/Kconfig	2003-09-27 12:18:43.000000000 +0200
@@ -88,8 +88,9 @@
 config WINBOND_840
 	tristate "Winbond W89c840 Ethernet support"
 	depends on NET_TULIP && PCI
 	select CRC32
+	select MII
 	help
 	  This driver is for the Winbond W89c840 chip.  It also works with 
 	  the TX9882 chip on the Compex RL100-ATX board.
 	  More specific information and updates are available from
--- linux-2.6.0-test5/drivers/net/pcmcia/Kconfig.old	2003-09-27 12:20:15.000000000 +0200
+++ linux-2.6.0-test5/drivers/net/pcmcia/Kconfig	2003-09-27 12:20:52.000000000 +0200
@@ -76,8 +76,9 @@
 config PCMCIA_SMC91C92
 	tristate "SMC 91Cxx PCMCIA support"
 	depends on NET_PCMCIA && PCMCIA
 	select CRC32
+	select MII
 	help
 	  Say Y here if you intend to attach an SMC 91Cxx compatible PCMCIA
 	  (PC-card) Ethernet or Fast Ethernet card to your computer.
 
--- linux-2.6.0-test5/drivers/usb/net/Kconfig.old	2003-09-27 12:21:13.000000000 +0200
+++ linux-2.6.0-test5/drivers/usb/net/Kconfig	2003-09-27 12:23:06.000000000 +0200
@@ -69,8 +69,9 @@
 
 config USB_PEGASUS
 	tristate "USB Pegasus/Pegasus-II based ethernet device support"
 	depends on USB && NET
+	select MII
 	---help---
 	  Say Y here if you know you have Pegasus or Pegasus-II based adapter.
 	  If in doubt then look at linux/drivers/usb/pegasus.h for the complete
 	  list of supported devices.
@@ -95,8 +96,9 @@
 config USB_USBNET
 	tristate "Multi-purpose USB Networking Framework"
 	depends on USB && NET
 	select CRC32
+	select MII
 	---help---
 	  This driver supports several kinds of network links over USB,
 	  with "minidrivers" built around a common network driver core
 	  that supports deep queues for efficient transfers.  (This gives
--- linux-2.6.0-test5/drivers/usb/net/Makefile.mii	2003-09-27 11:38:06.000000000 +0200
+++ /dev/null	2003-09-05 07:34:20.000000000 +0200
@@ -1,6 +0,0 @@
-#
-# Makefile for USB Network drivers which require generic MII code.
-#
-
-obj-$(CONFIG_USB_PEGASUS)	+= mii.o
-obj-$(CONFIG_USB_USBNET)	+= mii.o
