Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbRGZRVL>; Thu, 26 Jul 2001 13:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268275AbRGZRVB>; Thu, 26 Jul 2001 13:21:01 -0400
Received: from bayarea.engin.umich.edu ([141.213.40.173]:1285 "EHLO
	bayarea.engin.umich.edu") by vger.kernel.org with ESMTP
	id <S267748AbRGZRU4>; Thu, 26 Jul 2001 13:20:56 -0400
Date: Thu, 26 Jul 2001 13:21:01 -0400 (EDT)
From: Christopher Allen Wing <wingc@engin.umich.edu>
To: <sentry21@cdslash.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
In-Reply-To: <Pine.LNX.4.30.0107261149220.18300-100000@spring.webconquest.com>
Message-ID: <Pine.LNX.4.33.0107261312450.6405-100000@bayarea.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

I am assuming that the problem here was that fsck restored a lost inode to
lost+found, but the inode had been corrupted and had the immutable bit
set.

It should be pointed out that there is currently no way to modify ext2
attributes for symlinks or device files, because ext2 attributes are
implemented via an ext2-specific ioctl(). You can't open() symlinks to
even attempt an ioctl, and ioctl on a device file goes directly to the
device, skipping ext2's ioctl method.

So, in the long term do we need some sort of lchflags() system call to
operate on names?

At the very least, ext2 fsck should complain about ext2 attributes set for
symlinks or device files... I have had this same problem myself many times
on machines with bad SCSI termination- I end up with unremovable device
files thanks to a bogus immutable bit and have to use debugfs to get rid
of them.

-Chris Wing
wingc@engin.umich.edu


On Thu, 26 Jul 2001 sentry21@cdslash.net wrote:

> In order to avoid flooding the list and everyone else with replies to all
> the e-mails I've recieved, I'm going to put them all in one. Hope this
> doesn't cause anyone problems.

