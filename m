Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVCDJoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVCDJoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 04:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbVCDJop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 04:44:45 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:17318 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S262571AbVCDJom
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 04:44:42 -0500
Date: Fri, 4 Mar 2005 01:44:06 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>,
       <jfs-discussion@www-124.southbury.usf.ibm.com>, <reiser@namesys.com>,
       <mc@cs.stanford.edu>
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o
 sync/dirsync option?
In-Reply-To: <20050304011141.5ff037dc.akpm@osdl.org>
Message-ID: <Pine.GSO.4.44.0503040136010.9975-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That would be a bug.  Please send the e2fsck output.

Here is the trace

1. file system is made with sbin/mkfs.ext2 -F -b 1024 /dev/hda9 60
and  mounted with -o sync,dirsync

1.  operations FiSC did:

creat(/mnt/sbd0/0001)
write(/mnt/sbd0/0001)
rename(/mnt/sbd0/0001, /mnt/sbd0/0002)
mkdir(/mnt/sbd0/0003)

2.  FiSC "crashed" the test machine  after mkdir returns.  Crashed
disk image can be downloaded at: http://fisc.stanford.edu/bug2/crash.img.bz2

e2fsck output is:

e2fsck 1.36 (05-Feb-2005)
/dev/hda9 was not cleanly unmounted, check
forced.
Pass 1: Checking inodes, blocks, and sizes
Inode 12, i_blocks is 16, should be 2.  Fix? yes

Pass 2: Checking directory structure
Entry '0003' in / (2) has deleted/unused inode 13.  Clear? yes

Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -21
Fix? yes

Free blocks count wrong for group #0 (38, counted=39).
Fix? yes

Free blocks count wrong (38, counted=39).
Fix? yes

Inode bitmap differences:  -13
Fix? yes

Free inodes count wrong for group #0 (3, counted=4).
Fix? yes

Directories count wrong for group #0 (3, counted=2).
Fix? yes

Free inodes count wrong (3, counted=4).
Fix? yes


/dev/hda9: ***** FILE SYSTEM WAS MODIFIED
*****
/dev/hda9: 12/16 files (0.0% non-contiguous), 21/60 blocks

>
>
> It would be much better to test vaguely contemporary kernels.
>

I'm going to check 2.6.11 tonight.

