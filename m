Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272464AbRH3VHP>; Thu, 30 Aug 2001 17:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272465AbRH3VHG>; Thu, 30 Aug 2001 17:07:06 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:3594 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272464AbRH3VGt>;
	Thu, 30 Aug 2001 17:06:49 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302106.f7UL6t917787@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <200108302044.f7UKi7c20040@wildsau.idv-edu.uni-linz.ac.at> from
 "Herbert Rosmanith" at "Aug 30, 2001 10:44:07 pm"
To: "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>
Date: Thu, 30 Aug 2001 23:06:55 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org, ptb@it.uc3m.es
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Herbert Rosmanith wrote:"
> 
> >   if sizeof(typeof(a)) != sizeof(typeof(b))
> >       BUG() // sizes differ
> 
> this is not neccessarily a problem. should work with char/short char/int
> short/int comparison.

I got the impression that linus wanted two opposite things:

   1) every possible bug made to scream out loud until the author
      paid special attention to it and put it to bed with a 
      soothing declaration

   2) completely bona fide promotions made to go silent and not
      warn at all.

I don't see how he can really see 3arg_min/max as satisfying (2), since
the author will have to look at each and every existing min/max to
decide on a type with which to frontload the new min/max.  So I felt
justified in mostly ignoring (2).

On the other hand, he did say something about -Wsignedstuff being too
verbose, so I'm not sure. Maybe the -W really does make noise about
some compares that wouldn't be flagged by the  two constraints I
suggested? If so, perhaps that was what he wanted: a weaker and
more closely controlled -Wsignedgunggg.

> only problem seems to be signed/unsigned int comparison.

I don't know how you know that! You could be right - I don't know.
I haven't seen a tight enough specification of the basic problem
for me to be able to begin to formulate a generic solution. I've just
seen some examples, some more convincing than others.

> >   const (typeof(a)) _a = ~(typeof(a))0
> >   const (typeof(b)) _b = ~(typeof(b))0
> >   if _a < 0 && _b > 0 || _a > 0 && b < 0
> >       BUG() // one signed, the other unsigned
> >   standard_max(a,b)
> 
> if sizeof(typeof(a))==sizeof(int) && sizeof(typeof(b))==sizeof(int) &&
>    ( _a < 0 && _b > 0 || _a > 0 && b < 0 )
> 	BUG() // signed unsigned int compare

What makes sizeof(int) so magic? Are you saying that the problems
don't arise between signed long long and unsigned long long? I saw
an example that seemed generic for all signed unsigned comparisons,
namely that signed int and unsigned int are compared as unsigned, so 
(unsigned)2 < (signed)-1.  Are you saying that signed long and unsigned
long are NOT compared as unsigned iff sizeof(long) != sizeof(int).
Woooo!  Who wrote the C spec? No kidding? There is a special clause
for comparisons that use the native machine word?

And I was hoping that somebody could produce some gcc magic
replacement for BUG() that means "don't compile me". Perhaps
a bit of illegal assembler code with a line reference in?
Surely gcc must have something like __builtin_wont_compile()?
It just needs to be a leaf of the RTL that evokes a compile error.

Peter
