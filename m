Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWHUMv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWHUMv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWHUMv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:51:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2283 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932092AbWHUMvn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:51:43 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 3/4] NFS: Fix up filesystem caching patch
Date: Mon, 21 Aug 2006 13:50:27 +0100
To: akpm@osdl.org, trond.myklebust@fys.uio.no, michal.k.k.piotrowski@gmail.com,
       maciej.rutecki@gmail.com, bunk@stusta.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060821125027.1437.95895.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
References: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the NFS filesystem caching patch for when caching is disabled.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/nfs/fscache.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/nfs/fscache.h b/fs/nfs/fscache.h
index 48a993a..8899f16 100644
--- a/fs/nfs/fscache.h
+++ b/fs/nfs/fscache.h
@@ -446,7 +446,10 @@ static inline void nfs_fscache_zap_fh_co
 static inline void nfs_fscache_renew_fh_cookie(struct nfs_server *server, struct nfs_inode *nfsi) {}
 static inline void nfs_fscache_disable_fh_cookie(struct inode *inode) {}
 static inline void nfs_fscache_install_vm_ops(struct inode *inode, struct vm_area_struct *vma) {}
-static inline void nfs_fscache_release_page(struct page *page) {}
+static inline int nfs_fscache_release_page(struct page *page)
+{
+	return 1; /* True: may release page */
+}
 static inline void nfs_fscache_invalidate_page(struct page *page,
 					       struct inode *inode,
 					       unsigned long offset)
