Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264850AbUG2R5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264850AbUG2R5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUG2Rzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 13:55:48 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11155 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S264850AbUG2Rvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 13:51:43 -0400
Date: Thu, 29 Jul 2004 13:51:40 -0400
Message-Id: <200407291751.i6THpea3002949@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Subject: fistgen-0.1 released (linux-2.6 support)
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're pleased to announce the release of fistgen-0.1, the package of
stackable templates.  This release includes numerous bug fixes, but biggest
new thing is a port to Linux 2.6!

We've tested the templates under various conditions for more than two
months: over ext2/3, over nfs, with low-memory conditions, small/large
files, large compile benchmarks, small and large postmark configurations,
fsx-linux, and other tests -- and permutations of these.  This exhaustive
testing was done to help ensure that the templates are as stable as possible
(many people are now using fist in production environments).

Get the new tarball from

	ftp://ftp.filesystems.org/pub/fist/fistgen-0.1.tar.gz

Here's the relevant portion of the NEWS file:

*** Notes specific to fistgen 0.1:

Linux 2.6 templates!  Tested with base0fs, base1fs, base2fs, base3fs (aka
wrapfs), and cryptfs.  (SCA/Gzipfs and Attach-mode mounts not yet supported
in 2.6.)

Renamed all aux.c files to fist_aux.c to avoid conflicts with MS-DOS file
systems.

Malloc_DEBUG support for tracking memory leaks.  See explanation and use in
script match-malloc.pl.

Bugs fixed in Linux 2.4 templates:

- copy i_blocks correctly when mounted on top of ext2.

- wrapfs_commit_write() now behaves correctly for HIGHMEM systems
  (kmap/kunmap needed)

- for attach mode mounts the default maximum file size is taken from the
  root file system (and can be overridden using the maxbytes= mount time
  option).  This allows attach-mode file systems to support files larger
  than 2GB.

- fix refcnt leak on vfsmnt

- wrapfs_lock() needs struct flock's ->file set.  Work if called by
  posix_test_lock().

- readdir bug fix when exporting over NFS

- show dir= and debug= options in /proc/mounts

- move kmalloc outside spinlock

- bzero wrapfs_sb_info struct to avoid oops when lookup(hidden_root) fails

- don't generate attach code unless needed.

- ASSERT that hidden_file isn't NULL in various places where it shouldn't be

- up() the semaphore only if needed in wrapfs_commit_write

- kmalloc whole struct wrapfs_file_info, not just pointer, in wrapfs_open

- in wrapfs_lookup and wrapfs_symlink, don't use unsigned int for
  encoded_namelen, or we could never return an -ERRNO.

- in truncate, replace the hacky fake_file code with one that actually
  dentry_open's the real hidden_file.

- fail to sync files when mounted over NFS: correctly convert append-only mode
  writes to read-write in wrapfs_open.


Happy Stacking,
Erez and the fistgen team.
