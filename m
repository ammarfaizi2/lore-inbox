Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUJSJio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUJSJio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268108AbUJSJio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:38:44 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:21205 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S268101AbUJSJi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:38:27 -0400
Date: Tue, 19 Oct 2004 10:37:30 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK-URL] NTFS: 2.1.21 - Big update with race/bug fixes
Message-ID: <Pine.LNX.4.60.0410191017070.24986@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please do a

	bk pull bk://linux-ntfs.bkbits.net/ntfs-2.6

This is a rather big NTFS update that has been in the working whilst 
waiting for 2.6.9 to be released.  Large chunks of that have been in 
various -mm kernels allready.  It fixes some race conditions and other 
bugs as well as rewriting the inode writeout code and adding inode 
allocation/deallocation functionality (but not file creation/deletion!).

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

 Documentation/filesystems/ntfs.txt |  177 ++
 fs/ntfs/ChangeLog                  |  130 +
 fs/ntfs/Makefile                   |    8 
 fs/ntfs/aops.c                     |  433 ++++--
 fs/ntfs/aops.h                     |  108 +
 fs/ntfs/attrib.c                   | 1180 ++--------------
 fs/ntfs/attrib.h                   |   26 
 fs/ntfs/bitmap.c                   |    1 
 fs/ntfs/collate.c                  |    3 
 fs/ntfs/compress.c                 |    9 
 fs/ntfs/debug.h                    |    6 
 fs/ntfs/dir.c                      |   14 
 fs/ntfs/dir.h                      |    2 
 fs/ntfs/file.c                     |    5 
 fs/ntfs/index.c                    |   59 
 fs/ntfs/index.h                    |   10 
 fs/ntfs/inode.c                    |  152 +-
 fs/ntfs/inode.h                    |   19 
 fs/ntfs/layout.h                   |   85 +
 fs/ntfs/lcnalloc.c                 |    9 
 fs/ntfs/lcnalloc.h                 |   29 
 fs/ntfs/logfile.c                  |   67 
 fs/ntfs/malloc.h                   |    1 
 fs/ntfs/mft.c                      | 2637 +++++++++++++++++++++++++++++--------
 fs/ntfs/mft.h                      |   17 
 fs/ntfs/namei.c                    |    7 
 fs/ntfs/ntfs.h                     |   78 -
 fs/ntfs/quota.c                    |    3 
 fs/ntfs/runlist.c                  | 1512 ++++++++++++++++++++-
 fs/ntfs/runlist.h                  |   95 +
 fs/ntfs/super.c                    |   26 
 fs/ntfs/types.h                    |   28 
 fs/ntfs/unistr.c                   |    2 
 fs/ntfs/upcase.c                   |    1 
 fs/ntfs/volume.h                   |    4 
 35 files changed, 4917 insertions(+), 2026 deletions(-)

through these ChangeSets:

