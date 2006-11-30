Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936257AbWK3MLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936257AbWK3MLf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936255AbWK3MLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:11:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4229 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936257AbWK3MLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:11:34 -0500
Subject: [GFS2 & DLM] Guide to -nmw tree patches
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:12:13 +0000
Message-Id: <1164888733.3752.302.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below is a summary diffstat of all the changes in the GFS2 & DLM -nmw
(next merge window) git tree. Since merge time is once again upon us,
the following patches are the current complete content of the tree.

Although there are quite a few patches, there are relatively few major
changes. There is one new feature and thats the DLM TCP communications
layer. This existed before the (current upstream) TCP communications
layer and has received more testing over its lifetime, so its a kind of
old new feature :-)

Also 9 of these patches have been posted before as part of the -fixes
tree, so there are here again as Linus didn't pull that tree last week
and this is a superset therefore of the -fixes tree. I've marked the
patches that have been posted before with a * in the list below.

Also I've classified the patches into new=N, cleanup=C and bugfix=B to
help make more sense of them.

Of the remaining patches, 15 of them are from Al Viro and relate to
endianess annotation. A similar number of follow up patches from myself
build on that work by removing duplicated fields in the GFS2 in-core
inode, thus shrinking it and removing some extra copying that we were
doing.

Assuming that no major objections are raised, I'll send Linus a pull
request for these patches shortly. If any minor points are raised, then
hopefully they can be resolved with a follow up patch.

These patches have mostly (aside from the last few) been in -mm for some
time now. The patches do not touch anything outside the GFS2/DLM code.
Many thanks to all those who have sent bug reports & patches,

Steve.
-------------------------------------------------------------------------------------------

The following changes since commit 0215ffb08ce99e2bb59eca114a99499a4d06e704:
  Linus Torvalds:
        Linux 2.6.19

are found in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/steve/gfs2-2.6-nmw.git

Al Viro:
      [GFS2] split gfs2_dinode into on-disk and host variants               [C]
      [GFS2] gfs2_dinode_host fields are host-endian                        [C]
      [GFS2] split gfs2_sb                                                  [C]
      [GFS2] fields of gfs2_sb_host are host-endian                         [C]
      [GFS2] split and annotate gfs2_rgrp                                   [C]
      [GFS2] split and annotate gfs2_inum_range                             [C]
      [GFS2] split and annotate gfs2_log_head                               [C]
      [GFS2] split and annotate gfs2_meta_header                            [C]
      [GFS2] split and annotate gfs_rindex                                  [C]
      [GFS2] split and annotate gfs2_inum                                   [C]
      [GFS2] split and annotate gfs2_quota                                  [C]
      [GFS2] split and annotate gfs2_statfs_change                          [C]
      [GFS2] split and annotate gfs2_quota_change                           [C]
      [GFS2] gfs2 misc endianness annotations                               [C]
      [GFS2] gfs2 __user misannotation fix                                  [C]

David Teigland:
      [DLM] res_recover_locks_count not reset when recover_locks is aborted [B, *]
      [DLM] status messages ping-pong between unmounted nodes               [B, *]
      [DLM] fix requestqueue race                                           [B, *]
      [DLM] fix aborted recovery during node removal                        [B, *]
      [DLM] fix stopping unstarted recovery                                 [B, *]
      [DLM] do full recover_locks barrier                                   [B, *]
      [DLM] clear sbflags on lock master                                    [B, *]
      [DLM] fix add_requestqueue checking nodes list                        [B]
      [DLM] fix size of STATUS_REPLY message                                [B]
      [DLM] don't accept replies to old recovery messages                   [B]

Patrick Caulfield:
      [DLM] Add support for tcp communications                              [N]
      [DLM] Fix DLM config                                                  [B]

Randy Dunlap:
      [GFS2] lock function parameter                                        [B]

Russell Cattelan:
      [GFS2] Fix race in logging code                                       [B]
      [GFS2] Remove unused zero_readpage from stuffed_readpage              [B]

Ryusuke Konishi:
      [GFS2] fs/gfs2/log.c:log_bmap() fix printk format warning             [C]
      [DLM] fix format warnings in rcom.c and recoverd.c                    [C]

Srinivasa Ds:
      [GFS2] Mount problem with the GFS2 code                               [B]

