Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263012AbSJBJHP>; Wed, 2 Oct 2002 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263013AbSJBJHP>; Wed, 2 Oct 2002 05:07:15 -0400
Received: from thunk.org ([140.239.227.29]:62648 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S263012AbSJBJHO>;
	Wed, 2 Oct 2002 05:07:14 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] Add ext3 indexed directory (htree) support
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E17wfXz-0000CK-00@think.thunk.org>
Date: Wed, 02 Oct 2002 05:11:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	I believe the ext3 indexed directory (htree) patches are ready
for integration into the 2.5 tree at this point.  Please pull them from:

        bk://extfs.bkbits.net/for-linus-htree-2.5 

Patches against 2.5.40 and 2.4.19 are available from:

	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.5.40
and
	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.4.19-4

This patch significantly increases the speed of using large directories
in ext3, in a completely backwards and forwards compatible
fashion.  Creating 100,000 files in a single directory took 38 minutes
without directory indexing... and 11 seconds with the directory indexing
turned on.

Since the last time I've submitted this changeset to you, it's received
additional testing from the LKML list, and we've fixed few bugs in both
the kernel code and in e2fsprogs (please use e2fsprogs 1.30-WIP-0930
from sourceforge).  In addition, the code paths are essentially
unchanged if the directory indexing filesystem feature flag is disabled.
Hence, this is a low risk patch to apply.  

As before, existing filesystems can be updated to use directory indexing
by using the command "tune2fs -O dir_index /dev/hdXXX", and existing
large directories can be indexed by using the command "e2fsck -fD
/dev/hdXXX".

						- Ted


 fs/ext3/Makefile           |    2 
 fs/ext3/dir.c              |  299 +++++++++-
 fs/ext3/file.c             |    3 
 fs/ext3/hash.c             |  215 +++++++
 fs/ext3/namei.c            | 1333 ++++++++++++++++++++++++++++++++++++++++-----
 fs/ext3/super.c            |    6 
 include/linux/ext3_fs.h    |   86 ++
 include/linux/ext3_fs_sb.h |    2 
 include/linux/ext3_jbd.h   |    2 
 include/linux/rbtree.h     |    1 
 lib/rbtree.c               |   16 
 11 files changed, 1827 insertions(+), 138 deletions(-)
