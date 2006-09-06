Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWIFN6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWIFN6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 09:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWIFN5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 09:57:42 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:2837 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751070AbWIFN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 09:57:33 -0400
Message-Id: <20060906133954.264033000@chello.nl>
References: <20060906131630.793619000@chello.nl>>
User-Agent: quilt/0.45-1
Date: Wed, 06 Sep 2006 15:16:38 +0200
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH 08/21] nfs: enable swap on NFS
Content-Disposition: inline; filename=nfs_swapfile.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that NFS can handle swap cache pages, add a swapfile method to allow
swapping over NFS.

NOTE: this dummy method is obviously not enough to make it safe.
A more complete version of the nfs_swapfile() function will be present
in the next VM deadlock avoidance patches.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>
---
 fs/nfs/file.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-2.6/fs/nfs/file.c
===================================================================
--- linux-2.6.orig/fs/nfs/file.c
+++ linux-2.6/fs/nfs/file.c
@@ -321,6 +321,11 @@ static int nfs_release_page(struct page 
 		return 0;
 }
 
+static int nfs_swapfile(struct address_space *mapping, int enable)
+{
+	return 0;
+}
+
 const struct address_space_operations nfs_file_aops = {
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
@@ -334,6 +339,7 @@ const struct address_space_operations nf
 #ifdef CONFIG_NFS_DIRECTIO
 	.direct_IO = nfs_direct_IO,
 #endif
+	.swapfile = nfs_swapfile,
 };
 
 /* 

--
