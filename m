Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283842AbRK3X57>; Fri, 30 Nov 2001 18:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283835AbRK3X5u>; Fri, 30 Nov 2001 18:57:50 -0500
Received: from bitmover.com ([192.132.92.2]:47290 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283833AbRK3X5l>;
	Fri, 30 Nov 2001 18:57:41 -0500
Date: Fri, 30 Nov 2001 15:57:40 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Larry McVoy <lm@bitmover.com>, Daniel Phillips <phillips@bonn-fries.net>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <20011130155740.I14710@work.bitmover.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Larry McVoy <lm@bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Henning Schmiedehausen <hps@intermeta.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF8451D8AC.A8591425-ON4A256B12.00806245@au.ibm.com> <E169scn-0000kt-00@starship.berlin> <20011130110546.V14710@work.bitmover.com> <E169vcF-0000lQ-00@starship.berlin>, <E169vcF-0000lQ-00@starship.berlin>; <20011130140613.F14710@work.bitmover.com> <3C08057D.48645B56@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3C08057D.48645B56@zip.com.au>; from akpm@zip.com.au on Fri, Nov 30, 2001 at 02:17:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 02:17:33PM -0800, Andrew Morton wrote:
> Larry McVoy wrote:
> > 
> > Linux isn't there yet
> > and unless the development model changes somewhat, I'll stand behind my
> > belief that it is unlikely to ever get there.
> 
> I am (genuinely) interested in what changes you think are needed.

Well I have an opinion, not sure if it will be well received or not,
but here goes.

There is a choice which needs to be made up front, and that is this:

    do you want to try and turn the Linux kernel hackers into Sun style
    hackers or do you want to try something else?

This assumes we have agreement that there is a difference between the
two camps.  I'd rather not get into a "this way is better than that way"
discussion, let's just postulate that the Sun way has some pros/cons
and so do the Linux way.

If you want to try and make Linux people work like Sun people, I think
that's going to be tough.  First of all, Sun has a pretty small kernel
group, they work closely with each other, and they are full time,
highly paid, professionals working with a culture that is intolerant of
anything but the best.  It's a cool place to be, to learn, but I think
it is virtually impossible to replicate in a distributed team, with way
more people, who are not paid the same or working in the same way.

Again, let's not argue the point, let's postulate for the time being
that the Linux guys aren't going to work like the Sun guys any time soon.

So what's the problem?  The Sun guys fix more bugs, handle more corner
cases, and scale up better (Linux is still better on the uniprocessors
but the gap has narrowed considerably; Sun is getting better faster than
Linux is getting better, performance wise.  That's a bit unfair because
Linux had, and has, better absolute numbers so there was less room to
improve, but the point is that Sun is catching up fast.)

As the source base increases in size, handles more devices, runs on more
platforms, etc., it gets harder and harder to make the OS be reliable.
Anyone can make a small amount of code work well, it's exponentially
more difficult to make a large amount of code work well.  There are lots
of studies which show this to be true, the mythical man month is a good
starting place.

OK, so it sounds like I'm saying that the Linux guys are lame, Sun is
great, and there isn't any chance that Linux is going to be as good
as Solaris.  That's not quite what I'm saying.  *If* you want to play
by the same rules as Sun, i.e., develop and build things the same way,
then that is what I'm saying.  The Linux team will never be as good
as the Sun team unless the Sun team gets a lot worse.  I think that's
a fact of life, Sun has 100s of millions of dollars a year going into
software development.  ESR can spout off all he likes, but there is no
way a team of people working for fun is going to compete with that.

On the other hand, there is perhaps a way Linux could be better.  But it
requires changing the rules quite a bit.

Instead of trying to make the Linux hackers compete with the Sun hackers,
what would happen if you architected your way around the problem?
For example, suppose I said we need to have a smaller, faster, more
reliable uniprocessor kernel.  Suppose I could wave a magic wand and
make SMP go away (I can't, but bear with me for a second).  The problem
space just got at least an order of magnitude less complex than what Sun
deals with.  I think they are up to 32-64 way SMP and you can imagine,
I hope, the additional complexity that added.  OK, so *if* uniprocessor
was the only thing we had to worry about, or say 2-4 way SMP with just
a handful of locks, then can we agree that it is a lot more likely that
we could produce a kernel which was in every way as good or better than
Sun's kernel, on the same platform?  If the answer is yes, keep reading,
if the answer is no, then we're done because I don't know what to do if
we can't get that far.

For the sake of discussion, let's assume that you buy what I am saying
so far.  And let's say that we agree that if you were to toss the SMP
stuff then we have a good chance at making a reliable kernel, albeit
an uninteresting one when compared to big boxes.  If you want me to go
into what I think it would take to do that, I will.

The problem is that we can't ignore the SMP issues, it drives hardware
sales, gets press, it's cool, etc.  We have to have both but the problem
is that if we have both we really need Sun's level of professionalism
to make it work, and it isn't realistic to expect that from a bunch of
underpaid (or not at all paid) Linux hackers.

Here's how you get both.  Fork the development efforts into the SMP part
and the uniprocessor part.  The uniprocessor focus is on reliability,
stability, performance.  The SMP part is a whole new development effort,
which is architected in such a way as to avoid the complexity of a
traditional SMP implementation.

The uniprocessor team owns the core architecture of the system.  The
abstractions provided, the baseline code, etc., that's all uni.  The
focus there is a small, fast, stable kernel.

The SMP team doesn't get to touch the core code, or at least there is 
a very strong feedback loop against.  In private converstations, we've
started talking about the "punch in the nose" feedback loop, which means
while it may be necessary to touch generic code for the benefit of SMP,
someone has to feel strongly enough about it that they well sacrifice
their nose.

It would seem like I haven't solved anything here, just painted a nice
but impossible picture.  Maybe.  I've actually thought long and hard 
about the approach needed to scale up without touching all the code
and it is radically different from the traditional way (i.e., how
Sun, SGI, Sequent, etc., did it).  If you are interested in that, I'll
talk about it but I'll wait to see if anyone cares.

The summary over all of this is:

    If you want to solve all the problems that Sun does, run on the same
    range of UP to big SMP, Linux is never going to be as reliable as 
    Solaris.  My opinion, of course, but one that is starting to gain
    some traction as the OS becomes more complex.

    That leaves you with a choice: either give up on some things,
    magically turn the Linux hackers into Sun hackers, or
    architect your way around the problem.

My vote is the last one, it fits better with the Linux effort, the answer
is way more cool than anything Sun or anyone else has done, and it lets
you have a simple mainline kernel source base.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
