Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966439AbWKYLiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966439AbWKYLiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 06:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966440AbWKYLiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 06:38:09 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:8613 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S966439AbWKYLiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 06:38:07 -0500
X-Originating-Ip: 72.57.81.197
Date: Sat, 25 Nov 2006 06:34:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] MPT:  make all Fusion MPT sub-choices singly selectable
Message-ID: <Pine.LNX.4.64.0611250627200.20370@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-6.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_05 -5.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Put all of the Fusion MPT sub-choices under a single top-level
config entry.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  Is there any reason that the sub-choices for Fusion MPT can't be
selected or deselected en masse, the way it's done for, say, MTD
support and other components?

  There are other locations where this simplification could be used
but I thought I'd wait for some feedback on this example first.

diff --git a/drivers/message/fusion/Kconfig b/drivers/message/fusion/Kconfig
index ea31d84..a4f0097 100644
--- a/drivers/message/fusion/Kconfig
+++ b/drivers/message/fusion/Kconfig
@@ -2,13 +2,12 @@
 menu "Fusion MPT device support"

 config FUSION
-	bool
+	bool "Fusion MPT device support"
 	default n

 config FUSION_SPI
 	tristate "Fusion MPT ScsiHost drivers for SPI"
-	depends on PCI && SCSI
-	select FUSION
+	depends on FUSION && PCI && SCSI
 	select SCSI_SPI_ATTRS
 	---help---
 	  SCSI HOST support for a parallel SCSI host adapters.
@@ -22,8 +21,7 @@ config FUSION_SPI

 config FUSION_FC
 	tristate "Fusion MPT ScsiHost drivers for FC"
-	depends on PCI && SCSI
-	select FUSION
+	depends on FUSION && PCI && SCSI
 	select SCSI_FC_ATTRS
 	---help---
 	  SCSI HOST support for a Fiber Channel host adapters.
@@ -39,8 +37,7 @@ config FUSION_FC

 config FUSION_SAS
 	tristate "Fusion MPT ScsiHost drivers for SAS"
-	depends on PCI && SCSI
- 	select FUSION
+	depends on FUSION && PCI && SCSI
 	select SCSI_SAS_ATTRS
 	---help---
 	  SCSI HOST support for a SAS host adapters.


