Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264243AbVBDUES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264243AbVBDUES (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbVBDUDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:03:33 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:24836 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S266804AbVBDUAj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:00:39 -0500
Subject: [patch 2/8] uml: kconfig fixes [before 2.6.11]
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Fri, 04 Feb 2005 19:35:43 +0100
Message-Id: <20050204183543.D8A78310B6@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Change some config text (hide CONFIG_MODVERSION which is broken on UML and fix
a dummy prompt).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig |    6 ++----
 linux-2.6.11-paolo/init/Kconfig    |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff -puN init/Kconfig~uml-kconfig-fixes init/Kconfig
--- linux-2.6.11/init/Kconfig~uml-kconfig-fixes	2005-02-04 03:21:03.000000000 +0100
+++ linux-2.6.11-paolo/init/Kconfig	2005-02-04 03:23:37.000000000 +0100
@@ -410,7 +410,7 @@ config OBSOLETE_MODPARM
 
 config MODVERSIONS
 	bool "Module versioning support (EXPERIMENTAL)"
-	depends on MODULES && EXPERIMENTAL
+	depends on MODULES && EXPERIMENTAL && !USERMODE
 	help
 	  Usually, you have to use modules compiled with your kernel.
 	  Saying Y here makes it sometimes possible to use modules
diff -puN arch/um/Kconfig~uml-kconfig-fixes arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-kconfig-fixes	2005-02-04 03:26:44.762471872 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-02-04 03:26:44.764471568 +0100
@@ -313,11 +313,9 @@ if BROKEN
 	source "drivers/mtd/Kconfig"
 endif
 
+#This is just to shut up some Kconfig warnings, so no prompt.
 config INPUT
-	bool "Dummy option"
-	depends BROKEN
+	bool
 	default n
-	help
-	This is a dummy option to get rid of warnings.
 
 source "arch/um/Kconfig.debug"
_
