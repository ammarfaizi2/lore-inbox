Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWCLFPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWCLFPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 00:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWCLFPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 00:15:21 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:54380 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751103AbWCLFPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 00:15:21 -0500
Date: Sun, 12 Mar 2006 12:34:50 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] fix swap cluster offset
Message-ID: <20060312043450.GA7088@miraclelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When we've allocated SWAPFILE_CLUSTER pages, ->cluster_next should
be the first index of swap cluster. But current code probably sets it
wrong offset.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

Index: work/mm/swapfile.c
===================================================================
--- work.orig/mm/swapfile.c
+++ work/mm/swapfile.c
@@ -116,7 +116,7 @@ static inline unsigned long scan_swap_ma
 				last_in_cluster = offset + SWAPFILE_CLUSTER;
 			else if (offset == last_in_cluster) {
 				spin_lock(&swap_lock);
-				si->cluster_next = offset-SWAPFILE_CLUSTER-1;
+				si->cluster_next = offset-SWAPFILE_CLUSTER+1;
 				goto cluster;
 			}
 			if (unlikely(--latency_ration < 0)) {
