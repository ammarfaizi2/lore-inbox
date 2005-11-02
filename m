Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932609AbVKBHNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932609AbVKBHNZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbVKBHNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:13:25 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:8119 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932609AbVKBHNY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:13:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EFx9eVoSkQDtxLoO2uycvc3q3em1oZRNGgnY4qdMh9Q2owgvqFZrBrsVemyur6m9tsapqowz6n49AcpBQWnd51Br4g6afL0uMFgVE+DeJH97WzTlgj8Z3IEj2NyHOuRUlwFNutUzzq3TyBas7vxz0HgRcZ7l9XWK1tn6hFFi9Mk=
Message-ID: <81083a450511012313v25e292duf7b64da0ebf07835@mail.gmail.com>
Date: Wed, 2 Nov 2005 12:43:22 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       support@qlogic.com, akpm@osdl.org, stable@kernel.org
Subject: [PATCH] scsi - Fix Broken Qlogic ISP2x00 Device Driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the fact that although the scsi_transport_fc.h header
file is not included in qla_def.h, we still reference the function
fc_remote_port_unlock in the qlogic  ISP2x00 device driver ,
qla2xxx/qla_rscn.c

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

--
diff -Naurp linux-2.6.14-git1/drivers/scsi/qla2xxx/qla_def.h
linux-2.6.14/drivers/scsi/qla2xxx/qla_def.h
--- linux-2.6.14-git1/drivers/scsi/qla2xxx/qla_def.h	2005-10-28
05:32:08.000000000 +0530
+++ linux-2.6.14/drivers/scsi/qla2xxx/qla_def.h	2005-11-01
11:54:25.000000000 +0530
@@ -40,6 +40,7 @@
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_transport_fc.h>

 #if defined(CONFIG_SCSI_QLA21XX) || defined(CONFIG_SCSI_QLA21XX_MODULE)
 #define IS_QLA2100(ha)	((ha)->pdev->device == PCI_DEVICE_ID_QLOGIC_ISP2100)
