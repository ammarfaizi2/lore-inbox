Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752075AbWCJWYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075AbWCJWYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 17:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbWCJWYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 17:24:22 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9476 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1752075AbWCJWYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 17:24:22 -0500
Date: Fri, 10 Mar 2006 23:24:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] scsi/dmx3191d.c: fix a NULL pointer dereference
Message-ID: <20060310222421.GW21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL pointer dereference spotted by the Coverity 
checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc5-mm3-full/drivers/scsi/dmx3191d.c.old	2006-03-10 20:37:24.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/drivers/scsi/dmx3191d.c	2006-03-10 20:37:40.000000000 +0100
@@ -116,7 +116,7 @@ static int __devinit dmx3191d_probe_one(
  out_free_irq:
 	free_irq(shost->irq, shost);
  out_release_region:
-	release_region(shost->io_port, DMX3191D_REGION_LEN);
+	release_region(io, DMX3191D_REGION_LEN);
  out_disable_device:
 	pci_disable_device(pdev);
  out:

