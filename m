Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbVHDGMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbVHDGMP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 02:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVHDGJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 02:09:53 -0400
Received: from hendrix.ece.utexas.edu ([128.83.59.42]:43405 "EHLO
	hendrix.ece.utexas.edu") by vger.kernel.org with ESMTP
	id S261852AbVHDGH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 02:07:58 -0400
Date: Thu, 4 Aug 2005 01:07:50 -0500 (CDT)
From: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Reply-To: youssef@ece.utexas.edu
To: linux-kernel@vger.kernel.org
cc: linux-scsi@vger.kernel.org, youssef@ece.utexas.edu
Subject: [PATCH] [SCSI] megaraid: add check for NULL pointer
Message-ID: <Pine.LNX.4.61.0508040023020.14176@linux08.ece.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a check for NULL return from kmalloc.

Signed-off-by: Youssef Hmamouche <hyoussef@gmail.com>


--- a/drivers/scsi/megaraid.c   2005-08-03 21:12:43.000000000 -0700
+++ b/drivers/scsi/megaraid.c   2005-08-03 21:14:37.000000000 -0700
@@ -4456,6 +4456,10 @@
         memset(scmd, 0, sizeof(Scsi_Cmnd));

         sdev = kmalloc(sizeof(struct scsi_device), GFP_KERNEL);
+       if(sdev == NULL) {
+               printk(KERN_WARNING "megaraid: out of RAM.\n");
+               return -ENOMEM;
+       }
         memset(sdev, 0, sizeof(struct scsi_device));
         scmd->device = sdev;

