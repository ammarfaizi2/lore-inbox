Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268239AbRGWOcM>; Mon, 23 Jul 2001 10:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268242AbRGWOcD>; Mon, 23 Jul 2001 10:32:03 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:32014 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268239AbRGWObn>; Mon, 23 Jul 2001 10:31:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
Subject: Re: Common hash table implementation
Date: Mon, 23 Jul 2001 16:36:06 +0200
X-Mailer: KMail [version 1.2]
Cc: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0107221207460.3066-100000@bellatrix.tat.physik.uni-tuebingen.de>
In-Reply-To: <Pine.LNX.4.21.0107221207460.3066-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Message-Id: <01072316360604.00315@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sunday 22 July 2001 12:18, Richard Guenther wrote:
> On Sat, 21 Jul 2001, Daniel Phillips wrote:
> > On Saturday 21 July 2001 02:24, Brian J. Watson wrote:
> > > Daniel Phillips wrote:
> > > Richard Guenther sent the following link to his own common
> > > hashing code, which makes nice use of pseudo-templates:
> > >
> > > http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/~checkout~/glame/g
> > >lame /src/include/hash.h?rev=1.5&content-type=text/plain
> > >
> > > A few things I would consider changing are:
> > >
> > >   - ditching the pprev pointer
> >
> > Yes, you want to use the generic list macros there.
>
> You get one-pointer size hash table entries and generic deletion from
> it.

Having thought about it a little more, I don't see why the symmetric 
double link (i.e., like the page hash, not like the buffer hash) 
couldn't be used with single-pointer tables, using similar tests for 
NULL in insertion and deletion.

> > >   - encapsulating the next pointer inside a struct
> > > hash_head_##FOOBAR
> >
> > I think the generic list macros give you that for free.
>
> Umm, if you use such, you get lists.h style type-casting stuff which
> doesnt have a nice interface as

You could wrap the final product in inlines with internal typecasts.  
As you pointed out, C just doesn't have templates.

> > Naturally.  And trying to reduce the size of the macros.  It's not
> > that easy to get stuff that has dozens of lines ending with "\"
> > into the kernel.  You might have better luck just generalizing a
> > few short sets of common operations used in hashes, and showing
> > examples of how you'd use them to rewrite some of the existing hash
> > code.  Obviously, the new, improved approach has to be no less
> > efficient than the current way of doing things.
>
> All those \s are to encapsulate the whole thing into the
> template-style macro - not that I like this, but I cannot see an
> alternative.

An obvious alternative is to leave things the way they are.  I've 
noticed that this is a stance Linus typically adopts for improvements 
that aren't clearly better in every way ;-)

--
Daniel
