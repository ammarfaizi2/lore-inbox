Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267950AbRGVKTA>; Sun, 22 Jul 2001 06:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267951AbRGVKSu>; Sun, 22 Jul 2001 06:18:50 -0400
Received: from mx02.uni-tuebingen.de ([134.2.3.12]:16136 "EHLO
	mx02.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S267950AbRGVKSc>; Sun, 22 Jul 2001 06:18:32 -0400
Date: Sun, 22 Jul 2001 12:18:06 +0200 (CEST)
From: Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "Brian J. Watson" <Brian.J.Watson@compaq.com>,
        Larry McVoy <lm@bitmover.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Common hash table implementation
In-Reply-To: <01072122255100.02679@starship>
Message-ID: <Pine.LNX.4.21.0107221207460.3066-100000@bellatrix.tat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sat, 21 Jul 2001, Daniel Phillips wrote:

> On Saturday 21 July 2001 02:24, Brian J. Watson wrote:
> > Daniel Phillips wrote:
> > Richard Guenther sent the following link to his own common hashing
> > code, which makes nice use of pseudo-templates:
> >
> > http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/~checkout~/glame/glame
> >/src/include/hash.h?rev=1.5&content-type=text/plain
> >
> > A few things I would consider changing are:
> >
> >   - ditching the pprev pointer
> 
> Yes, you want to use the generic list macros there.

You get one-pointer size hash table entries and generic deletion from it.
 
> >   - encapsulating the next pointer inside a struct hash_head_##FOOBAR
> 
> I think the generic list macros give you that for free.

Umm, if you use such, you get lists.h style type-casting stuff which
doesnt have a nice interface as

my_type *hash_find_my()

instead you'd get

hash_dead_my *hash_find_my()

which you'll have to cast with something like the list_entry() macro.

> >   - stripping out the hard-coded hashing function, and allowing the
> >     user to provide their own

Ok, if the two expressions are not generic enough.

> Naturally.  And trying to reduce the size of the macros.  It's not that 
> easy to get stuff that has dozens of lines ending with "\" into the 
> kernel.  You might have better luck just generalizing a few short sets 
> of common operations used in hashes, and showing examples of how you'd 
> use them to rewrite some of the existing hash code.  Obviously, the 
> new, improved approach has to be no less efficient than the current way 
> of doing things.

All those \s are to encapsulate the whole thing into the template-style
macro - not that I like this, but I cannot see an alternative.

> > All the backslashes offend my aesthetic sensibility, but the
> > preprocessor provides no alternative. ;)
> 
> It's hard to argue against using inlines there.  It's true that there 
> are a lot of generalizations you just can't do with inlines, but so 
> what?  What matters is how efficient the generated code is and to a 
> lesser extent, how readable the source is.  You could make that source 
> quite a bit more readable with a few *small* macros and some inline 
> functions.  Suggestion: express the bucket probe as an inline, compute 
> the hash outside and pass it in.  Then you can wrap the whole thing up 
> in a really short macro.

Ok, with an approach like the list.h one (struct hash_head) you'd get
there, but of course without automatic type conversion (and safety).
Of course, if you can tidy up the macro without changing to use a
hash_head structure, I'd be glad to see how :)

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

