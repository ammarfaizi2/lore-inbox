Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUCOAi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 19:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262132AbUCOAi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 19:38:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:49858 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262129AbUCOAiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 19:38:22 -0500
Date: Sun, 14 Mar 2004 16:33:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: benh@kernel.crashing.org, davem@redhat.com
Subject: [patch/RFC] networking menus
Message-Id: <20040314163327.53102f46.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BenH mentioned last week that the networking menus need some help.
They are too twisted or confusing or something.

I was already looking into this.  Roman suggested s/config/menuconfig/,
which is helpful.

This is just a first pass/RFC.  It moves "Networking support" out of
the "Device Drivers" menu, which seems helpful to me.  However,
ISTM that it should really just be the "Networking options" here
and not include Amateur Radio, IrDA, and Bluetooth support.
I.e., I think that those latter 3 should fall under Device Drivers.
Does that make sense to anyone else?

Other comments?

Does this need to be discussed on netdev (also)?

Thanks,
--
~Randy



// Linux 2.6.4
// Rearrange networking menus so that Networking support/options
// isn't buried inside Device Drivers.

diffstat:=
 drivers/Kconfig       |    4 +++-
 init/Kconfig          |    0
 net/Kconfig           |    6 ++----
 net/ax25/Kconfig      |    7 ++-----
 net/bluetooth/Kconfig |    4 +---
 net/irda/Kconfig      |    6 ++----
 6 files changed, 10 insertions(+), 17 deletions(-)


diff -Naurp ./drivers/Kconfig~net_config ./drivers/Kconfig
--- ./drivers/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
+++ ./drivers/Kconfig	2004-03-12 15:20:39.000000000 -0800
@@ -1,5 +1,7 @@
 # drivers/Kconfig
 
+source "net/Kconfig"
+
 menu "Device Drivers"
 
 source "drivers/base/Kconfig"
@@ -28,7 +30,7 @@ source "drivers/message/i2o/Kconfig"
 
 source "drivers/macintosh/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff -Naurp ./net/bluetooth/Kconfig~net_config ./net/bluetooth/Kconfig
--- ./net/bluetooth/Kconfig~net_config	2004-03-10 18:55:43.000000000 -0800
+++ ./net/bluetooth/Kconfig	2004-03-12 15:41:42.000000000 -0800
@@ -2,10 +2,8 @@
 # Bluetooth subsystem configuration
 #
 
-menu "Bluetooth support"
+menuconfig BT
 	depends on NET
-
-config BT
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
diff -Naurp ./net/irda/Kconfig~net_config ./net/irda/Kconfig
--- ./net/irda/Kconfig~net_config	2004-03-10 18:55:27.000000000 -0800
+++ ./net/irda/Kconfig	2004-03-12 15:39:39.000000000 -0800
@@ -2,11 +2,9 @@
 # IrDA protocol configuration
 #
 
-menu "IrDA (infrared) support"
+menuconfig IRDA
 	depends on NET
-
-config IRDA
-	tristate "IrDA subsystem support"
+	tristate "IrDA (infrared) subsystem support"
 	---help---
 	  Say Y here if you want to build support for the IrDA (TM) protocols.
 	  The Infrared Data Associations (tm) specifies standards for wireless
diff -Naurp ./net/ax25/Kconfig~net_config ./net/ax25/Kconfig
--- ./net/ax25/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
+++ ./net/ax25/Kconfig	2004-03-12 15:40:01.000000000 -0800
@@ -6,9 +6,8 @@
 #		Joerg Reuter DL1BKE <jreuter@yaina.de>
 # 19980129	Moved to net/ax25/Config.in, sourcing device drivers.
 
-menu "Amateur Radio support"
-
-config HAMRADIO
+menuconfig HAMRADIO
+	depends on NET
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
@@ -109,5 +108,3 @@ source "drivers/net/hamradio/Kconfig"
 
 endmenu
 
-endmenu
-
diff -Naurp ./net/Kconfig~net_config ./net/Kconfig
--- ./net/Kconfig~net_config	2004-03-10 18:55:21.000000000 -0800
+++ ./net/Kconfig	2004-03-12 15:24:30.000000000 -0800
@@ -2,9 +2,9 @@
 # Network configuration
 #
 
-menu "Networking support"
+###menu "Networking support"
 
-config NET
+menuconfig NET
 	bool "Networking support"
 	---help---
 	  Unless you really know what you are doing, you should say Y here.
@@ -650,8 +650,6 @@ endmenu
 
 endmenu
 
-source "drivers/net/Kconfig"
-
 source "net/ax25/Kconfig"
 
 source "net/irda/Kconfig"
diff -Naurp ./init/Kconfig~net_config ./init/Kconfig
