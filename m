Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbWG0VHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbWG0VHM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWG0VHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:07:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750821AbWG0Uw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:52:59 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 09/30] NFS: Add a server capabilities NFS RPC op [try #11]
Date: Thu, 27 Jul 2006 21:52:46 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205246.8443.11317.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a set_capabilities NFS RPC op so that the server capabilities can be set.

Signed-Off-By: David Howells <dhowells@redhat.com>
Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/nfs4proc.c       |    1 +
 include/linux/nfs_xdr.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7fa2938..b433810 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3765,6 +3765,7 @@ struct nfs_rpc_ops	nfs_v4_clientops = {
 	.statfs		= nfs4_proc_statfs,
 	.fsinfo		= nfs4_proc_fsinfo,
 	.pathconf	= nfs4_proc_pathconf,
+	.set_capabilities = nfs4_server_capabilities,
 	.decode_dirent	= nfs4_decode_dirent,
 	.read_setup	= nfs4_proc_read_setup,
 	.read_done	= nfs4_read_done,
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index be80310..24ceac1 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -809,6 +809,7 @@ struct nfs_rpc_ops {
 			    struct nfs_fsinfo *);
 	int	(*pathconf) (struct nfs_server *, struct nfs_fh *,
 			     struct nfs_pathconf *);
+	int	(*set_capabilities)(struct nfs_server *, struct nfs_fh *);
 	u32 *	(*decode_dirent)(u32 *, struct nfs_entry *, int plus);
 	void	(*read_setup)   (struct nfs_read_data *);
 	int	(*read_done)  (struct rpc_task *, struct nfs_read_data *);
