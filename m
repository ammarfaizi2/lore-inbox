Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266944AbTADOxH>; Sat, 4 Jan 2003 09:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTADOxH>; Sat, 4 Jan 2003 09:53:07 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:3274 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S266944AbTADOxF>; Sat, 4 Jan 2003 09:53:05 -0500
Date: Sat, 4 Jan 2003 16:01:28 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: [PATCH] unify netdev config follow-up
Message-ID: <20030104150128.GZ1360@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add more netdev bus dependencies.  Patch by Arnd Bergmann.

Linus, please apply.



===== drivers/net/Kconfig 1.8 vs edited =====
--- 1.8/drivers/net/Kconfig	Thu Jan  2 22:05:21 2003
+++ edited/drivers/net/Kconfig	Fri Jan  3 17:48:11 2003
@@ -2364,7 +2364,7 @@
 
 config ARLAN
 	tristate "Aironet Arlan 655 & IC2200 DS support"
-	depends on NET_RADIO
+	depends on NET_RADIO && ISA
 	---help---
 	  Aironet makes Arlan, a class of wireless LAN adapters. These use the
 	  www.Telxon.com chip, which is also used on several similar cards.
===== drivers/net/wan/Kconfig 1.1 vs edited =====
--- 1.1/drivers/net/wan/Kconfig	Wed Oct 30 02:16:55 2002
+++ edited/drivers/net/wan/Kconfig	Fri Jan  3 18:25:47 2003
@@ -62,7 +62,7 @@
 #
 config COMX
 	tristate "MultiGate (COMX) synchronous serial boards support"
-	depends on WAN
+	depends on WAN && (ISA || PCI)
 	---help---
 	  Say Y if you want to use any board from the MultiGate (COMX) family.
 	  These boards are synchronous serial adapters for the PC,
@@ -176,7 +176,7 @@
 #
 config DSCC4
 	tristate "Etinc PCISYNC serial board support"
-	depends on WAN && m
+	depends on WAN && PCI && m
 	help
 	  This is a driver for Etinc PCISYNC boards based on the Infineon
 	  (ex. Siemens) DSCC4 chipset. It is supposed to work with the four
@@ -193,7 +193,7 @@
 #
 config LANMEDIA
 	tristate "LanMedia Corp. SSI/V.35, T1/E1, HSSI, T3 boards"
-	depends on WAN
+	depends on WAN && PCI
 	---help---
 	  This is a driver for the following Lan Media family of serial
 	  boards.
@@ -222,7 +222,7 @@
 # There is no way to detect a Sealevel board. Force it modular
 config SEALEVEL_4021
 	tristate "Sealevel Systems 4021 support"
-	depends on WAN && m
+	depends on WAN && ISA && m
 	help
 	  This is a driver for the Sealevel Systems ACB 56 serial I/O adapter.
 
@@ -336,7 +336,7 @@
 
 config N2
 	tristate "SDL RISCom/N2 support"
-	depends on HDLC
+	depends on HDLC && ISA
 	help
 	  This driver is for RISCom/N2 single or dual channel ISA cards
 	  made by SDL Communications Inc.  If you have such a card,
@@ -348,7 +348,7 @@
 
 config C101
 	tristate "Moxa C101 support"
-	depends on HDLC
+	depends on HDLC && ISA
 	help
 	  This driver is for C101 SuperSync ISA cards made by Moxa
 	  Technologies Co., Ltd. If you have such a card,
@@ -358,7 +358,7 @@
 
 config FARSYNC
 	tristate "FarSync T-Series support"
-	depends on HDLC
+	depends on HDLC && PCI
 	---help---
 	  This driver supports the FarSync T-Series X.21 (and V.35/V.24) cards
 	  from FarSite Communications Ltd.
@@ -432,7 +432,7 @@
 
 config SDLA
 	tristate "SDLA (Sangoma S502/S508) support"
-	depends on DLCI
+	depends on DLCI && ISA
 	help
 	  Say Y here if you need a driver for the Sangoma S502A, S502E, and
 	  S508 Frame Relay Access Devices. These are multi-protocol cards, but
@@ -465,7 +465,7 @@
 
 config VENDOR_SANGOMA
 	tristate "Sangoma WANPIPE(tm) multiprotocol cards"
-	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER
+	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA)
 	---help---
 	  WANPIPE from Sangoma Technologies Inc. (<http://www.sangoma.com/>)
 	  is a family of intelligent multiprotocol WAN adapters with data
@@ -559,7 +559,7 @@
 
 config CYCLADES_SYNC
 	tristate "Cyclom 2X(tm) cards (EXPERIMENTAL)"
-	depends on WAN_ROUTER_DRIVERS
+	depends on WAN_ROUTER_DRIVERS && (PCI || ISA)
 	---help---
 	  Cyclom 2X from Cyclades Corporation (<http://www.cyclades.com/> and

