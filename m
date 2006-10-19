Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946243AbWJSRGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946243AbWJSRGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946241AbWJSRGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:08 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946237AbWJSRGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:05 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607064:sNHT17332848"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.35298.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 08/11] NFS: __nfs_revalidate_inode() can use "inode" before
	checking it is non-NULL
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:23.0160 (UTC) FILETIME=[E78AFB80:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The "!inode" check in __nfs_revalidate_inode() occurs well after the first
time it is dereferenced, so get rid of it.

Coverity: #cid 1372, 1373

Test plan:
Code review; recheck with Coverity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 9979ad1..08cc4c5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -583,7 +583,7 @@ __nfs_revalidate_inode(struct nfs_server
 
 	nfs_inc_stats(inode, NFSIOS_INODEREVALIDATE);
 	lock_kernel();
-	if (!inode || is_bad_inode(inode))
+	if (is_bad_inode(inode))
  		goto out_nowait;
 	if (NFS_STALE(inode))
  		goto out_nowait;
