Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132685AbQK3Hvd>; Thu, 30 Nov 2000 02:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132689AbQK3HvX>; Thu, 30 Nov 2000 02:51:23 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:28912 "EHLO
        webber.adilger.net") by vger.kernel.org with ESMTP
        id <S132685AbQK3HvF>; Thu, 30 Nov 2000 02:51:05 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200011300720.eAU7KYT28277@webber.adilger.net>
Subject: Re: ext2 directory size bug (?)
In-Reply-To: <Pine.LNX.4.21.0011300453200.31229-100000@ace.ulyssis.org>
 "from Steven Van Acker at Nov 30, 2000 05:17:25 am"
To: Steven Van Acker <deepstar@ulyssis.org>
Date: Thu, 30 Nov 2000 00:20:34 -0700 (MST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You write:
> Hmm, gonna try to follow the REPORTING-BUGS file here...
> 
> [1.] One line summary of the problem:
> 
>      directory size increases when adding 0-size files, 
>      but doesn't decrease when removing them.

It may or may not be considered a bug, but in any case it has been like
this for a long time and I doubt it will change.  The directory size is
not dependent upon the file size, only the length of the file names.

One "reason" why ext2 directories don't shrink when the files are deleted
is because e2fsck relies on this behaviour for the lost+found directory,
so that you don't need to allocate blocks for lost+foung on a corrupted
filesystem when doing recovery of unlinked files.

In some cases, you may have a directory entry in the last block, so you
can't free any of the earlier blocks even if they are empty.

In most cases, if you have created many files in one directory in the past,
you are likely to create many there again - so easier just to keep the
directory blocks until next time.

In most cases, the number of blocks allocated to a directory (but never
to be used again) is very small, and people don't really worry about it.
I think the scenario where you have a large amount of space in directories
that will never be used again is very unusual and should not be a reason
to make the code more complex.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
