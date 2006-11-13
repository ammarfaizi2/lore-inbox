Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932762AbWKMSs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbWKMSs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322AbWKMSs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:48:58 -0500
Received: from khc.piap.pl ([195.187.100.11]:38056 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1755321AbWKMSs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:48:56 -0500
To: Jeff Garzik <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Francois Romieu <romieu@cogenit.fr>
Subject: [PATCH] WAN: DSCC4 driver requires generic HDLC
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 13 Nov 2006 19:48:54 +0100
Message-ID: <m37ixz89nt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing, reported recently to me by several people - DSCC4 WAN
driver now (and perhaps for the last couple of years+) requires the
generic HDLC. I've fixed the Kconfig and moved the DSCC4 option
under CONFIG_HDLC so it's consistent visually.

Jeff, Francois, I think it's safe to apply. Thanks.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

diff --git a/drivers/net/wan/Kconfig b/drivers/net/wan/Kconfig
index b5d0d7f..d5ab9cf 100644
--- a/drivers/net/wan/Kconfig
+++ b/drivers/net/wan/Kconfig
@@ -57,44 +57,6 @@ config COSA
 	  The driver will be compiled as a module: the
 	  module will be called cosa.
 
-config DSCC4
-	tristate "Etinc PCISYNC serial board support"
-	depends on WAN && PCI && m
-	help
-	  Driver for Etinc PCISYNC boards based on the Infineon (ex. Siemens)
-	  DSCC4 chipset.
-
-	  This is supposed to work with the four port card. Take a look at
-	  <http://www.cogenit.fr/dscc4/> for further information about the
-	  driver.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called dscc4.
-
-config DSCC4_PCISYNC
-	bool "Etinc PCISYNC features"
-	depends on DSCC4
-	help
-	  Due to Etinc's design choice for its PCISYNC cards, some operations
-	  are only allowed on specific ports of the DSCC4. This option is the
-	  only way for the driver to know that it shouldn't return a success
-	  code for these operations.
-
-	  Please say Y if your card is an Etinc's PCISYNC.
-
-config DSCC4_PCI_RST
-	bool "Hard reset support"
-	depends on DSCC4
-	help
-	  Various DSCC4 bugs forbid any reliable software reset of the ASIC.
-	  As a replacement, some vendors provide a way to assert the PCI #RST
-	  pin of DSCC4 through the GPIO port of the card. If you choose Y,
-	  the driver will make use of this feature before module removal
-	  (i.e. rmmod). The feature is known to be available on Commtech's
-	  cards. Contact your manufacturer for details.
-
-	  Say Y if your card supports this feature.
-
 #
 # Lan Media's board. Currently 1000, 1200, 5200, 5245
 #
@@ -323,6 +285,44 @@ config FARSYNC
 	  To compile this driver as a module, choose M here: the
 	  module will be called farsync.
 
+config DSCC4
+	tristate "Etinc PCISYNC serial board support"
+	depends on HDLC && PCI && m
+	help
+	  Driver for Etinc PCISYNC boards based on the Infineon (ex. Siemens)
+	  DSCC4 chipset.
+
+	  This is supposed to work with the four port card. Take a look at
+	  <http://www.cogenit.fr/dscc4/> for further information about the
+	  driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called dscc4.
+
+config DSCC4_PCISYNC
+	bool "Etinc PCISYNC features"
+	depends on DSCC4
+	help
+	  Due to Etinc's design choice for its PCISYNC cards, some operations
+	  are only allowed on specific ports of the DSCC4. This option is the
+	  only way for the driver to know that it shouldn't return a success
+	  code for these operations.
+
+	  Please say Y if your card is an Etinc's PCISYNC.
+
+config DSCC4_PCI_RST
+	bool "Hard reset support"
+	depends on DSCC4
+	help
+	  Various DSCC4 bugs forbid any reliable software reset of the ASIC.
+	  As a replacement, some vendors provide a way to assert the PCI #RST
+	  pin of DSCC4 through the GPIO port of the card. If you choose Y,
+	  the driver will make use of this feature before module removal
+	  (i.e. rmmod). The feature is known to be available on Commtech's
+	  cards. Contact your manufacturer for details.
+
+	  Say Y if your card supports this feature.
+
 config DLCI
 	tristate "Frame Relay DLCI support"
 	depends on WAN
