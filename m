Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWIABfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWIABfd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWIABfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:35:33 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:13190 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S964848AbWIABfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:35:32 -0400
Date: Thu, 31 Aug 2006 21:35:13 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches constitutes Unionfs version 2.0. We are presenting it to
be reviewed and considered for inclusion into the kernel.

Unionfs is a stackable filesystem that is based off of the FiST stackable
filesystem framework written by Erez Zadok: see <http://filesystems.org/>.

Josef Sipek presented Unionfs at the 2006 Ottawa Linux Symposiums; the
high-level overview from this year's symposium starts on page 349 of the
second half of the symposium proceedings:  see

  <http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf>

Note that this set of patches contains a considerably trimmed-down version
of Unionfs.  That way it'd be possible to evaluate Unionfs's most basic
functionality, gradually adding features in future patches.

To download tarballs of the full source, along with userspace utilities,
read various documents and other info about Unionfs, see the home page at

  <http://www.unionfs.org>

Josef "Jeff" Sipek, on behalf of the Unionfs team.

Index:
=======
[PATCH 01/22][RFC] Unionfs: Documentation
[PATCH 02/22][RFC] Unionfs: Kconfig and Makefile
[PATCH 03/22][RFC] Unionfs: Branch management functionality
[PATCH 04/22][RFC] Unionfs: Common file operations
[PATCH 05/22][RFC] Unionfs: Copyup Functionality
[PATCH 06/22][RFC] Unionfs: Dentry operations
[PATCH 07/22][RFC] Unionfs: Directory file operations
[PATCH 08/22][RFC] Unionfs: Directory manipulation helper functions
[PATCH 09/22][RFC] Unionfs: File operations
[PATCH 10/22][RFC] Unionfs: Inode operations
[PATCH 11/22][RFC] Unionfs: Lookup helper functions
[PATCH 12/22][RFC] Unionfs: Main module functions
[PATCH 13/22][RFC] Unionfs: Readdir state
[PATCH 14/22][RFC] Unionfs: Rename
[PATCH 15/22][RFC] Unionfs: Privileged operations workqueue
[PATCH 16/22][RFC] Unionfs: Handling of stale inodes
[PATCH 17/22][RFC] Unionfs: Miscellaneous helper functions
[PATCH 18/22][RFC] Unionfs: Superblock operations
[PATCH 19/22][RFC] Unionfs: Helper macros/inlines
[PATCH 20/22][RFC] Unionfs: Internal include file
[PATCH 21/22][RFC] Unionfs: Unlink
[PATCH 22/22][RFC] Unionfs: Include file

Known Issues and Limitations:

- The NFS server returns -EACCES for read-only exports, instead of -EROFS.
  This means we can't reliably detect a read-only NFS export.

- Modifying a Unionfs branch directly, while the union is mounted, is
  currently unsupported.  Any such change may cause Unionfs to oops and it
  can even result in data loss!

- The PPC module loading algorithm has an O(N^2) loop, so it takes a while
  to load the Unionfs module, because we have lots of symbols.

- Unionfs shouldn't use lookup_one_len on the underlying fs as it confuses
  NFS.

For the initial release we removed support for xattrs, persistent inode
mappings, and mmap operations.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>
