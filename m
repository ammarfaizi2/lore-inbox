Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965300AbWCTO5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965300AbWCTO5T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 09:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964959AbWCTO5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 09:57:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31658 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965300AbWCTO5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 09:57:19 -0500
To: torvalds@osdl.org
Subject: [git pull] jfs update
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060320145716.70DEA8318F@kleikamp.dyn.webahead.ibm.com>
Date: Mon, 20 Mar 2006 08:57:16 -0600 (CST)
From: shaggy@austin.ibm.com (Dave Kleikamp)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I guess the flood gates are open for 2.6.17.  :-)

Please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/shaggy/jfs-2.6.git for-linus

This will update the following files:

 fs/jfs/Makefile         |    3 -
 fs/jfs/acl.c            |    7 +-
 fs/jfs/file.c           |    1 
 fs/jfs/inode.c          |   15 ++---
 fs/jfs/ioctl.c          |  107 ++++++++++++++++++++++++++++++++++++++
 fs/jfs/jfs_dinode.h     |   31 +++++++++--
 fs/jfs/jfs_dmap.c       |    8 +-
 fs/jfs/jfs_dmap.h       |    2 
 fs/jfs/jfs_dtree.c      |   13 ++++
 fs/jfs/jfs_extent.c     |   20 +++----
 fs/jfs/jfs_imap.c       |   72 +++++++++++++++++++------
 fs/jfs/jfs_imap.h       |    4 -
 fs/jfs/jfs_incore.h     |   10 ++-
 fs/jfs/jfs_inode.c      |   46 ++++++++++++++--
 fs/jfs/jfs_inode.h      |    3 +
 fs/jfs/jfs_lock.h       |    1 
 fs/jfs/jfs_logmgr.c     |   35 ++++--------
 fs/jfs/jfs_logmgr.h     |    2 
 fs/jfs/jfs_metapage.c   |    3 -
 fs/jfs/jfs_superblock.h |    9 +--
 fs/jfs/jfs_txnmgr.c     |   36 ++++--------
 fs/jfs/namei.c          |   99 +++++++++++++++++------------------
 fs/jfs/super.c          |   98 ++++++++++++++++++++--------------
 fs/jfs/xattr.c          |    8 +-
 24 files changed, 429 insertions(+), 204 deletions(-)

through these ChangeSets:

commit c5111f504d2a9b0d258d7c4752b4093523315989 
tree 6a52864aff79691689aea21cb0cb928327d5de5b 
parent 69eb66d7da7dba2696281981347698e1693c2340 
parent a488edc914aa1d766a4e2c982b5ae03d5657ec1b 
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 14 Mar 2006 17:05:45 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 14 Mar 2006 17:05:45 -0600 

    Merge with /home/shaggy/git/linus-clean/

commit 69eb66d7da7dba2696281981347698e1693c2340 
tree ba699dc7a1a80efe159f4a4401b174a7e80779fc 
parent be0bf7da19135a7a0f8c275f20c819940be218d9 
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 09 Mar 2006 13:59:30 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 09 Mar 2006 13:59:30 -0600 

    JFS: add uid, gid, and umask mount options
    
    OS/2 doesn't initialize the uid, gid, or unix-style permission bits.  The
    uid, gid, & umask mount options perform pretty much like those for the fat
    file system, overriding what is stored on disk.  This is useful for users
    sharing the file system with OS/2.
    
    I implemented a little feature so that if you mask the execute bit, it
    will be re-enabled on directories when the appropriate read bit is unmasked.
    I didn't want to implement an fmask & dmask option.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit be0bf7da19135a7a0f8c275f20c819940be218d9 
