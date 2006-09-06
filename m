Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWIFNmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWIFNmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWIFNmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:42:22 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:8863 "EHLO
	amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750905AbWIFNie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:34 -0400
Message-Id: <20060906133955.337828000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:44 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Jeff Dike <jdike@addtoit.com>,
       Mike Christie <michaelc@cs.wisc.edu>
Subject: [PATCH 14/21] uml: enable scsi and add iscsi config
Content-Disposition: inline; filename=uml_iscsi.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enable iSCSI on UML, dunno why SCSI was deemed broken, it works like a charm.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Jeff Dike <jdike@addtoit.com>
CC: Mike Christie <michaelc@cs.wisc.edu>
---
 arch/um/Kconfig      |    2 +-
 arch/um/Kconfig.scsi |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

Index: linux-2.6/arch/um/Kconfig
===================================================================
--- linux-2.6.orig/arch/um/Kconfig
+++ linux-2.6/arch/um/Kconfig
@@ -286,7 +286,6 @@ source "crypto/Kconfig"
 source "lib/Kconfig"
 
 menu "SCSI support"
-depends on BROKEN
 
 config SCSI
 	tristate "SCSI support"
Index: linux-2.6/arch/um/Kconfig.scsi
===================================================================
--- linux-2.6.orig/arch/um/Kconfig.scsi
+++ linux-2.6/arch/um/Kconfig.scsi
@@ -56,3 +56,35 @@ config SCSI_DEBUG
 	tristate "SCSI debugging host simulator (EXPERIMENTAL)"
 	depends on SCSI
 
+config SCSI_ISCSI_ATTRS
+	tristate "iSCSI Transport Attributes"
+	depends on SCSI && NET
+	help
+	  If you wish to export transport-specific information about
+	  each attached iSCSI device to sysfs, say Y.
+	  Otherwise, say N.
+
+config ISCSI_TCP
+	tristate "iSCSI Initiator over TCP/IP"
+	depends on SCSI && INET
+	select CRYPTO
+	select CRYPTO_MD5
+	select CRYPTO_CRC32C
+	select SCSI_ISCSI_ATTRS
+	help
+	 The iSCSI Driver provides a host with the ability to access storage
+	 through an IP network. The driver uses the iSCSI protocol to transport
+	 SCSI requests and responses over a TCP/IP network between the host
+	 (the "initiator") and "targets".  Architecturally, the iSCSI driver
+	 combines with the host's TCP/IP stack, network drivers, and Network
+	 Interface Card (NIC) to provide the same functions as a SCSI or a
+	 Fibre Channel (FC) adapter driver with a Host Bus Adapter (HBA).
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called iscsi_tcp.
+
+	 The userspace component needed to initialize the driver, documentation,
+	 and sample configuration files can be found here:
+
+	 http://linux-iscsi.sf.net
+

--
