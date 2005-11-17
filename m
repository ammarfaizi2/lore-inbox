Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbVKQPhB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbVKQPhB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 10:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVKQPgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 10:36:55 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:30071 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751135AbVKQPgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 10:36:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=smVgOkp99kFmtY2klKSyQGT22dX7rlqN9LR7OGElqCfEFmy4dTq3RVF2NQo9Ett0IJQNpVBG1CT7YSfSVTF3O/XuWiIyX3+UIa9IgFiUaUnYt+fQmCrcMnS4mv+QJTkiBs82RPhsCQ/HmFidLjOszkxigMAdonpdAAAy/BYESjs=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051117153509.B89B4777@htj.dyndns.org>
In-Reply-To: <20051117153509.B89B4777@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 06/10] blk: update libata to use new blk_ordered
Message-ID: <20051117153509.7996C28F@htj.dyndns.org>
Date: Fri, 18 Nov 2005 00:36:41 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_blk_libata-update-ordered.patch

	Reflect changes in SCSI midlayer and updated to use new
        ordered request implementation

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c         |    1 -
 ata_piix.c     |    1 -
 sata_mv.c      |    1 -
 sata_nv.c      |    1 -
 sata_promise.c |    1 -
 sata_sil.c     |    1 -
 sata_sil24.c   |    1 -
 sata_sis.c     |    1 -
 sata_svw.c     |    1 -
 sata_sx4.c     |    1 -
 sata_uli.c     |    1 -
 sata_via.c     |    1 -
 sata_vsc.c     |    1 -
 13 files changed, 13 deletions(-)

Index: work/drivers/scsi/ahci.c
===================================================================
--- work.orig/drivers/scsi/ahci.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/ahci.c	2005-11-18 00:35:06.000000000 +0900
@@ -213,7 +213,6 @@ static struct scsi_host_template ahci_sh
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations ahci_ops = {
Index: work/drivers/scsi/ata_piix.c
===================================================================
--- work.orig/drivers/scsi/ata_piix.c	2005-11-18 00:14:21.000000000 +0900
+++ work/drivers/scsi/ata_piix.c	2005-11-18 00:35:06.000000000 +0900
@@ -144,7 +144,6 @@ static struct scsi_host_template piix_sh
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations piix_pata_ops = {
Index: work/drivers/scsi/sata_mv.c
===================================================================
--- work.orig/drivers/scsi/sata_mv.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_mv.c	2005-11-18 00:35:06.000000000 +0900
@@ -287,7 +287,6 @@ static struct scsi_host_template mv_sht 
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations mv_ops = {
Index: work/drivers/scsi/sata_nv.c
===================================================================
--- work.orig/drivers/scsi/sata_nv.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_nv.c	2005-11-18 00:35:06.000000000 +0900
@@ -235,7 +235,6 @@ static struct scsi_host_template nv_sht 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations nv_ops = {
Index: work/drivers/scsi/sata_promise.c
===================================================================
--- work.orig/drivers/scsi/sata_promise.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_promise.c	2005-11-18 00:35:06.000000000 +0900
@@ -111,7 +111,6 @@ static struct scsi_host_template pdc_ata
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations pdc_sata_ops = {
Index: work/drivers/scsi/sata_sil.c
===================================================================
--- work.orig/drivers/scsi/sata_sil.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_sil.c	2005-11-18 00:35:06.000000000 +0900
@@ -147,7 +147,6 @@ static struct scsi_host_template sil_sht
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations sil_ops = {
Index: work/drivers/scsi/sata_sis.c
===================================================================
--- work.orig/drivers/scsi/sata_sis.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_sis.c	2005-11-18 00:35:06.000000000 +0900
@@ -99,7 +99,6 @@ static struct scsi_host_template sis_sht
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations sis_ops = {
Index: work/drivers/scsi/sata_svw.c
===================================================================
--- work.orig/drivers/scsi/sata_svw.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_svw.c	2005-11-18 00:35:06.000000000 +0900
@@ -303,7 +303,6 @@ static struct scsi_host_template k2_sata
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: work/drivers/scsi/sata_sx4.c
===================================================================
--- work.orig/drivers/scsi/sata_sx4.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_sx4.c	2005-11-18 00:35:06.000000000 +0900
@@ -194,7 +194,6 @@ static struct scsi_host_template pdc_sat
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations pdc_20621_ops = {
Index: work/drivers/scsi/sata_uli.c
===================================================================
--- work.orig/drivers/scsi/sata_uli.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_uli.c	2005-11-18 00:35:06.000000000 +0900
@@ -87,7 +87,6 @@ static struct scsi_host_template uli_sht
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations uli_ops = {
Index: work/drivers/scsi/sata_via.c
===================================================================
--- work.orig/drivers/scsi/sata_via.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_via.c	2005-11-18 00:35:06.000000000 +0900
@@ -106,7 +106,6 @@ static struct scsi_host_template svia_sh
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static const struct ata_port_operations svia_sata_ops = {
Index: work/drivers/scsi/sata_vsc.c
===================================================================
--- work.orig/drivers/scsi/sata_vsc.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_vsc.c	2005-11-18 00:35:06.000000000 +0900
@@ -235,7 +235,6 @@ static struct scsi_host_template vsc_sat
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: work/drivers/scsi/sata_sil24.c
===================================================================
--- work.orig/drivers/scsi/sata_sil24.c	2005-11-18 00:14:22.000000000 +0900
+++ work/drivers/scsi/sata_sil24.c	2005-11-18 00:35:06.000000000 +0900
@@ -272,7 +272,6 @@ static struct scsi_host_template sil24_s
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1, /* NCQ not supported yet */
 };
 
 static const struct ata_port_operations sil24_ops = {

