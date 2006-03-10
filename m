Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752207AbWCJWYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752207AbWCJWYt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbWCJWYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:24:49 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:10500 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752196AbWCJWYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:24:48 -0500
Date: Fri, 10 Mar 2006 23:24:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: langa2@kph.uni-mainz.de
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/ibmmca.c: fix a NULL pointer dereference
Message-ID: <20060310222447.GX21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The variable was dereferenced only if it was NULL (sic)...

Spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/scsi/ibmmca.c.old	2006-03-10 20:39:03.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/scsi/ibmmca.c	2006-03-10 20:41:47.000000000 +0100
@@ -2357,8 +2357,7 @@ static int ibmmca_proc_info(struct Scsi_
 	spin_lock_irqsave(hosts[i]->host_lock, flags);	/* Check it */
 	host_index = i;
 	if (!shpnt) {
-		len += sprintf(buffer + len, "\nIBM MCA SCSI: Can't find adapter for host number %d\n",
-				shpnt->host_no);
+		len += sprintf(buffer + len, "\nIBM MCA SCSI: Can't find adapter");
 		return len;
 	}
 	max_pun = subsystem_maxid(host_index);

