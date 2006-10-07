Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWJGGCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWJGGCu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 02:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbWJGGCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 02:02:23 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:55728 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S932607AbWJGFy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 01:54:57 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 23] Unionfs: Stackable Namespace Unification Filesystem
Message-Id: <patchbomb.1160197639@thor.fsl.cs.sunysb.edu>
Date: Sat, 07 Oct 2006 01:07:19 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches constitutes Unionfs version 2.0. We are presenting it to
be reviewed and considered for inclusion into the kernel.

Some of the comments addressed since the first submission are:

- unionfs_lookup must pass lookup intents to the lower filesystem (Trond
  Myklebust)
- patches reordered (Stephen Rothwell)
- numerous style comments by Jan Engelhardt

Note that this set of patches contains a considerably trimmed-down version
of Unionfs.  That way it'd be possible to evaluate Unionfs's most basic
functionality, gradually adding features in future patches.

To download tarballs of the full source, along with userspace utilities,
read various documents and other info about Unionfs, see the home page at

  <http://www.unionfs.org>

Josef "Jeff" Sipek, on behalf of the Unionfs team.

Index:
=======
[PATCH 1 of 23] Unionfs: Documentation
[PATCH 2 of 23] lookup_one_len_nd - lookup_one_len with nameidata
[PATCH 3 of 23] Unionfs: Branch management functionality
[PATCH 4 of 23] Unionfs: Common file operations
[PATCH 5 of 23] Unionfs: Copyup Functionality
[PATCH 6 of 23] Unionfs: Dentry operations
[PATCH 7 of 23] Unionfs: File operations
[PATCH 8 of 23] Unionfs: Directory file operations
[PATCH 9 of 23] Unionfs: Directory manipulation helper functions
[PATCH 10 of 23] Unionfs: Inode operations
[PATCH 11 of 23] Unionfs: Lookup helper functions
[PATCH 12 of 23] Unionfs: Main module functions
[PATCH 13 of 23] Unionfs: Readdir state
[PATCH 14 of 23] Unionfs: Rename
[PATCH 15 of 23] Unionfs: Privileged operations workqueue
[PATCH 16 of 23] Unionfs: Handling of stale inodes
[PATCH 17 of 23] Unionfs: Miscellaneous helper functions
[PATCH 18 of 23] Unionfs: Superblock operations
[PATCH 19 of 23] Unionfs: Helper macros/inlines
[PATCH 20 of 23] Unionfs: Internal include file
[PATCH 21 of 23] Unionfs: Include file
[PATCH 22 of 23] Unionfs: Unlink
[PATCH 23 of 23] Unionfs: Kconfig and Makefile

Known Issues and Limitations:

- The NFS server returns -EACCES for read-only exports, instead of -EROFS.
  This means we can't reliably detect a read-only NFS export.

- Modifying a Unionfs branch directly, while the union is mounted, is
  currently unsupported.  Any such change may cause Unionfs to oops and it
  can even result in data loss!

- Unionfs shouldn't use lookup_one_len on the underlying fs as it confuses
  NFS. Currently, unionfs_lookup passes lookup intents to the lower
  filesystem, this eliminates part of the problem. The remaining calls to
  lookup_one_len may need to be changed to pass an intent.

For the initial release we removed support for xattrs, persistent inode
mappings, and mmap operations.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>


