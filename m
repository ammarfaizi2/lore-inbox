Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265044AbUGIQbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265044AbUGIQbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 12:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGIQbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 12:31:36 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:4746 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S265042AbUGIQbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 12:31:31 -0400
Date: Fri, 9 Jul 2004 18:31:30 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: strange "file system was modified" report from e2fsck
Message-ID: <20040709163130.GA6361@janus>
Mail-Followup-To: Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mke2fs -j
mount it
Fill disk as root with one huge >150GB file
umount it
e2fsck -f -v: ok
mount it
rm 150 GB file
umount it
e2fsck -f -v: ***** FILE SYSTEM WAS MODIFIED *****

After removing the big file and umounting the ext3 partition, e2fsck -f -v
invariably reports that the file system has been modified. This doesn't
happen for a small file.

e2fsck 1.34 (25-Jul-2003)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information

/dev/hdc1: ***** FILE SYSTEM WAS MODIFIED *****

      11 inodes used (0%)
       0 non-contiguous inodes (0.0%)
         # of inodes with ind/dind/tind blocks: 0/0/0
  621574 blocks used (1%)
       0 bad blocks
       0 large files

       0 regular files
       2 directories
       0 character device files
       0 block device files
       0 fifos
       0 links
       0 symbolic links (0 fast symbolic links)
       0 sockets
--------
       2 files


What is going on? should I be worried about it?


This was on an Redhat FC1 system with plain 2.4.26. tune2fs says:
# tune2fs -l /dev/hdc1
tune2fs 1.34 (25-Jul-2003)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          67b89aec-eb20-4e37-ae19-4263319496f6
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype sparse_super
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              19546112
Block count:              39072080
Reserved block count:     1953604
Free blocks:              38450506
Free inodes:              19546101
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16384
Inode blocks per group:   512
Filesystem created:       Thu Jul  8 21:26:18 2004
Last mount time:          Fri Jul  9 18:10:51 2004
Last write time:          Fri Jul  9 18:12:48 2004
Mount count:              0
Maximum mount count:      34
Last checked:             Fri Jul  9 18:12:48 2004
Check interval:           15552000 (6 months)
Next check after:         Wed Jan  5 17:12:48 2005
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
Default directory hash:   tea
Directory Hash Seed:      f719a1f4-e416-4699-b8d8-ce645600cd6d



-- 
Frank
