Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTLAGWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 01:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263356AbTLAGWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 01:22:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:32409 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263330AbTLAGWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 01:22:42 -0500
Date: Mon, 1 Dec 2003 17:20:52 +1100
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: XFS for 2.4
Message-ID: <20031201062052.GA2022@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please do a

	bk pull http://xfs.org:8090/linux-2.4+coreXFS

This will merge the core 2.4 kernel changes required for supporting
the XFS filesystem, as listed below.  If this all looks acceptable,
then please also pull the filesystem-specific code (fs/xfs/*)

	bk pull http://xfs.org:8090/linux-2.4+justXFS

cheers.

-- 
Nathan


linux-2.4+coreXFS updates the following files:

 Documentation/Changes              |   16 ++
 Documentation/Configure.help       |   84 +++++++++++++
 Documentation/filesystems/00-INDEX |    2 
 Documentation/filesystems/xfs.txt  |  226 +++++++++++++++++++++++++++++++++++--
 MAINTAINERS                        |    8 +
 drivers/block/ll_rw_blk.c          |    3 
 fs/Config.in                       |    7 +
 fs/Makefile                        |    4 
 fs/buffer.c                        |   59 ++++++++-
 fs/inode.c                         |   46 +++----
 fs/namei.c                         |   13 +-
 fs/open.c                          |   13 ++
 include/linux/dqblk_xfs.h          |    9 -
 include/linux/fs.h                 |   50 +++++++-
 include/linux/posix_acl_xattr.h    |   67 ++++++++++
 include/linux/sched.h              |    1 
 kernel/ksyms.c                     |   12 +
 mm/filemap.c                       |   63 +++++++++-
 18 files changed, 618 insertions(+), 65 deletions(-)

through these ChangeSets:

<nathans@bruce.melbourne.sgi.com> (03/11/24 1.1183.1.1)
   VFS support for filesystems which implement POSIX ACLs.
   
   This involves an inode flag which directs the VFS to skip application
   of the umask so that the filesystem ACL code can do this according to
   the POSIX rules, and a new header file defining the contents of the 2
   system ACL extended attributes.  This is a backport from 2.6.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1194)
   Fix utimes(2) and immutable/append-only files.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1195)
   Remove some unused macros and related comment from the XFS quota header.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1196)
   Add a process flag to identify a process performing a transaction.
   Used by XFS and backported from 2.6.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1197)
   Support for delayed allocation.  Used by XFS and backported from 2.6.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1198)
   Provide a simple try-lock based dirty page flushing routine.

<nathans@bruce.melbourne.sgi.com> (03/11/25 1.1199)
   Provide an iget variant without unlocking the inode and without the
   read_inode call (iget_locked).  Used by XFS and backported from 2.6.

<nathans@bruce.melbourne.sgi.com> (03/11/26 1.1200)
   Export several kernel symbols used by the XFS filesystem.

<nathans@bruce.melbourne.sgi.com> (03/11/26 1.1201)
   Add XFS documentation and incorporate XFS into the kernel build.

<nathans@bruce.melbourne.sgi.com> (03/12/01 1.1202.1.1)
   [XFS] Document the XFS noikeep option, make ikeep the default.

