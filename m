Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265808AbUEZVQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265808AbUEZVQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 17:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265809AbUEZVQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 17:16:31 -0400
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:15511 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S265808AbUEZVQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 17:16:29 -0400
Date: Wed, 26 May 2004 22:16:28 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.7-rc1-bk] NTFS: 2.1.12 release - Fix the second fix to the
 decompression engine and some cleanups.
Message-ID: <Pine.SOL.4.58.0405262214280.15648@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This will update the following files:

 Documentation/filesystems/ntfs.txt |    3
 fs/ntfs/ChangeLog                  |   18 ++++
 fs/ntfs/Makefile                   |    4 -
 fs/ntfs/aops.c                     |    9 ++
 fs/ntfs/compress.c                 |   20 +----
 fs/ntfs/dir.c                      |    2
 fs/ntfs/inode.c                    |  134 ++++++++++++++++++++++++-------------
 fs/ntfs/inode.h                    |    9 ++
 fs/ntfs/ntfs.h                     |    1
 fs/ntfs/super.c                    |    4 -
 10 files changed, 140 insertions(+), 64 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/05/17 1.1717.9.1)
   NTFS: Add a new address space operations struct, ntfs_mst_aops, for mst
         protected attributes.  This is because the default ntfs_aops do not
         make sense with mst protected data and were they to write anything to
         such an attribute they would cause data corruption so we provide
         ntfs_mst_aops which does not have any write related operations set.

<aia21@cantab.net> (04/05/25 1.1731)
   NTFS: Cleanup dirty ntfs inode handling (fs/ntfs/inode.[hc]) which also
         includes an adapted ntfs_commit_inode() and an implementation of
         ntfs_write_inode() which for now just cleans dirty inodes without
         writing them (it does emit a warning that this is happening).

<aia21@cantab.net> (04/05/26 1.1733)
   NTFS: 2.1.12 release - Fix the second fix to the decompression engine.

For the benefit of non-BK users and to make code review easier, I am
sending each ChangeSet in a separate email as a diff -u style patch.

Thanks!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/
