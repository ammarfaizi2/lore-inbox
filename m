Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVGMOl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVGMOl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVGMOl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:41:59 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:5527 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262653AbVGMOl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:41:56 -0400
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050713144149.6E10282C74@kleikamp.dyn.webahead.ibm.com>
Date: Wed, 13 Jul 2005 09:41:49 -0500 (CDT)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git/HEAD-for-linus

This will update the following files:

 fs/jfs/jfs_dmap.c    |  298 +-------------------------------------------
 fs/jfs/jfs_dtree.c   |  199 -----------------------------
 fs/jfs/jfs_dtree.h   |    7 -
 fs/jfs/jfs_imap.c    |  105 ---------------
 fs/jfs/jfs_unicode.c |    7 -
 fs/jfs/jfs_xtree.c   |  340 ---------------------------------------------------
 fs/jfs/jfs_xtree.h   |    6 
 fs/jfs/xattr.c       |    6 
 8 files changed, 15 insertions(+), 953 deletions(-)

through these ChangeSets:

commit 59192ed9e7aa81b06a1803661419f7261afca1ad
tree 31f592365ad2ecf5eb606de10290da502fc7eb74
parent 6211502d7ee9e515e4458d0c0ebfbb70553dc7de
author Ian Dall <ian@beware.dropbear.id.au> Wed, 13 Jul 2005 09:15:18 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 13 Jul 2005 09:15:18 -0500

    JFS: Need to be root to create files with security context
    
    It turns out this is due to some inverted logic in xattr.c
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 6211502d7ee9e515e4458d0c0ebfbb70553dc7de
tree 24ab6b567f793f8dd1c1e3458769290df2bf8f52
parent f7f24758ac98a506770bc5910d33567610fa3403
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 13 Jul 2005 09:07:53 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 13 Jul 2005 09:07:53 -0500

    JFS: Allow security.* xattrs to be set on symlinks
    
    All of the different xattr namespaces have different rules.
    user.* and ACL's are not allowed on symlinks, and since these were the
    first xattrs implemented, I assumed there was no need to support xattrs
    on symlinks.  This one-line patch should fix it.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit f7f24758ac98a506770bc5910d33567610fa3403
tree ff7fad3d01bf9dc2e2e54b908f9fca4891e1ee72
parent b38a3ab3d1bb0dc3288f73903d4dc4672b5cd2d0
parent c32511e2718618f0b53479eb36e07439aa363a74
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 13 Jul 2005 08:57:38 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 13 Jul 2005 08:57:38 -0500

    Merge with /home/shaggy/git/linus-clean/
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit b38a3ab3d1bb0dc3288f73903d4dc4672b5cd2d0
tree 31d017dd1f9f4a8ca3e80d25d110c64ae82d4aae
parent f5f287738bddf38ec9ca79344f00dab675e1bbf5
author Dave Kleikamp <shaggy@austin.ibm.com> Mon, 27 Jun 2005 15:35:37 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Mon, 27 Jun 2005 15:35:37 -0500

    JFS: Code cleanup - getting rid of never-used debug code
    
    I'm finally getting around to cleaning out debug code that I've never used.
    There has always been code ifdef'ed out by _JFS_DEBUG_DMAP, _JFS_DEBUG_IMAP,
    _JFS_DEBUG_DTREE, and _JFS_DEBUG_XTREE, which I have personally never used,
    and I doubt that anyone has since the design stage back in OS/2.  There is
    also a function, xtGather, that has never been used, and I don't know why it
    was ever there.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit f5f287738bddf38ec9ca79344f00dab675e1bbf5
tree c8144a3906f6904f7cf18c4520976c79a1e15b0a
parent a8ad86f2dc46356f87be1327dabc18bdbda32f50
author Sonny Rao <sonny@burdell.org> Thu, 23 Jun 2005 16:57:56 -0500
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 23 Jun 2005 16:57:56 -0500

    JFS: performance patch
    
    Basically, we saw a large amount of time spent in the
    jfs_strfromUCS_le() function, mispredicting the branch inside the
    loop, so I just added some unlikely modifiers to the if statements to
    re-ordered the code.  Again, these simple changes provided > 2 % on
    spec-sfs, so please consider it for inclusion.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

