Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFTQT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFTQT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVFTQT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:19:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:59360 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261375AbVFTQSz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:18:55 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050620161851.D1F78838CB@kleikamp.dyn.webahead.ibm.com>
Date: Mon, 20 Jun 2005 11:18:51 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

This will update the following files:

 fs/jfs/acl.c            |    6 +----
 fs/jfs/file.c           |    9 ++------
 fs/jfs/inode.c          |   11 +---------
 fs/jfs/jfs_debug.c      |   10 ---------
 fs/jfs/jfs_debug.h      |   15 ++++++++++----
 fs/jfs/jfs_dmap.c       |    9 --------
 fs/jfs/jfs_dtree.c      |    3 ++
 fs/jfs/jfs_extent.c     |    7 ------
 fs/jfs/jfs_imap.c       |    6 -----
 fs/jfs/jfs_inode.c      |    1 
 fs/jfs/jfs_inode.h      |   19 +++++++++++++++++-
 fs/jfs/jfs_logmgr.c     |   14 +++----------
 fs/jfs/jfs_logmgr.h     |    2 +
 fs/jfs/jfs_metapage.c   |    6 ++---
 fs/jfs/jfs_metapage.h   |    6 +++--
 fs/jfs/jfs_superblock.h |   11 ++++++++++
 fs/jfs/jfs_txnmgr.c     |   40 --------------------------------------
 fs/jfs/jfs_txnmgr.h     |   50 ++++++++++++++++++++----------------------------
 fs/jfs/namei.c          |   28 +++++---------------------
 fs/jfs/super.c          |   37 -----------------------------------
 fs/jfs/symlink.c        |    3 +-
 fs/jfs/xattr.c          |    6 +----
 22 files changed, 99 insertions(+), 200 deletions(-)

through these ChangeSets:

commit 72e3148a6e987974e3e949c5668e5ca812d7c818
tree abdf33dbbe33029ab81e7a209f11f29d2bc6b801
parent c2731509cfb538b9b38feaf657fab2334ea45253
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 03 Jun 2005 14:09:54 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 03 Jun 2005 14:09:54 -0500

    JFS: Fix compiler warning in jfs_logmgr.c
    
    fs/jfs/jfs_logmgr.c: In function `jfs_flush_journal':
    fs/jfs/jfs_logmgr.c:1632: warning: unused variable `mp'
    
    Some debug code in jfs_flush_journal does nothing when CONFIG_JFS_DEBUG
    is not defined.  Place the whole code segment within an ifdef to avoid
    unnecessary code to be compiled and the warning to be issued.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit c2731509cfb538b9b38feaf657fab2334ea45253
tree cb7ad2847067b5ba436b78077c4abc61ce736444
parent 7078253c085c037c070ca4e8bc9e9e7f18aa1e84
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 02 Jun 2005 12:18:20 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 02 Jun 2005 12:18:20 -0500

    JFS: kernel BUG at fs/jfs/jfs_txnmgr.c:859
    
    add_missing_indices() must set tlck->type to tlckBTROOT when modifying
    a root btree root to avoid a trap in txRelease()
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 259692bd5a2b2c2d351dd90748ba4126bc2a21b9
tree fa35d57768a76bbd88fa54b33daf922e9415f9da
parent 6f817abc643ec84cf07c99f964d04976212e1fd3
author Jesper Juhl <juhl-lkml@dif.dk> Mon, 09 May 2005 10:47:14 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 09 May 2005 10:47:14 -0500

    JFS: Remove redundant kfree() NULL pointer checks
    
    kfree() can handle a NULL pointer, don't worry about passing it one.
    
    Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 7a694ca74958b97ae2d437c8a730bddd9e9792c3
tree 1d25feb1d02cdff8affee0cbbcfc70b3af2c7385
parent dcc9871270aa3b1bbe2e61cc9c1d80e9b2e8099d
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:31:14 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:31:14 -0500

    JFS: Fix sparse warning
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit dcc9871270aa3b1bbe2e61cc9c1d80e9b2e8099d
tree a6f64721b55739fcac62ba251563e6809b985a7d
parent 1868f4aa5a4a72bbe0b7db6c1d4ee666824c3895
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:30:51 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:30:51 -0500

    JFS: cleanup - remove unneeded sanity check
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 1868f4aa5a4a72bbe0b7db6c1d4ee666824c3895
tree c3bfa2751dcc1d7adf16a6a96e5ad8cab76b6f76
parent 6b6bf51081a27e80334e7ebe2993ae1d046a3222
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:29:35 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 04 May 2005 15:29:35 -0500

    JFS: fix sparse warnings by moving extern declarations to headers
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

