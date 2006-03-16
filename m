Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932616AbWCPDps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWCPDps (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWCPDps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:45:48 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19399 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932616AbWCPDpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:45:47 -0500
Date: Thu, 16 Mar 2006 12:41:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [19/19] xfs
Message-Id: <20060316124113.7f0615bc.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.
in xfs.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/fs/xfs/linux-2.6/xfs_sysctl.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/fs/xfs/linux-2.6/xfs_sysctl.c
+++ linux-2.6.16-rc6-mm1/fs/xfs/linux-2.6/xfs_sysctl.c
@@ -38,7 +38,7 @@ xfs_stats_clear_proc_handler(
 
 	if (!ret && write && *valp) {
 		printk("XFS Clearing xfsstats\n");
-		for_each_cpu(c) {
+		for_each_possible_cpu(c) {
 			preempt_disable();
 			/* save vn_active, it's a universal truth! */
 			vn_active = per_cpu(xfsstats, c).vn_active;
Index: linux-2.6.16-rc6-mm1/fs/xfs/linux-2.6/xfs_stats.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/fs/xfs/linux-2.6/xfs_stats.c
+++ linux-2.6.16-rc6-mm1/fs/xfs/linux-2.6/xfs_stats.c
@@ -62,7 +62,7 @@ xfs_read_xfsstats(
 		while (j < xstats[i].endpoint) {
 			val = 0;
 			/* sum over all cpus */
-			for_each_cpu(c)
+			for_each_possible_cpu(c)
 				val += *(((__u32*)&per_cpu(xfsstats, c) + j));
 			len += sprintf(buffer + len, " %u", val);
 			j++;
@@ -70,7 +70,7 @@ xfs_read_xfsstats(
 		buffer[len++] = '\n';
 	}
 	/* extra precision counters */
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		xs_xstrat_bytes += per_cpu(xfsstats, i).xs_xstrat_bytes;
 		xs_write_bytes += per_cpu(xfsstats, i).xs_write_bytes;
 		xs_read_bytes += per_cpu(xfsstats, i).xs_read_bytes;
