Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRFGP2k>; Thu, 7 Jun 2001 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261505AbRFGP2a>; Thu, 7 Jun 2001 11:28:30 -0400
Received: from [192.48.153.1] ([192.48.153.1]:41763 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261550AbRFGP2U>;
	Thu, 7 Jun 2001 11:28:20 -0400
Message-ID: <3B1F9CEC.928C8E66@sgi.com>
Date: Thu, 07 Jun 2001 08:25:32 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1E4CD0.D16F58A8@illusionary.com>
		<3b204fe5.4014698@mail.mbay.net> <3B1E5316.F4B10172@illusionary.com>
		<m1wv6p5uqp.fsf@frodo.biederman.org> <3B1EA748.6B9C1194@sgi.com> <m1g0dc6blz.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> There are cetain scenario's where you can't avoid virtual mem =
> min(RAM,swap). Which is what I was trying to say, (bad formula).  What
> happens is that pages get referenced  evenly enough and quickly enough
> that you simply cannot reuse the on disk pages.  Basically in the
> worst case all of RAM is pretty much in flight doing I/O.  This is
> true of all paging systems.

----
    So, if I understand, you are talking about thrashing behavior
where your active set is larger than physical ram.  If that
is the case then requiring 2X+ swap for "better" performance
is reasonable.  However, if your active set is truely larger
than your physical memory on a consistant basis, in this day,
the solution is usually "add more RAM".  I may be wrong, but
my belief is that with today's computers people are used to having
enough memory to do their normal tasks and that swap is for
"peak loads" that don't occur on a sustained basis.  Of course
I imagine that this is my belief as it is my own practice/view.
I want to have considerably more memory than my normal working
set.  Swap on my laptop disk is *slow*.  It's a low-power, low-RPM,
slow seek rate all to conserve power (difference between spinning/off
= 1W).  So I have 50% of my phys mem on swap -- because I want to
'feel' it when I goto swap and start looking for memory hogs.
For me, the pathological case is touching swap *at all*.  So the
idea of the entire active set being >=phys mem is already broken
on my setup.  Thus my expectation of swap only as 'warning'/'buffer'
zone.

    Now for whatever reason, since 2.4, I consistently use at least
a few Mb of swap -- stands at 5Meg now.  Weird -- but I notice things
like nscd running 7 copies that take 72M.  Seems like overkill for
a laptop.

> However just because in the worst case virtual mem = min(RAM,swap), is
> no reason other cases should use that much swap.  If you are doing a
> lot of swapping it is more efficient to plan on mem = min(RAM,swap) as
> well, because frequently you can save on I/O operations by simply
> reusing the existing swap page.

---
    Agreed.  But planning your swap space for a worst
case scenario that you never hit is wasteful.  My worst
case is using any swap.  The system should be able to live
with swap=1/2*phys in my situation.  I don't think I'm
unique in this respect.

> It's a theoretical worst case and they all have it.  In practice it is
> very hard to find a work load where practically every page in the
> system is close to the I/O point howerver.

---
    Well exactly the point.  It was in such situations in some older
systems that some programs were swapped out and temporarily made
unavailable for running (they showed up in the 'w' space in vmstat).

> Except for removing pages that aren't used paging with swap < RAM is
> not useful.  Simply removing pages that aren't in active use but might
> possibly be used someday is a common case, so it is worth supporting.

---
    I think that is the point -- it was supported in 2.2, it is, IMO,
a serious regression that it is not supported in 2.4.

-linda

--
The above thoughts and       | They may have nothing to do with
writings are my own.         | the opinions of my employer. :-)
L A Walsh                    | Senior MTS, Trust Tech., Core Linux, SGI
law@sgi.com                  | Voice: (650) 933-5338



