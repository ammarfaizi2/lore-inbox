Return-Path: <linux-kernel-owner+w=401wt.eu-S1030533AbXAHEWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030533AbXAHEWS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 23:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbXAHET0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 23:19:26 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:50459 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030529AbXAHETT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 23:19:19 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, akpm@osdl.org, mhalcrow@us.ibm.com
Subject: [PATCH 00/24] Unionfs, try #4
Date: Sun,  7 Jan 2007 23:12:52 -0500
Message-Id: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The have been no real significant changes since the previous submission (see
end of this email for detailed changelog).

We believe that the code is stable enough to warrant inclusion into -mm.

As before, there is a git repo at:

git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/unionfs.git

(master.kernel.org:/pub/scm/linux/kernel/git/jsipek/unionfs.git)

The repository contains 24 commits (also available as patches in replies to
this email):

      Unionfs: Documentation
      lookup_one_len_nd - lookup_one_len with nameidata argument
      Unionfs: Branch management functionality
      Unionfs: Common file operations
      Unionfs: Copyup Functionality
      Unionfs: Dentry operations
      Unionfs: File operations
      Unionfs: Directory file operations
      Unionfs: Directory manipulation helper functions
      Unionfs: Inode operations
      Unionfs: Lookup helper functions
      Unionfs: Main module functions
      Unionfs: Readdir state
      Unionfs: Rename
      Unionfs: Privileged operations workqueue
      Unionfs: Handling of stale inodes
      Unionfs: Miscellaneous helper functions
      Unionfs: Superblock operations
      Unionfs: Helper macros/inlines
      Unionfs: Internal include file
      Unionfs: Include file
      Unionfs: Unlink
      Unionfs: Kconfig and Makefile
      Unionfs: Extended Attributes support


Thanks,

Josef 'Jeff' Sipek <jsipek@cs.sunysb.edu> on behalf of the Unionfs team.


Changes since try #3:

- Renamed several functions: more consistent and less likely to cause
	namespace collisions (Jan Engelhardt)
- Moved Unionfs magic to include/linux/ (Jan Engelhardt)
- Misc coding style cleanup (Jan Engelhardt)

Changes since try #2:

- Added more comments (akpm)
- Cleaned up inode/dentry/file/sb private data structure member names
- Moved struct inode from unionfs_inode_container into unionfs_inode_info
        (following ext2's example)
- Renamed {d,i,f,s}topd to UNIONFS_{D,I,F,S} (following almost any fs's
        example)
- Removed *_ptr and *_lhs macros, open-coding the assignments (Pekka Enberg)
- Kill wrappers (e.g., unionfs_kill_block_super) (Pekka Enberg)
- Few tiny coding style fixes
- Removed some unnecessary complexity (no need to pass struct file and a
        struct dentry for that file to a function - just pass a struct file
        and dereference in the function, etc.)
- Removed some unnecessary checks (if (foo) kfree(foo); is completely
        redundant as kfree has a null check)
- Changed C++-style comments to C-style comments (Pekka Enberg)
- Use struct kmem_cache instead of kmem_cache_t (Pekka Enberg)
- Use anonymous unions for sioq (Jan Engelhardt)
- Moved some functionality into fsstack (most of it is in -mm already)

Changes since try #1:

- unionfs_lookup must pass lookup intents to the lower filesystem (Trond
	Myklebust)
- patches reordered (Stephen Rothwell)
- numerous style comments by Jan Engelhardt

