Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289621AbSA2L7t>; Tue, 29 Jan 2002 06:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSA2L6B>; Tue, 29 Jan 2002 06:58:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:32193 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289516AbSA2L45>;
	Tue, 29 Jan 2002 06:56:57 -0500
Date: Tue, 29 Jan 2002 14:54:27 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Rob Landley <landley@trommello.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <200201290446.g0T4kZU31923@snark.thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Jan 2002, Rob Landley wrote:

> (You keep complaining people never send you patches.  People are
> suggesting automated patch remailers to spam your mailbox even harder.
> There has GOT to be a better way...)

None of the examples you cited so far are convincing to me, and i'd like
to explain why. I've created and submitted thousands of patches to the
Linux kernel over the past 4 years (my patch archive doesnt go back more
than 4 years):

  # ls patches | wc -l
     2818

a fair percentage of those went to Linus as well, and while having seen
some of them rejected does hurt mentally, i couldnt list one reject from
Linus that i wouldnt reject *today*. But i sure remember being frustrated
about rejects when they happened. In any case, i have some experience in
submitting patches and i'm maintaining a few subsystems, so here's my take
on the 'patch penguin' issue:

If a patch gets ignored 33 times in a row then perhaps the person doing
the patch should first think really hard about the following 4 issues:

  - cleanliness
  - concept
  - timing
  - testing

a violation of any of these items can cause patch to be dropped *without
notice*. Face it, it's not Linus' task to teach people how to code or how
to write correct patches. Sure, he still does teach people most of the
time, but you cannot *expect* him to be able to do it 100% of the time.

1) cleanliness

code cleanliness is a well-know issue, see Documentation/CodingStyle.  If
a patch has such problems then maintainers are very likely to help - Linus
probably wont and shouldnt. I'm truly shocked sometimes, how many active
and experienced kernel developers do not follow these guidelines. While
the Linux coding style might be arbitrary in places, all coding styles are
arbitrary in some areas, and only one thing is important above all:
consistency between kernel subsystems. If i go from one kernel subsystem
to another then i'd like to have the same 'look and feel' of source code -
i think this is a natural desire we all share. If anyone doesnt see the
importance of this issue then i'd say he hasnt seen, hacked and maintained
enough kernel code yet. I'd say the absolute positive example here is Al
Viro. I think most people just do not realize the huge amount of
background cleanup work Al did in the past 2 years. And guess what? I bet
Linus would be willing to apply Al's next patch blindfolded.

impact: a patch penguin might help here - but he probably wont scale as
well as the current set of experienced kernel hackers scale, many of whom
are happy to review patches for code cleanliness (and other) issues.

2) concept

many of the patches which were rejected for a long time are *difficult*
issues. And one thing many patch submitters miss: even if the concept of
the patch is correct, you first have to start by cleaning up *old* code,
see issue 1). Your patch is not worth a dime if you leave in old cruft, or
if the combination of old cruft and your new code is confusing. Also, make
sure the patch is discussed and developed openly, not on some obscure
list. linux-kernel@vger.kernel.org will do most of the time. I do not want
to name specific patches that violate this point (doing that in public
just offends people needlessly - and i could just as well list some of my
older patches), but i could list 5 popular patches immediately.

impact: a patch penguin just wont solve this concept issue, because, by
definition, he doesnt deal with design issues. And most of the big patch
rejections happen due to exactly these concept issues.

3) timing

kernel source code just cannot go through arbitrary transitions. Eg. right
now the scheduler is being cleaned up (so far it was more than 50
sub-patches and they are still coming) - and work is going on to maximize
the quality of the preemption patch, but until the base scheduler has
stabilized there is just no point in applying the preemption patch - no
matter how good the preemption patch is. Robert understands this very
much. Many other people do not.

impact: a patch penguin just wont solve this issue, because a patch
penguin cannot let his tree transition arbitrarily either. Only separately
maintained and tested patches/trees can handle this issue.

4) testing

there are code areas and methods which need more rigorous testing and
third-party feedback - no matter how good the patch. Most notably, if a
patch exports some new user-space visible interface, then this item
applies. An example is the aio patch, which had all 3 items right but was
rejected due to this item. [things are improving very well on the aio
front so i think this will change in the near future.]

impact: a patch penguin just wont solve this issue, because his job, by
definition, is not to keep patches around indefinitely, but to filter them
to Linus. Only separately maintained patches/trees help here. More people
are willing to maintain separate trees is good (-dj, -ac, -aa, etc.), one
tree can do a nontrivial transition at a time, and by having more of them
we can eg. get one of them testing aio, the other one testing some other
big change. A single patch penguin will be able to do only one nontrivial
transition - and it's not his task to do nontrivial transitions to begin
with.


Many people who dont actually maintain any Linux code are quoting Rik's
complains as an example. I'll now have to go on record disagreeing with
Rik humbly, i believe he has done a number of patch-management mistakes
during his earlier VM development, and i strongly believe the reason why
Linus ignored some of his patches were due to these issues. Rik's flames
against Linus are understandable but are just that: flames. Fortunately
Rik has learned meanwhile (we all do) and his rmap patches are IMHO
top-notch. Joining the Andrea improvements and Rik's tree could provide a
truly fantastic VM. [i'm not going to say anything about the IDE patches
situation because while i believe Rik understands public criticism, i
failed to have an impact on Andre before :-) ]

also, many people just start off with a single big patch. That just doesnt
work and you'll likely violate one of the 4 items without even noticing
it. Start small, because for small patches people will have the few
minutes needed to teach you. The bigger a patch, the harder it is to
review it, and the less likely it happens. Also, if a few or your patches
have gone into the Linux tree that does not mean you are senior kernel
hacker and can start off writing the one big, multi-megabyte super-feature
you dreamt about for years. Start small and increase the complexity of
your patches slowly - and perhaps later on you'll notice that that
super-feature isnt all that super anymore. People also underestimate the
kind of complexity explosion that occurs if a large patch is created.
Instead of 1-2 places, you can create 100-200 problems.

face it, most of the patches rejected by Linus are not due to overload. He
doesnt guarantee to say why he rejects patches - *and he must not*. Just
knowing that your patch got rejected and thinking it all over again often
helps finding problems that Linus missed first time around. If you submit
to Linus then you better know exactly what you do.

if you are uncertain about why a patch got rejected, then shake off your
frustration and ask *others*. Many kernel developers, including myself,
are happy to help reviewing patches. But people do have egos, and it
happens very rarely that people ask it on public lists why their patches
got rejected, because people do not like talking about failures. And the
human nature makes it much easier to attack than to talk about failures.
Which fact alone pretty much shows that most of the time the problem is
with the patch submitter, not with Linus.

it's so much easier to blame Linus, or maintainers. It's so much easier to
fire off an email flaming Linus and getting off the steam than to actually
accept the possibility of mistake and *fix* the patch. I'll go on record
saying that good patches are not ignored, even these days when the number
of active kernel hackers has multipled. People might have to go through
several layers first, and finding some kernel hacker who is not as loaded
as Linus to review your patch might be necessery as well (especially if
the patch is complex), but if you go through the right layers then you can
be sure that nothing worthwile gets rejected arbitrarily.

	Ingo

