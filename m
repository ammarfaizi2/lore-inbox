Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVG0SFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVG0SFw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVG0SFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:05:52 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44781 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261369AbVG0SFu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:05:50 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050727180547.6E5CE82BC4@kleikamp.dyn.webahead.ibm.com>
Date: Wed, 27 Jul 2005 13:05:47 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

This will update the following files:

 fs/jfs/jfs_dmap.c     |   46 ++++++++++++++++++++++++++++++----------------
 fs/jfs/jfs_dtree.c    |   13 +++++++++----
 fs/jfs/jfs_logmgr.c   |    3 ++-
 fs/jfs/jfs_metapage.c |   11 +----------
 4 files changed, 42 insertions(+), 31 deletions(-)

through these ChangeSets:

commit 18190cc08d70a6ec8ef69f0f6ede021f7cb3f9b8
tree 5e1d35d247e5ddd549283e0d71bb7810c04b02f1
parent c2783f3a625b2aba943ef94623e277557a91a448
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 26 Jul 2005 09:29:13 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 26 Jul 2005 09:29:13 -0500

    JFS: Fix i_blocks accounting when allocation fails
    
    A failure in dbAlloc caused a directory's i_blocks to be incorrectly
    incremented, causing jfs_fsck to find the inode to be corrupt.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit c2783f3a625b2aba943ef94623e277557a91a448
tree e262b750f4e8cd5785417a55dd68b427e31bd86f
parent c40c202493d18de42fcd0b8b5d68c22aefb70f03
author Dave Kleikamp <shaggy@austin.ibm.com> Mon, 25 Jul 2005 08:58:54 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 25 Jul 2005 08:58:54 -0500

    JFS: Don't set log_SYNCBARRIER when log->active == 0
    
    If a metadata page is kept active, it is possible that the sync barrier logic
    continues to trigger, even if all active transactions have been phyically
    written to the journal.  This can cause a hang, since the completion of the
    journal I/O is what unsets the sync barrier flag to allow new transactions
    to be created.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit c40c202493d18de42fcd0b8b5d68c22aefb70f03
tree f8629741d3e049ca8fe7893bd1f089f82ef05611
parent 21d1ee8b375bcd180f1d6b8ccbb8d8f938596310
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 22 Jul 2005 11:08:44 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 22 Jul 2005 11:08:44 -0500

    JFS: Fix typo in last patch
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 21d1ee8b375bcd180f1d6b8ccbb8d8f938596310
tree 2e82b65c16a4aaa88eeb7dd9f47f2d1c418e77d0
parent 3d9b1cdd2455017c6aa25bc2442092b81438981f
parent f60f700876cd51de9de69f3a3c865d95e287a24d
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 19 Jul 2005 13:46:53 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 19 Jul 2005 13:46:53 -0500

    Merge with /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 3d9b1cdd2455017c6aa25bc2442092b81438981f
tree 0f0bf8deaeabc2d14fbded203392ec5bf7dc37ad
parent 56d1254917d9f301a8e24155cd3f2236e642cb7d
author Qu Fuping <qufuping@ercist.iscas.ac.cn> Fri, 15 Jul 2005 10:36:08 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 15 Jul 2005 10:36:08 -0500

    JFS: fsync wrong behavior when I/O failure occurs
    
    This is half of a patch that Qu Fuping submitted in April.  The first part
    was applied to fs/mpage.c in 2.6.12-rc4.
    
    jfs_fsync should return error, but it doesn't wait for the metadata page to
    be uptodate, e.g.:
    jfs_fsync->jfs_commit_inode->txCommit->diWrite->read_metapage->
    __get_metapage->read_cache_page reads a page from disk. Because read is
    async, when read_cache_page: err = filler(data, page), filler will not
    return error, it just submits I/O request and returns. So, page is not
    uptodate.  Checking only if(IS_ERROR(mp->page)) is not enough, we should
    add "|| !PageUptodate(mp->page)"
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 56d1254917d9f301a8e24155cd3f2236e642cb7d
tree 63b6881444c37e73caf039ebfdbfc9edece87aa6
parent 00be3e7e5cc3ca80e035b387e883d5ec10d7b897
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 15 Jul 2005 09:43:36 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 15 Jul 2005 09:43:36 -0500

    JFS: Remove assert statement in dbJoin & return -EIO instead
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 00be3e7e5cc3ca80e035b387e883d5ec10d7b897
tree 916ae70cead5b9a15afe2e6cc9f453b153e8bf3e
parent ba460e48064edeb57e3398eb8972c58de33f11ea
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 14 Jul 2005 15:15:39 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 14 Jul 2005 15:15:39 -0500

    JFS: Remove bogus WARN_ON statement and some dead code
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

