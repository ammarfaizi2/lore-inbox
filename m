Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVEBCLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVEBCLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 22:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVEBByv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 21:54:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:39440 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261668AbVEBBrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 21:47:12 -0400
Date: Mon, 2 May 2005 03:47:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: lw_linux@hotmail.com, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/sym53c416.c: fix a wrong check
Message-ID: <20050502014710.GA3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found that this for loop was wrong.

This patch changes it to what seems to be intended.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Apr 2005

--- linux-2.6.12-rc2-mm2-full/drivers/scsi/sym53c416.c.old	2005-04-09 22:16:04.000000000 +0200
+++ linux-2.6.12-rc2-mm2-full/drivers/scsi/sym53c416.c	2005-04-09 22:16:28.000000000 +0200
@@ -803,19 +803,19 @@
 static int sym53c416_host_reset(Scsi_Cmnd *SCpnt)
 {
 	int base;
 	int scsi_id = -1;	
 	int i;
 
 	/* printk("sym53c416_reset\n"); */
 	base = SCpnt->device->host->io_port;
 	/* search scsi_id - fixme, we shouldnt need to iterate for this! */
-	for(i = 0; i < host_index && scsi_id != -1; i++)
+	for(i = 0; i < host_index && scsi_id == -1; i++)
 		if(hosts[i].base == base)
 			scsi_id = hosts[i].scsi_id;
 	outb(RESET_CHIP, base + COMMAND_REG);
 	outb(NOOP | PIO_MODE, base + COMMAND_REG);
 	outb(RESET_SCSI_BUS, base + COMMAND_REG);
 	sym53c416_init(base, scsi_id);
 	return SUCCESS;
 }
 

