Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131594AbQLQBZL>; Sat, 16 Dec 2000 20:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbQLQBZA>; Sat, 16 Dec 2000 20:25:00 -0500
Received: from lips.borg.umn.edu ([160.94.232.50]:25107 "EHLO
	lips.borg.umn.edu") by vger.kernel.org with ESMTP
	id <S131594AbQLQBYs>; Sat, 16 Dec 2000 20:24:48 -0500
Message-ID: <3A3C0EB2.6F8FD302@thebarn.com>
Date: Sat, 16 Dec 2000 18:54:10 -0600
From: Russell Cattelan <cattelan@thebarn.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.12 i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.LNX.4.10.10012150108430.31093-100000@home.suse.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:

> On Fri, 15 Dec 2000, Alexander Viro wrote:
>
> > Just one: any fs that really cares about completion callback is very likely
> > to be picky about the requests ordering. So sync_buffers() is very unlikely
> > to be useful anyway.
> >
> Somewhat.  I guess there are at least two ways to do it.  First flush the
> buffers where ordering matters (log blocks), then send the others onto the
> dirty list (general metadata).  You might have your own end_io for those, and
> sync_buffers would lose it.
>
> Second way (reiserfs recently changed to this method) is to do all the
> flushing yourself, and remove the need for an end_io call back.
>
I'm curious about this.
Does the mean reiserFS is doing all of it's own buffer management?

This would seem a little redundant with what is already in the kernel?

>
>
> > In that sense we really don't have anonymous buffers here. I seriously
> > suspect that "unrealistic" assumption is not unrealistic at all. I'm
> > not sufficiently familiar with XFS code to say for sure, but...
> >
> > What we really need is a way for VFS/VM to pass the pressure on filesystem.
> > That's it. If fs wants unusual completions for requests - let it have its
> > own queueing mechanism and submit these requests when it finds that convenient.
> >
> Yes, this is exactly what we've discussed.
>
> -chris

--
Russell Cattelan
cattelan@thebarn.com



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
