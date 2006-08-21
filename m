Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWHUMvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWHUMvc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWHUMvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:51:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52458 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932092AbWHUMvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:51:31 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/4] NFS: Fix up warnings
Date: Mon, 21 Aug 2006 13:50:22 +0100
To: akpm@osdl.org, trond.myklebust@fys.uio.no, michal.k.k.piotrowski@gmail.com,
       maciej.rutecki@gmail.com, bunk@stusta.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up warnings from compiling on ppc64.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/client.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index dd4ff23..8620e14 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -839,7 +839,9 @@ struct nfs_server *nfs_create_server(con
 	}
 	memcpy(&server->fsid, &fattr.fsid, sizeof(server->fsid));
 
-	dprintk("Server FSID: %llx:%llx\n", server->fsid.major, server->fsid.minor);
+	dprintk("Server FSID: %llx:%llx\n",
+		(unsigned long long) server->fsid.major,
+		(unsigned long long) server->fsid.minor);
 
 	BUG_ON(!server->nfs_client);
 	BUG_ON(!server->nfs_client->rpc_ops);
@@ -1005,7 +1007,9 @@ struct nfs_server *nfs4_create_server(co
 	if (error < 0)
 		goto error;
 
-	dprintk("Server FSID: %llx:%llx\n", server->fsid.major, server->fsid.minor);
+	dprintk("Server FSID: %llx:%llx\n",
+		(unsigned long long) server->fsid.major,
+		(unsigned long long) server->fsid.minor);
 	dprintk("Mount FH: %d\n", mntfh->size);
 
 	error = nfs_probe_fsinfo(server, mntfh, &fattr);
@@ -1077,7 +1081,8 @@ struct nfs_server *nfs4_create_referral_
 		goto error;
 
 	dprintk("Referral FSID: %llx:%llx\n",
-		server->fsid.major, server->fsid.minor);
+		(unsigned long long) server->fsid.major,
+		(unsigned long long) server->fsid.minor);
 
 	spin_lock(&nfs_client_lock);
 	list_add_tail(&server->client_link, &server->nfs_client->cl_superblocks);
@@ -1109,7 +1114,8 @@ struct nfs_server *nfs_clone_server(stru
 	int error;
 
 	dprintk("--> nfs_clone_server(,%llx:%llx,)\n",
-		fattr->fsid.major, fattr->fsid.minor);
+		(unsigned long long) fattr->fsid.major,
+		(unsigned long long) fattr->fsid.minor);
 
 	server = nfs_alloc_server();
 	if (!server)
@@ -1134,7 +1140,8 @@ struct nfs_server *nfs_clone_server(stru
 		goto out_free_server;
 
 	dprintk("Cloned FSID: %llx:%llx\n",
-		server->fsid.major, server->fsid.minor);
+		(unsigned long long) server->fsid.major,
+		(unsigned long long) server->fsid.minor);
 
 	error = nfs_start_lockd(server);
 	if (error < 0)
@@ -1378,7 +1385,8 @@ static int nfs_volume_list_show(struct s
 		 MAJOR(server->s_dev), MINOR(server->s_dev));
 
 	snprintf(fsid, 17, "%llx:%llx",
-		 server->fsid.major, server->fsid.minor);
+		 (unsigned long long) server->fsid.major,
+		 (unsigned long long) server->fsid.minor);
 
 	seq_printf(m, "v%d %02x%02x%02x%02x %4hx %-7s %-17s %s\n",
 		   clp->cl_nfsversion,
