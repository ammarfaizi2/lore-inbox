Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270257AbRHHBO6>; Tue, 7 Aug 2001 21:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270258AbRHHBOs>; Tue, 7 Aug 2001 21:14:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43488 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270256AbRHHBOi>;
	Tue, 7 Aug 2001 21:14:38 -0400
Date: Tue, 7 Aug 2001 21:14:47 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC][PATCH] parser for mount options
In-Reply-To: <200108072352.XAA25661@vlet.cwi.nl>
Message-ID: <Pine.GSO.4.21.0108072010260.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001 Andries.Brouwer@cwi.nl wrote:

> 	while (more_tokens) {
> 		t = type_of_next_token();
> 		switch (t) {
> 		case ...
> 		}
> 	}
> 
> where the type_of_next_token() does the parsing, and the switch
> does the assigning. Much more code. Much uglier - but tastes differ.

I would agree, if in all cases it was about assigning a single value.
It isn't.

> If you see strange warts in my parser it is mostly because
> it was a patch without user-visible changes, so all existing
> msdos option peculiarities had to be accommodated.

But that's precisely the point. It's accomodated to warts of random syntax
and basically says "OK, nobody will ever want something that would not be
covered by it".

> Once such code is in place one needs a very good reason to
> invent option syntax not covered by it.

In other words, we can optimize for pretty arbitrary limitations.  Sure.
It had been done before.  Who might think that we'll ever need something
besides the array of integers or a string for sysctls?  Not too random,
in that case...  Well, just look at the thing now.  Famous last words:
"nobody will ever do that"...

By the way, I wouldn't be surprised if it turned out that now we have
a wart not covered by ones that were there 5 years ago.  I'm sure that
it also can be dealt with - no arguments here.  However, it still
doesn't deal with:

	* syntax being not transparent.
	* the whole interface being basically _defined_ by a snapshot
of warts taken at some point.

How it was? "The difference between good and bad programs is that good
ones end up used in ways authors had never anticipated"?

Sigh... Let me put it that way - what you had described is, IMO, a kludge.
I don't think that it would be an improvement compared to the current
state of the things, but if you want it in the tree - you know where to
submit it.  Tastes differ, your and mine - quite seriously.

