Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWDMXMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWDMXMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWDMXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:11:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16083 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965017AbWDMXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:11:37 -0400
From: hawkes@sgi.com
To: Andrew Morton <akpm@osdl.org>
Cc: hawkes@sgi.com, linux-kernel@vger.kernel.org
Date: Thu, 13 Apr 2006 16:11:35 -0700
Message-Id: <20060413231135.3397.56412.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] nfs_show_stats: for_each_possible_cpu(), not NR_CPUS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert a for-loop that explicitly references "NR_CPUS" into the potentially
more efficient for_each_possible_cpu() construct.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/fs/nfs/inode.c
===================================================================
--- linux.orig/fs/nfs/inode.c	2006-04-13 12:48:18.000000000 -0700
+++ linux/fs/nfs/inode.c	2006-04-13 15:49:23.000000000 -0700
@@ -700,12 +700,9 @@ static int nfs_show_stats(struct seq_fil
 	/*
 	 * Display superblock I/O counters
 	 */
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+	for_each_possible_cpu(cpu) {
 		struct nfs_iostats *stats;
 
-		if (!cpu_possible(cpu))
-			continue;
-
 		preempt_disable();
 		stats = per_cpu_ptr(nfss->io_stats, cpu);
 
