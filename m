Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWIVGEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWIVGEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 02:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWIVGEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 02:04:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:57199 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751700AbWIVGEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 02:04:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sCV0HraP97ygN1IQ7cVjTwmatVjCBp+nO17YUCpaOShmuOG4MwMDajr2JDAajZw6N+KCc8Q4UoCFEeTGPb5d+Q5saO66t0+zu36vq3NJGNCHpPwu2vjprHVlbkfh5nB4Lgo1huZ6AuVcG1zFgFP0+rzUI3HZ5YntofJxb0wuUmU=
Message-ID: <6b4e42d10609212304o52bbc9b4y434bbd7ef71281e3@mail.gmail.com>
Date: Thu, 21 Sep 2006 23:04:53 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [KJ] kmalloc to kzalloc patches for drivers/block [sane version]
In-Reply-To: <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10609202311t47038692x5627f51d69f28209@mail.gmail.com>
	 <20060921072017.GA27798@us.ibm.com>
	 <6b4e42d10609212240i3d02241djbdaa0176ab9bfb2b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Comments incorporated
Changes kmalloc() calls succeeded by memset(,0,) to kzalloc()

Signed off by : Om Narasimhan <om.turyx@gmail.com>
 drivers/block/cciss.c    |    4 +---
 drivers/block/cpqarray.c |    7 ++-----
 drivers/block/loop.c     |    3 +--
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 2cd3391..a800a69 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -900,7 +900,7 @@ #if 0				/* 'buf_size' member is 16-bits
 				return -EINVAL;
 #endif
 			if (iocommand.buf_size > 0) {
-				buff = kmalloc(iocommand.buf_size, GFP_KERNEL);
+				buff = kzalloc(iocommand.buf_size, GFP_KERNEL);
 				if (buff == NULL)
 					return -EFAULT;
 			}
@@ -911,8 +911,6 @@ #endif
 					kfree(buff);
 					return -EFAULT;
 				}
-			} else {
-				memset(buff, 0, iocommand.buf_size);
 			}
 			if ((c = cmd_alloc(host, 0)) == NULL) {
 				kfree(buff);
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 78082ed..34f8e96 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -424,7 +424,7 @@ static int __init cpqarray_register_ctlr
 	hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
 		hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
 		&(hba[i]->cmd_pool_dhandle));
-	hba[i]->cmd_pool_bits = kmalloc(
+	hba[i]->cmd_pool_bits = kzalloc(
 		((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
 		GFP_KERNEL);

@@ -432,7 +432,6 @@ static int __init cpqarray_register_ctlr
 			goto Enomem1;

 	memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-	memset(hba[i]->cmd_pool_bits, 0,
((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
 	printk(KERN_INFO "cpqarray: Finding drives on %s",
 		hba[i]->devname);

@@ -523,7 +522,6 @@ static int __init cpqarray_init_one( str
 	i = alloc_cpqarray_hba();
 	if( i < 0 )
 		return (-1);
-	memset(hba[i], 0, sizeof(ctlr_info_t));
 	sprintf(hba[i]->devname, "ida%d", i);
 	hba[i]->ctlr = i;
 	/* Initialize the pdev driver private data */
@@ -580,7 +578,7 @@ static int alloc_cpqarray_hba(void)

 	for(i=0; i< MAX_CTLR; i++) {
 		if (hba[i] == NULL) {
-			hba[i] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			hba[i] = kzalloc(sizeof(ctlr_info_t), GFP_KERNEL);
 			if(hba[i]==NULL) {
 				printk(KERN_ERR "cpqarray: out of memory.\n");
 				return (-1);
@@ -765,7 +763,6 @@ static int __init cpqarray_eisa_detect(v
 			continue;
 		}

-		memset(hba[ctlr], 0, sizeof(ctlr_info_t));
 		hba[ctlr]->io_mem_addr = eisa[i];
 		hba[ctlr]->io_mem_length = 0x7FF;
 		if(!request_region(hba[ctlr]->io_mem_addr,
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7b3b94d..91b48ef 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1260,10 +1260,9 @@ static int __init loop_init(void)
 	if (register_blkdev(LOOP_MAJOR, "loop"))
 		return -EIO;

-	loop_dev = kmalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
+	loop_dev = kzalloc(max_loop * sizeof(struct loop_device), GFP_KERNEL);
 	if (!loop_dev)
 		goto out_mem1;
-	memset(loop_dev, 0, max_loop * sizeof(struct loop_device));

 	disks = kmalloc(max_loop * sizeof(struct gendisk *), GFP_KERNEL);
 	if (!disks)
