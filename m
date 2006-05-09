Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWEITvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWEITvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 15:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWEITvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 15:51:48 -0400
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:28835
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1751053AbWEITvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 15:51:46 -0400
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
X-PatchBomber: http://selenic.com/scripts/mailpatches
Cc: linux-kernel@vger.kernel.org, iss_storagedev@hp.com
In-Reply-To: <2.628477917@selenic.com>
Message-Id: <5.628477917@selenic.com>
Subject: [PATCH 4/6] random: Change cpqarray to use add_disk_randomness
Date: Tue, 09 May 2006 14:50:25 -0500
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
