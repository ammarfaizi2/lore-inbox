Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267619AbUHWKZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267619AbUHWKZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 06:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267635AbUHWKZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 06:25:30 -0400
Received: from ppsw-8.csi.cam.ac.uk ([131.111.8.138]:8686 "EHLO
	ppsw-8.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S267619AbUHWKZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:25:19 -0400
Date: Mon, 23 Aug 2004 11:25:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [2.6-BK-URL] NTFS 2.1.17 release
Message-ID: <Pine.LNX.4.60.0408231055290.24220@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This is quite a big update and all of it has been in -mm kernels for a 
while.  I have been holding off until 2.6.8 had been released before 
submitting so any problems would have time to get to me.  I haven't had 
any problem reports so here it is.  The most important points are that 
NTFS now provides most of the facilities provided by other Linux fs, e.g.:
	- fsync/fdatasync/msync
	- access {a/m/c}time updates
	- readv/writev
	- aio_read/aio_write
Also several bugs in the mount code error paths were fixed and a global 
variable got eliminated as a result.  See below for details ChangeSet 
comemnts.

Please apply.  Thanks!

For the benefit of non-BK users and to make code review easier, I am
sending each ChangeSet in a separate email as a diff -u style patch.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

This will update the following files:

 Documentation/filesystems/ntfs.txt |   22 
 fs/ntfs/ChangeLog                  |   70 +-
 fs/ntfs/Makefile                   |   12 
 fs/ntfs/aops.c                     |   78 +-
 fs/ntfs/attrib.c                   |  539 +++++++++++--------
 fs/ntfs/attrib.h                   |   20 
 fs/ntfs/bitmap.c                   |  203 ++++++-
 fs/ntfs/bitmap.h                   |  118 ++++
 fs/ntfs/compress.c                 |   34 -
 fs/ntfs/debug.c                    |   17 
 fs/ntfs/debug.h                    |    2 
 fs/ntfs/dir.c                      |   61 ++
 fs/ntfs/file.c                     |  105 +++
 fs/ntfs/inode.c                    |  140 +++-
 fs/ntfs/inode.h                    |   15 
 fs/ntfs/layout.h                   |   14 
 fs/ntfs/lcnalloc.c                 | 1043 ++++++++++++++++++++++++++++++++++++-
 fs/ntfs/lcnalloc.h                 |   83 ++
 fs/ntfs/ntfs.h                     |    1 
 fs/ntfs/super.c                    |  298 +++++++---
 fs/ntfs/types.h                    |   12 
 fs/ntfs/volume.h                   |   15 
 22 files changed, 2368 insertions(+), 534 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/07/07 1.1784.14.1)
   NTFS: Add support for readv/writev and aio_read/aio_write.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/08 1.1784.14.2)
   NTFS: Change ntfs_write_inode to return 0 on success and -errno on error
         and create a wrapper ntfs_write_inode_vfs that does not have a
         return value and use the wrapper for the VFS super_operations
         write_inode function.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/08 1.1784.14.3)
   NTFS: Implement fsync, fdatasync, and msync both for files (fs/ntfs/file.c)
         and directories (fs/ntfs/dir.c).
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/14 1.1784.3.21)
   NTFS: 2.1.16 - Implement access time updates in fs/ntfs/inode.c::ntfs_write_inode.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/21 1.1808)
   NTFS: Implement bitmap modification code (fs/ntfs/bitmap.[hc]).  This
         includes functions to set/clear a single bit or a run of bits.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/21 1.1809)
   NTFS: Wrap the new bitmap.[hc] code in #ifdef NTFS_RW / #endif.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/21 1.1810)
   NTFS: Rename run_list to runlist everywhere to bring in line with libntfs.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/21 1.1811)
   NTFS: Rename map_runlist() to ntfs_map_runlist().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/21 1.1812)
   NTFS: Rename vcn_to_lcn() to ntfs_vcn_to_lcn().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/22 1.1813)
   NTFS: Complete "run list" to "runlist" renaming.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/22 1.1814)
   NTFS: Move a NULL check to before the first use of the pointer.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/22 1.1815)
   NTFS: Add fs/ntfs/attrib.[hc]::ntfs_find_vcn().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/07/30 1.1816)
   NTFS: Fix compilation with gcc-2.95 in attrib.c::ntfs_find_vcn().  (Adrian Bunk)
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
   Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

<aia21@cantab.net> (04/08/16 1.1820)
   NTFS: Implement cluster (de-)allocation code (fs/ntfs/lcnalloc.[hc]).
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/17 1.1821)
   NTFS: Minor update to fs/ntfs/bitmap.c to only perform rollback if at
   least one bit has actually been changed.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/17 1.1822)
   NTFS: Fix fs/ntfs/lcnalloc.c::ntfs_cluster_alloc() to use LCN_RL_NOT_MAPPED
   rather than LCN_ENOENT as runlist terminator.  Also, make it not create a
   LCN_RL_NOT_MAPPED element at the beginning.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/17 1.1823)
   NTFS: Fix fs/ntfs/debug.c::ntfs_debug_dump_runlist() for the previous
   removal of LCN_EINVAL which was not used in the kernel NTFS driver.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/17 1.1824)
   NTFS: Only need two spare runlist elements when reallocating memory in
   fs/ntfs/lcnalloc.c::ntfs_cluster_alloc(), not three since we no longer
   add a starting element.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/18 1.1825)
   NTFS: - Load attribute definition table from $AttrDef at mount time.
         - Fix bugs in mount time error code paths involving (de)allocation of
           the default and volume upcase tables.
         - Remove ntfs_nr_mounts as it is no longer used.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/08/18 1.1826)
   NTFS: 2.1.17 - Fix bugs in mount time error code paths.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
