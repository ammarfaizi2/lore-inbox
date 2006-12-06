Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936461AbWLFQn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936461AbWLFQn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 11:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936463AbWLFQn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 11:43:26 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47664 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936461AbWLFQnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 11:43:25 -0500
Date: Wed, 6 Dec 2006 17:42:35 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061206152244.GA24613@elte.hu>
Message-ID: <Pine.LNX.4.64.0612061633230.1867@scrub.home>
References: <20061204204024.2401148d.akpm@osdl.org> <Pine.LNX.4.64.0612060348150.1868@scrub.home>
 <20061205203013.7073cb38.akpm@osdl.org> <1165393929.24604.222.camel@localhost.localdomain>
 <Pine.LNX.4.64.0612061334230.1867@scrub.home> <20061206131155.GA8558@elte.hu>
 <Pine.LNX.4.64.0612061422190.1867@scrub.home> <20061206152244.GA24613@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Ingo Molnar wrote:

> > > > > If I understand it correctly, Roman wants clockevents to be usable 
> > > > > for other things aside hrtimer/dyntick, i.e. let other code request 
> > > > > unused timer event hardware for special purposes. I thought about 
> > > > > that in the originally but I stayed away from it, as there are no 
> > > > > users at the moment and I wanted to avoid the usual "who needs that" 
> > > > > comment.
> > > > 
> > > > Nonsense, [...]
> > > 
> > > why do you call Thomas' observation nonsense?
> > 
> > What's the point of this question? [...]
> 
> the point of my question was what it said: to ask you why you called 
> Thomas' pretty fair observation 'nonsense'.

The nonsense comment was regarding the 'the usual "who needs that" 
comment', how is it possible that Thomas can observe something that hasn't 
happened yet?

> > [...] Your answer is/was in the "[...]" part.
> 
> meaning:
> 
> > > > [...] one obvious user would be the scheduler, [...]
> 
> but that is not a refutation of what Thomas said, at all. You say that 
> the scheduler /could/ use such a facility. What Thomas said was that 
> /there are no current users of such a facility/. It is a really simple 
> (and unconditionally true) observation from Thomas. Yes, we could change 
> other kernel code not directly related to high-res timers, but we chose 
> not to.

I didn't say "/could/", the scheduler _needs_ such a facility. If hrtimer 
and scheduler have to use the same facility, they have to be coordinated 
somehow. The current patches don't clean up anything here and actually 
introduce extra complexity via the scheduler tick emulation, with little 
to no indication how this will be cleaned up. Others may have more faith, 
that it will somehow work out, but I'd like to get a bit more information 
beforehand.

> > > Fact: there is no current user of such a facility. What we 
> > > implemented, high-res timers and dynticks does not need such a 
> > > facility.
> > 
> > Fact: there _are_ users which need a timer facility (e.g. the 
> > scheduler).
> 
> this is something we are not contesting at all: that a new timer 
> facility /could/ be used by /other/ kernel code, which does /not/ use it 
> right now.
> 
> our point is simple: the code we add does not in itself necessiate the 
> new facility, hence we didnt add it. We didnt want to impact other 
> kernel code, just yet. We repeat: we agree (in theory) with such a 
> facility, but we wanted to do it separately.

You don't really refute that this eventually will impact other code. The 
problem here is that there is pretty much no plan how this will happen. 
Without this information most developers cannot tell (without diving deep 
into these issues), how this will impact existing code (e.g. all the arch 
timer code) or how much more cruft this is going to add, which may have to 
be cleaned up later again. Maybe this code is perfect, but how is anyone 
going to tell?

> > > we wholeheartedly agree that such a facility 'would be nice', and 
> > > 'could be used by existing kernel code' but we didnt want to chew 
> > > too much at a time.
> > 
> > Maybe the existing code should have been cleaned up first? 
> 
> yes, we'll do that, and we have a good track record doing such cleanups. 

You didn't answer my question, how are you going to do this _first_?

> > > > [...] one obvious user would be the scheduler, [...]
> > > 
> > > But cleaning up the scheduler tick was not our purpose with high-res 
> > > timers nor with dynticks. One of your previous complaints was that the 
> > > patches are too intrusive to be trusted. Now they are too simple?
> > 
> > Would you please stop these personal attacks?
> 
> please point it out which portion of the above two sentences you 
> consider a personal attack - or if you cannot, please retract your 
> baseless accusation.

Ingo, above it's you who makes a baseless accusation in the first place.
Your accusation is so generic, that I have no other way than to take this 
personally.

> Fact: you did complain in the past about the complexity and/or 
> intrusiveness of our high-res timers patches - we've been working on 
> getting high-res timers upstream for more than a year now.
> 
> Fact: you did complain about unused facilities in past patches of ours, 
> and your feedback caused us significant extra work to remove those 
> facilities, just to reintroduce them later again.

As long as you see my comments only as "complaining", I'm not really 
surprised we don't get nowhere...

> this time around we chose the minimalistic approach, we didnt add 
> anything that is not immediately needed, and we didnt want to increase 
> intrusiveness by "cleaning up" other code and changing it over to the 
> new facilities.

At the risk of repeating myself:

Since this is very important code, it would be rather useful to know
what's coming and to get to an agreement about the general direction this
code is taking. This code has to cover a wide range of applications, where
as you guys are rather focused on realtime applications, which is ok, but
we need to _carefully_ rethink how time is managed within the kernel,
instead of randomly poking around in the kernel.

> It cannot be had both ways: either we stay simpler and less intrusive, 
> or we go more generic but more intrusive.

You miss the point, I don't care how intrusive this is, but with every 
step we make we have to keep the big picture in mind and the latter is 
seriously lacking here.
I have my doubts about where this is going and all I'm getting from you 
now (again) is that you try to turn this around and put all the blame on 
me. Sorry, Ingo, I'm not taking it and if you continue like this it will 
end like this every single time.

bye, Roman
