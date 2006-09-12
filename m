Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWILJD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWILJD0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 05:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWILJD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 05:03:26 -0400
Received: from 85-210-233-64.dsl.pipex.com ([85.210.233.64]:23254 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S964975AbWILJDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 05:03:25 -0400
Date: Tue, 12 Sep 2006 10:02:24 +0100
To: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] BODGE scsi misc module reference count checks with no MODULE_UNLOAD
Message-ID: <20060912090223.GA31576@shadowen.org>
References: <45067632.4020906@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <45067632.4020906@shadowen.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BODGE scsi misc module reference count checks with no MODULE_UNLOAD

A quick bodge to try and get this to compile for testing.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 20d2cdf..2acc0cb 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -884,7 +884,11 @@ void scsi_device_put(struct scsi_device 
 
 	/* The module refcount will be zero if scsi_device_get()
 	 * was called from a module removal routine */
-	if (module && module_refcount(module) != 0)
+	if (module
+#ifdef CONFIG_MODULE_UNLOAD
+			&& module_refcount(module) != 0
+#endif
+			)
 		module_put(module);
 	put_device(&sdev->sdev_gendev);
 }
