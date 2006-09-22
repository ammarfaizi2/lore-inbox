Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932516AbWIVOdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516AbWIVOdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWIVOdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:33:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38094 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932516AbWIVOdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:33:07 -0400
Subject: GFS2 & DLM merge request
From: Steven Whitehouse <swhiteho@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 22 Sep 2006 15:37:54 +0100
Message-Id: <1158935874.11901.408.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus, I believe that all the outstanding issues raised by Christoph,
Jan and others relating to GFS2 and DLM are now settled. Please
therefore consider pulling from:

	git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6.git

The diffstat is below. Thanks are due to everybody who has sent us
comments, suggestions and patches, particularly the aforementioned
reviewers,

Steve.


---------------------------------------------------------------------------------------------

 CREDITS                            |    6 
 Documentation/filesystems/gfs2.txt |   43 
 MAINTAINERS                        |   18 
 fs/Kconfig                         |    2 
 fs/Makefile                        |    2 
 fs/configfs/item.c                 |    2 
 fs/dlm/Kconfig                     |   21 
 fs/dlm/Makefile                    |   19 
 fs/dlm/ast.c                       |  173 +
 fs/dlm/ast.h                       |   26 
 fs/dlm/config.c                    |  789 +++++++
 fs/dlm/config.h                    |   42 
 fs/dlm/debug_fs.c                  |  387 +++
 fs/dlm/dir.c                       |  423 ++++
 fs/dlm/dir.h                       |   30 
 fs/dlm/dlm_internal.h              |  543 +++++
 fs/dlm/lock.c                      | 3871 +++++++++++++++++++++++++++++++++++++
 fs/dlm/lock.h                      |   62 
 fs/dlm/lockspace.c                 |  717 ++++++
 fs/dlm/lockspace.h                 |   25 
 fs/dlm/lowcomms.c                  | 1238 +++++++++++
 fs/dlm/lowcomms.h                  |   26 
 fs/dlm/lvb_table.h                 |   18 
 fs/dlm/main.c                      |   97 
 fs/dlm/member.c                    |  327 +++
 fs/dlm/member.h                    |   24 
 fs/dlm/memory.c                    |  116 +
 fs/dlm/memory.h                    |   29 
 fs/dlm/midcomms.c                  |  140 +
 fs/dlm/midcomms.h                  |   21 
 fs/dlm/rcom.c                      |  472 ++++
 fs/dlm/rcom.h                      |   24 
 fs/dlm/recover.c                   |  765 +++++++
 fs/dlm/recover.h                   |   34 
 fs/dlm/recoverd.c                  |  290 ++
 fs/dlm/recoverd.h                  |   24 
 fs/dlm/requestqueue.c              |  184 +
 fs/dlm/requestqueue.h              |   22 
 fs/dlm/user.c                      |  788 +++++++
 fs/dlm/user.h                      |   16 
 fs/dlm/util.c                      |  161 +
 fs/dlm/util.h                      |   22 
 fs/gfs2/Kconfig                    |   44 
 fs/gfs2/Makefile                   |   10 
 fs/gfs2/acl.c                      |  309 ++
 fs/gfs2/acl.h                      |   39 
 fs/gfs2/bmap.c                     | 1220 +++++++++++
 fs/gfs2/bmap.h                     |   31 
 fs/gfs2/daemon.c                   |  196 +
 fs/gfs2/daemon.h                   |   19 
 fs/gfs2/dir.c                      | 1962 ++++++++++++++++++
 fs/gfs2/dir.h                      |   79 
 fs/gfs2/eaops.c                    |  230 ++
 fs/gfs2/eaops.h                    |   30 
 fs/gfs2/eattr.c                    | 1501 ++++++++++++++
 fs/gfs2/eattr.h                    |  100 
 fs/gfs2/gfs2.h                     |   31 
 fs/gfs2/glock.c                    | 2231 +++++++++++++++++++++
 fs/gfs2/glock.h                    |  153 +
 fs/gfs2/glops.c                    |  564 +++++
 fs/gfs2/glops.h                    |   25 
 fs/gfs2/incore.h                   |  634 ++++++
 fs/gfs2/inode.c                    | 1340 ++++++++++++
 fs/gfs2/inode.h                    |   56 
 fs/gfs2/lm.c                       |  217 ++
 fs/gfs2/lm.h                       |   42 
 fs/gfs2/locking.c                  |  184 +
 fs/gfs2/locking/dlm/Makefile       |    3 
 fs/gfs2/locking/dlm/lock.c         |  524 +++++
 fs/gfs2/locking/dlm/lock_dlm.h     |  187 +
 fs/gfs2/locking/dlm/main.c         |   64 
 fs/gfs2/locking/dlm/mount.c        |  255 ++
 fs/gfs2/locking/dlm/plock.c        |  301 ++
 fs/gfs2/locking/dlm/sysfs.c        |  226 ++
 fs/gfs2/locking/dlm/thread.c       |  359 +++
 fs/gfs2/locking/nolock/Makefile    |    3 
 fs/gfs2/locking/nolock/main.c      |  246 ++
 fs/gfs2/log.c                      |  578 +++++
 fs/gfs2/log.h                      |   65 
 fs/gfs2/lops.c                     |  809 +++++++
 fs/gfs2/lops.h                     |   99 
 fs/gfs2/main.c                     |  150 +
 fs/gfs2/meta_io.c                  |  753 +++++++
 fs/gfs2/meta_io.h                  |   78 
 fs/gfs2/mount.c                    |  214 ++
 fs/gfs2/mount.h                    |   17 
 fs/gfs2/ondisk.c                   |  308 ++
 fs/gfs2/ops_address.c              |  782 +++++++
 fs/gfs2/ops_address.h              |   22 
 fs/gfs2/ops_dentry.c               |  119 +
 fs/gfs2/ops_dentry.h               |   17 
 fs/gfs2/ops_export.c               |  298 ++
 fs/gfs2/ops_export.h               |   22 
 fs/gfs2/ops_file.c                 |  642 ++++++
 fs/gfs2/ops_file.h                 |   24 
 fs/gfs2/ops_fstype.c               |  943 +++++++++
 fs/gfs2/ops_fstype.h               |   18 
 fs/gfs2/ops_inode.c                | 1151 +++++++++++
 fs/gfs2/ops_inode.h                |   20 
 fs/gfs2/ops_super.c                |  468 ++++
 fs/gfs2/ops_super.h                |   17 
 fs/gfs2/ops_vm.c                   |  184 +
 fs/gfs2/ops_vm.h                   |   18 
 fs/gfs2/quota.c                    | 1226 +++++++++++
 fs/gfs2/quota.h                    |   35 
 fs/gfs2/recovery.c                 |  570 +++++
 fs/gfs2/recovery.h                 |   34 
 fs/gfs2/rgrp.c                     | 1513 ++++++++++++++
 fs/gfs2/rgrp.h                     |   69 
 fs/gfs2/super.c                    |  977 +++++++++
 fs/gfs2/super.h                    |   54 
 fs/gfs2/sys.c                      |  583 +++++
 fs/gfs2/sys.h                      |   27 
 fs/gfs2/trans.c                    |  184 +
 fs/gfs2/trans.h                    |   39 
 fs/gfs2/util.c                     |  245 ++
 fs/gfs2/util.h                     |  170 +
 include/linux/Kbuild               |   39 
 include/linux/dlm.h                |  302 ++
 include/linux/dlm_device.h         |   86 
 include/linux/fs.h                 |    3 
 include/linux/gfs2_ondisk.h        |  443 ++++
 include/linux/iflags.h             |  102 
 include/linux/kernel.h             |    1 
 include/linux/lm_interface.h       |  273 ++
 include/linux/lock_dlm_plock.h     |   41 
 mm/filemap.c                       |    3 
 mm/readahead.c                     |    1 
 128 files changed, 40266 insertions(+), 24 deletions(-)


