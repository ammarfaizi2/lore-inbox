Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268650AbRGZS5T>; Thu, 26 Jul 2001 14:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268652AbRGZS5J>; Thu, 26 Jul 2001 14:57:09 -0400
Received: from lightning.hereintown.net ([207.196.96.3]:60355 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id <S268650AbRGZS5C>; Thu, 26 Jul 2001 14:57:02 -0400
Date: Thu, 26 Jul 2001 15:11:20 -0400 (EDT)
From: Chris Meadors <clubneon@hereintown.net>
To: Andreas Dilger <adilger@turbolinux.com>
cc: Christopher Allen Wing <wingc@engin.umich.edu>,
        "sentry21@cdslash.net" <sentry21@cdslash.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
In-Reply-To: <200107261821.f6QIL4017990@lynx.adilger.int>
Message-ID: <Pine.LNX.4.31.0107261502020.3437-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Andreas Dilger wrote:

> It should actually assume that such inodes are corrupt, and either just
> delete them at e2fsck time, or at least clear the "bad" parts of the inode
> before sticking it in lost+found.

I had this happen to me once before.  I did something bad, and when I
started my machine up again, I got a couple of files in lost+found.  I
couldn't delete two of them.

I posted my trouble here, and I got many of the same hints I've seen given
this time around.

What just made me think, is you just said that e2fsck should clean up this
problem before putting it in lost+found.  That is probally a good idea.
But it was also half way to my solution.  e2fsck did know there was
something wrong with the inodes, but since it marked the disk clean the
first time it was run it wouldn't bother looking over the disk upon
farther reboots.  I wasn't comfortable with figuring out how to use
debugfs, so I just left the 2 bad files there.  Until I did something
else silly and another fsck was forced.  Upon being run the second time
e2fsck did notice something out of order and fixed up the files so I could
delete them.

So yes, e2fsck probally should have noticed the problem the first time
through and not written a funky file to lost+found.  But this might be a
possible solution for the orginal poster of the message.  Just force a
check right now and see if it gets fixed.

-Chris
-- 
Two penguins were walking on an iceberg.  The first penguin said to the
second, "you look like you are wearing a tuxedo."  The second penguin
said, "I might be..."                         --David Lynch, Twin Peaks

