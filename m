Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbUBEAeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 19:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbUBEAYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 19:24:38 -0500
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:48905 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S265155AbUBEAVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 19:21:19 -0500
Date: Wed, 4 Feb 2004 18:25:42 -0600 (CST)
From: mikem@beardog.cca.cpqcorp.net
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates for 2.6 [11 of 11]
Message-ID: <Pine.LNX.4.58.0402041819510.18320@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 11 of 11 (finally).
This patch fixes an Oops when unloading the driver. Bug fix.
Please consider this for inclusion.

All of the patches sent out are needed to get the driver in the 2.6 tree
up to the level of the driver that is in the 2.4 tree, excluding this
patch which is not required in 2.4.
More patches will be coming. They include multi-path failover support,
support for more than 8 controllers, and msi support. Presently working on
a per logical volume queueing scheme.
Please forgive me for flooding your inboxes.
--------------------------------------------------------------------------------------
diff -burN lx262-p010/drivers/block/cciss.c lx262/drivers/block/cciss.c
--- lx262-p010/drivers/block/cciss.c	2004-02-04 12:44:52.000000000 -0600
+++ lx262/drivers/block/cciss.c	2004-02-04 12:46:44.000000000 -0600
@@ -2668,7 +2668,6 @@
 	pci_set_drvdata(pdev, NULL);
 	iounmap((void*)hba[i]->vaddr);
 	cciss_unregister_scsi(i);  /* unhook from SCSI subsystem */
-	blk_cleanup_queue(hba[i]->queue);
 	unregister_blkdev(COMPAQ_CISS_MAJOR+i, hba[i]->devname);
 	remove_proc_entry(hba[i]->devname, proc_cciss);

@@ -2679,6 +2678,7 @@
 			del_gendisk(disk);
 	}

+	blk_cleanup_queue(hba[i]->queue);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
 			    hba[i]->cmd_pool, hba[i]->cmd_pool_dhandle);
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof( ErrorInfo_struct),

Thanks,
mikem
mike.miller@hp.com

