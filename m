Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129725AbQKFRtG>; Mon, 6 Nov 2000 12:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129816AbQKFRs4>; Mon, 6 Nov 2000 12:48:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:11532 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129725AbQKFRsl>; Mon, 6 Nov 2000 12:48:41 -0500
Date: Mon, 6 Nov 2000 09:48:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <andrewm@uow.edu.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of
In-Reply-To: <3A06C007.99EE3746@uow.edu.au>
Message-ID: <Pine.LNX.4.10.10011060941070.7955-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Nov 2000, Andrew Morton wrote:

> Alan Cox wrote:
> > 
> > > Even 2.2.x can be fixed to do the wake-one for accept(), if required.
> > 
> > Do we really want to retrofit wake_one to 2.2. I know Im not terribly keen to
> > try and backport all the mechanism. I think for 2.2 using the semaphore is a
> > good approach. Its a hack to fix an old OS kernel. For 2.4 its not needed
> 
> It's a 16-liner!  I'll cheerfully admit that this patch
> may be completely broken, but hey, it's free.  I suggest
> that _something_ has to be done for 2.2 now, because
> Apache has switched to unserialised accept().

This is why I'd love to _not_ see silly work-arounds in apache: we
obviously _can_ fix the places where our performance sucks, but only if we
don't have other band-aids hiding the true issues.

For example, with a file-locking apache, we'd have to fix the (noticeably
harder) file locking thing to be wake-one instead, and even then we'd
never be able to do as well as something that gets the same wake-one thing
without the two extra system calls.

The patch looks superficially fine to me, although it does seem to add
another cache-line to the wakeup setup - it migth be worth-while to have
the exclusive state closer. But maybe I just didn't count right.

		Linus


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
