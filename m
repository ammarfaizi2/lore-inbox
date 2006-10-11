Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWJKMvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWJKMvH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 08:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWJKMvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 08:51:07 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:58604 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751247AbWJKMuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 08:50:44 -0400
Subject: [PATCH 2/3] drivers/scsi/megaraid.c: Replacing yield() with a
	better alternative
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@steeleye.com,
       kernel Janitors <kernel-janitors@lists.osdl.org>
Content-Type: text/plain
Date: Wed, 11 Oct 2006 18:24:03 +0530
Message-Id: <1160571243.19143.322.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For this driver cond_resched() seems to be a better
alternative

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/drivers/scsi/megaraid.c linux-2.6.19-rc1/drivers/scsi/megaraid.c
--- linux-2.6.19-rc1-orig/drivers/scsi/megaraid.c	2006-10-05 14:00:51.000000000 +0530
+++ linux-2.6.19-rc1/drivers/scsi/megaraid.c	2006-10-11 17:57:02.000000000 +0530
@@ -1755,7 +1755,8 @@ __mega_busywait_mbox (adapter_t *adapter
 	for (counter = 0; counter < 10000; counter++) {
 		if (!mbox->m_in.busy)
 			return 0;
-		udelay(100); yield();
+		udelay(100); 
+		cond_resched();
 	}
 	return -1;		/* give up after 1 second */
 }


