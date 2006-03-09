Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWCIJYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWCIJYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbWCIJYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:24:09 -0500
Received: from koto.vergenet.net ([210.128.90.7]:41110 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751599AbWCIJYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:24:08 -0500
Date: Thu, 9 Mar 2006 18:23:45 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH] NFS Client: remove supurflous goto from nfs_create_client()
Message-ID: <20060309092341.GA26949@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Cluestick: seven
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The out_fail label in nfs_create_client just returns clnt,
which happens to be a duplicate of a return immediately above.
Remove the label and instead of calling goto out_fail (once),
just return clnt.

Signed-Off-By: Horms <horms@verge.net.au>

 inode.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index a77ee95..367d62c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -408,16 +408,13 @@ nfs_create_client(struct nfs_server *ser
 	if (IS_ERR(clnt)) {
 		dprintk("%s: cannot create RPC client. Error = %ld\n",
 				__FUNCTION__, PTR_ERR(xprt));
-		goto out_fail;
+		return clnt;
 	}
 
 	clnt->cl_intr     = 1;
 	clnt->cl_softrtry = 1;
 
 	return clnt;
-
-out_fail:
-	return clnt;
 }
 
 /*
