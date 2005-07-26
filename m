Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVGZRDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVGZRDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261886AbVGZPrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:47:33 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:53486 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261784AbVGZPq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:46:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:references:in-reply-to:subject:message-id:date;
        b=utm5xtJSWjeAzZRt6hxeB7PPxiiAOxspeDP+lF/IxaI1dr1abQVUCz0MxsJza68gaMPr6vWgZcIKQln0WVgOLZBrx8oz/41O1rjWOQXmDxz+A85/+1JnY8a+qaXMiIzJt5xtwTygXJNGasdazR9AXz6YF+9K8KVSQ2mCc7qgAtI=
From: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       bzolnier@gmail.com
Cc: linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
References: <20050726154457.38D60C67@htj.dyndns.org>
In-Reply-To: <20050726154457.38D60C67@htj.dyndns.org>
Subject: Re: [PATCH linux-2.6-block:master 06/10] blk: update libata to use new blk_ordered
Message-ID: <20050726154457.0A5F3806@htj.dyndns.org>
Date: Wed, 27 Jul 2005 00:46:21 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

06_blk_libata-update-ordered.patch

	Reflect changes in SCSI midlayer and updated to use new
        ordered request implementation

Signed-off-by: Tejun Heo <htejun@gmail.com>

 ahci.c         |    1 -
 ata_piix.c     |    1 -
 sata_nv.c      |    1 -
 sata_promise.c |    1 -
 sata_sil.c     |    1 -
 sata_sis.c     |    1 -
 sata_svw.c     |    1 -
 sata_sx4.c     |    1 -
 sata_uli.c     |    1 -
 sata_via.c     |    1 -
 sata_vsc.c     |    1 -
 11 files changed, 11 deletions(-)

Index: blk-fixes/drivers/scsi/ahci.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ahci.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/ahci.c	2005-07-27 00:44:51.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template ahci_sht = {
 	.dma_boundary		= AHCI_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations ahci_ops = {
Index: blk-fixes/drivers/scsi/ata_piix.c
===================================================================
--- blk-fixes.orig/drivers/scsi/ata_piix.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/ata_piix.c	2005-07-27 00:44:51.000000000 +0900
@@ -123,7 +123,6 @@ static Scsi_Host_Template piix_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations piix_pata_ops = {
Index: blk-fixes/drivers/scsi/sata_nv.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_nv.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_nv.c	2005-07-27 00:44:51.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template nv_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations nv_ops = {
Index: blk-fixes/drivers/scsi/sata_promise.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_promise.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_promise.c	2005-07-27 00:44:51.000000000 +0900
@@ -103,7 +103,6 @@ static Scsi_Host_Template pdc_ata_sht = 
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_ata_ops = {
Index: blk-fixes/drivers/scsi/sata_sil.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sil.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sil.c	2005-07-27 00:44:51.000000000 +0900
@@ -135,7 +135,6 @@ static Scsi_Host_Template sil_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sil_ops = {
Index: blk-fixes/drivers/scsi/sata_sis.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sis.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sis.c	2005-07-27 00:44:51.000000000 +0900
@@ -90,7 +90,6 @@ static Scsi_Host_Template sis_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations sis_ops = {
Index: blk-fixes/drivers/scsi/sata_svw.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_svw.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_svw.c	2005-07-27 00:44:51.000000000 +0900
@@ -288,7 +288,6 @@ static Scsi_Host_Template k2_sata_sht = 
 	.proc_info		= k2_sata_proc_info,
 #endif
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 
Index: blk-fixes/drivers/scsi/sata_sx4.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_sx4.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_sx4.c	2005-07-27 00:44:51.000000000 +0900
@@ -188,7 +188,6 @@ static Scsi_Host_Template pdc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations pdc_20621_ops = {
Index: blk-fixes/drivers/scsi/sata_uli.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_uli.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_uli.c	2005-07-27 00:44:51.000000000 +0900
@@ -82,7 +82,6 @@ static Scsi_Host_Template uli_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations uli_ops = {
Index: blk-fixes/drivers/scsi/sata_via.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_via.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_via.c	2005-07-27 00:44:51.000000000 +0900
@@ -102,7 +102,6 @@ static Scsi_Host_Template svia_sht = {
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 static struct ata_port_operations svia_sata_ops = {
Index: blk-fixes/drivers/scsi/sata_vsc.c
===================================================================
--- blk-fixes.orig/drivers/scsi/sata_vsc.c	2005-07-27 00:44:48.000000000 +0900
+++ blk-fixes/drivers/scsi/sata_vsc.c	2005-07-27 00:44:51.000000000 +0900
@@ -206,7 +206,6 @@ static Scsi_Host_Template vsc_sata_sht =
 	.dma_boundary		= ATA_DMA_BOUNDARY,
 	.slave_configure	= ata_scsi_slave_config,
 	.bios_param		= ata_std_bios_param,
-	.ordered_flush		= 1,
 };
 
 

