Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263694AbTCUS3M>; Fri, 21 Mar 2003 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263677AbTCUS2p>; Fri, 21 Mar 2003 13:28:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:55939
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263743AbTCUS0I>; Fri, 21 Mar 2003 13:26:08 -0500
Date: Fri, 21 Mar 2003 19:41:23 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211941.h2LJfNjS025893@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: config.in/Makefile for ne2k-cbus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/Kconfig linux-2.5.65-ac2/drivers/net/Kconfig
--- linux-2.5.65/drivers/net/Kconfig	2003-03-03 19:20:10.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/Kconfig	2003-03-20 18:31:38.000000000 +0000
@@ -978,7 +978,7 @@
 
 config NET_ISA
 	bool "Other ISA cards"
-	depends on NET_ETHERNET && ISA
+	depends on NET_ETHERNET && ISA && !X86_PC9800
 	---help---
 	  If your network (Ethernet) card hasn't been mentioned yet and its
 	  bus system (that's the way the cards talks to the other components
@@ -1176,6 +1176,55 @@
 	  the Ethernet-HOWTO, available from
 	  <http://www.linuxdoc.org/docs.html#howto>.
 
+config NET_CBUS
+	bool "NEC PC-9800 C-bus cards"
+	depends on NET_ETHERNET && ISA && X86_PC9800
+	---help---
+	  If your network (Ethernet) card hasn't been mentioned yet and its
+	  bus system (that's the way the cards talks to the other components
+	  of your computer) is NEC PC-9800 C-Bus, say Y.
+
+config NE2K_CBUS
+	tristate "Most NE2000-based Ethernet support"
+	depends on NET_CBUS
+
+config NE2K_CBUS_EGY98
+	bool "Melco EGY-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_LGY98
+	bool "Melco LGY-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_ICM
+	bool "ICM IF-27xxET support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_IOLA98
+	bool "I-O DATA LA-98 support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_CNET98EL
+	bool "Contec C-NET(98)E/L support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_CNET98EL_IO_BASE
+	hex "C-NET(98)E/L I/O base address (0xaaed or 0x55ed)"
+	depends on NE2K_CBUS_CNET98EL
+	default "0xaaed"
+
+config NE2K_CBUS_ATLA98
+	bool "Allied Telesis LA-98 Support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_BDN
+	bool "ELECOM Laneed LD-BDN[123]A Support"
+	depends on NE2K_CBUS
+
+config NE2K_CBUS_NEC108
+	bool "NEC PC-9801-108 Support"
+	depends on NE2K_CBUS
+
 config SKMC
 	tristate "SKnet MCA support"
 	depends on NET_ETHERNET && MCA
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/Makefile linux-2.5.65-ac2/drivers/net/Makefile
--- linux-2.5.65/drivers/net/Makefile	2003-03-03 19:20:10.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/Makefile	2003-03-20 18:29:43.000000000 +0000
@@ -81,6 +81,7 @@
 obj-$(CONFIG_WD80x3) += wd.o 8390.o
 obj-$(CONFIG_EL2) += 3c503.o 8390.o
 obj-$(CONFIG_NE2000) += ne.o 8390.o
+obj-$(CONFIG_NE2K_CBUS) += ne2k_cbus.o 8390.o
 obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
 obj-$(CONFIG_HPLAN) += hp.o 8390.o
 obj-$(CONFIG_HPLAN_PLUS) += hp-plus.o 8390.o
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/net/Makefile.lib linux-2.5.65-ac2/drivers/net/Makefile.lib
--- linux-2.5.65/drivers/net/Makefile.lib	2003-02-15 03:39:31.000000000 +0000
+++ linux-2.5.65-ac2/drivers/net/Makefile.lib	2003-03-20 18:29:43.000000000 +0000
@@ -19,6 +19,7 @@
 obj-$(CONFIG_MACMACE)		+= crc32.o
 obj-$(CONFIG_MIPS_AU1000_ENET)	+= crc32.o
 obj-$(CONFIG_NATSEMI)		+= crc32.o	
+obj-$(CONFIG_NE2K_CBUS)		+= crc32.o
 obj-$(CONFIG_PCMCIA_FMVJ18X)	+= crc32.o
 obj-$(CONFIG_PCMCIA_SMC91C92)	+= crc32.o
 obj-$(CONFIG_PCMCIA_XIRTULIP)	+= crc32.o
