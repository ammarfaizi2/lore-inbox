Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVKGVVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVKGVVq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbVKGVS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:18:58 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11780 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965076AbVKGVSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:18:55 -0500
Date: Mon, 7 Nov 2005 22:18:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ext2: remove the ancient CHANGES file
Message-ID: <20051107211853.GA3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes an ancient changelog file.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 31 Oct 2005

 fs/ext2/CHANGES |  157 ------------------------------------------------
 1 file changed, 157 deletions(-)

--- linux-2.6.14-rc5-mm1-full/fs/ext2/CHANGES	2005-08-29 01:41:01.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,157 +0,0 @@
-Changes from version 0.5a to version 0.5b
-=========================================
-	- Now that we have sysctl(), the immutable flag cannot be changed when
-	  the system is running at security level > 0.
-	- Some cleanups in the code.
-	- More consistency checks on directories.
-	- The ext2.diff patch from Tom May <ftom@netcom.com> has been
-	  integrated.  This patch replaces expensive "/" and "%" with
-	  cheap ">>" and "&" where possible.
-
-Changes from version 0.5 to version 0.5a
-========================================
-	- Zero the partial block following the end of the file when a file
-	  is truncated.
-	- Dates updated in the copyright.
-	- More checks when the filesystem is mounted: the count of blocks,
-	  fragments, and inodes per group is checked against the block size.
-	- The buffers used by the error routines are now static variables, to
-	  avoid using space on the kernel stack, as requested by Linus.
-	- Some cleanups in the error messages (some versions of syslog contain
-	  a bug which truncates an error message if it contains '\n').
-	- Check that no data can be written to a file past the 2GB limit.
-	- The famous readdir() bug has been fixed by Stephen Tweedie.
-	- Added a revision level in the superblock.
-	- Full support for O_SYNC flag of the open system call.
-	- New mount options: `resuid=#uid' and `resgid=#gid'.  `resuid' causes
-	  ext2fs to consider user #uid like root for the reserved blocks.
-	  `resgid' acts the same way with group #gid.  New fields in the
-	  superblock contain default values for resuid and resgid and can
-	  be modified by tune2fs.
-	  Idea comes from Rene Cougnenc <cougnenc@renux.frmug.fr.net>.
-	- New mount options: `bsddf' and `minixdf'.  `bsddf' causes ext2fs
-	  to remove the blocks used for FS structures from the total block
-	  count in statfs.  With `minixdf', ext2fs mimics Minix behavior
-	  in statfs (i.e. it returns the total number of blocks on the
-	  partition).  This is intended to make bde happy :-)
-	- New file attributes:
-	  - Immutable files cannot be modified.  Data cannot be written to
-	    these files.  They cannot be removed, renamed and new links cannot
-	    be created.  Even root cannot modify the files.  He has to remove
-	    the immutable attribute first.
-	  - Append-only files: can only be written in append-mode when writing.
-	    They cannot be removed, renamed and new links cannot be created.
-	    Note: files may only be added to an append-only directory.
-	  - No-dump files: the attribute is not used by the kernel.  My port
-	    of dump uses it to avoid backing up files which are not important.
-	- New check in ext2_check_dir_entry: the inode number is checked.
-	- Support for big file systems: the copy of the FS descriptor is now
-	  dynamically allocated (previous versions used a fixed size array).
-	  This allows to mount 2GB+ FS.
-	- Reorganization of the ext2_inode structure to allow other operating
-	  systems to create specific fields if they use ext2fs as their native
-	  file system.  Currently, ext2fs is only implemented in Linux but
-	  will soon be part of Gnu Hurd and of Masix.
-
-Changes from version 0.4b to version 0.5
-========================================
-	- New superblock fields: s_lastcheck and s_checkinterval added
-	  by Uwe Ohse <uwe@tirka.gun.de> to implement timedependent checks
-	  of the file system
-	- Real random numbers for secure rm added by Pierre del Perugia
-	  <delperug@gla.ecoledoc.ibp.fr>
-	- The mount warnings related to the state of a fs are not printed
-	  if the fs is mounted read-only, idea by Nick Holloway
-	  <alfie@dcs.warwick.ac.uk>
-
-Changes from version 0.4a to version 0.4b
-=========================================
-	- Copyrights changed to include the name of my laboratory.
-	- Clean up of balloc.c and ialloc.c.
-	- More consistency checks.
-	- Block preallocation added by Stephen Tweedie.
-	- Direct reads of directories disallowed.
-	- Readahead implemented in readdir by Stephen Tweedie.
-	- Bugs in block and inodes allocation fixed.
-	- Readahead implemented in ext2_find_entry by Chip Salzenberg.
-	- New mount options:
-	  `check=none|normal|strict'
-	  `debug'
-	  `errors=continue|remount-ro|panic'
-	  `grpid', `bsdgroups'
-	  `nocheck'
-	  `nogrpid', `sysvgroups'
-	- truncate() now tries to deallocate contiguous blocks in a single call
-	  to ext2_free_blocks().
-	- lots of cosmetic changes.
-
-Changes from version 0.4 to version 0.4a
-========================================
-        - the `sync' option support is now complete.  Version 0.4 was not
-          supporting it when truncating a file.  I have tested the synchronous
-          writes and they work but they make the system very slow :-(  I have
-          to work again on this to make it faster.
-        - when detecting an error on a mounted filesystem, version 0.4 used
-          to try to write a flag in the super block even if the filesystem had
-          been mounted read-only.  This is fixed.
-        - the `sb=#' option now causes the kernel code to use the filesystem
-          descriptors located at block #+1.  Version 0.4 used the superblock
-          backup located at block # but used the main copy of the descriptors.
-        - a new file attribute `S' is supported.  This attribute causes
-          synchronous writes but is applied to a file not to the entire file
-          system (thanks to Michael Kraehe <kraehe@bakunin.north.de> for
-          suggesting it).
-        - the directory cache is inhibited by default.  The cache management
-          code seems to be buggy and I have to look at it carefully before
-          using it again.
-        - deleting a file with the `s' attribute (secure deletion) causes its
-          blocks to be overwritten with random values not with zeros (thanks to
-          Michael A. Griffith <grif@cs.ucr.edu> for suggesting it).
-        - lots of cosmetic changes have been made.
-
-Changes from version 0.3 to version 0.4
-=======================================
-        - Three new mount options are supported: `check', `sync' and `sb=#'.
-          `check' tells the kernel code to make more consistency checks
-          when the file system is mounted.  Currently, the kernel code checks
-          that the blocks and inodes bitmaps are consistent with the free
-          blocks and inodes counts.  More checks will be added in future
-          releases.
-          `sync' tells the kernel code to use synchronous writes when updating
-          an inode, a bitmap, a directory entry or an indirect block.  This
-          can make the file system much slower but can be a big win for files
-          recovery in case of a crash (and we can now say to the BSD folks
-          that Linux also supports synchronous updates :-).
-          `sb=#' tells the kernel code to use an alternate super block instead
-          of its master copy.  `#' is the number of the block (counted in
-          1024 bytes blocks) which contains the alternate super block.
-          An ext2 file system typically contains backups of the super block
-          at blocks 8193, 16385, and so on.
-        - I have change the meaning of the valid flag used by e2fsck.  it
-          now contains the state of the file system.  If the kernel code
-          detects an inconsistency while the file system is mounted, it flags
-          it as erroneous and e2fsck will detect that on next run.
-        - The super block now contains a mount counter.  This counter is
-          incremented each time the file system is mounted read/write.   When
-          this counter becomes bigger than a maximal mount counts (also stored
-          in the super block), e2fsck checks the file system, even if it had
-          been unmounted cleanly, and resets this counter to 0.
-        - File attributes are now supported.  One can associate a set of
-          attributes to a file.  Three attributes are defined:
-          `c': the file is marked for automatic compression,
-          `s': the file is marked for secure deletion: when the file is
-          deleted, its blocks are zeroed and written back to the disk,
-          `u': the file is marked for undeletion: when the file is deleted,
-          its contents are saved to allow a future undeletion.
-          Currently, only the `s' attribute is implemented in the kernel
-          code.  Support for the other attributes will be added in a future
-          release.
-        - a few bugs related to times updates have been fixed by Bruce
-          Evans and me.
-        - a bug related to the links count of deleted inodes has been fixed.
-          Previous versions used to keep the links count set to 1 when a file
-          was deleted.  The new version now sets links_count to 0 when deleting
-          the last link.
-        - a race condition when deallocating an inode has been fixed by
-          Stephen Tweedie.
-

