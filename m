Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTEVRsY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 13:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTEVRsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 13:48:01 -0400
Received: from dhcp05.ists.dartmouth.edu ([129.170.249.105]:2690 "EHLO
	uml.karaya.com") by vger.kernel.org with ESMTP id S262918AbTEVRqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 13:46:40 -0400
Message-Id: <200305221759.h4MHxdjm013272@uml.karaya.com>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML filesystems
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 May 2003 13:59:39 -0400
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/fs-2.5

This adds the two UML filesystems to the 2.5 tree - hostfs allows a directory
on the host to be mounted as a filesystem inside UML, and hppfs is an overlay
over /proc which allows the content of the UML's /proc to be controlled from
the host.

These are going into fs/hostfs and fs/hppfs.

The changes here include the merge into 2.5 and subsequent bug fixes.

				Jeff


 arch/um/Kconfig         |   13 
 fs/Makefile             |    2 
 fs/hostfs/Makefile      |   36 +
 fs/hostfs/hostfs.h      |   79 +++
 fs/hostfs/hostfs_kern.c |  958 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hostfs/hostfs_user.c |  355 +++++++++++++++++
 fs/hppfs/Makefile       |   19 
 fs/hppfs/hppfs_kern.c   |  810 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 2272 insertions(+)

ChangeSet@1.1042.83.2, 2003-05-02 13:07:39-04:00, jdike@uml.karaya.com
  Fixed the mode calculation in hostfs_create.
  Removed root hostfs support.

ChangeSet@1.971.47.4, 2003-03-28 21:22:12-05:00, jdike@uml.karaya.com
  Moved arch/um/fs/{hostfs,hppfs} under fs/.

ChangeSet@1.971.47.3, 2003-03-27 23:12:47-05:00, jdike@uml.karaya.com
  Fixed some minor bugs in the open_private_file changes.

ChangeSet@1.971.47.2, 2003-03-27 22:37:42-05:00, jdike@uml.karaya.com
  hppfs needed to be updated to use open/close_private_file instead
  of init_private_file.

ChangeSet@1.889.409.1, 2003-03-22 13:58:55-05:00, jdike@uml.karaya.com
  Merge uml.karaya.com:/home/jdike/linux/2.5/linus-2.5
  into uml.karaya.com:/home/jdike/linux/2.5/fs-2.5

ChangeSet@1.889.306.4, 2003-03-12 09:46:13-05:00, jdike@uml.karaya.com
  Moved host descriptor cleanup from delete_inode to destroy_inode.
  This stops file descriptors from being leaked.

ChangeSet@1.889.306.3, 2003-03-07 12:37:51-05:00, jdike@uml.karaya.com
  hppfs works now that inodes are always read.

ChangeSet@1.889.307.2, 2003-03-05 14:23:03-05:00, jdike@uml.karaya.com
  Small fix to make hppfs work correctly.

ChangeSet@1.889.242.6, 2003-02-24 17:26:48-05:00, jdike@uml.karaya.com
  Fixed hppfs_lookup so that hppfs does more than just mount OK.

ChangeSet@1.889.242.5, 2003-02-24 13:17:04-05:00, jdike@uml.karaya.com
  Fixed the interface of stat_file.

ChangeSet@1.889.242.4, 2003-02-24 01:50:34-05:00, jdike@uml.karaya.com
  A minor fix to hostfs.
  hppfs now compiles and mounts.

ChangeSet@1.889.242.3, 2003-02-23 22:49:54-05:00, jdike@uml.karaya.com
  Added a first-pass update of hppfs to 2.5.

ChangeSet@1.889.242.2, 2003-02-23 21:48:56-05:00, jdike@uml.karaya.com
  Some small compilation fixes to hostfs.

ChangeSet@1.889.242.1, 2003-02-23 20:56:17-05:00, jdike@uml.karaya.com
  Merged Petr Baudis' hostfs updates to 2.5.

