Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262446AbVAJS77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVAJS77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262445AbVAJS4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:56:36 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:42162 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262286AbVAJSyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:54:24 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] FUSE - Filesystem in Userspace
Message-Id: <E1Co4fv-00043K-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Jan 2005 19:53:59 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus,

Please apply the following patches, which add Filesystem in Userspace
to the kernel.  The patches are against 2.6.10.

FUSE [1] exports the filesystem functionality to userspace.  The
communication interface is designed to be simple, efficient, secure
and able to support most of the usual filesystem semantics.

It can be used for prototyping and for network/virtual filesystems
requiring external libraries or programs.  A typical example is sshfs
[2] which uses the sftp protocol and allows zero-setup mounting of
remote sites.

FUSE is currently in use by dozens of publicly available filesystems
[3], and by many in-house applications.  It has proved useful and
stable for lots of users.

Thanks to everyone for the comments on the last submission.  Changes
since then are:

 - Made it Deadlock Free (TM).  This includes removing support for
   shared writable mapping and making all requests interruptible.

 - Removed INVALIDATE userspace initiated request, this is probably
   not used by any application.

 - Updated ABI to be independent of sizeof(long), so dual-size archs
   don't cause problems

 - Remove /sys/fs/fuse/version.  Version checking is now done through
   the fuse device

The patch is split up to the following parts:

  01 - MAINTAINERS, Kconfig and Makefile changes
  02 - FUSE core
  03 - FUSE device functions
  04 - read-only operations (getattr, readlink, readdir, ...)
  05 - read-write operations (setattr, mkdir, symlink, ...)
  06 - file operations (open, read, write, ...)
  07 - mount options controlling the behavior of the filesystem
  08 - extended attribute operations (getxattr, setxattr, ...)
  09 - readpages operation
  10 - NFS export support
  11 - direct I/O support

Thanks,
Miklos

[1] http://fuse.sourceforge.net/

[2] http://sourceforge.net/project/showfiles.php?group_id=121684&package_id=140425

[3] http://fuse.sourceforge.net/filesystems.html
