Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317142AbSFKQEs>; Tue, 11 Jun 2002 12:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317144AbSFKQEr>; Tue, 11 Jun 2002 12:04:47 -0400
Received: from dsl-213-023-038-217.arcor-ip.net ([213.23.38.217]:34945 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317142AbSFKQEq>;
	Tue, 11 Jun 2002 12:04:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: george anzinger <george@mvista.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
Date: Tue, 11 Jun 2002 18:03:56 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com> <3D060EC8.321A0D66@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Ho7g-00009u-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 June 2002 16:52, george anzinger wrote:
> Linus Torvalds wrote:
> > The real #include hell comes, to a large degree, from the fact that we
> > like inline functions. Which have many wonderful properties, but they have
> > the same nasty property typedefs have: they require full type information
> > and cannot be predeclared.
> > 
> > And while I'd like to avoid #include hell, I'm not willing to replace
> > inline functions with #define's to avoid it ;^p
> 
> On wonders if it might be useful to split header files into
> say for example, list_d.h and list_i.h with the declarations
> in the "_d.h" and inlines in the "_i.h".  Then we could move
> the "_i.h" includes to the end of the include list.  Yeah, I
> know, too many includes in includes to work.  

No, it does work, and it works very well.  The winning strategy is to
split out heavily referenced data declarations from any dependent
function declarations, and give them their own headers, also included
from the orginal headers.  The normal 'compile this header once'
mechanism makes this work smoothly and that's optimized by cpp so
compile speed impact is negigible.  In many cases only the data
declaration is needed, so it's possible we might even see a slight
speedup.

The tradeoff of a few more header files (and it's only a few) against
a lot more sanity is well worth it.  I demonstrated the technique in
my 'early_page' patch set, which lets you declare struct page as the
first thing in mm.h. and I suppose I should dust that off, update it
to 2.5 and submit it.

-- 
Daniel
