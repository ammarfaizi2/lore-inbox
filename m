Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317114AbSFKOyD>; Tue, 11 Jun 2002 10:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317115AbSFKOyC>; Tue, 11 Jun 2002 10:54:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34043 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317114AbSFKOyB>;
	Tue, 11 Jun 2002 10:54:01 -0400
Message-ID: <3D060EC8.321A0D66@mvista.com>
Date: Tue, 11 Jun 2002 07:52:56 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.LNX.4.44.0206110128130.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 11 Jun 2002, Rusty Russell wrote:
> >
> > Worst sin is that you can't predeclare typedefs.  For many uses (not the
> > list macros of course):
> >       struct xx;
> > is sufficient and avoids the #include hell,
> 
> True.
> 
> However, that only works for function declarations.
> 
> typedefs are easy to avoid.
> 
> The real #include hell comes, to a large degree, from the fact that we
> like inline functions. Which have many wonderful properties, but they have
> the same nasty property typedefs have: they require full type information
> and cannot be predeclared.
> 
> And while I'd like to avoid #include hell, I'm not willing to replace
> inline functions with #define's to avoid it ;^p

On wonders if it might be useful to split header files into
say for example, list_d.h and list_i.h with the declarations
in the "_d.h" and inlines in the "_i.h".  Then we could move
the "_i.h" includes to the end of the include list.  Yeah, I
know, too many includes in includes to work.  

By the way, my reading of the C standard indicates that they
don't _have to_ compile the inlines when they are found, but
_may_ defer the compile until they are referenced by
non-inline code.  This change would fix the problem.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
