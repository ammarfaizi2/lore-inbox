Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDEUot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDEUot (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWDEUot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 16:44:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:10122 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750791AbWDEUos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 16:44:48 -0400
Date: Wed, 5 Apr 2006 22:44:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Thomas Gleixner <tglx@linutronix.de>
cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/5] clocksource patches
In-Reply-To: <1144236167.5344.581.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604051723190.32445@scrub.home>
References: <Pine.LNX.4.64.0604031431220.25825@scrub.home> 
 <1144126422.5344.418.camel@localhost.localdomain>  <Pine.LNX.4.64.0604041218250.32445@scrub.home>
 <1144236167.5344.581.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Apr 2006, Thomas Gleixner wrote:

> > Thomas, I would really appreciate if you actually started to argue your 
> > point instead of just disagreeing with me every time. I have no problem to 
> > admit that I'm wrong, but it takes a bit more than you just saying it is 
> > so.
> 
> I on my side would appreciate, if you would stop to take every line I
> write as a personal offense.

Believe me, I'm trying very hard and I'm not easily offended, but you 
don't exactly make it easy.
For example I get very little positive feedback from you and I'd be happy 
if you gave me at least constructive criticism, but you mainly just 
contradict me. An important indicator here is asking questions, you barely 
ask me any questions, which would show you're interested in my opinion and 
would help to avoid misunderstandings as shown further below.

> > For example above you bascially only state that your clock event source 
> > is superior and the correct way of doing this without any explanation why 
> > (and the "No, thanks." doesn't exactly imply that you're even interested 
> > in alternatives). 
> 
> The question arises, who is not interested in alternatives. You are well
> aware about the efforts others made, but you don't even think about
> working together with them. Do you really expect people to jump on your
> train, when you entirely ignore their work and efforts and just propose
> your own view of the world? 

First off please leave other people out of this, I get along with other 
people quite well, it's you I continuously have these problems with.
Secondly considering my contributions to John's work, it's fucking rude of 
you to accuse me of "not interested in alternatives" and "don't even 
think about working together". There is a simple reason that e.g. I'm not 
working on the -rt tree - lack of time. For weeks now I already had no 
time to work on the m68k tree, for months now I already sit on a batch of 
kconfig patches I'm trying to make ready. As long as your stuff doesn't 
appear on lkml, I consider as in development and I spent my time on more 
important things (which may be not so important to you).

> I did nowhere say that I'm not interested in alternative solutions. You
> interpret it into my words for whatever reason.
> 
> Your way to rip out a single statement of its context and making your
> argument on that is simply annoying.
> 
> Thats the original quote:
> > How should a combo solution allow to add special hardware, which
> > provides only one of the services ? By using "something else
> > internally" ? No, thanks.
> 
> It is entirely clear, that "No thanks" is related to "something else
> internally".

The interesting part is that I never said "something else internally", 
more specifically I said "internally use another clocksource". It's you 
who made the generalization and then only talks about clock events, so 
it's easy to come to the conclusion that the "No, thanks." is not related 
to something specific I said, but to the generic "something else (than 
clock events)". I had nothing "to rip out".

> Thats the point I made further up in my first reply. It was your
> proposal to combine clock sources and clock events.

This is the point were you could have saved us a lot of grief by simply 
asking me instead of jumping to conclusions. Nowhere in my initial mail 
did I make such a proposal, I'm not even mentioning clock events.
The original quote:

> > AFAICT it's
> > more common that the subsystem which is used to read the time is also used
> > as timer (i.e. for the scheduler tick), this means the clocksource driver
> > should also include the interrupt setup.
> 
> I don't think so. Coupling the clock sources to clock event sources is
> wrong.

What I had in mind is the _current_ setup, that e.g. the scheduler tick 
can be generated by a clock event is a possibility, but since your 
clockevent patch is not even in -mm, it wasn't something I had in mind 
when I wrote this comment. This comment was specifically about the 
_current_ way time.c sets up the timer interrupt and i8253.c sets up the 
timer hardware.
I also specifically said "This is not important right now, but ... 
something to keep in mind" to indicate this needs further discussion, 
nowhere did I ever exclude the possibility to do this via clock events, 
but you just jumped at me with "this is wrong".

> Why are those seperate items ?
> 
> Looking at the various hardware implementations there are three types of
> devices:
> 
> 1. Read only devices (e.g. TSC)
> 2. Next interrupt only devices (e.g. various timer implementations on
> SoC CPUs)
> 3. Devices which combine both functions
> 
> Building an abstraction layer which handles all device types requires
> either 
> 
> - that e.g. a read only device needs to be combined with a next
> interrupt device in some way. This introduces artifical combos of
> functionality which can and should be handled completely seperate.
> 
> or 
> 
> - to handle all the corner cases where a device has to be handled which
> only provides one of the functionalies. Also the selection of different
> combinations of devices will introduce extra handling code.

Neither excludes a basic clock source abstraction, which can create any 
kind of clock events. The basic question is should any clock source be 
able to create every kind of clock events?
The problem here is that we may have to synchronize reading time with the 
timer interrupt. To make an extreme example let's assume the TSC clock is 
updated every 1msec and the PIT generates an interrupt every 1.01msec, 
this means jiffies is updated every 100th interrupt by 2. Also the NTP 
error adjustment algorithm works better with small offsets, my latest 
version compensates better for that, but a smaller offset still means a 
smaller jitter.
These kinds of problems I had in mind when I wrote "Something like TSC 
should internally use another clocksource" and if you had asked I could 
have explained this, but I had no chance as you simply jumped to your own 
conclusions. :-(

> So we have two functional domains, which provide a high level interface:
> 
> The clock source abstraction provides:
> - gettimeofday()
> - getmonotonic()
> - settimeofday()
> - clock skew adjustment functions()
> 
> The clock event source abstraction provides:
> - setup periodic events()
> - setup one shot events()
> - associate services (function to call on an event) to a clock event
> source
> 
> This is a clear seperation and there is no combined functionality.

Unfortunately it's not that simple, e.g. generating gettimeofday() 
requires a periodic event. At some point you have to combine 
functionality, whether it's done inside the clocksource or by something 
else is a different discussion. My proposal to do it inside the clock 
source was because we don't have that "something else" yet (which may be 
your clock events, I don't know).

I have to skip the rest of your mail, as it's so generic and so out of 
context that I don't really disagree with it, if there was something 
important, please put back it into some context.

bye, Roman
