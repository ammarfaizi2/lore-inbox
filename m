Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261933AbVANJyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261933AbVANJyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 04:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVANJyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 04:54:47 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:36523 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261933AbVANJyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 04:54:44 -0500
Message-ID: <41E796DD.9040009@yahoo.com.au>
Date: Fri, 14 Jan 2005 20:54:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Will Dyson <will.dyson@gmail.com>
CC: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>, lkml@s2y4n2c.de,
       rlrevell@joe-job.com, arjanv@redhat.com, joq@io.com, chrisw@osdl.org,
       mpm@selenic.com, hch@infradead.org, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <1105669451.5402.38.camel@npiggin-nld.site>	 <200501140240.j0E2esKG026962@localhost.localdomain>	 <20050113191237.25b3962a.akpm@osdl.org> <41E739F4.1030902@kolivas.org>	 <1105673482.5402.58.camel@npiggin-nld.site> <8e6f947205011401213c39b785@mail.gmail.com>
In-Reply-To: <8e6f947205011401213c39b785@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will Dyson wrote:
> On Fri, 14 Jan 2005 14:31:21 +1100, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>  
> 
>>It sounds to me like both your proposals may be too complex and not
>>sufficiently deterministic (I don't know for sure, maybe that's
>>exactly what the RT people want).
>>
>>I wouldn't have thought it is so much a matter of having real-time-ish
>>scheduling available that tries to play nicely in a multi user machine.
>>That must still imply that either the user is able to unduly tie up
>>resources (and thus it has to be a privileged operation), or that it
>>sometimes can't meet its "guarantees" (in which case, is it useful?).
> 
> 
> The VM system with overcommit is in a similar pickle. It can't honor
> the "guarantees" it makes. Yet, I think it is in wide use. Overcommit
> is a useful behavior for many people, despite the fact that it allows
> any user to turn loose the oom_killer on the system.
> 

I'm not sure if that is a really good comparison.

> So I think many people would also find a best-effort-at-realtime
> SCHED_ISO type thing pretty useful, even if it allowed unprivileged
> users to tie up resources (while protecting the system from DOS).
> Heck, we don't have to allow unprivileged users to tie up resources.
> SCHED_ISO use could be limited to members of a certain group, possibly
> implemented using some sort of LSM module... :)
> 
> Of course, suggesting that access to SCHED_ISO be limited pretty much
> admits that running processes as SCHED_ISO should be a privileged
> operation, like accessing /dev/dsp (a privilege that is granted
> through group membership on most desktops).
> 

Now I'm not adverse to cool hacks, and I haven't thought about
SCHED_ISO enough to comment on it much (nor has its behaviour
even been firmly defined as far as I know).

But regarding the kernel in general and the scheduler especially:
it is pretty important to fight feature creep. SCHED_ISO will have
a non zero cost in terms of complexity, maintainability, and
probably performance.

So the only way it can go in is if a non trivial number of people
really need it for things that can't be satisfied in userspace or
with a good privilege system or [something elegant], etc.

I'm not by any means stopping anyone from coming up with a firm
definition for SCHED_ISO, implementing it, and demonstrating that
it is the best way to solve a problem that X people care about,
and that its benefits outweigh its inevitable costs...
I'm just giving some frank advice.

> 
>>I was thinking that the solution might be more along the lines of
>>a nice way to handle privileges for these guys.
> 
> 
> A nice,  flexible way to hand out scheduler (and perhaps other)
> privileges would be... nice. Are you thinking of something more
> fine-grained than per-user?
> 

I'm not too sure, that topic's out of my league... But that is
basically what is sought after by the guys behind the realtime LSM.
So I'd better stop hijacking their thread!

