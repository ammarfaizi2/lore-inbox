Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLOJpG>; Fri, 15 Dec 2000 04:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLOJo4>; Fri, 15 Dec 2000 04:44:56 -0500
Received: from ns1.SuSE.com ([202.58.118.2]:53511 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S129325AbQLOJom>;
	Fri, 15 Dec 2000 04:44:42 -0500
Date: Fri, 15 Dec 2000 01:14:14 -0800 (PST)
From: Chris Mason <mason@suse.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
In-Reply-To: <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10012150108430.31093-100000@home.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Dec 2000, Alexander Viro wrote:

> Just one: any fs that really cares about completion callback is very likely
> to be picky about the requests ordering. So sync_buffers() is very unlikely
> to be useful anyway.
> 
Somewhat.  I guess there are at least two ways to do it.  First flush the
buffers where ordering matters (log blocks), then send the others onto the
dirty list (general metadata).  You might have your own end_io for those, and
sync_buffers would lose it.

Second way (reiserfs recently changed to this method) is to do all the
flushing yourself, and remove the need for an end_io call back.

> In that sense we really don't have anonymous buffers here. I seriously
> suspect that "unrealistic" assumption is not unrealistic at all. I'm
> not sufficiently familiar with XFS code to say for sure, but...
> 
> What we really need is a way for VFS/VM to pass the pressure on filesystem.
> That's it. If fs wants unusual completions for requests - let it have its
> own queueing mechanism and submit these requests when it finds that convenient.
> 
Yes, this is exactly what we've discussed.

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
