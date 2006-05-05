Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWEEQov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWEEQov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 12:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWEEQov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 12:44:51 -0400
Received: from CPE-70-92-180-7.mn.res.rr.com ([70.92.180.7]:32900 "EHLO
	cinder.waste.org") by vger.kernel.org with ESMTP id S1751641AbWEEQou
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 12:44:50 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
In-Reply-To: <2.420169009@selenic.com>
Message-Id: <5.420169009@selenic.com>
Subject: [PATCH 4/14] random: Change cpqarray to use add_disk_randomness
Date: Fri, 05 May 2006 11:42:34 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change cpqarray to use add_disk_randomness

Disk devices should use add_disk_randomness rather than SA_SAMPLE_RANDOM

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/block/cpqarray.c
===================================================================
--- 2.6.orig/drivers/block/cpqarray.c	2006-05-02 17:29:26.000000000 -0500
+++ 2.6/drivers/block/cpqarray.c	2006-05-03 11:25:55.000000000 -0500
@@ -408,8 +408,7 @@ static int cpqarray_register_ctlr( int i
 	}
 	hba[i]->access.set_intr_mask(hba[i], 0);
 	if (request_irq(hba[i]->intr, do_ida_intr,
-		SA_INTERRUPT|SA_SHIRQ|SA_SAMPLE_RANDOM,
-		hba[i]->devname, hba[i]))
+		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
 	{
 		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n",
 				hba[i]->intr, hba[i]->devname);
@@ -1034,6 +1033,8 @@ static inline void complete_command(cmdl
 
 	complete_buffers(cmd->rq->bio, ok);
 
+	add_disk_randomness(cmd->rq->rq_disk);
+
         DBGPX(printk("Done with %p\n", cmd->rq););
 	end_that_request_last(cmd->rq, ok ? 1 : -EIO);
 }
