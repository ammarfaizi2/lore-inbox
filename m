Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJPNeP>; Tue, 16 Oct 2001 09:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276247AbRJPNeH>; Tue, 16 Oct 2001 09:34:07 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:20748 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S276231AbRJPNdx>; Tue, 16 Oct 2001 09:33:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: David Lang <dlang@diginsite.com>
Subject: Re: VM
Date: Tue, 16 Oct 2001 09:34:23 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110152111280.1380-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.40.0110152111280.1380-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011016133402Z276231-17408+990@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 October 2001 00:40, David Lang wrote:
> and the problem with trying to do the perfect thing in every situation is
> that you need to predict all the situations so that you have the right
> response for each one.

predicting more situations ...not every situation.  Our brains aren't 
hardcoded with the knowledge of how to deal with everything ...that would be 
as impossible as predicting all situations dealing with VM.   Instead it 
looks at more variables and decides upon that what to do.  

> it gets even worse when you have a mix of loads (parts of several
> different basic situations).

This is where a complex solution can be better than a simple.  A mix of loads 
means you'll have different Kinds of programs....not just different programs, 
asking the VM for various things.  Because they're different kinds of 
programs they'll benefit from not being treated all under a vague reaction 
that would be given by a simplistic VM.  A simplistic solution may be faster 
in doing what it does, but in the real world time goes on from that point and 
what the VM did before effects what is happening later.  And overall a 
simplistic solution may actually hurt the performance of a VM.  

> this is why a simpler solution that may not be quite as good in several of
> the simple situations can end up being a winner in the real world (where
> you almost always have a mix of situations)

A complex solution (that works), will handle memory in a way that makes what 
is going to happen next, more efficient.  We see this in Rik's vm.  This 
makes overall VM performance much smoother and in most people's opinions, 
better.  

> also if you have a lot of special cases you need to choose between you
> can easily  end up spending more time selecting the proper mode then you
> save by being in that mode

True, but taking a tiny bit of time to find the right mode may save a lot of 
time in the long run by having memory allocated in a more efficient way for 
new accesses.  We see this from the VM being reported "more smooth".   The 
jerkiness in a vm is caused by having to correct a past operation that 
probably put too much memory somewhere it wasn't needed and now it needs it 
so it has to take the time to deallocate it and then allocate it to the new 
one. 

> one thing that the entire 2.[34] VM hassle has shown is that the VM
> hackers don't have a good handle on the real world loads along with a way
> to reasonably duplicate those loads in testing (if anyone had any idea
> what sort of VM problems 2.4 would have they would have been resolved in
> the 2.3 series, right?) This makes simple/general solutions better then
> attempts to define and select a bunch of special purpose solutions.

The thing with benchmarks is that you'll always have people saying they're 
not valid and people saying they are.  If you want to package a bunch of 
static binaries and write a script to time and give all sorts of stats while 
it runs them in some series or concurrently, go for it.  But even if you do 
and they're all programs most people run daily, people will still say that 
it's not valid due to compiler optimizations.  It's a lose-lose situation 
with testing.   The only way to do it is go with the majority's reaction to 
it on their own systems, there is no fast simulation way that will appease 
people. 

> from the looks of things Rik's VM is getting to the point where it is
> almost covering enough special cases to be practical, but for the reasons
> I gave above I have less confidence in it then in the AA VM for the near
> future. Long term may be a different story however.

Practicality is subjective obviously.   It depends on which definitions of 
stability and performance you are concerned with.  Both are valid in their 
areas of use but in the end what will determine which gets used is going to 
be just how much of a hit does Rik's vm do on servers and such by being 
complex and less predictable.  Just because it's less predictable doesn't 
mean it will hinder a running server in the long run, perhaps it'll be better 
for a server that stays up for a long time.  Only people running it will 
tell. 

> One thing that I think is needed for future 2.4/2.5 before much more
> VM development can be done is some significant instramentation of the
> existing VM to gather data on real-world loads along with some simulater
> to be able to recreate them. without this sort of data and tools the best
> that the VM hackers can do is to test it on the machines and loads they
> see and hope that they cover enough cases to make the special casing
> approach work, otherwise we keep running the risk of the same type of
> problems with the next implementation.
>
> in part this is a chicken-and-egg problem, until the new VM gets extensive
> real-world testing it won't run into all the corner cases to be able to
> see if it works well but this also means that when released on the general
> user base it will break peoples servers. thus the need for better
> documentation and instramentation of the real world loads (becouse they
> are frequently NOT the 'best' way of doing things and in some cases they
> are downright bad ways)

