Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288742AbSATWpC>; Sun, 20 Jan 2002 17:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288759AbSATWov>; Sun, 20 Jan 2002 17:44:51 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:5124
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S288742AbSATWof>; Sun, 20 Jan 2002 17:44:35 -0500
Date: Sun, 20 Jan 2002 17:45:31 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Hans Reiser <reiser@namesys.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4AAA95.8040702@namesys.com>
Message-ID: <Pine.LNX.4.40.0201201744480.459-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


But why should each filesystem have to have a different method of
buffering/caching? that just doesn't fit the layered model of the kernel
IMHO.

Shawn.

On Sun, 20 Jan 2002, Hans Reiser wrote:

> In version 4 of reiserfs, our plan is to implement writepage such that
> it does not write the page but instead pressures the reiser4 cache and
> marks the page as recently accessed.  This is Linus's preferred method
> of doing that.
>
> Personally, I think that makes writepage the wrong name for that
> function, but I must admit it gets the job done, and it leaves writepage
> as the right name for all filesystems that don't manage their own cache,
> which is most of them.
>
> Hans
>
> Shawn wrote:
>
> >I've noticed that XFS's filesystem has a separate pagebuf_daemon to handle
> >caching/buffering.
> >
> >Why not make a kernel page/caching daemon for other filesystems to use
> >(kpagebufd) so that each filesystem can use a kernel daemon interface to
> >handle buffering and caching.
> >
> >I found that XFS's buffering/caching significantly reduced I/O load on the
> >system (with riel's rmap11b + rml's preempt patches and Andre's IDE
> >patch).
> >
> >But I've not been able to acheive the same speed results with ReiserFS :-(
> >
> >Just as we have a filesystem (VFS) layer, why not have a buffering/caching
> >layer for the filesystems to use inconjunction with the VM?
> >
> There is hostility to this from one of the VM maintainers.  He is
> concerned that separate caches were what they had before and they
> behaved badly.  I think that they simply coded them wrong the time
> before.  The time before, the pressure on the subcaches was uneven, with
> some caches only getting pressure if the other caches couldn't free
> anything, so of course it behaved badly.
>
> >
> >
> >Comments, suggestions, flames welcome ;)
> >
> >Shawn.
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
>
>
>

