Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSI0TBm>; Fri, 27 Sep 2002 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262591AbSI0TBm>; Fri, 27 Sep 2002 15:01:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27825 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262576AbSI0TBl>;
	Fri, 27 Sep 2002 15:01:41 -0400
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.23
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF820EAC47.8CA1410E-ON85256C41.005D787F@pok.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 27 Sep 2002 14:06:53 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 09/27/2002 03:06:54 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.23 of JFS was made available today.

Drop 61 on September 27, 2002 (jfs-2.4-1.0.23.tar.gz
and jfsutils-1.0.23.tar.gz) includes fixes to the file
system and utilities.

Utilities changes

- print fsck.jfs start timestamp correctly in fsck.jfs log
- allow xchklog to run on a JFS file system with an external journal
- initialize program name in logdump properly
- code cleanup



File System changes

- Detect and fix invalid directory index values
   The directory index values are the unique cookies used to resume
   a readdir at the proper place. These are stored with each entry
   in a directory. fsck.jfs does not currently validate these entries,
   nor even create them when populating the lost+found directory.
   This fix causes readdir to detect the invalid cookies, and generate
   new ones, if possible.
- Fix problems with NFS
   Don't complain when read_inode is called with a deleted inode. This
   is normally done by revalidate.
   readdir: Don't hold metadata page while calling filldir(). NFS's
   filldir may call lookup() which could result in a hang.
- Fix off-by-one error in dbNextAG
   In certain situations, dbNextAG set db_agpref to db_numag, is
   one higher than the last valid value. This will eventually result
   in a trap.
- Avoid parallel allocations within the same allocation group
   When large files are writing in parallel, allocating the space for
   these files within the same allocation group can cause severe
   fragmentation of the files. By keeping track of open, growing files
   within an allocation group, we can force other new allocations into
   a different allocation group to avoid causing fragmentation.
- Fix test in lmLogFileSystem
- Remove assert(i < MAX_ACTIVE) when the external log can't be found.
- Remove excessive typedefs

For more details about JFS, please see the patch instructions or
changelog.jfs files.


Steve Best
Linux Technology Center
JFS for Linux http://oss.software.ibm.com/jfs




