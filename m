Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTD3Myv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 08:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262157AbTD3Myv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 08:54:51 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:29939 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP id S262156AbTD3Myt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 08:54:49 -0400
Date: Wed, 30 Apr 2003 14:07:09 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
Reply-To: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [BK-PATCH-2.5] NTFS 2.1.4 release: many fixes / sync up with 2.4.x driver
Message-ID: <Pine.SOL.3.96.1030430134249.19762B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please do a:

	bk pull http://linux-ntfs.bkbits.net/ntfs-2.5

This will update NTFS to version 2.1.4 which fixes all known bugs and
compiler issues and brings the driver up to date with its 2.4.x kernel
counterpart where all development has been happening in recent time. (Due
to distributions like Mandrake Linux and SuSE Linux having added it to
their kernels and hence us getting a lot of testing and feedback.)

I am not including a patch as it is quite big but the bk pull will only
touch fs/ntfs/* and Documentation/filesystems/ntfs.txt as below summary
shows:

 Documentation/filesystems/ntfs.txt |   13 ++
 fs/ntfs/ChangeLog                  |   33 ++++-
 fs/ntfs/Makefile                   |    8 -
 fs/ntfs/aops.c                     |   33 ++---
 fs/ntfs/attrib.c                   |   56 ++++----
 fs/ntfs/attrib.h                   |    8 -
 fs/ntfs/compress.c                 |   94 +++++++++++---
 fs/ntfs/dir.c                      |  146 +++++++++++-----------
 fs/ntfs/inode.c                    |  240 ++++++++++++++++++-------------------
 fs/ntfs/inode.h                    |   38 ++---
 fs/ntfs/layout.h                   |  182 ++++++++++++++++------------
 fs/ntfs/mft.c                      |   28 ++--
 fs/ntfs/namei.c                    |   10 -
 fs/ntfs/super.c                    |  193 +++++++++++++++++------------
 fs/ntfs/unistr.c                   |   10 -
 fs/ntfs/upcase.c                   |   10 -
 16 files changed, 625 insertions(+), 477 deletions(-)

The ChangeLog since the previous 2.5 series NTFS release (2.1.0) follows
below:

2.1.4 - Reduce compiler requirements. 

- Remove all uses of unnamed structs and unions in the driver to make
  old and newer gcc versions happy. Makes it a bit uglier IMO but at
  least people will stop hassling me about it. 

2.1.3 - Important bug fixes in corner cases. 

- super.c::parse_ntfs_boot_sector(): Correct the check for 64-bit
  clusters. (Philipp Thomas)
- attrib.c::load_attribute_list(): Fix bug when initialized_size is a
  multiple of the block_size but not the cluster size. (Szabolcs
  Szakacsits <szaka@sienet.hu>) 

2.1.2 - Important bug fixes aleviating the hangs in statfs. 

- Fix buggy free cluster and free inode determination logic. 

2.1.1 - Minor updates. 

- Add handling for initialized_size != data_size in compressed files.  -
  Reduce function local stack usage from 0x3d4 bytes to just noise in
  fs/ntfs/upcase.c. (Randy Dunlap <rddunlap@osdl.ord>)  - Remove compiler
  warnings for newer gcc. 

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

