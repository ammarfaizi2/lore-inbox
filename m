Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTBYDEw>; Mon, 24 Feb 2003 22:04:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265423AbTBYDEv>; Mon, 24 Feb 2003 22:04:51 -0500
Received: from palrel12.hp.com ([156.153.255.237]:7128 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S265396AbTBYDDs>;
	Mon, 24 Feb 2003 22:03:48 -0500
Date: Mon, 24 Feb 2003 19:13:57 -0800
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] : Wireless Kconfig cleanup
Message-ID: <20030225031357.GA24361@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	In kernel 2.5.63, you have moved more wireless LAN drivers
into ../drivers/net/wireless/. Unfortunately, there was a bit more to
cleanup as the result of this work.
	You will need to :
		o Apply the attached patch
		o rm /drivers/net/pcmcia/aironet4500_cs.c

	Have fun...

	Jean

P.S. : You will notice that I took the liberty to organise the config
option in what I hope is a more logical order.
P.S.2 : Did you receive my IrDA patches ?

-------------------------------------------------------------------

diff -u -p -r linux/net-j1/core/Makefile linux/net/core/Makefile
--- linux/net-j1/core/Makefile	Mon Feb 24 17:00:59 2003
+++ linux/net/core/Makefile	Mon Feb 24 18:31:05 2003
@@ -19,5 +19,3 @@ obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PROFILE) += profile.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_NET_RADIO) += wireless.o
-# Ugly. I wish all wireless drivers were moved in drivers/net/wireless
-obj-$(CONFIG_NET_PCMCIA_RADIO) += wireless.o
diff -u -p -r linux/net-j1/core/dev.c linux/net/core/dev.c
--- linux/net-j1/core/dev.c	Mon Feb 24 17:04:57 2003
+++ linux/net/core/dev.c	Mon Feb 24 18:31:32 2003
@@ -107,10 +107,10 @@
 #include <linux/kmod.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
-#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+#ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
-#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#endif	/* CONFIG_NET_RADIO */
 #ifdef CONFIG_PLIP
 extern int plip_init(void);
 #endif
diff -u -p -r linux/net-j1/netsyms.c linux/net/netsyms.c
--- linux/net-j1/netsyms.c	Mon Feb 24 17:05:40 2003
+++ linux/net/netsyms.c	Mon Feb 24 18:29:38 2003
@@ -646,12 +646,12 @@ EXPORT_SYMBOL(register_gifconf);
 
 EXPORT_SYMBOL(softnet_data);
 
-#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+#ifdef CONFIG_NET_RADIO
 /* Don't include the whole header mess for a single function */
 union iwreq_data;
 extern void wireless_send_event(struct net_device *dev, unsigned int cmd, union iwreq_data *wrqu, char *extra);
 EXPORT_SYMBOL(wireless_send_event);
-#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#endif	/* CONFIG_NET_RADIO */
 
 EXPORT_SYMBOL(linkwatch_fire_event);
 
diff -u -p -r linux/net-j1/socket.c linux/net/socket.c
--- linux/net-j1/socket.c	Mon Feb 24 17:04:10 2003
+++ linux/net/socket.c	Mon Feb 24 18:30:12 2003
@@ -83,9 +83,9 @@
 #include <linux/kmod.h>
 #endif
 
-#if defined(CONFIG_NET_RADIO) || defined(CONFIG_NET_PCMCIA_RADIO)
+#ifdef CONFIG_NET_RADIO
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
-#endif	/* CONFIG_NET_RADIO || CONFIG_NET_PCMCIA_RADIO */
+#endif	/* CONFIG_NET_RADIO */
 
 #include <asm/uaccess.h>
 
diff -u -p linux/drivers/net/pcmcia-j1/Kconfig linux/drivers/net/pcmcia/Kconfig
--- linux/drivers/net/pcmcia-j1/Kconfig	Mon Feb 24 17:05:25 2003
+++ linux/drivers/net/pcmcia/Kconfig	Mon Feb 24 18:54:32 2003
@@ -153,19 +153,5 @@ config PCMCIA_IBMTR
 	  The module will be called ibmtr_cs.  If you want to compile it as
 	  a module, say M here and read <file:Documentation/modules.txt>.
 
-config AIRONET4500_CS
-	tristate "Aironet 4500/4800 PCMCIA support"
-	depends on NET_PCMCIA_RADIO && AIRONET4500 && PCMCIA
-	help
-	  Say Y here if you have a PCMCIA Aironet 4500/4800 card which you
-	  want to use with the standard PCMCIA cardservices provided by the
-	  pcmcia-cs package.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called aironet4500_cs. If you want to
-	  compile it as a module, say M here and read
-	  <file:Documentation/modules.txt>.
-
 endmenu
 
diff -u -p linux/drivers/net/pcmcia-j1/Makefile linux/drivers/net/pcmcia/Makefile
--- linux/drivers/net/pcmcia-j1/Makefile	Mon Feb 24 17:05:25 2003
+++ linux/drivers/net/pcmcia/Makefile	Mon Feb 24 18:54:55 2003
@@ -13,7 +13,4 @@ obj-$(CONFIG_PCMCIA_XIRC2PS)	+= xirc2ps_
 obj-$(CONFIG_ARCNET_COM20020_CS)+= com20020_cs.o
 obj-$(CONFIG_PCMCIA_AXNET)	+= axnet_cs.o
 
