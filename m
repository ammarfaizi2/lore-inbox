Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269060AbUHMK1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269060AbUHMK1D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269057AbUHMK0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:26:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60104 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269065AbUHMKZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:25:01 -0400
Date: Fri, 13 Aug 2004 12:22:02 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.or
Subject: [2.6 patch] CONFIG_MII requires only CONFIG_NET
Message-ID: <20040813102202.GT13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

the patch below still applies against 2.6.8-rc4-mm1.

Could you comment on it and apply it if it's correct?

TIA
Adrian


But trying it out CONFIG_MII=y seems to at least compile with 
CONFIG_NET_ETHERNET=n.

@Jeff:
It seems, CONFIG_MII doesn't actually require CONFIG_NET_ETHERNET?
Could you comment on the following patch?


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.6-rc1-mm1-full/drivers/net/Kconfig.old	2004-04-20 00:48:27.000000000 +0200
+++ linux-2.6.6-rc1-mm1-full/drivers/net/Kconfig	2004-04-20 01:07:51.000000000 +0200
@@ -151,6 +151,15 @@
 
 	  If you don't have this card, of course say N.
 
+config MII
+        tristate "Generic Media Independent Interface device support"
+        depends on NET
+        help
+          Most ethernet controllers have MII transceiver either as an external
+          or internal device.  It is safe to say Y or M here even if your
+          ethernet card lack MII.
+
+
 if NETDEVICES
 	source "drivers/net/arcnet/Kconfig"
 endif
@@ -188,14 +197,6 @@
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
 
-config MII
-	tristate "Generic Media Independent Interface device support"
-	depends on NET_ETHERNET
-	help
-	  Most ethernet controllers have MII transceiver either as an external
-	  or internal device.  It is safe to say Y or M here even if your
-	  ethernet card lack MII.
-
 source "drivers/net/arm/Kconfig"
 
 config MACE


