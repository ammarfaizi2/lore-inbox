Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWG0U7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWG0U7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWG0Uxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:53:48 -0400
Received: from mx2.redhat.com ([66.187.237.31]:50401 "EHLO mx2.redhat.com")
	by vger.kernel.org with ESMTP id S1750948AbWG0UxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:53:19 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 20/30] NFS: Fix error handling [try #11]
Date: Thu, 27 Jul 2006 21:53:12 +0100
To: torvalds@osdl.org, akpm@osdl.org, steved@redhat.com,
       trond.myklebust@fys.uio.no
Cc: linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
Message-Id: <20060727205312.8443.52843.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
References: <20060727205222.8443.29381.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an error handling problem: nfs_put_client() can be given a NULL pointer if
nfs_free_server() is asked to destroy a partially initialised record.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/client.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 27f6478..700bd58 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -208,6 +208,9 @@ #endif
  */
 void nfs_put_client(struct nfs_client *clp)
 {
+	if (!clp)
+		return;
+
 	dprintk("--> nfs_put_client({%d})\n", atomic_read(&clp->cl_count));
 
 	if (atomic_dec_and_lock(&clp->cl_count, &nfs_client_lock)) {
