Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269762AbUJMRts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269762AbUJMRts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 13:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269766AbUJMRts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 13:49:48 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:24964
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269762AbUJMRtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 13:49:43 -0400
Subject: [patch 1/1] uml: mark broken configs (fixed-up)
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it,
       zippel@linux-m68k.org
From: blaisorblade_spam@yahoo.it
Date: Wed, 13 Oct 2004 19:20:40 +0200
Message-Id: <20041013172041.2C3C58685@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>, Roman Zippel <zippel@linux-m68k.org>
Some configuration options are known not to compile. So then make them
depend on CONFIG_BROKEN.

In this version, which completely replaces the previous one, posted yesterday
as "uml: mark broken configs", I do this:
 menu "SCSI support"
+depends on BROKEN

instead of this:

-menu "SCSI support"
+if BROKEN
+     menu "SCSI support"
...
+endif

as was requested by Roman Zippel.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Kconfig       |    7 +++++--
 linux-2.6.9-current-paolo/arch/um/Kconfig_block |    1 +
 linux-2.6.9-current-paolo/arch/um/Kconfig_net   |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff -puN arch/um/Kconfig~uml-mark_broken_configs arch/um/Kconfig
--- linux-2.6.9-current/arch/um/Kconfig~uml-mark_broken_configs	2004-10-13 17:23:55.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig	2004-10-13 17:26:54.967233056 +0200
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
@@ -226,6 +226,7 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 menu "SCSI support"
+depends on BROKEN
 
 config SCSI
 	tristate "SCSI support"
@@ -242,6 +243,8 @@ endmenu
 
 source "drivers/md/Kconfig"
 
-source "drivers/mtd/Kconfig"
+if BROKEN
+	source "drivers/mtd/Kconfig"
+endif
 
 source "arch/um/Kconfig.debug"
diff -puN arch/um/Kconfig_block~uml-mark_broken_configs arch/um/Kconfig_block
--- linux-2.6.9-current/arch/um/Kconfig_block~uml-mark_broken_configs	2004-10-13 17:23:55.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_block	2004-10-13 17:23:55.920452304 +0200
@@ -54,6 +54,7 @@ config BLK_DEV_INITRD
 
 config MMAPPER
 	tristate "Example IO memory driver"
+	depends on BROKEN
 	help
         The User-Mode Linux port can provide support for IO Memory
         emulation with this option.  This allows a host file to be
diff -puN arch/um/Kconfig_net~uml-mark_broken_configs arch/um/Kconfig_net
--- linux-2.6.9-current/arch/um/Kconfig_net~uml-mark_broken_configs	2004-10-13 17:23:55.000000000 +0200
+++ linux-2.6.9-current-paolo/arch/um/Kconfig_net	2004-10-13 17:23:55.920452304 +0200
@@ -135,7 +135,7 @@ config UML_NET_MCAST
 
 config UML_NET_PCAP
 	bool "pcap transport"
-	depends on UML_NET
+	depends on UML_NET && BROKEN
 	help
 	The pcap transport makes a pcap packet stream on the host look
 	like an ethernet device inside UML.  This is useful for making 
_
