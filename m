Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030689AbWKOQpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030689AbWKOQpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030692AbWKOQpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:45:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63917 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030691AbWKOQpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:45:16 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
References: <20061114200621.12943.18023.stgit@warthog.cambridge.redhat.com> 
To: trond.myklebust@fys.uio.no, torvalds@osdl.org, akpm@osdl.org,
       sds@tycho.nsa.gov
Cc: dhowells@redhat.com, selinux@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       aviro@redhat.com, steved@redhat.com
Subject: [PATCH 23/19] FS-Cache: NFS: Don't invoke FS-Cache from nfs_zap_caches()
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 15 Nov 2006 16:42:56 +0000
Message-ID: <29409.1163608976@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't invoke FS-Cache from nfs_zap_caches() as that is supposed to be quick
whereas FS-Cache may get semaphores and other sleepy things.

As it happens, the cache will be zapped upon the next revalidation anyway, and
so this is probably unnecessary.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/inode.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0d683eb..25376a5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -130,8 +130,6 @@ void nfs_zap_caches(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	nfs_zap_caches_locked(inode);
 	spin_unlock(&inode->i_lock);
-
-	nfs_fscache_zap_fh_cookie(inode);
 }
 
 void nfs_zap_mapping(struct inode *inode, struct address_space *mapping)
