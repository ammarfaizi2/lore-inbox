Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbWEJC5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbWEJC5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWEJC5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:12 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:11070 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932449AbWEJC44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:56 -0400
Date: Tue, 9 May 2006 19:56:04 -0700
Message-Id: <200605100256.k4A2u46E031743@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: yokota@netlab.is.tsukuba.ac.jp, gotom@debian.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH -mm] nsp32 gcc 4.1 warning fix 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following warning,

drivers/scsi/nsp32.c: In function ‘nsp32_detect’:
drivers/scsi/nsp32.c:2889: warning: ignoring return value of ‘scsi_add_host’, declared with attribute warn_unused_result

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/nsp32.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/nsp32.c
+++ linux-2.6.16/drivers/scsi/nsp32.c
@@ -2886,7 +2886,8 @@ static int nsp32_detect(struct scsi_host
         }
 
 #if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,73))
-	scsi_add_host (host, &PCIDEV->dev);
+	if (scsi_add_host (host, &PCIDEV->dev))
+		return DETECT_NG;
 	scsi_scan_host(host);
 #endif
 	pci_set_drvdata(PCIDEV, host);
