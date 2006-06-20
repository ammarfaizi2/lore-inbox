Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbWFTMkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbWFTMkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWFTMkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:40:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17085 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965067AbWFTMkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:40:11 -0400
Subject: Re: GFS2 and DLM
From: Steven Whitehouse <swhiteho@redhat.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <4497EAC6.3050003@yahoo.com.au>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	 <4497EAC6.3050003@yahoo.com.au>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 20 Jun 2006 13:47:10 +0100
Message-Id: <1150807630.3856.1372.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-06-20 at 22:32 +1000, Nick Piggin wrote:
> Steven Whitehouse wrote:
> > Hi,
> > 
> > Linus, Andrew suggested to me to send this pull request to you directly.
> > Please consider merging the GFS2 filesystem and DLM from (they are both
> > in the same tree for ease of testing):
> > 
> > rsync://rsync.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git
> > 
> > They have both lived in -mm for quite some time. We merged all review
> > feedback and patches that came though -mm and from the various previous
> > postings of patches to lkml and fsdevel mailing lists.
> > 
> > I have updated my git tree so that its fully uptodate with your current
> > tree (as of the time of this request) and tested building and using it,
> 
> Hi Steve,
> 
> Could you post a diffstat?
> 
Here is the diffstat as requested,

Steve.

------------------------------------------------------------------------------------------------
 CREDITS                            |    6 
 Documentation/filesystems/gfs2.txt |   43 
 MAINTAINERS                        |   18 
 fs/Kconfig                         |    2 
 fs/Makefile                        |    2 
 fs/configfs/item.c                 |    2 
 fs/dlm/Kconfig                     |   29 
 fs/dlm/Makefile                    |   21 
 fs/dlm/ast.c                       |  167 +
 fs/dlm/ast.h                       |   26 
 fs/dlm/config.c                    |  789 ++++++++
 fs/dlm/config.h                    |   42 
 fs/dlm/debug_fs.c                  |  296 +++
 fs/dlm/device.c                    | 1239 ++++++++++++
 fs/dlm/dir.c                       |  423 ++++
 fs/dlm/dir.h                       |   30 
 fs/dlm/dlm_internal.h              |  494 +++++
 fs/dlm/lock.c                      | 3547 +++++++++++++++++++++++++++++++++++++
 fs/dlm/lock.h                      |   50 
 fs/dlm/lockspace.c                 |  678 +++++++
 fs/dlm/lockspace.h                 |   24 
 fs/dlm/lowcomms.c                  | 1238 ++++++++++++
 fs/dlm/lowcomms.h                  |   26 
 fs/dlm/lvb_table.h                 |   18 
 fs/dlm/main.c                      |   89 
 fs/dlm/member.c                    |  312 +++
 fs/dlm/member.h                    |   24 
 fs/dlm/memory.c                    |  106 +
 fs/dlm/memory.h                    |   29 
 fs/dlm/midcomms.c                  |  140 +
 fs/dlm/midcomms.h                  |   21 
 fs/dlm/rcom.c                      |  457 ++++
 fs/dlm/rcom.h                      |   24 
 fs/dlm/recover.c                   |  762 +++++++
 fs/dlm/recover.h                   |   34 
 fs/dlm/recoverd.c                  |  285 ++
 fs/dlm/recoverd.h                  |   24 
 fs/dlm/requestqueue.c              |  184 +
 fs/dlm/requestqueue.h              |   22 
 fs/dlm/util.c                      |  161 +
 fs/dlm/util.h                      |   22 
 fs/gfs2/Kconfig                    |   44 
 fs/gfs2/Makefile                   |   10 
 fs/gfs2/acl.c                      |  315 +++
 fs/gfs2/acl.h                      |   37 
 fs/gfs2/bmap.c                     | 1103 +++++++++++
 fs/gfs2/bmap.h                     |   32 
 fs/gfs2/daemon.c                   |  196 ++
 fs/gfs2/daemon.h                   |   19 
 fs/gfs2/dir.c                      | 1980 ++++++++++++++++++++
 fs/gfs2/dir.h                      |   73 
 fs/gfs2/eaops.c                    |  230 ++
 fs/gfs2/eaops.h                    |   31 
 fs/gfs2/eattr.c                    | 1548 ++++++++++++++++
 fs/gfs2/eattr.h                    |   97 +
 fs/gfs2/format.h                   |   21 
 fs/gfs2/gfs2.h                     |   31 
 fs/gfs2/glock.c                    | 2280 +++++++++++++++++++++++
 fs/gfs2/glock.h                    |  152 +
 fs/gfs2/glops.c                    |  491 +++++
 fs/gfs2/glops.h                    |   23 
 fs/gfs2/incore.h                   |  659 ++++++
 fs/gfs2/inode.c                    | 1363 ++++++++++++++
 fs/gfs2/inode.h                    |   58 
 fs/gfs2/lm.c                       |  244 ++
 fs/gfs2/lm.h                       |   41 
 fs/gfs2/lm_interface.h             |  295 +++
 fs/gfs2/locking.c                  |  191 +
 fs/gfs2/locking/dlm/Makefile       |    3 
 fs/gfs2/locking/dlm/lock.c         |  541 +++++
 fs/gfs2/locking/dlm/lock_dlm.h     |  188 +
 fs/gfs2/locking/dlm/main.c         |   64 
 fs/gfs2/locking/dlm/mount.c        |  256 ++
 fs/gfs2/locking/dlm/plock.c        |  299 +++
 fs/gfs2/locking/dlm/sysfs.c        |  225 ++
 fs/gfs2/locking/dlm/thread.c       |  352 +++
 fs/gfs2/locking/nolock/Makefile    |    3 
 fs/gfs2/locking/nolock/main.c      |  259 ++
 fs/gfs2/log.c                      |  601 ++++++
 fs/gfs2/log.h                      |   61 
 fs/gfs2/lops.c                     |  800 ++++++++
 fs/gfs2/lops.h                     |   96 +
 fs/gfs2/lvb.c                      |   45 
 fs/gfs2/lvb.h                      |   19 
 fs/gfs2/main.c                     |  127 +
 fs/gfs2/meta_io.c                  |  888 +++++++++
 fs/gfs2/meta_io.h                  |   89 
 fs/gfs2/mount.c                    |  214 ++
 fs/gfs2/mount.h                    |   15 
 fs/gfs2/ondisk.c                   |  304 +++
 fs/gfs2/ops_address.c              |  669 ++++++
 fs/gfs2/ops_address.h              |   17 
 fs/gfs2/ops_dentry.c               |  123 +
 fs/gfs2/ops_dentry.h               |   15 
 fs/gfs2/ops_export.c               |  285 ++
 fs/gfs2/ops_export.h               |   15 
 fs/gfs2/ops_file.c                 | 1000 ++++++++++
 fs/gfs2/ops_file.h                 |   20 
 fs/gfs2/ops_fstype.c               |  842 ++++++++
 fs/gfs2/ops_fstype.h               |   16 
 fs/gfs2/ops_inode.c                | 1163 ++++++++++++
 fs/gfs2/ops_inode.h                |   18 
 fs/gfs2/ops_super.c                |  471 ++++
 fs/gfs2/ops_super.h                |   15 
 fs/gfs2/ops_vm.c                   |  195 ++
 fs/gfs2/ops_vm.h                   |   16 
 fs/gfs2/page.c                     |  268 ++
 fs/gfs2/page.h                     |   23 
 fs/gfs2/quota.c                    | 1305 +++++++++++++
 fs/gfs2/quota.h                    |   32 
 fs/gfs2/recovery.c                 |  575 +++++
 fs/gfs2/recovery.h                 |   32 
 fs/gfs2/rgrp.c                     | 1529 +++++++++++++++
 fs/gfs2/rgrp.h                     |   63 
 fs/gfs2/super.c                    |  928 +++++++++
 fs/gfs2/super.h                    |   52 
 fs/gfs2/sys.c                      |  579 ++++++
 fs/gfs2/sys.h                      |   24 
 fs/gfs2/trans.c                    |  184 +
 fs/gfs2/trans.h                    |   34 
 fs/gfs2/util.c                     |  245 ++
 fs/gfs2/util.h                     |  169 +
 include/linux/dlm.h                |  302 +++
 include/linux/dlm_device.h         |   86 
 include/linux/fs.h                 |    3 
 include/linux/gfs2_ondisk.h        |  441 ++++
 include/linux/iflags.h             |  102 +
 include/linux/kernel.h             |    1 
 include/linux/lock_dlm_plock.h     |   40 
 kernel/printk.c                    |    1 
 mm/filemap.c                       |    1 
 mm/readahead.c                     |    1 
 132 files changed, 40815 insertions(+), 4 deletions(-)


