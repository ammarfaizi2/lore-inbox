Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268325AbUIFSFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268325AbUIFSFc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbUIFSFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:05:31 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:46039 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268325AbUIFSFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:05:13 -0400
Subject: [patch 1/1] uml-mark_broken_configs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 06 Sep 2004 20:00:33 +0200
Message-Id: <20040906180033.7463E8D1E@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some configuration options are known not to compile. So then make them
depend on CONFIG_BROKEN.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/arch/um/Kconfig       |   27 +++++++++++++++-----------
 uml-linux-2.6.8.1-paolo/arch/um/Kconfig_block |    1 
 uml-linux-2.6.8.1-paolo/arch/um/Kconfig_net   |    2 -
 3 files changed, 18 insertions(+), 12 deletions(-)

diff -puN arch/um/Kconfig~uml-mark_broken_configs arch/um/Kconfig
--- uml-linux-2.6.8.1/arch/um/Kconfig~uml-mark_broken_configs	2004-08-29 14:40:49.316714496 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig	2004-08-29 14:40:49.320713888 +0200
@@ -155,6 +155,7 @@ config HOST_2G_2G
 
 config UML_SMP
 	bool "Symmetric multi-processing support"
+	depends on BROKEN
 	help
         This option enables UML SMP support.  UML implements virtual SMP by
         allowing as many processes to run simultaneously on the host as
@@ -203,6 +204,7 @@ config KERNEL_HALF_GIGS
 
 config HIGHMEM
 	bool "Highmem support"
+	depends on BROKEN
 
 config KERNEL_STACK_ORDER
 	int "Kernel stack size order"
@@ -249,25 +251,28 @@ source "crypto/Kconfig"
 
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
 
 menu "Kernel hacking"
 
diff -puN arch/um/Kconfig_block~uml-mark_broken_configs arch/um/Kconfig_block
--- uml-linux-2.6.8.1/arch/um/Kconfig_block~uml-mark_broken_configs	2004-08-29 14:40:49.317714344 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig_block	2004-08-29 14:40:49.320713888 +0200
@@ -64,6 +64,7 @@ config BLK_DEV_INITRD
 
 config MMAPPER
 	tristate "Example IO memory driver"
+	depends on BROKEN
 	help
         The User-Mode Linux port can provide support for IO Memory
         emulation with this option.  This allows a host file to be
diff -puN arch/um/Kconfig_net~uml-mark_broken_configs arch/um/Kconfig_net
--- uml-linux-2.6.8.1/arch/um/Kconfig_net~uml-mark_broken_configs	2004-08-29 14:40:49.318714192 +0200
+++ uml-linux-2.6.8.1-paolo/arch/um/Kconfig_net	2004-08-29 14:40:49.321713736 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET
+	depends on UML_NET && BROKEN
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
_
