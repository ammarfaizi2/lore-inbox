Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129931AbQLURiv>; Thu, 21 Dec 2000 12:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbQLURik>; Thu, 21 Dec 2000 12:38:40 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:49397 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129931AbQLURi3>; Thu, 21 Dec 2000 12:38:29 -0500
Date: Thu, 21 Dec 2000 15:07:08 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: Andrew Morton <andrewm@uow.edu.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
In-Reply-To: <20001221161952.B20843@athlon.random>
Message-ID: <Pine.LNX.4.21.0012211502400.1613-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Andrea Arcangeli wrote:

> > The key question is: which of the following do we want?
> > 
> > a) A simple, specific accept()-accelerator, and 2.2 remains without
> >    an exclusive wq API or
> 
> To make the accellerator we need a minimal wake-one support. So a) doesn't
> make sense to me.
> 
> > b) A general purpose exclusive wq mechanism which does not correctly
> >    support waiting on two queues simultaneuously where one is
> >    exclusive or
> 
> That's what we had in whole 2.3.x and that is better suitable for 2.2.x
> as it allows to do a) with obviously right approch and minimal effort.
> 
> > c) A general purpose exclusive wq mechanism which _does_ support it.
> >
> > Each choice has merit!  You seem to want b).  davem wants c).
> 
> I have not read any email from DaveM who proposes C for
> 2.2.19pre3 (or 2.2.x in general). Are you sure he wasn't talking
> about 2.4.x?

c) will also implement a) in an obviously right and simple way.

I've still not seen ANY reason why we'd want 2.2 to have different
wake-one semantics from 2.4...

> > And given that 2.2 has maybe 2-4 years life left in it, I'd
> 
> I hope no ;).

People are still converting their 2.0 systems to 2.2 as
we speak. I really doubt that 2.2 has _less_ than 3 years
of life left ... as much as I hate this idea ;)

> > agree with David.  Let's do it once and do it right while the issue
> > is fresh in our minds.
> 
> I disagree. The changes to separate the two waitqueues even only
> for accept are not suitable for 2.2.x. Alan filter should forbid
> that changes.  They're simply not worthwhile because I cannot
> even think at ...

They're not worthwhile just because you can't think of an example ?

The same could be said of `b)' above. Do you have an example where
that is the preferable semantics ?

If both are equally preferable (ie. nobody can think of any example
where the corner case is being used), why do you keep insisting on
giving 2.2 different wake-one semantics from 2.4 ?

[these wake-one semantics may become rather important for people
backporting drivers to 2.2 over the next years ... or to something
else which nobody has even thought about ... 2-4 years is a long
time, so 2.2 maintainability is still an issue]

regards,

Rik
--
Hollywood goes for world dumbination,
	Trailer at 11.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