-# 16-bit wireless client drivers
-obj-$(CONFIG_AIRONET4500_CS)	+= aironet4500_cs.o
-
 obj-$(CONFIG_PCMCIA_IBMTR)	+= ibmtr_cs.o
diff -u -p linux/drivers/net/wireless-j1/Kconfig linux/drivers/net/wireless/Kconfig
--- linux/drivers/net/wireless-j1/Kconfig	Mon Feb 24 17:05:26 2003
+++ linux/drivers/net/wireless/Kconfig	Mon Feb 24 18:58:54 2003
@@ -6,13 +6,13 @@ menu "Wireless LAN (non-hamradio)"
 	depends on NETDEVICES
 
 config NET_RADIO
-	bool "Wireless LAN (non-hamradio)"
+	bool "Wireless LAN drivers (non-hamradio) & Wireless Extensions"
 	---help---
 	  Support for wireless LANs and everything having to do with radio,
 	  but not with amateur radio or FM broadcasting.
 
 	  Saying Y here also enables the Wireless Extensions (creates
-	  /proc/net/wireless and enables ifconfig access). The Wireless
+	  /proc/net/wireless and enables iwconfig access). The Wireless
 	  Extension is a generic API allowing a driver to expose to the user
 	  space configuration and statistics specific to common Wireless LANs.
 	  The beauty of it is that a single set of tool can support all the
@@ -28,6 +28,11 @@ config NET_RADIO
 	  special kernel support are available from
 	  <ftp://shadow.cabi.net/pub/Linux/>.
 
+# Note : the cards are obsolete (can't buy them anymore), but the drivers
+# are not, as people are still using them...
+comment "Obsolete Wireless cards support (pre-802.11)"
+	depends on NET_RADIO && (INET || ISA || PCMCIA)
+
 config STRIP
 	tristate "STRIP (Metricom starmode radio IP)"
 	depends on NET_RADIO && INET
@@ -68,10 +73,6 @@ config ARLAN
 	  On some computers the card ends up in non-valid state after some
 	  time. Use a ping-reset script to clear it.
 
-comment "Wireless ISA/PCI cards support"
-	depends on NET_RADIO && (ISA || PCI || ALL_PPC || PCMCIA)
-
-# Good old obsolete Wavelan.
 config WAVELAN
 	tristate "AT&T/Lucent old WaveLAN & DEC RoamAbout DS ISA support"
 	depends on NET_RADIO && ISA
@@ -102,7 +103,54 @@ config WAVELAN
 	  module, say M here and read <file:Documentation/modules.txt> as well
 	  as <file:Documentation/networking/net-modules.txt>.
 
-# 802.11b cards
+config PCMCIA_WAVELAN
+	tristate "AT&T/Lucent old WaveLAN Pcmcia wireless support"
+	depends on NET_RADIO && PCMCIA
+	help
+	  Say Y here if you intend to attach an AT&T/Lucent Wavelan PCMCIA
+	  (PC-card) wireless Ethernet networking card to your computer.  This
+	  driver is for the non-IEEE-802.11 Wavelan cards.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called wavelan_cs.  If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+	  If unsure, say N.
+
+config PCMCIA_NETWAVE
+	tristate "Xircom Netwave AirSurfer Pcmcia wireless support"
+	depends on NET_RADIO && PCMCIA
+	help
+	  Say Y here if you intend to attach this type of PCMCIA (PC-card)
+	  wireless Ethernet networking card to your computer.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called netwave_cs.  If you want to compile it
+	  as a module, say M here and read <file:Documentation/modules.txt>.
+	  If unsure, say N.
+
+comment "Wireless 802.11 Frequency Hopping cards support"
+	depends on NET_RADIO && PCMCIA
+
+config PCMCIA_RAYCS
+	tristate "Aviator/Raytheon 2.4MHz wireless support"
+	depends on NET_RADIO && PCMCIA
+	---help---
+	  Say Y here if you intend to attach an Aviator/Raytheon PCMCIA
+	  (PC-card) wireless Ethernet networking card to your computer.
+	  Please read the file <file:Documentation/networking/ray_cs.txt> for
+	  details.
+
+	  This driver is also available as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want).
+	  The module will be called ray_cs.  If you want to compile it as a
+	  module, say M here and read <file:Documentation/modules.txt>.  If
+	  unsure, say N.
+
+comment "Wireless 802.11b ISA/PCI cards support"
+	depends on NET_RADIO && (ISA || PCI || ALL_PPC || PCMCIA)
+
 config AIRO
 	tristate "Cisco/Aironet 34X/35X/4500/4800 ISA and PCI cards"
 	depends on NET_RADIO && (ISA || PCI)
@@ -175,41 +223,12 @@ config PCI_HERMES
 	  this variety.
 
 # If Pcmcia is compiled in, offer Pcmcia cards...
