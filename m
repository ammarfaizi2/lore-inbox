Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287253AbSAGWEC>; Mon, 7 Jan 2002 17:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSAGWDw>; Mon, 7 Jan 2002 17:03:52 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:7183 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S287235AbSAGWDm>; Mon, 7 Jan 2002 17:03:42 -0500
Date: Mon, 7 Jan 2002 22:03:36 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Lightweight user-level semaphores
In-Reply-To: <Pine.LNX.4.33.0201071223450.6942-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201072144110.8813-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Linus Torvalds wrote:

> >  * It leaks.  How were you going to refcount the kernel
> >    portions?  Could they be attached to the VM mapping?
> >    Would a lockfs be too expensive?
>
> Yes, I was going to just attach to the vma,

Wouldn't that have to be an address_space, so separate maps
of the same object will use the same count?  Or (not unlikely)
am I misunderstanding the way these structures are laid out?

> along with potentially also require a flag at mmap time (MAP_SEMAPHORE
> - some other unixes have something like it already) to tell the OS
> about the consistency issues that might come up on some architectures
> (on x86 it would be a no-op).

OK.

> >  * It doesn't have a timeout.  Is there something like a
> >    down_timeout() available?
>
> Not as-is, but all the kernel infrastructure should be there in
> theory.

OK, thanks.

> >  * I don't do the:
> >
> > 	if (kfs->user_address != fs)
> > 		goto bad_sem;
> >
> >    because it doesn't seem to add anything, and prevents
> >    putting these locks in a non-fixed file or SysV SHM
> >    map.
>
> Fair enough. I think I suggested that just as another sanity check,
> and because some architectures _will_ require address issues (not
> necessarily total equality, but at least "modulo X equality").

Should being in the same place in the same page (though
possibly at a different address) should suffice for all
architectures?

Matthew.

