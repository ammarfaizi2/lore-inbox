Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269401AbUJLAXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269401AbUJLAXW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbUJLAXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:23:14 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:25475
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269398AbUJLATJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:09 -0400
Subject: [patch 08/10] uml: mark broken configs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:18:01 +0200
Message-Id: <20041012001801.7FD428697@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some configuration options are known not to compile. So then make them
depend on CONFIG_BROKEN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig       |   27 +++++++++++++-----------
 linux-2.6.9-current-paolo/arch/um/Kconfig_block |    1 
 linux-2.6.9-current-paolo/arch/um/Kconfig_net   |    2 -
 3 files changed, 17 insertions(+), 13 deletions(-)

diff -puN arch/um/Kconfig~uml-mark_broken_configs arch/um/Kconfig
--- linux-2.6.9-current/arch/um/Kconfig~uml-mark_broken_configs	2004-10-12 01:17:58.598244688 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig	2004-10-12 01:17:58.602244080 +0200
@@ -143,7 +143,6 @@ config SMP
         will appear to be running simultaneously.  If the host is a
         multiprocessor, then UML processes may run simultaneously, depending
         on the host scheduler.
-        CONFIG_SMP will be set to whatever this option is set to.
         It is safe to leave this unchanged.
 
 config NR_CPUS
@@ -179,6 +178,7 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
+	depends on BROKEN
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
@@ -225,23 +225,26 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
-menu "SCSI support"
+if BROKEN
+	menu "SCSI support"
 
-config SCSI
-	tristate "SCSI support"
+	config SCSI
+		tristate "SCSI support"
 
 # This gives us free_dma, which scsi.c wants.
-config GENERIC_ISA_DMA
-	bool
-	depends on SCSI
-	default y
+	config GENERIC_ISA_DMA
+		bool
+		depends on SCSI
+		default y
 
-source "arch/um/Kconfig_scsi"
+	source "arch/um/Kconfig_scsi"
 
-endmenu
+	endmenu
+endif
 
 source "drivers/md/Kconfig"
 
-source "drivers/mtd/Kconfig"
-
+if BROKEN
+	source "drivers/mtd/Kconfig"
+endif
 source "arch/um/Kconfig.debug"
diff -puN arch/um/Kconfig_block~uml-mark_broken_configs arch/um/Kconfig_block
--- linux-2.6.9-current/arch/um/Kconfig_block~uml-mark_broken_configs	2004-10-12 01:17:58.599244536 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_block	2004-10-12 01:17:58.602244080 +0200
@@ -54,6 +54,7 @@ config BLK_DEV_INITRD
 
 config MMAPPER
 	tristate "Example IO memory driver"
+	depends on BROKEN
 	help
         The User-Mode Linux port can provide support for IO Memory
         emulation with this option.  This allows a host file to be
diff -puN arch/um/Kconfig_net~uml-mark_broken_configs arch/um/Kconfig_net
--- linux-2.6.9-current/arch/um/Kconfig_net~uml-mark_broken_configs	2004-10-12 01:17:58.600244384 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_net	2004-10-12 01:17:58.603243928 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET
+	depends on UML_NET && BROKEN
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
_
