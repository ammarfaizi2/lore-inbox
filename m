Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbREYUNl>; Fri, 25 May 2001 16:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261840AbREYUNV>; Fri, 25 May 2001 16:13:21 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:17933 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261839AbREYUNQ>; Fri, 25 May 2001 16:13:16 -0400
Date: Fri, 25 May 2001 22:12:51 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: blkdev-pagecache-2 [was Re: DVD blockdevice buffers]
Message-ID: <20010525221251.I9634@athlon.random>
In-Reply-To: <Pine.LNX.4.31.0105231258420.6642-100000@penguin.transmeta.com> <3B0C202E.AA9962AD@mandrakesoft.com> <20010524003220.C764@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010524003220.C764@athlon.random>; from andrea@suse.de on Thu, May 24, 2001 at 12:32:20AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 12:32:20AM +0200, Andrea Arcangeli wrote:
> userspace. I will try to work on the blkdev patch tomorrow to bring it
> in an usable state.

It seems in an usable state right but it is still very early beta, I
need to recheck the whole thing, I will do that tomorrow, for now it
should get it right the fsck on a ro mount fs and the cache coherency
across multiple inodes all pointing to the same blkdev, it actually
worked without any problem in the first basic tests I did. However I
expect it to corrupt a rw mounted fs if you open the blkdev under it
(the fsck test happens with the fs ro), so while it's in an usable state
it's not ready for public consumation yet. Of course ramdisk is still
totally broken too. The other first round of bugs mentioned in the first
thread should be fixed. The blocksize is still hardwired to 4k, I'll
think about the read-modify-write problem later. About the proposed
readpage API change I think it's not worthwhile for new hardware where
reading 1k or 4k doesn't make relevant difference. Handling partial
I/O seems worthwhile only during writes because a partial write would
otherwise trigger a read-modify-write operation with a synchronous read.

	ftp://ftp.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.4.5pre6/blkdev-pagecache-2

Andrea
