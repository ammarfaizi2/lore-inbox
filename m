Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137154AbRAHHMR>; Mon, 8 Jan 2001 02:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137153AbRAHHMH>; Mon, 8 Jan 2001 02:12:07 -0500
Received: from slc293.modem.xmission.com ([166.70.2.39]:14346 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S136990AbRAHHLx>; Mon, 8 Jan 2001 02:11:53 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Adam J. Richter" <adam@yggdrasil.com>, parsley@roanoke.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Patch (repost): cramfs memory corruption fix
In-Reply-To: <Pine.LNX.4.21.0101071910200.21675-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jan 2001 23:56:06 -0700
In-Reply-To: Rik van Riel's message of "Sun, 7 Jan 2001 19:11:56 -0200 (BRDT)"
Message-ID: <m1d7dyilbt.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Sun, 7 Jan 2001, Linus Torvalds wrote:
> > On Sun, 7 Jan 2001, Alan Cox wrote:
> > 
> > > -ac has the rather extended ramfs with resource limits and stuff. That one
> > > also has rather more extended bugs 8). AFAIK none of those are in the
> vanilla
> 
> > > ramfs code
> 
> > This is actually where I agree with whoever it was that said that ramfs as
> > it stands now (without the limit checking etc) is much nicer simply
> > because it can act as an example of how to do a simple filesystem. 
> > 
> > I wonder what to do about this - the limits are obviously useful, as would
> > the "use swap-space as a backing store" thing be. At the same time I'd
> > really hate to lose the lean-mean-clean ramfs. 
> 
> Sounds like a job for ... <drum roll> ... tmpfs!!

If you need tmpfs the VFS layer is broken.  For 99% of everything
performance is determined by VFS layer caching.  A fs that
uses swap space as a backing store is not a big win.  You just have 
a fs that doesn't support sync and you can add a mount option to
a normal fs if you want that.

I've written the filesystem and it was a dumb idea.

Ramfs with (maybe) some basic limits has a place.  tmpfs is just
extra code to maintain. 

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
