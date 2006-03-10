Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752198AbWCJWY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbWCJWY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWCJWY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:24:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11524 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752197AbWCJWY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:24:56 -0500
Date: Fri, 10 Mar 2006 23:24:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Neela.Kolli@engenio.com
Cc: linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/megaraid/megaraid_mm.c: fix a NULL pointer dereference
Message-ID: <20060310222455.GY21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL pointer dereference spotted by the Coverity 
checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/scsi/megaraid/megaraid_mm.c.old	2006-03-10 20:45:36.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/scsi/megaraid/megaraid_mm.c	2006-03-10 20:46:04.000000000 +0100
@@ -898,10 +898,8 @@ mraid_mm_register_adp(mraid_mmadp_t *lld
 
 	adapter = kmalloc(sizeof(mraid_mmadp_t), GFP_KERNEL);
 
-	if (!adapter) {
-		rval = -ENOMEM;
-		goto memalloc_error;
-	}
+	if (!adapter)
+		return -ENOMEM;
 
 	memset(adapter, 0, sizeof(mraid_mmadp_t));
 

