Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267664AbTACVKp>; Fri, 3 Jan 2003 16:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267665AbTACVKo>; Fri, 3 Jan 2003 16:10:44 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:22471 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267664AbTACVKm>; Fri, 3 Jan 2003 16:10:42 -0500
Message-Id: <200301032119.WAA23832@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [unify netdev config 19/22] net.1-sparc
To: Tomas Szepe <kala@pinerecords.com>, linux-kernel@vger.kernel.org
Date: Fri, 03 Jan 2003 21:16:08 +0100
References: <3E14B164.mailLYS1115SL@louise.pinerecords.com>
Organization: IBM Deutschland Entwicklung GmbH
User-Agent: KNode/0.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:

> diff -urN a/drivers/net/Kconfig b/drivers/net/Kconfig
> --- a/drivers/net/Kconfig	2002-12-24 10:45:39.000000000 +0100
> +++ b/drivers/net/Kconfig	2003-01-02 22:01:16.000000000 +0100
> @@ -384,7 +384,7 @@
>  
>  config NET_VENDOR_3COM
>  	bool "3COM cards"
> -	depends on NET_ETHERNET
> +	depends on NET_ETHERNET && (ISA || EISA || MCA || PCI)
>  	help
>  	  If you have a network (Ethernet) card belonging to this class, say Y
>  	  and read the Ethernet-HOWTO, available from
... and a lot more.

There are some bus dependencies for network drivers that you omitted,
either on purpose or by accident. The patch below adds these
dependencies, which is required for compiling with allyesconfig
on s390 and perhaps other architectures.
The dependencies are taken either from reading the source of
searching the web, so there is a chance that there are mistakes.

	Arnd <><

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