People who use the latest 2.4.x kernel aren't running critical servers, 
rebooting back to their previous non-Rik vm kernel wont be much of an issue. 
It wont "break" anything, rather just be better or worse performance wise.  
If you can afford to reboot to upgrade to the latest 2.4.x, you can afford to 
reboot to move back to your backup kernel. 
Makeing a standard way of testing "real world" things is bad.  Real world 
tests are unlimited and thus can be very hard to recreate but with this way 
you can actually see the "special" cases that become more apparent when more 
users use the kernel much earlier.  This would be the same as your statement 
above about releasing a bad kernel onto the public as a stable kernel.  If 
you tune to a standard real world test that some people come up with, then 
you are no longer tuning for the real world since you lose that 
unpredictability that real users can enter into the equation. 

Like i said before, tests are a lose lose situation,  if you dont do them you 
release code unto the world that is well, untested.  If you do them, then 
you're tuning for your test and not the real world and you have people saying 
that the test is invalid or biased.  Well, so far not using a test is out of 
the question and Both VM's certainly get their round of testing, the 
contraversy with that is what tests are important in the real world.  Figure 
that out and maybe you'll get somewhere with figuring out which VM is better 
for everyone.  If you manage to convince everyone that those tests are 
important to the real world, you're probably writing the code and/or a 
god-like being. 


> David Lang
>
>  On Tue, 16 Oct 2001, safemode wrote:
> > Date: Tue, 16 Oct 2001 01:08:02 -0400
> > From: safemode <safemode@speakeasy.net>
> > To: linux-kernel@vger.kernel.org
> > Subject: Re: VM
> >
> > I think it was said earlier that we're dealing with definitions of
> > stability and performance.
> > If you look at stability as being able to depend on an effect given a
> > cause, then andrea's has been said to be more stable in that sense.   If
> > you look at performance being the amount of different situations  that
> > the vm is stable and everything else being a lower priority, then
> > andrea's vm is better performing.
> >
> > Rik's vm is performance first, meaning it tries to do what's best for
> > each situation and basically the difference is that rik's vm has more
> > variables effecting what happens.  This treats everything differently but
> > it means that each situation is dealt with personally instead of trying
> > to blanket each like situation.  That basically destroys our previous
> > definition of stability.  So we make a new one.  Stability here deals
> > with how much the system needs to stop other things for VM things.  Of
> > course the not corrupting things and crashing things are implied to both
> > definitions. For instance though,  when you swap, that takes time away to
> > write to disk. This can take longer than a complex way of re-arranging
> > pages and removing pages in ram.
> >
> > It seems like andrea's vm is more tuned for systems that do the same
> > things over and over, like a server.  And rik's vm is more tuned for
> > systems that you dont know what is going to be run or is running numerous
> > programs that have no real regularity.
> >
> > And complex does not mean smart, but it doesn't mean it can't be smart. 
> > When you're dealing with something as complex as a VM, using a simplistic
> > approach may just be too limiting in the end and I think many people are
> > seeing that when they say programs are more responsive in alan's kernel
> > and memory usage is more efficient.  It doesn't seem very logical to make
> > the VM do B when you do A on a multiprocessing system unless the
> > environment is exactly the same every time you do A because what's good
> > at one time doesn't mean it's good the second or third time you do it
> > either due to memory limitations or other applications requiring
> > different things of the VM.
> >
> > I'm kind of picturing the two VM's like the two parts of our brain.  The
> > brain stem (sometimes called the reptillian brain) and the cerebrum. 
> > Your reptillian brain is quite fast at reacting and can make a few
> > decisions on what to do based on a few specific variables.   The cerebrum
> > is slower at those same tasks but it better manages those tasks, based on
> > many more variables, so that the reaction is not too much or too little
> > so that the next thing that happens is in a better position than what the
> > reptillian brain would have left for it.
> >
> > Of course being able to do more means you have opened yourself up to more
> > problems.  I wont speak for all ac branch users, but i feel that the more
> > complex way of handing memory is a better choice because it's a function
> > of the kernel that demands a complex solution. A simplistic solution is
> > too limited, it would be like reacting from your brain stem and
> > overreacting instead of using your higher logic and taking a more
> > educated reaction.
> >
> > And that's all the contraversy, deciding if 2.4's VM demands a complex
> > solution that handles each situation uniquely,  or it can have a simple
> > solution that handles a wide range fairly good.
> >
> > Perhaps aiming for a simplistic VM should be the goal of 2.5 from the
> > beginning ( as if it wasn't), that way you can build everything else
> > around it and avoid all this vm trouble that 2.4 has been plagued with
> > since the mid 2.3 days.
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