-comment "Wireless Pcmcia/Cardbus cards support"
-	depends on NET_RADIO && PCMCIA
-
-# Obsolete cards
-config PCMCIA_NETWAVE
-	tristate "Xircom Netwave AirSurfer Pcmcia wireless support"
-	depends on NET_RADIO && PCMCIA
-	help
-	  Say Y here if you intend to attach this type of PCMCIA (PC-card)
-	  wireless Ethernet networking card to your computer.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called netwave_cs.  If you want to compile it
-	  as a module, say M here and read <file:Documentation/modules.txt>.
-	  If unsure, say N.
-
-config PCMCIA_WAVELAN
-	tristate "AT&T/Lucent old Wavelan Pcmcia wireless support"
+comment "Wireless 802.11b Pcmcia/Cardbus cards support"
 	depends on NET_RADIO && PCMCIA
-	help
-	  Say Y here if you intend to attach an AT&T/Lucent Wavelan PCMCIA
-	  (PC-card) wireless Ethernet networking card to your computer.  This
-	  driver is for the non-IEEE-802.11 Wavelan cards.
 
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called wavelan_cs.  If you want to compile it
-	  as a module, say M here and read <file:Documentation/modules.txt>.
-	  If unsure, say N.
-
-# 802.11b cards
 config PCMCIA_HERMES
 	tristate "Hermes PCMCIA card support"
-	depends on PCMCIA!=n && HERMES
+	depends on NET_RADIO && PCMCIA && HERMES
 	---help---
 	  A driver for "Hermes" chipset based PCMCIA wireless adaptors, such
 	  as the Lucent WavelanIEEE/Orinoco cards and their OEM (Cabletron/
@@ -248,34 +267,6 @@ config AIRO_CS
 	  Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
 	  for location).  You also want to check out the PCMCIA-HOWTO,
 	  available from <http://www.linuxdoc.org/docs.html#howto>.
-
-config NET_PCMCIA_RADIO
-	bool "PCMCIA Wireless LAN"
-	depends on NET_PCMCIA
-	help
-	  Say Y here if you would like to use a PCMCIA (PC-card) device to
-	  connect to a wireless local area network. Then say Y to the driver
-	  for your particular card below.
-
-	  To use your PC-cards, you will need supporting software from David
-	  Hinds' pcmcia-cs package (see the file <file:Documentation/Changes>
-	  for location). You also want to check out the PCMCIA-HOWTO,
-	  available from <http://www.linuxdoc.org/docs.html#howto>.
-
-config PCMCIA_RAYCS
-	tristate "Aviator/Raytheon 2.4MHz wireless support"
-	depends on NET_PCMCIA_RADIO && PCMCIA
-	---help---
-	  Say Y here if you intend to attach an Aviator/Raytheon PCMCIA
-	  (PC-card) wireless Ethernet networking card to your computer.
-	  Please read the file <file:Documentation/networking/ray_cs.txt> for
-	  details.
-
-	  This driver is also available as a module ( = code which can be
-	  inserted in and removed from the running kernel whenever you want).
-	  The module will be called ray_cs.  If you want to compile it as a
-	  module, say M here and read <file:Documentation/modules.txt>.  If
-	  unsure, say N.
 
 # yes, this works even when no drivers are selected
 config NET_WIRELESS
diff -u -p linux/drivers/net/wireless-j1/todo.txt linux/drivers/net/wireless/todo.txt
--- linux/drivers/net/wireless-j1/todo.txt	Mon Nov  4 14:30:37 2002
+++ linux/drivers/net/wireless/todo.txt	Mon Feb 24 18:57:33 2003
@@ -2,28 +2,14 @@
 	-------------
 
 1) Bring other kernel Wireless LAN drivers here
-	Already done :
-	 o hermes.c/orinoco.c	-> Wavelan IEEE driver + Airport driver
-	 o airo.c/airo_cs.c	-> Ben's Aironet driver
-	 o wavelan.c		-> old Wavelan ISA driver
-	 o wavelan_cs.c		-> old Wavelan Pcmcia driver
-	 o netwave_cs.c		-> Netwave Pcmcia driver
-	Drivers likely to go :
-	 o ray_cs.c		-> Raytheon/Aviator driver (maintainer MIA)
-	Drivers I have absolutely no control over :
-	 o arlan.c		-> old Aironet Arlan 655 (need to ask Elmer)
-	 o aironet4500_xxx.c	-> Elmer's Aironet driver (need to ask Elmer)
-	 o strip.c		-> Metricom's stuff. Not a wlan. Hum...
-
-	ETA : Kernel 2.5.X
+	Completed
 
 2) Bring new Wireless LAN driver not yet in the kernel there
 	See my web page for details
+	In particular : HostAP
 
 3) Misc
 	o Mark wavelan, wavelan_cs, netwave_cs drivers as obsolete
 	o Maybe arlan.c, ray_cs.c and strip.c also deserve to be obsolete
-	o Use new Probe/module stuff in wavelan.c
-	o New Wireless Extension API (pending)
 
 	Jean II
