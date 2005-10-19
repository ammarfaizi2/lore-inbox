Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbVJSMs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVJSMs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbVJSMsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:48:38 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:58691 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750924AbVJSMsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:48:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=fsb7/KuwSgrefsGC/vocX1PuH4s2pNcnDUGV2laLss8d+VLmpqE+53algklgYXfO3WdF9ht1SvdZfmQdm6lJoT3Xce47zBg+B10kNOORyE4M0NOl2cATDCAQza9wNiTBzX58i9QkZrH23key5XB0YPFUIsZgos2V3wj65SKCdIY=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20051019124716.EF1F6546@htj.dyndns.org>
In-Reply-To: <20051019124716.EF1F6546@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 06/10] blk: update libata to use new blk_ordered
Message-ID: <20051019124716.A890C9E5@htj.dyndns.org>
Date: Wed, 19 Oct 2005 21:48:11 +0900 (KST)
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
 sata_sis.c     |    1 -
 sata_svw.c     |    1 -
 sata_sx4.c     |    1 -
 sata_uli.c     |    1 -
 sata_via.c     |    1 -
 sata_vsc.c     |    1 -
 12 files changed, 12 deletions(-)

Index: blk-fixes/drivers/scsi/ahci.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ahci.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/ahci.c	2005-10-19 21:47:14.000000000 +0900
@@ -213,7 +213,6 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations ahci_ops = {
Index: blk-fixes/drivers/scsi/ata_piix.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ata_piix.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/ata_piix.c	2005-10-19 21:47:14.000000000 +0900
@@ -144,7 +144,6 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations piix_pata_ops = {
Index: blk-fixes/drivers/scsi/sata_nv.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_nv.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_nv.c	2005-10-19 21:47:14.000000000 +0900
@@ -235,7 +235,6 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations nv_ops = {
Index: blk-fixes/drivers/scsi/sata_promise.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_promise.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_promise.c	2005-10-19 21:47:14.000000000 +0900
@@ -110,7 +110,6 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_sata_ops = {
Index: blk-fixes/drivers/scsi/sata_sil.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sil.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sil.c	2005-10-19 21:47:14.000000000 +0900
@@ -147,7 +147,6 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sil_ops = {
Index: blk-fixes/drivers/scsi/sata_sis.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sis.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sis.c	2005-10-19 21:47:14.000000000 +0900
@@ -99,7 +99,6 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sis_ops = {
Index: blk-fixes/drivers/scsi/sata_svw.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_svw.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_svw.c	2005-10-19 21:47:14.000000000 +0900
@@ -293,7 +293,6 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/sata_sx4.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sx4.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sx4.c	2005-10-19 21:47:14.000000000 +0900
@@ -193,7 +193,6 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
Index: blk-fixes/drivers/scsi/sata_uli.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_uli.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_uli.c	2005-10-19 21:47:14.000000000 +0900
@@ -87,7 +87,6 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations uli_ops = {
Index: blk-fixes/drivers/scsi/sata_via.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_via.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_via.c	2005-10-19 21:47:14.000000000 +0900
@@ -106,7 +106,6 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations svia_sata_ops = {
Index: blk-fixes/drivers/scsi/sata_vsc.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_vsc.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_vsc.c	2005-10-19 21:47:14.000000000 +0900
@@ -227,7 +227,6 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/sata_mv.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_mv.c	2005-10-19 21:46:49.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_mv.c	2005-10-19 21:47:14.000000000 +0900
@@ -207,7 +207,6 @@ static Scsi_Host_Template mv_sht = {
 	.dma_boundary		= MV_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations mv_ops = {

