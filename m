Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWHUMvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWHUMvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWHUMvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:51:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56298 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932100AbWHUMve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:51:34 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/4] FS-Cache: AFS: Fix up AFS filesystem caching patch
Date: Mon, 21 Aug 2006 13:50:25 +0100
To: akpm@osdl.org, trond.myklebust@fys.uio.no, michal.k.k.piotrowski@gmail.com,
       maciej.rutecki@gmail.com, bunk@stusta.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060821125025.1437.52134.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
References: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the AFS filesystem caching patch for when caching is disabled.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/afs/file.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 93f2cc0..db441c5 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -323,13 +323,15 @@ static int afs_file_releasepage(struct p
 {
 	_enter("{%lu},%x", page->index, gfp_flags);
 
-	/* deny */
+#ifdef CONFIG_AFS_FSCACHE
+	/* deny if page is being written to the cache */
 	if (PageFsMisc(page)) {
 		_leave(" = F");
 		return 0;
 	}
 
 	fscache_uncache_page(AFS_FS_I(page->mapping->host)->cache, page);
+#endif
 
 	/* indicate that the page can be released */
 	_leave(" = T");
