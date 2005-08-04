Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262699AbVHDVJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262699AbVHDVJt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVHDVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:09:40 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:18134 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262699AbVHDVH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:07:28 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050804210724.9BA1883FA2@kleikamp.dyn.webahead.ibm.com>
Date: Thu,  4 Aug 2005 16:07:24 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, if there is still time to get this into 2.6.13, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

I'm experimenting with a sparse git tree, so if it fails, that's probably why.
I was able to pull from it, so I expect it to work.

This will update the following files:

 fs/jfs/inode.c      |    4 ++++
 fs/jfs/jfs_logmgr.c |   36 +++++++++++++++++++-----------------
 fs/jfs/jfs_logmgr.h |    2 +-
 fs/jfs/jfs_txnmgr.c |   10 +++++-----
 fs/jfs/super.c      |    2 +-
 5 files changed, 30 insertions(+), 24 deletions(-)

through these ChangeSets:

commit a5c96cab8f3c4ca9b2177dceb5de5a0edb31418e
tree 45692a1b3d770f721f4586ad81c206f1b8509b75
parent 30db1ae8640d3527ca7ac8df4bcbf14ccc6ae9cd
parent 1c5ad84516ae7ea4ec868436a910a6bd8d20215a
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 04 Aug 2005 15:56:15 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 04 Aug 2005 15:56:15 -0500

    Merge with /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 30db1ae8640d3527ca7ac8df4bcbf14ccc6ae9cd
tree f42fc0f8fc07dcd0c2cc15aa31566a321a8f2a30
parent da28c12089dfcfb8695b6b555cdb8e03dda2b690
author Dave Kleikamp <shaggy@austin.ibm.com> Mon, 01 Aug 2005 16:54:26 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 01 Aug 2005 16:54:26 -0500

    JFS: Check for invalid inodes in jfs_delete_inode
    
    Some error paths may iput an invalid inode with i_nlink=0.  jfs should
    not try to actually delete such an inode.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit da28c12089dfcfb8695b6b555cdb8e03dda2b690
tree b3ff509f21352ef053cb3d490cb13528090d32ac
parent 6de7dc2c4c713d037c19aa1e310d240f16973414
parent 577a4f8102d54b504cb22eb021b89e957e8df18f
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 28 Jul 2005 09:03:36 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 28 Jul 2005 09:03:36 -0500

    Merge with /home/shaggy/git/linus-clean/
    /home/shaggy/git/linus-clean/
    /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 6de7dc2c4c713d037c19aa1e310d240f16973414
tree 68963db8081e6ef18affd06cf2e9b00578ef874e
parent cbc3d65ebcb0c494183d45cf202a53352cbf3871
parent 9e566d8bd61f939b7f5d7d969f5b178571471cf9
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 27 Jul 2005 12:50:08 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 27 Jul 2005 12:50:08 -0500

    Merge with /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit cbc3d65ebcb0c494183d45cf202a53352cbf3871
tree 4f05bef55fd76ddd7668187e84e7fbc16a4849f6
parent de8fd087b280797977b012a4275ee53ff2999f3f
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 27 Jul 2005 09:17:57 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 27 Jul 2005 09:17:57 -0500

    JFS: Improve sync barrier processing
    
    Under heavy load, hot metadata pages are often locked by non-committed
    transactions, making them difficult to flush to disk.  This prevents
    the sync point from advancing past a transaction that had modified the
    page.
    
    There is a point during the sync barrier processing where all
    outstanding transactions have been committed to disk, but no new
    transaction have been allowed to proceed.  This is the best time
    to write the metadata.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit de8fd087b280797977b012a4275ee53ff2999f3f
tree 5cd65289983ad65812a6a4335fe657eeb125a7f0
parent 18190cc08d70a6ec8ef69f0f6ede021f7cb3f9b8
parent 6b6a93c6876ea1c530d5d3f68e3678093a27fab0
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 26 Jul 2005 09:55:10 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 26 Jul 2005 09:55:10 -0500

    Merge with /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

