Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWILP4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWILP4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWILP4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:56:17 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:43682 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751430AbWILPu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:58 -0400
Message-Id: <20060912144904.514733000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 14/20] uml: enable scsi and add iscsi config
Content-Disposition: inline; filename=uml_iscsi.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable iSCSI on UML, dunno why SCSI was deemed broken, it works like a charm.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Jeff Dike <jdike@addtoit.com>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 arch/um/Kconfig      |   16 --------------
 arch/um/Kconfig.scsi |   58 ---------------------------------------------------
 2 files changed, 1 insertion(+), 73 deletions(-)

Index: linux-2.6/arch/um/Kconfig
===================================================================
--- linux-2.6.orig/arch/um/Kconfig
+++ linux-2.6/arch/um/Kconfig
@@ -285,21 +285,7 @@ source "crypto/Kconfig"
 
 source "lib/Kconfig"
 
-menu "SCSI support"
-depends on BROKEN
-
-config SCSI
-	tristate "SCSI support"
-
-# This gives us free_dma, which scsi.c wants.
-config GENERIC_ISA_DMA
-	bool
-	depends on SCSI
-	default y
-
-source "arch/um/Kconfig.scsi"
-
-endmenu
+source "drivers/scsi/Kconfig"
 
 source "drivers/md/Kconfig"
 
Index: linux-2.6/arch/um/Kconfig.scsi
===================================================================
--- linux-2.6.orig/arch/um/Kconfig.scsi
+++ /dev/null
@@ -1,58 +0,0 @@
-comment "SCSI support type (disk, tape, CD-ROM)"
-	depends on SCSI
-
-config BLK_DEV_SD
-	tristate "SCSI disk support"
-	depends on SCSI
-
-config SD_EXTRA_DEVS
-	int "Maximum number of SCSI disks that can be loaded as modules"
-	depends on BLK_DEV_SD
-	default "40"
-
-config CHR_DEV_ST
-	tristate "SCSI tape support"
-	depends on SCSI
-
-config BLK_DEV_SR
-	tristate "SCSI CD-ROM support"
-	depends on SCSI
-
-config BLK_DEV_SR_VENDOR
-	bool "Enable vendor-specific extensions (for SCSI CDROM)"
-	depends on BLK_DEV_SR
-
-config SR_EXTRA_DEVS
-	int "Maximum number of CDROM devices that can be loaded as modules"
-	depends on BLK_DEV_SR
-	default "2"
-
-config CHR_DEV_SG
-	tristate "SCSI generic support"
-	depends on SCSI
-
-comment "Some SCSI devices (e.g. CD jukebox) support multiple LUNs"
-	depends on SCSI
-
-#if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-config SCSI_DEBUG_QUEUES
-	bool "Enable extra checks in new queueing code"
-	depends on SCSI
-
-#fi
-config SCSI_MULTI_LUN
-	bool "Probe all LUNs on each SCSI device"
-	depends on SCSI
-
-config SCSI_CONSTANTS
-	bool "Verbose SCSI error reporting (kernel size +=12K)"
-	depends on SCSI
-
-config SCSI_LOGGING
-	bool "SCSI logging facility"
-	depends on SCSI
-
-config SCSI_DEBUG
-	tristate "SCSI debugging host simulator (EXPERIMENTAL)"
-	depends on SCSI
-

--

