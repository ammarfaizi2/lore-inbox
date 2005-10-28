Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751663AbVJ1TMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbVJ1TMz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbVJ1TMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 15:12:55 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:56272 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751662AbVJ1TMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 15:12:54 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051028191251.4955C82BEA@kleikamp.dyn.webahead.ibm.com>
Date: Fri, 28 Oct 2005 14:12:51 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/jfs_dmap.c     |   20 ++++++++++++++------
 fs/jfs/jfs_imap.c     |   10 ++++++++--
 fs/jfs/jfs_metapage.c |    6 ++++++
 fs/jfs/jfs_txnmgr.c   |    2 --
 fs/jfs/jfs_xtree.c    |   18 +++++++++---------
 fs/jfs/super.c        |    1 +
 6 files changed, 38 insertions(+), 19 deletions(-)

through these ChangeSets:

commit 7038f1cbac899654cf0515e60dbe3e44d58271de
tree 73909f95989f10bd85929073395e494ceb1a6b3f
parent b6a47fd8ff08a9d5cd279cdb8d97a619983575fa
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 28 Oct 2005 13:27:40 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 28 Oct 2005 13:27:40 -0500

    JFS: make sure right-most xtree pages have header.next set to zero
    
    The xtTruncate code was only doing this for leaf pages.  When a file is
    horribly fragmented, we may truncate a file leaving an internal page with
    an invalid head.next field, which may cause a stale page to be referenced.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit b6a47fd8ff08a9d5cd279cdb8d97a619983575fa
tree 5e946b5a7c3f224d181525ca475fd3f29508c47d
parent ac17b8b57013a3e38d1958f66a218f15659e5752
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 11 Oct 2005 09:06:59 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 11 Oct 2005 09:06:59 -0500

    JFS: Corrupted block map should not cause trap
    
    Replace assert statements with better error handling.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit ac17b8b57013a3e38d1958f66a218f15659e5752
tree f7a28ccd5bd5496f6a2284f3d77a5019dc75c820
parent ddea7be0ec8d1374f0b483a81566ed56ec9f3905
author Dave Kleikamp <shaggy@austin.ibm.com> Mon, 03 Oct 2005 15:32:11 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 03 Oct 2005 15:32:11 -0500

    JFS: make special inodes play nicely with page balancing
    
    This patch fixes up a few problems with jfs's reserved inodes.
    
    1. There is no need for the jfs code setting the I_DIRTY bits in i_state.
    I am ashamed that the code ever did this, and surprised it hasn't been
    noticed until now.
    
    2. Make sure special inodes are on an inode hash list.  If the inodes are
    unhashed, __mark_inode_dirty will fail to put the inode on the
    superblock's dirty list, and the data will not be flushed under memory
    pressure.
    
    3. Force writing journal data to disk when metapage_writepage is unable to
    write a metadata page due to pending journal I/O.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

