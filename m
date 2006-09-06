Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWIFNjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWIFNjI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWIFNih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:38:37 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:50224 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1750918AbWIFNi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:38:29 -0400
Message-Id: <20060906133954.023622000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:37 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 07/21] nfs: add a comment explaining the use of PG_private in the NFS client
Content-Disposition: inline; filename=nfs_PG_private_comment.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
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

--
