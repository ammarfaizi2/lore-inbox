Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265192AbSJaGVY>; Thu, 31 Oct 2002 01:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265193AbSJaGVY>; Thu, 31 Oct 2002 01:21:24 -0500
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:50878 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S265192AbSJaGVW>; Thu, 31 Oct 2002 01:21:22 -0500
From: Duncan Sands <baldrick@wanadoo.fr>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Htree ate my hard drive, was: post-halloween 0.2
Date: Thu, 31 Oct 2002 07:27:52 +0100
User-Agent: KMail/1.4.7
References: <20021030171149.GA15007@suse.de>
In-Reply-To: <20021030171149.GA15007@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200210310727.52636.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> EXT3 Htree support.
> ~~~~~~~~~~~~~~~~~~~
> The ext3 filesystem has gained indexed directory support, which offers
> considerable performance gains when used on filesystems with large
> directories. In order to use the htree feature, you need at least version
> 1.29 of e2fsprogs. Existing filesystems can be converted using the command
> "tune2fs -O dir_index /dev/hdXXX" The latest e2fsprogs can be found at
> http://prdownloads.sourceforge.net/e2fsprogs

I ran this (tune2fs -O dir_index /dev/hdXXX).

After a bit of switching back and forth between 2.4.19 and 2.5.44,
fsck was run while booting 2.4.19 (the usual check because of >30
mounts).  There was a message about optimizing directories.  Booting
continued but (big surprise) X refused to run.  It turned out that some
device files had vanished.  Very strange.  On rebooting, fsck found a
gazillion bad inodes.  They all turned out to be from the 2.5.44 tree -
poetic justice I suppose!  But this did not suffice.  Rebooting, I got
"optimizing directories" again.  Next fsck showed up more dud inodes.
After a few cycles of this, I ran

tune2fs -O ^dir_index /dev/hdXXX

to remove htree support.  No problems since then.

Duncan.

PS: UP, no preempt.

tune2fs 1.30-WIP (30-Sep-2002)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          ee433ceb-6b14-45b1-894c-2a8aad1e280f
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal needs_recovery
Filesystem state:         clean
Errors behavior:          Unknown (continue)
Filesystem OS type:       Linux
Inode count:              290816
Block count:              2315368
Reserved block count:     115768
Free blocks:              871842
Free inodes:              36718
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         4096
Inode blocks per group:   128
Last mount time:          Thu Oct 31 06:37:46 2002
Last write time:          Thu Oct 31 06:37:46 2002
Mount count:              7
Maximum mount count:      30
Last checked:             Wed Oct 30 11:50:37 2002
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal UUID:             <none>
Journal inode:            493
Journal device:           0x0000
First orphan inode:       139500



