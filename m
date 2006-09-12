Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWILP7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWILP7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWILP6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:58:00 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:53137 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751425AbWILPux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:50:53 -0400
Message-Id: <20060912144903.770953000@chello.nl>
References: <20060912143049.278065000@chello.nl>
User-Agent: quilt/0.45-1
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       David Miller <davem@davemloft.net>, Rik van Riel <riel@redhat.com>,
       Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 07/20] nfs: add a comment explaining the use of PG_private in the NFS client
Content-Disposition: inline; filename=nfs_PG_private_comment.patch
Date: Tue, 12 Sep 2006 17:25:49 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a little comment explaining the use of PG_private in the NFS client.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/nfs/write.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/fs/nfs/write.c
===================================================================
--- linux-2.6.orig/fs/nfs/write.c
+++ linux-2.6/fs/nfs/write.c
@@ -417,6 +417,11 @@ static int nfs_inode_add_request(struct 
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

--

