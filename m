Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261398AbVBBFMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261398AbVBBFMx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 00:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVBBFMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 00:12:53 -0500
Received: from mail.joq.us ([67.65.12.105]:26548 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261398AbVBBFM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 00:12:28 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
References: <20050124085902.GA8059@elte.hu> <20050124125814.GA31471@elte.hu>
	<20050125135613.GA18650@elte.hu> <87sm4opxto.fsf@sulphur.joq.us>
	<20050126070404.GA27280@elte.hu> <87fz0neshg.fsf@sulphur.joq.us>
	<1106782165.5158.15.camel@npiggin-nld.site>
	<874qh3bo1u.fsf@sulphur.joq.us>
	<1106796360.5158.39.camel@npiggin-nld.site>
	<87pszr1mi1.fsf@sulphur.joq.us> <20050127113530.GA30422@elte.hu>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 01 Feb 2005 23:10:48 -0600
Message-ID: <873bwfo8br.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo, 

I hope we can get past this anger and continue working together.  We
have too much to gain by cooperating.  It would be a shame to let hurt
feelings get in the way for either of us.

> * Jack O'Quin <joq@io.com> wrote:
>> Well, this extremely long discussion started with a request on behalf
>> of a large group of audio developers and users for a way to gain
>> realtime scheduling privileges without running as root.
>> 
>> Several kernel developers felt that would be unacceptable, because of
>> the Denial of Service implications.  We argued that the owner of a
>> Digital Audio Workstation should be free to lock up his CPU any time
>> he wants.  But, no one would listen. [...]

Ingo Molnar <mingo@elte.hu> writes:
> i certainly listened, but that didnt make the RT-LSM proposal better in
> any way!

You co-opted the whole discussion in the direction you already wanted
to go.  To me, that isn't listening.

> So in the Linux core code we have zero tolerance on crap. We are
> doing this for the long-term fun of it.

So, we should never do anything boring, even though people actually
need it?  

The fact that a large group of frustrated Linux audio developers could
find no better outlet than to develop this solution is a rather strong
indictment of the kernel requirements-gathering process.

> and if nobody ends up writing the 'proper' solution then there probably
> wasnt enough demand to begin with ... We'll rather live on with one less
> feature for another year than with a crappy feature that is twice as
> hard to get rid of!

Is nobody responsible for figuring out what users need?  I didn't
realize kernel development had become so disconnected.

The implicit assumptions are that (1) only problems for which someone
has submitted a nice, clean patch are worth working on, and (2) only
kernel developers are smart enough to understand the real requirements.

> you might ask yourself, 'why is this so, and why cannot the Linux guys
> apply pretty much any hack as e.g. userspace code might': the difference
> in the case of the kernel is compatibility with thousands of
> applications and millions of users. If we expose some method to
> applications then that decision has to stick in 99.999% of the cases. 
> It's awfully hard to get rid of a bad, user-visible feature. Also,
> kernel code, especially the scheduler (and the security subsystem) is
> complex, interdependent, performance-sensitive and is modified very
> frequently - any bad decision lives with us for long, and hinders us for
> long.

I do understand binary compatibility and OS maintenance very well.
That is why I submitted a solution with *no* Application Programming
Interface and no hit to the scheduler.

Remember when I asked how you handle changes to sizeof(struct rusage)?
That was a serious question.  I hope there's a solution.  But, I got
no answer, only handwaving.

> Put your hand on your heart and tell me, assuming RT-LSM went in, and in
> a year's time i'd write the rlimit patch, would you even test my rlimit
> patch with your audio apps? Or would you have told me 'sorry, RT-LSM is
> good enough for our purposes and i dont have time to test this now'.

Yes, I would.  Even if you keep insulting me.  I would do it because
(like you) I want to make things better.  We don't have to be friends
to work together, though a little mutual respect *would* help.

Maybe you recall when I offered to help with realtime testing last
year.  It was a major embarrassment that 2.6.0 shipped with low
latency claims when in fact it was quite inferior to 2.4 with the low
latency patches.  (Thanks to you, in 2.6.10 it finally is not.)  No
one thought this was important enough to accept my offer.  After all,
if I were smart, I would be a kernel programmer, right?

> so we have two different goals. You want a feature. We want robust
> features. Those goals do meet in that we both want features, but our
> interests are exactly the opposite in terms of quality and timeframe:
> you want a solution that meets _your_ needs, as soon as possible - while
> we want a longterm solution. (i.e. a solution that is as generic, clean,
> maintainable and robust as possible.)

The LSM was a stop-gap measure intended to tide us over until a real
fix could be "done right" for 2.8.  It had the advantage of being
minimally disruptive to the kernel and its maintainability.  In that
role it is a success[1].

 [1] http://packages.debian.org/testing/misc/realtime-lsm-module-2.6.8-1-686-smp

I am still amazed that you are willing to make scheduler changes in
the 2.6 development stream.  But, that is your decision to make.

> What would you have told me if my patch also removed RT-LSM (because it
> implemented a superior method and i wanted to get rid of the crap)? 
> Would you possibly have cried bloody murder about breaking backwards
> compatibility with audio apps?

I expect that the life span of the RT-LSM will end in 2.8, replaced by
something better.  Does this break binary compatibility?  No, it has
no API.  Only system admin procedures are affected.  These things
change between major releases anyway.  As long as there is still a way
to solve the problem, we will adjust.

If you were to take it out and replace it with something like that
nice(-20) hack that theoretically works but actually doesn't, *then*
I'd scream bloody murder.  Wouldn't you want me to?

> (Dont misunderstand me, this is not any 'fault' of yours, this is simply
> your interest: you are not hacking kernel code so you are at most
> compassionate with our needs, but you are not directly affected by
> kernel code quality issues.)

I do care.  But, since maintainance is your responsibility, I am
willing to defer to your wishes in the matter.  I looked at sched.c.
It appears well-written.  I have no desire to second-guess development
when it's working.

Lack of clear requirements gathering, on the other hand, directly
affects me in very unpleasant ways.  That's not working.

> (also, believe me, this is not arrogance or some kind of game on our
> part. If there was a nice clean solution that solved your and others'
> problems equally well then it would already be in Linus' tree. But there
> is no such solution yet, at the moment. Moreover, the pure fact that so
> many patch proposals exist and none looks dominantly convincing shows
> that this is a problem area for which there are no easy solutions. We
> hate such moments just as much as you do, but they do happen.)

The actual requirement is nowhere near as difficult as you imagine.
You and several others continue to view realtime in a multi-user
context.  That doesn't work.  No wonder you have no good solution.

The humble RT-LSM was actually optimal for the multi-user scenario:
don't load it.  Then it adds no security issues, complexity or
scheduler pathlength.  As an added benefit, the sysadmin can easily
verify that it's not there.

The cost/performance characteristics of commodity PC's running Linux
are quite compelling for a wide range of practical realtime
applications.  But, these are dedicated machines.  The whole system
must be carefully tuned.  That is the only method that actually works.
The scheduler is at most a peripheral concern; the best it can do is
not screw up.
-- 
  joq
