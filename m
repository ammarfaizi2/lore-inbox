Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313307AbSEYDsX>; Fri, 24 May 2002 23:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313314AbSEYDsW>; Fri, 24 May 2002 23:48:22 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:12303 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S313307AbSEYDsV>; Fri, 24 May 2002 23:48:21 -0400
Message-ID: <3CEF0911.425C00E7@opersys.com>
Date: Fri, 24 May 2002 23:46:25 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andrea Arcangeli <andrea@e-mind.com>, Dan Kegel <dank@kegel.com>,
        Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Christoph Rohland <cr@sap.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205242020010.4051-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds wrote:
> On Fri, 24 May 2002, Karim Yaghmour wrote:
> > This is incorrect, see below.
> 
> This is _correct_.
> 
> The fact that under RTAI it isn't the case does not change the fact that
> under RTLinux it _is_.

Fine, but aren't you the least bit interested in seing how it is done in 
the other real-time Linux implementation?

> > I'm sorry, but I'm missing the point here about visualization tools.
> > Such tools are not part of any of the real-time Linux community's
> > concerns.
> 
> With RTLinux, you have to split the app up into the "hard realtime" part
> (which ends up being in kernel space) and the "rest".
> 
> Which is, in my opinion, the only sane way to handle hard realtime. No
> confusion about priority inversions, no crap. Clear borders between what
> is "has to happen _now_" and "this can do with the regular soft realtime".

There are no priority inversions in the case of RTAI hard-real-time processes
either. They get scheduled exactly as other real-time processes and they
can have priority even over real-time tasks within modules.

Moreover, I would like to point out that many real-time developers like
to have memory protection for their tasks. Hard-real-time in the kernel
with RTLinux isn't possible. Hard-real-time in user-space with RTAI
is.

There is no reason that what happens _now_ shouldn't have memory protection
and what happens later should.

> Your claim was that RTLinux made realtime hard to do with licensing
> concerns. MY claim is that if you actually were to use RTLinux, you
> wouldn't _have_ any licensing concerns: the kernel module would have to be
> GPL (both because the kernel wants it that way _and_ because you get the
> liences to the patent that way), and the user-level code that uses
> whatever data the RT module produces is no longer hard realtime at all.

Sure. I'm not contesting the merits of using GPL modules. True, this
is the best way to go. However, not everyone has this option and my
claim is that this is one of the facts that is putting Linux out in the
cold in front of the competition in regards to rt.

That said, I wouldn't be using RTLinux, I'd be using RTAI to implement
both the collection and visualization tasks in user-space. The separation
between what's hard-rt and what's soft-rt could then be done either on
a process basis or even separate C files within the same program.

Again, why should hard-rt tasks not use memory protection when they can?

> Clean separation, both from a license standpoint _and_ from a purely
> technical standpoint.

Again, from a purely technical standpoint, there are many advantages in
having the hard-rt tasks in user-space. As for the licensing standpoint,
the issues "should" also be very clear: since the hard-rt tasks are in
user-space, then they are covered by the GPL-exclusion put in place in
the Linux kernel.

I say "should" because nothing is clear in the current situation and
this is pivotal in developers' decision to use or not to use Linux.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
