Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281704AbRKZOPd>; Mon, 26 Nov 2001 09:15:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281701AbRKZOPY>; Mon, 26 Nov 2001 09:15:24 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:53690 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S281696AbRKZOPH>; Mon, 26 Nov 2001 09:15:07 -0500
Date: Mon, 26 Nov 2001 08:14:25 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200111261414.IAA83967@tomcat.admin.navo.hpc.mil>
To: robert.cohen@anu.edu.au, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] 2.5/2.6/2.7 transition
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Cohen <robert.cohen@anu.edu.au>:
> Linus Torvalds wrote
> 
> >So I could throw a 2.6 directly over the fence, and start a 2.7 series,
> >but that would have two really killer problems
> >
> > (a) I really don't like giving something bad to whoever gets to be
> >     maintainer of the stable kernel. It just doesn't work that way:
> >     whoever would be willing to maintain such a stable kernel would be a
> >     real sucker and a glutton for punishment.
> .
> . 
> >The _real_ solution is to make fewer fundamental changes between stable
> >kernels, and that's a real solution that I expect to become more and more
> >realistic as the kernel stabilizes. I already expect 2.5 to have a _lot_
> >less fundamental changes than the 2.3.x tree ever had - the SMP
> >scaliability efforts and page-cachification between 2.2.x and 2.4.x is
> >really quite a big change.
> 
> 
> I think theres a more fundamental problem with our model of kernel
> development.
> It would be nice to have stable kernel releases much more often, say
> every 6- 8 months.
> Or at worst once a year.
> But the way we do development just doesn't lend itself to that.
> Lots of experimental code gets dumped into the devel kernel, by the time
> that gets sorted out, something else experimental has been pushed in
> elsewhere. We try to get around this by having freeze periods, but that
> seems unnatural. And in a freeze period, you have the quandry of if
> something is unstable, do you try to fix it or do you pull it out.
> 
> Essentially the problem of stabilising a devel kernel is itself
> unstable. Its a battle between bug fixers trying to stabilise things and
> developers trying to get new features in. And to go from a devel kernel
> to a stable kernel, everything has to be stable at the same time. Which
> historically has been a real problem :-)
> 
> I don't know if it would really work any better in practise, but I would
> like to propose for consideration a 3 level model of kernel development.
> 
> You have 3 kernel trees
> 
> 2.4.x: the stable kernel
> 2.5.x: the development area for our 2.6 candidate
> Experimental: the real development area
> 
> The basic model of development is that code gets developed and tested in
> experimental.
> The only thing stuff that gets into 2.5 is code that has been in
> experimental for a while and generally considered stable.
> The goal is that at any point in time, 2.5 should be a fairly reasonable
> candidate for 2.6.
> Every so often when there's general agreement, 2.5 gets promoted to 2.6
> and we start again
> We don't have the great quandry of how to stabilise 2.5 enough to be
> ready for a stable kernel. Its always more or less ready. So we can have
> a much quicker cycle time.

I believe this has been tried before (ancient history).

What occurs is that fixes applied to the "development" area have to be
patched both forward and sometimes backward. Patches to the experimental must
then also be back ported to at least one, and possibly two versions.

Granted, this depends on what the patch is.

> The only stuff what would go into 2.4 is clear bug fixes and
> occasionally stable code (eg drivers) from 2.5 which have been
> backported.

And patches to drivers backported as errors show up; which may need to be
ported to 2.5 and to the experimental...

> People have been sort of using this kind of scheme unofficially anyway.
> Alan's AC kernels and Andrea's AA kernels have been sort of fulfulling
> this role. I am suggesting that we formalise this arrangement.

Difference in view  -  (at least in the 2.3/2.4 varieties...). There was a
LOT of work done on two nearly incompatable VM implementations. Each workd,
but were better in different ways. This brings up a different notion --
more loadable modules (including a VM module, a scheduling module) along with
the current device modules, filesystem modules, and (hopefully) a usable
security module.

If more modular developement were done, then the core boot function could
end up being a module loader.

It would also make it easier to identify/exclude unstable elements when a
new release is "ready".

And I know that it has been posed that a VM module and scheduling module would
impose too much overhead for production use. (My comment on that is "yes, but
once you have selected the appropriate VM/scheduling module you should then
compile it in".)
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
