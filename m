Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316739AbSFUSbn>; Fri, 21 Jun 2002 14:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFUSbm>; Fri, 21 Jun 2002 14:31:42 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:52183 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316739AbSFUSbl>;
	Fri, 21 Jun 2002 14:31:41 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.20
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFDFDF0583.75312435-ON85256BDF.0065A0DA@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 21 Jun 2002 13:31:29 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 06/21/2002 02:31:32 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.20 of JFS was made available today.

Drop 58 on June 21, 2002 (jfs-2.4-1.0.20.tar.gz
and jfsutils-1.0.20.tar.gz) includes fixes to the file
system and utilities.

Utilities changes

- don't display heartbeat during log format if output is redirected
  (eliminates strange characters in redirected output from mkfs.jfs
  with external log, fsck.jfs Phase 9)
- fix mkfs.jfs to set version in JFS superblock properly if external
   log is used (enables JFS external log compatibility with EVMS 1.1-pre2
   or greater)
- enhance jfsutils to support enormous disks like 8TB+ (Peter C.)
- remove unused variables (Christoph Hellwig)

File System changes

- set s_maxbytes to 1 byte lower
   When i_size was (PAGE_CACHE_SIZE << 32), generic_file_read overflowed
   an index and failed on any read. Subtracting one fixes it.
- procfs entries should be created when CONFIG_JFS_STATISTICS is set.
   Currently, if CONFIG_JFS_DEBUG is not set, no entries are created
   under /proc/fs/jfs, even if CONFIG_JFS_STATISTICS is set.
- fix fsync (Christoph Hellwig)
   fsync is allowed to return early if datasysnc is set and the
   I_DIRTY_DATASYNC flags is cleared, not if either of those is true
- JFS does not need to set i_version. It is never used. (Manfred Spraul)
- Fix for truncate problem, assert(!test_cflag(COMMIT_Nolink, ip))
   kernel BUG at jfs_txnmgr.c537! (bugzilla #583)
- Fix race in JFS kernel threads.
   Timing window existed between time threads dropped locks and slept,
   where the waker can try and wake the threads before they got to sleep.

For more details about JFS, please see the patch instructions or
changelog.jfs files.

Steve Best
Linux Technology Center
JFS for Linux http://oss.software.ibm.com/jfs







