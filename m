Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290741AbSAYR22>; Fri, 25 Jan 2002 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290744AbSAYR2S>; Fri, 25 Jan 2002 12:28:18 -0500
Received: from ns.suse.de ([213.95.15.193]:55053 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290741AbSAYR2J>;
	Fri, 25 Jan 2002 12:28:09 -0500
Date: Fri, 25 Jan 2002 18:28:08 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: [PATCH] Fix 2.5.3pre reiserfs BUG() at boot time
Message-ID: <20020125182808.A8130@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resent because t-offline's outgoing mail server seems to be eating/
not delivering mail. sorry if it appears multiple times]

This patch fixes an reiserfs BUG() at boot time introduced by the 
inode cleanups. The problem is that it passes a 20 char name to
kmem_cache_create() ("reiserfs_inode_cache") but kmem_cache_create()
only allows 19 character names and BUG()s for longer names.

The patch fixes this in a low tech approach.  It's required to boot
a 2.5.3preX machine with reiserfs compiled in.

-Andi


Index: fs/reiserfs/super.c
===================================================================
RCS file: /cvs/linux/fs/reiserfs/super.c,v
retrieving revision 1.17
diff -u -u -r1.17 super.c
--- fs/reiserfs/super.c	2002/01/24 14:07:54	1.17
+++ fs/reiserfs/super.c	2002/01/24 22:03:34
@@ -153,7 +153,7 @@
  
 static int init_inodecache(void)
 {
-	reiserfs_inode_cachep = kmem_cache_create("reiserfs_inode_cache",
+	reiserfs_inode_cachep = kmem_cache_create("reiser_inode_cache",
 					     sizeof(struct reiserfs_inode_info),
 					     0, SLAB_HWCACHE_ALIGN,
 					     init_once, NULL);
