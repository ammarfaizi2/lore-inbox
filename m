Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVAMPdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVAMPdJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 10:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVAMPcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 10:32:02 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:60932 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261657AbVAMPbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 10:31:11 -0500
Subject: [patch 2/8] uml: readd CONFIG_MAGIC_SYSRQ for UML
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 06:13:27 +0100
Message-Id: <20050113051327.B173A6324B@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

This config option was lost during the creation of lib/Kconfig.debug, due to a
bad expressed dependency; I also moved the option back to its original place
for UML (it is near CONFIG_MCONSOLE since it depends on that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/Kconfig   |   19 +++++++++++++++++++
 linux-2.6.11-paolo/lib/Kconfig.debug |    1 -
 2 files changed, 19 insertions(+), 1 deletion(-)

diff -puN lib/Kconfig.debug~uml-readd-config-magic-sysrq lib/Kconfig.debug
--- linux-2.6.11/lib/Kconfig.debug~uml-readd-config-magic-sysrq	2005-01-13 01:48:41.153139144 +0100
+++ linux-2.6.11-paolo/lib/Kconfig.debug	2005-01-13 01:48:41.157138536 +0100
@@ -23,7 +23,6 @@ config MAGIC_SYSRQ
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on DEBUG_KERNEL && (H8300 || M68KNOMMU || V850)
-	depends (USERMODE && MCONSOLE)
 	help
 	  Enables console device to interpret special characters as
 	  commands to dump state information.
diff -puN arch/um/Kconfig~uml-readd-config-magic-sysrq arch/um/Kconfig
--- linux-2.6.11/arch/um/Kconfig~uml-readd-config-magic-sysrq	2005-01-13 01:48:41.155138840 +0100
+++ linux-2.6.11-paolo/arch/um/Kconfig	2005-01-13 01:48:41.158138384 +0100
@@ -145,6 +145,25 @@ config MCONSOLE
 
         It is safe to say 'Y' here.
 
+config MAGIC_SYSRQ
+	bool "Magic SysRq key"
+	depends on MCONSOLE
+	---help---
+	If you say Y here, you will have some control over the system even
+	if the system crashes for example during kernel debugging (e.g., you
+	will be able to flush the buffer cache to disk, reboot the system
+	immediately or dump some status information). A key for each of the
+	possible requests is provided.
+
+	This is the feature normally accomplished by pressing a key
+	while holding SysRq (Alt+PrintScreen).
+
+	On UML, this is accomplished by sending a "sysrq" command with
+	mconsole, followed by the letter for the requested command.
+
+	The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
+	unless you really know what this hack does.
+
 config HOST_2G_2G
 	bool "2G/2G host address space split"
 	default n
_
