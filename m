Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVCQW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVCQW1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVCQWY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 17:24:57 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:63612 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261259AbVCQWVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 17:21:34 -0500
From: Brett Russ <russb@emc.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgarzik@pobox.com
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050317221753.53957EDF@lns1032.lss.emc.com>
In-Reply-To: <20050317221753.53957EDF@lns1032.lss.emc.com>
Subject: Re: [PATCH libata-dev-2.6 01/05] libata: AHCI tf_read() support
Message-ID: <20050317221753.F8B31934@lns1032.lss.emc.com>
Date: Thu, 17 Mar 2005 17:20:06 -0500 (EST)
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

01_libata_garzik-ahci-tf-read.patch

	(included in libata-2.6) This is Jeff's tf_read() support
	patch for AHCI.

Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

 ahci.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: libata-dev-2.6/drivers/scsi/ahci.c
===================================================================
--- libata-dev-2.6.orig/drivers/scsi/ahci.c	2005-03-17 12:36:29.000000000 -0500
+++ libata-dev-2.6/drivers/scsi/ahci.c	2005-03-17 17:16:57.000000000 -0500
@@ -179,6 +179,7 @@ static void ahci_eng_timeout(struct ata_
 static int ahci_port_start(struct ata_port *ap);
 static void ahci_port_stop(struct ata_port *ap);
 static void ahci_host_stop(struct ata_host_set *host_set);
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf);
 static void ahci_qc_prep(struct ata_queued_cmd *qc);
 static u8 ahci_check_status(struct ata_port *ap);
 static u8 ahci_check_err(struct ata_port *ap);
@@ -213,6 +214,8 @@ static struct ata_port_operations ahci_o
 	.check_err		= ahci_check_err,
 	.dev_select		= ata_noop_dev_select,
 
+	.tf_read		= ahci_tf_read,
+
 	.phy_reset		= ahci_phy_reset,
 
 	.qc_prep		= ahci_qc_prep,
@@ -466,6 +469,14 @@ static u8 ahci_check_err(struct ata_port
 	return (readl(mmio + PORT_TFDATA) >> 8) & 0xFF;
 }
 
+static void ahci_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ahci_port_priv *pp = ap->private_data;
+	u8 *d2h_fis = pp->rx_fis + RX_FIS_D2H_REG;
+
+	ata_tf_from_fis(d2h_fis, tf);
+}
+
 static void ahci_fill_sg(struct ata_queued_cmd *qc)
 {
 	struct ahci_port_priv *pp = qc->ap->private_data;

