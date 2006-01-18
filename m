Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWASAAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWASAAA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 19:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWARX7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:59:44 -0500
Received: from [151.97.230.9] ([151.97.230.9]:6889 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030486AbWARX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:59:36 -0500
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] Kbuild menu - hide empty NETDEVICES menu when NET is disabled
Date: Wed, 18 Jan 2006 12:00:33 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060118110032.27763.6389.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make the whole netdevices menu depend on NET, rather than having an empty
submenu when networking is disabled.

Indeed, almost the whole body of the menu was surrounded by if NETDEVICES, and
what was outside depended on NETCONSOLE which is inside the menu.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 drivers/net/Kconfig |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index c0f9351..3d5fbd8 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -4,9 +4,9 @@
 #
 
 menu "Network device support"
+	depends on NET
 
 config NETDEVICES
-	depends on NET
 	default y if UML
 	bool "Network device support"
 	---help---
@@ -24,9 +24,6 @@ config NETDEVICES
 
 	  If unsure, say Y.
 
-# All the following symbols are dependent on NETDEVICES - do not repeat
-# that for each of the symbols.
-if NETDEVICES
 
 config IFB
 	tristate "Intermediate Functional Block support"
@@ -2687,8 +2684,6 @@ config NETCONSOLE
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.
 
-endif #NETDEVICES
-
 config NETPOLL
 	def_bool NETCONSOLE
 

