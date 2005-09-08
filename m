Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVIHTb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVIHTb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbVIHTb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:31:58 -0400
Received: from mail0.lsil.com ([147.145.40.20]:53144 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964952AbVIHTb5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:31:57 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E5703662B21@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1][BUG] undefined symbol in legacy megaraid driver on 2.
	6.12-mm1
Date: Thu, 8 Sep 2005 15:31:51 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2658.27)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've created a patch to address "legacy megaraid driver compilation error on
2.6.12-mm1 kernel.
Please take this patch and let me know for any further concern.

Thank you,

Seokmann

Sign-off by: Seokmann JU <seokmann.ju@lsil.com>
---
diff -Naur old/drivers/scsi/megaraid.c new/drivers/scsi/megaraid.c
--- old/drivers/scsi/megaraid.c	2005-09-08 16:24:12.017451400 -0400
+++ new/drivers/scsi/megaraid.c	2005-09-08 16:23:36.509849376 -0400
@@ -1975,9 +1975,11 @@
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
-	adapter = (adapter_t *)cmd->device->host->hostdata;
+	adapter_t *adapter;
 	int rc;
 
+	adapter = (adapter_t *)cmd->device->host->hostdata;
+
 	spin_lock_irq(&adapter->lock);
 	rc = __megaraid_reset(cmd);
 	spin_unlock_irq(&adapter->lock);
---
