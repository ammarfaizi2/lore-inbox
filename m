Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270362AbRHMSRS>; Mon, 13 Aug 2001 14:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270366AbRHMSRJ>; Mon, 13 Aug 2001 14:17:09 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:24047 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S270362AbRHMSRA>; Mon, 13 Aug 2001 14:17:00 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108131815.f7DIFigl003620@webber.adilger.int>
Subject: Re: ext3-2.4-0.9.6
In-Reply-To: <3B75E9E3.FAAF05CC@zip.com.au> "from Andrew Morton at Aug 11, 2001
 07:28:51 pm"
To: Andrew Morton <akpm@zip.com.au>
Date: Mon, 13 Aug 2001 12:15:44 -0600 (MDT)
CC: Tom Rini <trini@kernel.crashing.org>, ext3-users@redhat.com,
        lkml <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew writes:
> I *think* that at present an unrecovered ext3 filesystem is "incomaptible"
> with ext2.  If, however we were to make it "read-only compatible" then
> ext2-aware loaders would still be able to read the fs and boot from it.
> But this stuff makes my head hurt - let's see what Andreas and Stephen
> have to say.

I advocated changing the compat flag to be RO_COMPAT at one time as well.
Technically, an unrecovered ext3 filesystem is as "compatible" as an ext2
filesystem that was not fscked before mount.  We ro mount unchecked root
filesystems all the time, so there shouldn't be a _huge_ issue for ro
mounting unrecovered ext3 filesystems.

Stephen and Ted disagree, because with the ext3 journal it is possible
to have a large number of pending changes in the journal at the time
of a crash.  The Linux VFS doesn't easily allow flushing all of the
cached inodes between recovery and remount-rw, so this may cause filesystem
corruption if the in-kernel inode data does not match the on-disk inode
data after recovery.

The only time this becomes an issue is with the root filesystem, generally.

The "solution" for the problem at hand would probably be to make
GRUB, et. al., recognize the INCOMPAT_RECOVER flag, and still read the
kernel/initrd images from disk.  They will generally be static, so the
contents of the journal will not affect them, and can be ignored.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