Steven Whitehouse:
      [GFS2] Fix crc32 calculation in recovery.c                            [B]
      [GFS2] Change argument of gfs2_dinode_out                             [C]
      [GFS2] Change argument to gfs2_dinode_in                              [C]
      [GFS2] Move gfs2_dinode_in to inode.c                                 [C]
      [GFS2] Change argument to gfs2_dinode_print                           [C]
      [GFS2] Shrink gfs2_inode (1) - di_header/di_num                       [C]
      [GFS2] Shrink gfs2_inode (2) - di_major/di_minor                      [C]
      [GFS2] Shrink gfs2_inode (3) - di_mode                                [C]
      [GFS2] Shrink gfs2_inode (4) - di_uid/di_gid                          [C]
      [GFS2] Shrink gfs2_inode (5) - di_nlink                               [C]
      [GFS2] Shrink gfs2_inode (6) - di_atime/di_mtime/di_ctime             [C]
      [GFS2] Shrink gfs2_inode (7) - di_payload_format                      [C]
      [GFS2] Shrink gfs2_inode (8) - i_vn                                   [C]
      [GFS2] Tidy up 0 initialisations in inode.c                           [C]
      [GFS2] Don't copy meta_header for rgrp in and out                     [C]
      [GFS2] Remove unused GL_DUMP flag                                     [C]
      [GFS2] Fix page lock/glock deadlock                                   [B]
      [GFS2] Only set inode flags when required                             [C]
      [GFS2] Inode number is constant                                       [C]
      [GFS2] Remove gfs2_inode_attr_in                                      [C]
      [GFS2] Fix memory allocation in glock.c                               [B, *]
      [GFS2] Tidy up bmap & fix boundary bug                                [B,C]
      [GFS2] Remove unused sysfs files                                      [C]
      [GFS2] Remove unused function from inode.c                            [B, C]
      [GFS2] Make sentinel dirents compatible with gfs1                     [B]
      [GFS2] Fix Kconfig wrt CRC32                                          [B, *]
      [GFS2] Simplify glops functions                                       [C]
      [GFS2] Fix glock ordering on inode creation                           [B]
      [GFS2] mark_inode_dirty after write to stuffed file                   [B]
      [GFS2] Fix journal flush problem                                      [B]
      [GFS2] Move gfs2_meta_syncfs() into log.c                             [C]
      [GFS2] Reduce number of arguments to meta_io.c:getbuf()               [C]
      [GFS2] Fix recursive locking in gfs2_permission                       [B]
      [GFS2] Fix recursive locking in gfs2_getattr                          [B]
      [GFS2] Remove gfs2_check_acl()                                        [C]
      [GFS2] Add a comment about reading the super block                    [C]
      [GFS2] Don't flush everything on fdatasync                            [B, C]

 fs/dlm/Kconfig              |   20 +
 fs/dlm/Makefile             |    4 
 fs/dlm/dlm_internal.h       |    4 
 fs/dlm/lock.c               |   16 -
 fs/dlm/lockspace.c          |    4 
 fs/dlm/lowcomms-sctp.c      | 1239 ++++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms-tcp.c       | 1263 +++++++++++++++++++++++++++++++++++++++++++
 fs/dlm/lowcomms.c           | 1239 ------------------------------------------
 fs/dlm/member.c             |    8 
 fs/dlm/rcom.c               |   58 +-
 fs/dlm/recover.c            |    1 
 fs/dlm/recoverd.c           |   44 +
 fs/dlm/requestqueue.c       |   26 +
 fs/dlm/requestqueue.h       |    2 
 fs/gfs2/Kconfig             |    1 
 fs/gfs2/acl.c               |   39 -
 fs/gfs2/acl.h               |    1 
 fs/gfs2/bmap.c              |  179 +++---
 fs/gfs2/daemon.c            |    7 
 fs/gfs2/dir.c               |   93 ++-
 fs/gfs2/dir.h               |    8 
 fs/gfs2/eaops.c             |    2 
 fs/gfs2/eattr.c             |   66 +-
 fs/gfs2/eattr.h             |    6 
 fs/gfs2/glock.c             |   36 -
 fs/gfs2/glock.h             |    3 
 fs/gfs2/glops.c             |  138 +----
 fs/gfs2/incore.h            |   43 +
 fs/gfs2/inode.c             |  406 +++++---------
 fs/gfs2/inode.h             |   20 -
 fs/gfs2/log.c               |   41 +
 fs/gfs2/log.h               |    2 
 fs/gfs2/lops.c              |   40 +
 fs/gfs2/lops.h              |    2 
 fs/gfs2/meta_io.c           |   46 +-
 fs/gfs2/meta_io.h           |    1 
 fs/gfs2/ondisk.c            |  138 +----
 fs/gfs2/ops_address.c       |   52 +-
 fs/gfs2/ops_dentry.c        |    4 
 fs/gfs2/ops_export.c        |   38 +
 fs/gfs2/ops_export.h        |    2 
 fs/gfs2/ops_file.c          |   65 ++
 fs/gfs2/ops_file.h          |    2 
 fs/gfs2/ops_fstype.c        |    4 
 fs/gfs2/ops_inode.c         |  134 ++---
 fs/gfs2/ops_super.c         |   11 
 fs/gfs2/ops_vm.c            |    2 
 fs/gfs2/quota.c             |   15 -
 fs/gfs2/recovery.c          |   29 +
 fs/gfs2/recovery.h          |    2 
 fs/gfs2/rgrp.c              |   13 
 fs/gfs2/super.c             |   50 +-
 fs/gfs2/super.h             |    6 
 fs/gfs2/sys.c               |    8 
 fs/gfs2/util.h              |    6 
 include/linux/gfs2_ondisk.h |  138 ++++-
 56 files changed, 3526 insertions(+), 2301 deletions(-)
 create mode 100644 fs/dlm/lowcomms-sctp.c
 create mode 100644 fs/dlm/lowcomms-tcp.c
 delete mode 100644 fs/dlm/lowcomms.c


