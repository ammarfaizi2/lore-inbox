Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWC1XBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWC1XBU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 18:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964782AbWC1W7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:59:09 -0500
Received: from [198.99.130.12] ([198.99.130.12]:20675 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964786AbWC1W7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:59:02 -0500
Message-Id: <200603282300.k2SN0C7n022987@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       viro@zeniv.linux.org.uk
Subject: [PATCH 6/10] Sanitize net Kconfigs
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Mar 2006 18:00:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
uml: kconfig sanitized around drivers/net
 
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

 arch/um/Kconfig               |    3 +++
 drivers/net/Kconfig           |    2 --
 drivers/net/tokenring/Kconfig |    2 +-
 drivers/net/wireless/Kconfig  |    2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.16-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/arch/um/Kconfig	2006-03-23 16:40:20.000000000 -0500
+++ linux-2.6.16-mm/arch/um/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -22,6 +22,9 @@ config SBUS
 config PCI
 	bool
 
+config PCMCIA
+	bool
+
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: linux-2.6.16-mm/drivers/net/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/Kconfig	2006-03-28 09:30:43.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -2313,13 +2313,11 @@ config S2IO_NAPI
 
 endmenu
 
-if !UML
 source "drivers/net/tokenring/Kconfig"
 
 source "drivers/net/wireless/Kconfig"
 
 source "drivers/net/pcmcia/Kconfig"
-endif
 
 source "drivers/net/wan/Kconfig"
 
Index: linux-2.6.16-mm/drivers/net/tokenring/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/tokenring/Kconfig	2006-03-28 09:30:43.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/tokenring/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -3,7 +3,7 @@
 #
 
 menu "Token Ring devices"
-	depends on NETDEVICES
+	depends on NETDEVICES && !UML
 
 # So far, we only have PCI, ISA, and MCA token ring devices
 config TR
Index: linux-2.6.16-mm/drivers/net/wireless/Kconfig
===================================================================
--- linux-2.6.16-mm.orig/drivers/net/wireless/Kconfig	2006-03-28 09:30:44.000000000 -0500
+++ linux-2.6.16-mm/drivers/net/wireless/Kconfig	2006-03-28 09:34:46.000000000 -0500
@@ -359,7 +359,7 @@ config PCI_HERMES
 
 config ATMEL
       tristate "Atmel at76c50x chipset  802.11b support"
-      depends on NET_RADIO
+      depends on NET_RADIO && (PCI || PCMCIA)
       select FW_LOADER
       select CRC32
        ---help---

