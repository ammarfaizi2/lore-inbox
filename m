Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135476AbQL3UxM>; Sat, 30 Dec 2000 15:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135537AbQL3UxD>; Sat, 30 Dec 2000 15:53:03 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:34059 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135476AbQL3Uwv>; Sat, 30 Dec 2000 15:52:51 -0500
Date: Sat, 30 Dec 2000 12:21:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generic deferred file writing
In-Reply-To: <Pine.GSO.4.21.0012301503290.4082-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012301214210.1017-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Dec 2000, Alexander Viro wrote:
> 
> Except that we've got file-expanding writes outside of ->i_sem. Thanks, but
> no thanks.

No, Al, the file size is still updated inside i_sem.

Yes, it will do actual block allocation outside i_sem, but that is already
true of any mmap'ed writes, and has been true for a long long time. So if
we have a bug here (and I don't think we have one), it's not something
new. But the inode semaphore doesn't protect the balloc() data structures
anyway, as they are filesystem-global.

If you're nervous about the effects of "truncate()", then that should be
handled properly by truncate_inode_pages().

In short, I don't see _those_ kinds of issues. I do see error reporting as
a major issue, though. If we need to do proper low-level block allocation
in order to get correct ENOSPC handling, then the win from doing deferred
writes is not very big.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