<aia21@cantab.net> (04/09/29 1.1995.1.2)
   NTFS: Implement extent mft record deallocation.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2000.1.1)
   NTFS: Splitt runlist related functions off from attrib.[hc] to runlist.[hc].
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2000.1.2)
   NTFS: Add vol->mft_data_pos and initialize it at mount time.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2000.1.3)
   NTFS: Rename init_runlist() to ntfs_init_runlist(), ntfs_vcn_to_lcn() to
         ntfs_rl_vcn_to_lcn(), decompress_mapping_pairs() to
         ntfs_mapping_pairs_decompress() and adapt all callers.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2004)
   NTFS: Forgot to lock the mft bitmap when clearing the bit in
         ntfs_extent_mft_record_free().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2005)
   NTFS: Add fs/ntfs/runlist.[hc]::ntfs_get_nr_significant_bytes(),
         ntfs_get_size_for_mapping_pairs(), ntfs_write_significant_bytes(),
         and ntfs_mapping_pairs_build(), adapted from libntfs.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2005.1.1)
   NTFS: Rename ntfs_merge_runlists() to ntfs_runlists_merge().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2005.1.2)
   NTFS: - Add fs/ntfs/lcnalloc.h::ntfs_cluster_free_from_rl() which is a static
           inline wrapper for ntfs_cluster_free_from_rl_nolock() which takes the
           cluster bitmap lock for the duration of the call.
         - Make fs/ntfs/lcnalloc.c::ntfs_cluster_free_from_rl_nolock() not
           static and add a declaration for it to lcnalloc.h.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/09/30 1.2005.1.3)
   NTFS: Add fs/ntfs/attrib.[hc]::ntfs_attr_record_resize().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/01 1.2011)
   NTFS: Implement the equivalent of memset() for an ntfs attribute in
         fs/ntfs/attrib.[hc]::ntfs_attr_set() and switch
         fs/ntfs/logfile.c::ntfs_empty_logfile() to using it.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/01 1.2011.1.1)
   NTFS: Remove unnecessary casts from LCN_* constants.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/02 1.2011.1.2)
   NTFS: Implement fs/ntfs/runlist.c::ntfs_rl_truncate_nolock().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/03 1.2017)
   NTFS: Add MFT_RECORD_OLD as a copy of MFT_RECORD in fs/ntfs/layout.h
         and change MFT_RECORD to contain the NTFS 3.1+ specific fields.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/03 1.2018)
   NTFS: Add some debugging checks to fs/ntfs/inode.c::ntfs_truncate() and fix
         a typo in fs/ntfs/layout.h.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/05 1.2022.1.1)
   NTFS: Add a helper function fs/ntfs/aops.c::mark_ntfs_record_dirty() which
         marks all buffers belonging to an ntfs record dirty, followed by
         marking the page the ntfs record is in dirty and also marking the vfs
         inode containing the ntfs record dirty (I_DIRTY_PAGES).
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/05 1.2022.1.2)
   NTFS: Switch fs/ntfs/index.h::ntfs_index_entry_mark_dirty() to using the
         new helper fs/ntfs/aops.c::mark_ntfs_record_dirty() and remove the no
         longer needed fs/ntfs/index.[hc]::__ntfs_index_entry_mark_dirty().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/07 1.2029)
   NTFS: - Move ntfs_{un,}map_page() from ntfs.h to aops.h and fix resulting
           include errors.
         - Move typedefs for runlist_element and runlist from ntfs.h to
           runlist.h and fix resulting include errors.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/07 1.2030)
   NTFS: Remove unused {__,}format_mft_record() from fs/ntfs/mft.c.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/07 1.2031)
   NTFS: - Modify fs/ntfs/mft.c::__mark_mft_record_dirty() to use the helper
           mark_ntfs_record_dirty() which also changes the behaviour in that we
           now set the buffers belonging to the mft record dirty as well as the
           page itself.
         - Update fs/ntfs/mft.c::write_mft_record_nolock() and sync_mft_mirror()
           to cope with the fact that there now are dirty buffers in mft pages.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/10 1.2032.1.1)
   NTFS: Update fs/ntfs/inode.c::ntfs_write_inode() to also use the helper
         mark_ntfs_record_dirty() and thus to set the buffers belonging to the
         mft record dirty as well as the page itself.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/10 1.2032.1.2)
   NTFS: Fix warnings on x86-64.  (Randy Dunlap with slight modification from me)
   
   Fix printk arg type warnings on x86-64 (and OK on x86-32) (gcc 3.3.3):
   fs/ntfs/dir.c:1272: warning: long long unsigned int format, long unsigned int arg (arg 6)
   fs/ntfs/dir.c:1388: warning: long long unsigned int format, long unsigned int arg (arg 5
   
   Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/11 1.2041)
   NTFS: Add fs/ntfs/mft.c::try_map_mft_record() which fails with -EALREADY if
         the mft record is already locked and otherwise behaves the same way
         as fs/ntfs/mft.c::map_mft_record().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/11 1.2041.1.1)
   NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() so that it only
         writes the mft record if the buffers belonging to it are dirty.
         Otherwise we assume that it was written out by other means already.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/12 1.2041.1.2)
   NTFS: Attempting to write outside initialized size is _not_ a bug so remove
         the bug check from fs/ntfs/aops.c::ntfs_write_mst_block().  It is in
         fact required to write outside initialized size when preparing to
         extend the initialized size.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/12 1.2041.1.3)
   NTFS: Map the page instead of using page_address() before writing to it in
         fs/ntfs/aops.c::ntfs_mft_writepage().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/12 1.2041.1.4)
   NTFS: Provide exclusion between opening an inode / mapping an mft record
         and accessing the mft record in fs/ntfs/mft.c::ntfs_mft_writepage()
         by setting the page not uptodate throughout ntfs_mft_writepage().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/14 1.2046)
   NTFS: Big cleanup of mft record writing code.
   
   - Clear the page uptodate flag in fs/ntfs/aops.c::ntfs_write_mst_block()
     to ensure noone can see the page whilst the mst fixups are applied.
   - Add the helper fs/ntfs/mft.c::ntfs_may_write_mft_record() which
     checks if an mft record may be written out safely obtaining any
     necessary locks in the process.  This is used by
     fs/ntfs/aops.c::ntfs_write_mst_block().
   - Modify fs/ntfs/aops.c::ntfs_write_mst_block() to also work for
     writing mft records and improve its error handling in the process.
     Now if any of the records in the page fail to be written out, all
     other records will be written out instead of aborting completely.
   - Remove ntfs_mft_aops and update all users to use ntfs_mst_aops.
   - Modify fs/ntfs/inode.c::ntfs_read_locked_inode() to set the
     ntfs_mst_aops for all inodes which are NInoMstProtected() and
     ntfs_aops for all other inodes.
   - Rename fs/ntfs/mft.c::sync_mft_mirror{,_umount}() to
     ntfs_sync_mft_mirror{,_umount}() and change their parameters so they
     no longer require an ntfs inode to be present.  Update all callers.
   - Cleanup the error handling in fs/ntfs/mft.c::ntfs_sync_mft_mirror().
   - Clear the page uptodate flag in fs/ntfs/mft.c::ntfs_sync_mft_mirror()
     to ensure noone can see the page whilst the mst fixups are applied.
   - Remove the no longer needed fs/ntfs/mft.c::ntfs_mft_writepage() and
     fs/ntfs/mft.c::try_map_mft_record().
   - Fix callers of fs/ntfs/aops.c::mark_ntfs_record_dirty() to call it
     with the ntfs inode which contains the page rather than the ntfs
     inode the mft record of which is in the page.
   
   Ooops.  Yes, I know, I should have split this up into smaller changes...
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/14 1.2047)
   NTFS: - Fix two race conditions in fs/ntfs/inode.c::ntfs_put_inode().
   
   - Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by moving the
     index inode bitmap inode release code from there to
     fs/ntfs/inode.c::ntfs_clear_big_inode().  (Thanks to Christoph
     Hellwig for spotting this.)
   - Fix race condition in fs/ntfs/inode.c::ntfs_put_inode() by taking the
     inode semaphore around the code thst sets ni->itype.index.bmp_ino to
     NULL and reorganize the code to optimize it a bit.  (Thanks to
     Christoph Hellwig for spotting this.)
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2047.1.1)
   NTFS: Modify fs/ntfs/aops.c::mark_ntfs_record_dirty() to no longer take the
         ntfs inode as a parameter as this is confusing and misleading and the
         ntfs inode is available via NTFS_I(page->mapping->host).
         Adapt all callers to this change.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2047.1.2)
   NTFS: Modify fs/ntfs/mft.c::write_mft_record_nolock() and
         fs/ntfs/aops.c::ntfs_write_mst_block() to only check the dirty state
         of the first buffer in a record and to take this as the ntfs record
         dirty state.  We cannot look at the dirty state for subsequent
         buffers because we might be racing with
         fs/ntfs/aops.c::mark_ntfs_record_dirty().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2051)
   NTFS: Move the static inline ntfs_init_big_inode() from fs/ntfs/inode.c to
         inode.h and make fs/ntfs/inode.c::__ntfs_init_inode() non-static and
         add a declaration for it to inode.h.  Fix some compilation issues
         that resulted due to #includes and header file interdependencies.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2052)
   NTFS: Simplify setup of i_mode in fs/ntfs/inode.c::ntfs_read_locked_inode().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2053)
   NTFS: Add helpers fs/ntfs/layout.h::MK_MREF() and MK_LE_MREF().
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/15 1.2054)
   NTFS: Modify fs/ntfs/mft.c::map_extent_mft_record() to only verify the mft
         record sequence number if it is specified (i.e. not zero).
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/16 1.2055)
   NTFS: Add fs/ntfs/mft.[hc]::ntfs_mft_record_alloc() and various helper
         functions used by it.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/17 1.2059)
   NTFS: 2.1.21 release
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

<aia21@cantab.net> (04/10/18 1.2061)
   NTFS: Update Documentation/filesystems/ntfs.txt with instructions on how to
         use the Device-Mapper driver with NTFS ftdisk/LDM raid.  This removes
         the linear raid problem with the Software RAID / MD driver when one
         or more of the devices has an odd number of sectors.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

