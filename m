Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272122AbRIJXQ2>; Mon, 10 Sep 2001 19:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272124AbRIJXQJ>; Mon, 10 Sep 2001 19:16:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272122AbRIJXQD>; Mon, 10 Sep 2001 19:16:03 -0400
Date: Mon, 10 Sep 2001 16:16:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Rik van Riel <riel@conectiva.com.br>,
        Andreas Dilger <adilger@turbolabs.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
In-Reply-To: <20010910230721Z16600-26187+42@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33.0109101611450.1034-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Sep 2001, Daniel Phillips wrote:

> On September 11, 2001 12:39 am, Rik van Riel wrote:
> > On Mon, 10 Sep 2001, Linus Torvalds wrote:
> >
> > > (Ugly secret: because I tend to have tons of memory, I sometimes do
> > >
> > > 	find tree1 tree2 -type f | xargs cat > /dev/null
> >
> > This suggests we may want to do agressive readahead on the
> > inode blocks.
>
> While that is most probably true, that wasn't his point.  He preloaded the
> page cache.

Well, yes, but more importantly, I pre-loaded my page cache _with_io_that_
_is_more_likely_to_be_consecutive_.

This means that the preload + subsequent diff is already likely to be
faster than doing just one "diff" would have been.

So it' snot just about preloading. It's also about knowing about access
patterns beforehand - something that the kernel really cannot do.

Pre-loading your cache always depends on some limited portion of
prescience. If you preload too aggressively compared to your knowledge of
future usage patterns, you're _always_ going to lose. I think that the
kernel doing physical read-ahead is "too aggressive", while doing it
inside "diff" (that _knows_ the future patterns) is not.

And doing it by hand depends on the user knowing what he will do in the
future. In some cases that's fairly easy for the user to guess ;)

		Linus

