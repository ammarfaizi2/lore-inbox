Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266137AbUHDO0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266137AbUHDO0B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 10:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266136AbUHDOZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 10:25:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:49392 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266069AbUHDOZk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 10:25:40 -0400
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<christian@borntraeger.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: [PATCH] Add bus dependencies to two scsi drivers
Date: Wed, 4 Aug 2004 16:25:37 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408041625.37223.christian@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two scsi drivers do not compile on systems without ISA/PCI. Therefore 
allyesconfig breaks on hardware like s390. 

Signed-off-by: Christian Bornträger <linux-kernel@borntraeger.net>

diff -u -r1.36 Kconfig
--- a/drivers/scsi/Kconfig	23 Jun 2004 14:39:43 -0000	1.36
+++ b/drivers/scsi/Kconfig	4 Aug 2004 14:10:34 -0000
@@ -309,7 +309,7 @@
 
 config SCSI_AIC7XXX_OLD
 	tristate "Adaptec AIC7xxx support (old driver)"
-	depends on SCSI
+	depends on (ISA || EISA || PCI ) && SCSI
 	help
 	  WARNING This driver is an older aic7xxx driver and is no longer
 	  under active development.  Adaptec, Inc. is writing a new driver to
@@ -578,7 +578,7 @@
 
 config SCSI_EATA_PIO
 	tristate "EATA-PIO (old DPT PM2001, PM2012A) support"
-	depends on SCSI
+	depends on (ISA || EISA || PCI) && SCSI
 	---help---
 	  This driver supports all EATA-PIO protocol compliant SCSI Host
 	  Adapters like the DPT PM2001 and the PM2012A.  EATA-DMA compliant



