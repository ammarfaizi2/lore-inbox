Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317534AbSGESif>; Fri, 5 Jul 2002 14:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317535AbSGESie>; Fri, 5 Jul 2002 14:38:34 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12552 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317534AbSGESie>; Fri, 5 Jul 2002 14:38:34 -0400
Date: Fri, 5 Jul 2002 15:40:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] return value for shrink_*_memory
Message-ID: <Pine.LNX.4.44L.0207051537270.8346-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch (lifted from rmap) gives shrink_icache_memory,
shrink_dqcache_memory and shrink_dcache_memory proper return values.
AFAICS this small patch doesn't clash with any of akpm's changes.

please apply,
thanks,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

 dcache.c |    3 +--
 dquot.c  |    3 +--
 inode.c  |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff -uNr linux-2.5.24/fs/dcache.c linux-2.5.24-rmap/fs/dcache.c
--- linux-2.5.24/fs/dcache.c	Thu Jun 13 22:05:27 2002
+++ linux-2.5.24-rmap/fs/dcache.c	Fri Jun 21 01:07:07 2002
@@ -602,8 +602,7 @@
 	count = dentry_stat.nr_unused / priority;

 	prune_dcache(count);
-	kmem_cache_shrink(dentry_cache);
-	return 0;
+	return kmem_cache_shrink(dentry_cache);
 }

 #define NAME_ALLOC_LEN(len)	((len+16) & ~15)
diff -uNr linux-2.5.24/fs/dquot.c linux-2.5.24-rmap/fs/dquot.c
--- linux-2.5.24/fs/dquot.c	Sun Jun 16 22:46:39 2002
+++ linux-2.5.24-rmap/fs/dquot.c	Fri Jun 21 01:07:07 2002
@@ -498,8 +498,7 @@
 	count = dqstats.free_dquots / priority;
 	prune_dqcache(count);
 	unlock_kernel();
-	kmem_cache_shrink(dquot_cachep);
-	return 0;
+	return kmem_cache_shrink(dquot_cachep);
 }

 /*
diff -uNr linux-2.5.24/fs/inode.c linux-2.5.24-rmap/fs/inode.c
--- linux-2.5.24/fs/inode.c	Tue Jun 18 20:53:25 2002
+++ linux-2.5.24-rmap/fs/inode.c	Fri Jun 21 01:07:07 2002
@@ -431,8 +431,7 @@
 	count = inodes_stat.nr_unused / priority;

 	prune_icache(count);
-	kmem_cache_shrink(inode_cachep);
-	return 0;
+	return kmem_cache_shrink(inode_cachep);
 }

 /*


