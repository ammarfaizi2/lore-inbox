Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUJ3WDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUJ3WDp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbUJ3WDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:03:45 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:36613 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261339AbUJ3WDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:03:41 -0400
Date: Sun, 31 Oct 2004 00:03:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Roman Zippel <zippel@linux-m68k.org>, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let FW_LOADER select HOTPLUG
Message-ID: <20041030220309.GE4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If it wasn't for external modules, FW_LOADER wasn't user-visible.
Let FW_LOADER select HOTPLUG To make the dependencies easier for users.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/base/Kconfig.old	2004-10-30 23:51:28.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/base/Kconfig	2004-10-30 23:51:40.000000000 +0200
@@ -20,7 +20,7 @@
 
 config FW_LOADER
 	tristate "Hotplug firmware loading support"
-	depends on HOTPLUG
+	select HOTPLUG
 	---help---
 	  This option is provided for the case where no in-kernel-tree modules
 	  require hotplug firmware loading support, but a module built outside
--- linux-2.6.10-rc1-mm2-full/drivers/net/wireless/Kconfig.old	2004-10-30 23:56:20.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/wireless/Kconfig	2004-10-30 23:56:39.000000000 +0200
@@ -309,9 +309,10 @@
 
 comment "Prism GT/Duette 802.11(a/b/g) PCI/Cardbus support"
 	depends on NET_RADIO && PCI
+
 config PRISM54
 	tristate 'Intersil Prism GT/Duette/Indigo PCI/Cardbus' 
-	depends on PCI && NET_RADIO && EXPERIMENTAL && HOTPLUG
+	depends on PCI && NET_RADIO && EXPERIMENTAL
 	select FW_LOADER
 	---help---
 	  Enable PCI and Cardbus support for the following chipset based cards:
--- linux-2.6.10-rc1-mm2-full/drivers/net/tokenring/Kconfig.old	2004-10-30 23:57:10.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/net/tokenring/Kconfig	2004-10-30 23:57:21.000000000 +0200
@@ -84,7 +84,7 @@
 
 config TMS380TR
 	tristate "Generic TMS380 Token Ring ISA/PCI adapter support"
-	depends on TR && (PCI || ISA) && HOTPLUG
+	depends on TR && (PCI || ISA)
 	select FW_LOADER
 	---help---
 	  This driver provides generic support for token ring adapters
