Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263960AbUCPQ2H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263359AbUCPQ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:28:06 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:58884 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S263982AbUCPQ1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:27:10 -0500
Date: Tue, 16 Mar 2004 10:38:24 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray patches for 2.6 [2 of 5]
Message-ID: <20040316163824.GB21377@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second of 5 patches for cpqarray. The patch fixes an Oops when unloading the driver. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
   * Fix for segmentation fault when calling rmmod


 drivers/block/cpqarray.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.1/drivers/block/cpqarray.c~cpqarray_0	2004-02-11 15:45:44.381344184 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.c	2004-02-11 15:47:34.110662792 -0600
@@ -300,7 +300,6 @@ static void __exit cpqarray_exit(void)
 		iounmap(hba[i]->vaddr);
 		unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
 		del_timer(&hba[i]->timer);
-		blk_cleanup_queue(hba[i]->queue);
 		remove_proc_entry(hba[i]->devname, proc_array);
 		pci_free_consistent(hba[i]->pci_dev, 
 			NR_CMDS * sizeof(cmdlist_t), (hba[i]->cmd_pool), 
@@ -313,6 +312,7 @@ static void __exit cpqarray_exit(void)
 			devfs_remove("ida/c%dd%d",i,j);
 			put_disk(ida_gendisk[i][j]);
 		}
+		blk_cleanup_queue(hba[i]->queue);
 	}
 	devfs_remove("ida");
 	remove_proc_entry("cpqarray", proc_root_driver);

_