tree c8ba72b711730ce11f52fc20cd7c0e9c4bee7bc0 
parent 5b3030e39049212c975665cdb3eeabcfaf7c94ca 
author Dave Kleikamp <shaggy@austin.ibm.com> Wed, 08 Mar 2006 10:59:15 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 08 Mar 2006 10:59:15 -0600 

    JFS: Take logsync lock before testing mp->lsn
    
    This fixes a race where lsn could be cleared before taking the lock
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 5b3030e39049212c975665cdb3eeabcfaf7c94ca 
tree 93742231c2e01087ae36d7c05d8bd7bdb7ca8878 
parent d9e902668e815f9f33ba5056089684b0704eeac6 
author Eric Sesterhenn <snakebyte@gmx.de> Thu, 23 Feb 2006 09:47:13 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 23 Feb 2006 09:47:13 -0600 

    JFS: kzalloc conversion
    
    this converts fs/jfs to kzalloc() usage.
    compile tested with make allyesconfig
    
    Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit d9e902668e815f9f33ba5056089684b0704eeac6 
tree a2efed26b40b36f38e155955d661f776759a42dc 
parent 91dbb4deb30e817efc8d6bed89b1190a489ca776 
author Herbert Poetzl <herbert@13thfloor.at> Wed, 22 Feb 2006 14:14:58 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 22 Feb 2006 14:14:58 -0600 

    JFS: Add missing file from fa3241d24cf1182b0ffb6e4d412c3bc2a2ab7bf6
    
    My mistake here.  I failed to checkin fs/jfs/ioctl.c
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 91dbb4deb30e817efc8d6bed89b1190a489ca776 
tree d3742a35be49da1ab785ac398459d7a71a64a765 
parent 4837c672fd4d43c519d6b53308ee68d45b91b872 
author Christoph Hellwig <hch@lst.de> Wed, 15 Feb 2006 12:49:04 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Wed, 15 Feb 2006 12:49:04 -0600 

    JFS: Use the kthread_ API
    
    Use the kthread_ API instead of opencoding lots of hairy code for kernel
    thread creation and teardown.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 4837c672fd4d43c519d6b53308ee68d45b91b872 
tree 6aea45f6de8a7320be022ccf5e4c98ddfcf3ea33 
parent fa3241d24cf1182b0ffb6e4d412c3bc2a2ab7bf6 
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 10 Feb 2006 08:11:53 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 10 Feb 2006 08:11:53 -0600 

    JFS: Fix regression.  fsck complains if symlinks do not have INLINEEA attribute
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit fa3241d24cf1182b0ffb6e4d412c3bc2a2ab7bf6 
tree b39000f89c6699612d64d98fd5739ca7feba8d8f 
parent 1de87444f8f91009b726108c9a56600645ee8751 
author Herbert Poetzl <herbert@13thfloor.at> Thu, 09 Feb 2006 09:09:16 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 09 Feb 2006 09:09:16 -0600 

    JFS: ext2 inode attributes for jfs
    
    ext2 inode attributes with relevance for jfs:
    
    'a' 	EXT2_APPEND_FL       -> append only
    'i' 	EXT2_IMMUTABLE_FL    -> immutable file
    's' 	EXT2_SECRM_FL	     -> zero file
    'u' 	EXT2_UNRM_FL	     -> allow for unrm
    'A' 	EXT2_NOATIME_FL      -> no access time
    'D' 	EXT2_DIRSYNC_FL      -> dirsync
    'S' 	EXT2_SYNC_FL	     -> sync
    
    overview of jfs flags (partially for OS/2)
    
    value	   (OS/2)	Linux	ext2 attrs
    ------------------------------------------------
    0x00010000 IFJOURNAL	-
    0x00020000 ISPARSE  	used
    0x00040000 INLINEEA 	used
    0x00080000 -	    	-	JFS_NOATIME_FL
    
    0x00100000 -	    	-	JFS_DIRSYNC_FL
    0x00200000 -	    	-	JFS_SYNC_FL
    0x00400000 -	    	-	JFS_SECRM_FL
    0x00800000 ISWAPFILE	-	JFS_UNRM_FL
    
    0x01000000 -	    	-	JFS_APPEND_FL
    0x02000000 IREADONLY	-	JFS_IMMUTABLE_FL
    0x04000000 IHIDDEN  	-	-
    0x08000000 ISYSTEM  	-	-
    
    0x10000000 -	    	-
    0x20000000 IDIRECTORY	used
    0x40000000 IARCHIVE 	-
    0x80000000 INEWNAME 	-
    
    the implementation is straight forward, except
    for the fact that the attributes have to be mapped
    to match with the ext2 ones to avoid a separate
    tool for manipulating them (this could be avoided
    when using a separate flag field in the on-disk
    representation, but the overhead is minimal)
    
    a special jfs_ioctl is added to allow for the new
    JFS_IOC_GETFLAGS and JFS_IOC_SETFLAGS calls.
    
    a helper function jfs_set_inode_flags() to transfer
    the flags from the on-disk version to the inode
    
    minor changes to allow flag inheritance on inode
    creation, as well as a cleanup of the on-disk
    flags (including the new ones)
    
    beforementioned helper to map between ext2 and jfs
    versions of the new flags ...
    
    the JFS_SECRM_FL and JFS_UNRM_FL are not done yet
    and I'm not 100% sure they are worth the effort,
    the rest seems to work out of the box ...
    
    Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 1de87444f8f91009b726108c9a56600645ee8751 
