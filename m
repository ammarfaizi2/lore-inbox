Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbUKLOcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbUKLOcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 09:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKLOci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 09:32:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46853 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262535AbUKLObL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 09:31:11 -0500
Date: Fri, 12 Nov 2004 15:30:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [patch] 2.6.10-rc1-mm5: some reiser4 cleanups
Message-ID: <20041112143038.GC7707@stusta.de>
References: <20041111012333.1b529478.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20041111012333.1b529478.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch (gzip'ed due to the 100 kB limit on linux-kernel) is not 
intended for immediate applying but requires a review.

I've gone throught the reiser4 code in 2.6.10-rc1-mm5, removed unused 
code and made needlessly global code static.

Size comparison (with all through Kconfig available debugging enabled,
gcc 3.4 on i386):

1787503 2004-11-12 15:12 built-in.o
1821820 2004-11-11 23:55 built-in.o-before-cleanup

That's a 1.9% space saving with zero functionality loss.

diffstat output:
 fs/reiser4/Makefile                       |    5 
 fs/reiser4/block_alloc.c                  |   29 ---
 fs/reiser4/block_alloc.h                  |   10 -
 fs/reiser4/carry.c                        |   25 +--
 fs/reiser4/carry.h                        |   20 --
 fs/reiser4/cluster.h                      |    4 
 fs/reiser4/context.c                      |    6 
 fs/reiser4/context.h                      |    5 
 fs/reiser4/coord.c                        |   43 -----
 fs/reiser4/coord.h                        |    4 
 fs/reiser4/debug.c                        |   31 ---
 fs/reiser4/debug.h                        |    4 
 fs/reiser4/estimate.c                     |    6 
 fs/reiser4/flush.c                        |   16 -
 fs/reiser4/flush.h                        |    2 
 fs/reiser4/flush_queue.c                  |    4 
 fs/reiser4/inode.c                        |   13 -
 fs/reiser4/inode.h                        |    2 
 fs/reiser4/jnode.c                        |   19 +-
 fs/reiser4/jnode.h                        |    8 
 fs/reiser4/kassign.c                      |   37 ----
 fs/reiser4/kassign.h                      |    3 
 fs/reiser4/kcond.c                        |   15 -
 fs/reiser4/kcond.h                        |    3 
 fs/reiser4/lnode.c                        |  177 ----------------------
 fs/reiser4/lnode.h                        |    6 
 fs/reiser4/lock.c                         |    2 
 fs/reiser4/log.c                          |   44 -----
 fs/reiser4/log.h                          |   10 -
 fs/reiser4/page_cache.c                   |   10 -
 fs/reiser4/page_cache.h                   |    1 
 fs/reiser4/plugin/cryptcompress.c         |   33 +---
 fs/reiser4/plugin/cryptcompress.h         |    1 
 fs/reiser4/plugin/dir/dir.c               |    4 
 fs/reiser4/plugin/dir/hashed_dir.c        |    2 
 fs/reiser4/plugin/file/file.c             |   31 +--
 fs/reiser4/plugin/file/funcs.h            |    1 
 fs/reiser4/plugin/file/pseudo.c           |    2 
 fs/reiser4/plugin/file/tail_conversion.c  |   10 -
 fs/reiser4/plugin/item/ctail.c            |    9 -
 fs/reiser4/plugin/item/ctail.h            |    2 
 fs/reiser4/plugin/item/extent.c           |    8 
 fs/reiser4/plugin/item/extent.h           |    2 
 fs/reiser4/plugin/item/extent_flush_ops.c |    4 
 fs/reiser4/plugin/item/item.c             |    2 
 fs/reiser4/plugin/item/tail.c             |    2 
 fs/reiser4/plugin/node/node.c             |   92 -----------
 fs/reiser4/plugin/node/node.h             |    5 
 fs/reiser4/plugin/node/node40.c           |   16 -
 fs/reiser4/plugin/node/node40.h           |    2 
 fs/reiser4/plugin/object.c                |    8 
 fs/reiser4/plugin/object.h                |    2 
 fs/reiser4/plugin/plugin.c                |   23 --
 fs/reiser4/plugin/plugin_set.c            |   37 +---
 fs/reiser4/plugin/plugin_set.h            |    4 
 fs/reiser4/plugin/space/bitmap.c          |    6 
 fs/reiser4/plugin/space/bitmap.h          |    1 
 fs/reiser4/pool.c                         |    2 
 fs/reiser4/pool.h                         |    1 
 fs/reiser4/repacker.c                     |    6 
 fs/reiser4/repacker.h                     |    1 
 fs/reiser4/safe_link.c                    |    2 
 fs/reiser4/safe_link.h                    |    1 
 fs/reiser4/search.c                       |   37 ----
 fs/reiser4/stats.c                        |    2 
 fs/reiser4/stats.h                        |    3 
 fs/reiser4/super.c                        |   75 ---------
 fs/reiser4/super.h                        |    8 
 fs/reiser4/tap.c                          |    9 -
 fs/reiser4/tap.h                          |    2 
 fs/reiser4/tree.c                         |   16 -
 fs/reiser4/tree.h                         |    9 -
 fs/reiser4/txnmgr.c                       |   79 ---------
 fs/reiser4/txnmgr.h                       |   11 -
 fs/reiser4/wander.c                       |    2 
 fs/reiser4/znode.c                        |  155 ++++---------------
 fs/reiser4/znode.h                        |   11 -
 77 files changed, 189 insertions(+), 1116 deletions(-)


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


--opJtzjQTFsWo+cga
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="patch-cleanup-reiser4.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
