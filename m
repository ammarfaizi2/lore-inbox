Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSFNGuw>; Fri, 14 Jun 2002 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316822AbSFNGuv>; Fri, 14 Jun 2002 02:50:51 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:29681 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S314078AbSFNGuv>; Fri, 14 Jun 2002 02:50:51 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 14 Jun 2002 00:49:05 -0600
To: OHKUBO Katsuhiko <ohkubo-k@suri.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question: The use of s_op->write_super_lockfs/unlockfs
Message-ID: <20020614064905.GT682@clusterfs.com>
Mail-Followup-To: OHKUBO Katsuhiko <ohkubo-k@suri.co.jp>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020614122405.FF2D.OHKUBO-K@suri.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 14, 2002  12:55 +0900, OHKUBO Katsuhiko wrote:
> There ars
> 	void write_super_lockfs(super_block *)
> 	void unlockfs(super_block *)
> in struct super_operations.
> 
> Ext3 and reiserfs have implementations of it.
> But I cannot find callers of it and system calls for it.
> 
> There are some pathches such as 
> 	http://www.lifix.fi/listarchive/lkml/2001-08/msg00464.html
> but it's not included in Linux 2.4.18/2.5.21.
> 	drivers/md/lvm.c has only callers of functions in this patch
> 	if defined LVM_VFS_ENHANCEMENT, but there aren't function bodys.
> 
> Q1: Who does use s_op->write_super_lockfs/unlockfs now?

LVM and EVMS use this interface, but it has not been accepted into the
kernel yet.  I think Chris Mason wants to submit the patch to implement
this, but has not yet.  I believe the 2.4.18 patch needs changing for
both 2.4.20 and 2.5.x.

> Q3: Is it enable to implement of system calls for lockfs/unlockfs
> 	without deadlocks?

No, because there is no guarantee that the user process will ever
call unlockfs (it could die or something).  I _suppose_ it would
be possible to call an ioctl to do the lockfs, and if the process dies
before calling unlockfs the close() will also do the unlockfs.  It
could still deadlock on I/O to the locked device and never terminate,
and it would be unkillable from user-space (stuck in "D" state).

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

