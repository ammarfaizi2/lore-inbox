Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946245AbWJSRGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946245AbWJSRGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 13:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946241AbWJSRGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 13:06:18 -0400
Received: from mx2.netapp.com ([216.240.18.37]:6061 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1946245AbWJSRGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 13:06:09 -0400
X-IronPort-AV: i="4.09,330,1157353200"; 
   d="scan'208"; a="419607094:sNHT42737268"
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Date: Thu, 19 Oct 2006 13:04:32 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20061019170432.8171.64428.stgit@lade.trondhjem.org>
In-Reply-To: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
References: <20061019170432.8171.75076.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Subject: [PATCH 09/11] NFS: remove unused check in nfs4_open_revalidate
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 19 Oct 2006 17:06:27.0535 (UTC) FILETIME=[EA268DF0:01C6F3A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Coverity spotted a superfluous error check in nfs4_open_revalidate().
Remove it.

Coverity: #cid 847

Test plan:
Code inspection; another pass through Coverity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4proc.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 47c7e6e..7421bcb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1314,11 +1314,9 @@ nfs4_open_revalidate(struct inode *dir, 
 			case -EROFS:
 				lookup_instantiate_filp(nd, (struct dentry *)state, NULL);
 				return 1;
-			case -ENOENT:
-				if (dentry->d_inode == NULL)
-					return 1;
+			default:
+				goto out_drop;
 		}
-		goto out_drop;
 	}
 	if (state->inode == dentry->d_inode) {
 		nfs4_intent_set_file(nd, dentry, state);
