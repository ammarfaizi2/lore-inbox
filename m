Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422715AbWHYPn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422715AbWHYPn1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWHYPnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:43:07 -0400
Received: from [213.46.243.16] ([213.46.243.16]:20308 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030265AbWHYPmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:42:53 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Rik van Riel <riel@redhat.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 25 Aug 2006 17:38:12 +0200
Message-Id: <20060825153812.24254.9718.sendpatchset@twins>
In-Reply-To: <20060825153709.24254.28118.sendpatchset@twins>
References: <20060825153709.24254.28118.sendpatchset@twins>
Subject: [PATCH 6/6] nfs: Enable swap over NFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Now that NFS can handle swap cache pages, add a swapfile method to allow
swapping over NFS.

NOTE: this dummy method is obviously not enough to make it safe.
A more complete version of the nfs_swapfile() function will be present
in the next VM deadlock avoidance patches.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfs/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/fs/nfs/file.c
===================================================================
--- linux-2.6.orig/fs/nfs/file.c
+++ linux-2.6/fs/nfs/file.c
@@ -315,6 +315,11 @@ static int nfs_release_page(struct page 
 	return !nfs_wb_page(page_file_mapping(page)->host, page);
 }
 
+static int nfs_swapfile(struct address_space *mapping, int enable)
+{
+	return 0;
+}
+
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -328,6 +333,7 @@ const struct address_space_operations nf
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+	.swapfile = nfs_swapfile,
 };
 
 /* 
