Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVCQWUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVCQWUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCQWUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:20:37 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:19836 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261212AbVCQWUS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:20:18 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 02/05] libata: AHCI error handling fix
Message-ID: <20050317221753.47B975B8@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:11 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

02_libata_ahci-err-int.patch

	(included in libata-2.6) Fixes AHCI bits during handling of
	fatal error int.

Signed-off-by: Brett Russ <russb@emc.com>

 ahci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: libata-dev-2.6/drivers/scsi/ahci.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/ahci.c	2005-03-17 17:16:57.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/ahci.c	2005-03-17 17:16:57.000000000 -0500
@@ -548,7 +548,7 @@ static void ahci_intr_error(struct ata_p
 
 	/* stop DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp &= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp &= ~PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 
 	/* wait for engine to stop.  TODO: this could be
@@ -580,7 +580,7 @@ static void ahci_intr_error(struct ata_p
 
 	/* re-start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
-	tmp |= PORT_CMD_START | PORT_CMD_FIS_RX;
+	tmp |= PORT_CMD_START;
 	writel(tmp, port_mmio + PORT_CMD);
 	readl(port_mmio + PORT_CMD); /* flush */
 

