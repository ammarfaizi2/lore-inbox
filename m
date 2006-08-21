Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWHUMv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWHUMv4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWHUMvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:51:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932457AbWHUMvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:51:36 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 4/4] FS-Cache: CacheFiles: Fix up warnings
Date: Mon, 21 Aug 2006 13:50:29 +0100
To: akpm@osdl.org, trond.myklebust@fys.uio.no, michal.k.k.piotrowski@gmail.com,
       maciej.rutecki@gmail.com, bunk@stusta.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       dhowells@redhat.com
Message-Id: <20060821125029.1437.85589.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
References: <20060821125022.1437.2836.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up warnings in the CacheFiles patch.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/cf-bind.c      |   10 ++++++----
 fs/cachefiles/cf-interface.c |   15 +++++++++++----
 fs/cachefiles/cf-proc.c      |    6 +++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/cachefiles/cf-bind.c b/fs/cachefiles/cf-bind.c
index d8cb4c3..5325719 100644
--- a/fs/cachefiles/cf-bind.c
+++ b/fs/cachefiles/cf-bind.c
@@ -173,7 +173,9 @@ static int cachefiles_proc_add_cache(str
 	_debug("blksize %u (shift %u)",
 	       cache->bsize, cache->bshift);
 
-	_debug("size %llu, avail %llu", stats.f_blocks, stats.f_bavail);
+	_debug("size %llu, avail %llu",
+	       (unsigned long long) stats.f_blocks,
+	       (unsigned long long) stats.f_bavail);
 
 	/* set up caching limits */
 	stats.f_blocks >>= cache->bshift;
@@ -183,9 +185,9 @@ static int cachefiles_proc_add_cache(str
 	cache->brun  = stats.f_blocks * cache->brun_percent;
 
 	_debug("limits {%llu,%llu,%llu}",
-	       cache->brun,
-	       cache->bcull,
-	       cache->bstop);
+	       (unsigned long long) cache->brun,
+	       (unsigned long long) cache->bcull,
+	       (unsigned long long) cache->bstop);
 
 	/* get the cache directory and check its type */
 	cachedir = cachefiles_get_directory(cache, root, "cache");
diff --git a/fs/cachefiles/cf-interface.c b/fs/cachefiles/cf-interface.c
index b5ca30f..6be3d98 100644
--- a/fs/cachefiles/cf-interface.c
+++ b/fs/cachefiles/cf-interface.c
@@ -323,7 +323,10 @@ int cachefiles_has_space(struct cachefil
 	int ret;
 
 	_enter("{%llu,%llu,%llu},%d",
-	       cache->brun, cache->bcull, cache->bstop,  nr);
+	       (unsigned long long) cache->brun,
+	       (unsigned long long) cache->bcull,
+	       (unsigned long long) cache->bstop,
+	       nr);
 
 	/* find out how many pages of blockdev are available */
 	memset(&stats, 0, sizeof(stats));
@@ -337,7 +340,7 @@ int cachefiles_has_space(struct cachefil
 
 	stats.f_bavail >>= cache->bshift;
 
-	_debug("avail %llu", stats.f_bavail);
+	_debug("avail %llu", (unsigned long long) stats.f_bavail);
 
 	/* see if there is sufficient space */
 	stats.f_bavail -= nr;
@@ -715,7 +718,9 @@ static int cachefiles_read_or_alloc_page
 	block0 <<= shift;
 
 	block = inode->i_mapping->a_ops->bmap(inode->i_mapping, block0);
-	_debug("%llx -> %llx", block0, block);
+	_debug("%llx -> %llx",
+	       (unsigned long long) block0,
+	       (unsigned long long) block);
 
 	if (block) {
 		/* submit the apparently valid page to the backing fs to be
@@ -1040,7 +1045,9 @@ static int cachefiles_read_or_alloc_page
 
 		block = inode->i_mapping->a_ops->bmap(inode->i_mapping,
 						      block0);
-		_debug("%llx -> %llx", block0, block);
+		_debug("%llx -> %llx",
+		       (unsigned long long) block0,
+		       (unsigned long long) block);
 
 		if (block) {
 			/* we have data - add it to the list to give to the
diff --git a/fs/cachefiles/cf-proc.c b/fs/cachefiles/cf-proc.c
index a4a056b..cf246a3 100644
--- a/fs/cachefiles/cf-proc.c
+++ b/fs/cachefiles/cf-proc.c
@@ -162,9 +162,9 @@ static ssize_t cachefiles_proc_read(stru
 		     " bcull=%llx"
 		     " bstop=%llx",
 		     test_bit(CACHEFILES_CULLING, &cache->flags) ? '1' : '0',
-		     cache->brun,
-		     cache->bcull,
-		     cache->bstop
+		     (unsigned long long) cache->brun,
+		     (unsigned long long) cache->bcull,
+		     (unsigned long long) cache->bstop
 		     );
 
 	if (n > buflen)