tree 66f731a701a005be55337792bf873c182470141a 
parent 0a0fc0ddbe732779366ab6b1b879f62195e65967 
author Ingo Molnar <mingo@elte.hu> Tue, 24 Jan 2006 15:22:50 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 24 Jan 2006 15:22:50 -0600 

    JFS: semaphore to mutex conversion.
    
    the conversion was generated via scripts, and the result was validated
    automatically via a script as well.
    
    build and boot tested.
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit 0a0fc0ddbe732779366ab6b1b879f62195e65967 
tree 7b42490a676cf39ae0691b6859ecf7fd410f229b 
parent 4d5dbd0945d9e0833dd7964a3d6ee33157f7cc7a 
parent 3ee68c4af3fd7228c1be63254b9f884614f9ebb2 
author Dave Kleikamp <shaggy@austin.ibm.com> Tue, 24 Jan 2006 14:34:47 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 24 Jan 2006 14:34:47 -0600 

    Merge with /home/shaggy/git/linus-clean/

commit 4d5dbd0945d9e0833dd7964a3d6ee33157f7cc7a 
tree 139d47bcbfbbca350536be935961fece7477a7b6 
parent ca869912366f60cb5e0bdd09f65e80ee6816e73c 
author Arjan van de Ven <arjan@infradead.org> Tue, 29 Nov 2005 08:28:58 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Tue, 29 Nov 2005 08:28:58 -0600 

    JFS: make buddy table static
    
    Idea is to reduce false cacheline sharing and stuff
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

commit ca869912366f60cb5e0bdd09f65e80ee6816e73c 
tree a72913a29495ca078987c09fc0008f47e11b900b 
parent dd8a306ac0c918268bd2ae89da2dea627f6e352d 
parent 388f7ef720a982f49925e7b4e96f216f208f8c03 
author Dave Kleikamp <shaggy@austin.ibm.com> Fri, 11 Nov 2005 14:09:06 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Fri, 11 Nov 2005 14:09:06 -0600 

    Merge with /home/shaggy/git/linus-clean/

commit dd8a306ac0c918268bd2ae89da2dea627f6e352d 
tree e3f2c244505931d93b09f7d314014cf3832b0176 
parent 3b44f137b9a846c5452d9e6e1271b79b1dbcc942 
author Dave Kleikamp <shaggy@austin.ibm.com> Thu, 10 Nov 2005 07:50:03 -0600 
committer Dave Kleikamp <shaggy@austin.ibm.com> Thu, 10 Nov 2005 07:50:03 -0600 

    JFS: Add back directory i_size calculations for legacy partitions
    
    Linux-formatted jfs partitions have a different idea about what i_size
    represents than partitions formatted on OS/2.  The i_size calculation is
    now based on the size of the directory index.  For legacy partitions, which
    have no directory index, the i_size is never being updated.
    
    This patch adds back the original i_size calculations for legacy partitions.
    
    Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

