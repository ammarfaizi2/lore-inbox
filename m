Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbWHYPnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbWHYPnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 11:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWHYPmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 11:42:50 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:57106 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030269AbWHYPmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 11:42:42 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Rik van Riel <riel@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Fri, 25 Aug 2006 17:38:01 +0200
Message-Id: <20060825153801.24254.34847.sendpatchset@twins>
In-Reply-To: <20060825153709.24254.28118.sendpatchset@twins>
References: <20060825153709.24254.28118.sendpatchset@twins>
Subject: [PATCH 5/6] nfs: Add comment on PG_private use of NFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a comment explaining the use of PG_private in the NFS client.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 fs/nfs/write.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/fs/nfs/write.c
===================================================================
--- linux-2.6.orig/fs/nfs/write.c
+++ linux-2.6/fs/nfs/write.c
@@ -424,6 +424,11 @@ static int nfs_inode_add_request(struct 
 		if (nfs_have_delegation(inode, FMODE_WRITE))
 			nfsi->change_attr++;
 	}
+	/*
+	 * The PG_private bit is unfortunately needed if we want to fix the
+	 * hole in the mmap semantics. If we do not set it, then the VM will
+	 * fail to call the "releasepage" address ops.
+	 */
 	SetPagePrivate(req->wb_page);
 	nfsi->npages++;
 	atomic_inc(&req->wb_count);
