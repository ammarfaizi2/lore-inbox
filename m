Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293658AbSBREVK>; Sun, 17 Feb 2002 23:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293710AbSBREVA>; Sun, 17 Feb 2002 23:21:00 -0500
Received: from duracef.shout.net ([204.253.184.12]:57361 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S293658AbSBREUy>; Sun, 17 Feb 2002 23:20:54 -0500
Date: Sun, 17 Feb 2002 22:20:44 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200202180420.g1I4Ki910380@duracef.shout.net>
To: esr@thyrsus.com
Subject: Re: Disgusted with kbuild developers
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre <nico@cam.org>:
> Show us that you're able to write a 1 for 1 functional correspondance
> between CML1 and CML2 and propose that for inclusion into 2.5

Eric S. Raymond <esr@thyrsus.com>:
> This requirement is absurd.  When someone designs a new VM, we
> don't demand that it crash or lock up the system in exactly the same
> way that the old one did before it can go into the kernel.

I disagree with this statement in three different ways.

[1] lkml readers are kbuild users, not kbuild developers

kbuild is special.  The relationship between most lkml readers and most
linux kernel code (such as the VM) is the relationship of developers to
a corpus of code.  The relationship of most lkml readers to kbuild is
the relationship of *users* to a corpus of code.  I think of everybody
that has not submitted patches or written code to kbuild tools as a
kbuild user.

Oddly enough, people behave differently in their roles as users than
their roles as developers.  Many people who have actually worked on
menuconfig would love to shitcan that monstrosity, but people who run
menuconfig don't mind the ugliness of its implementation.

The first thing users want to know about a software upgrade is: "is it
going to break what I am doing right now".  In a mature system, it really
is better to leave 10 old bugs unfixed rather than introduce one new bug.
I believe that is why people ask for functional equivalence, even for bugs.
Users do not trust developers to decide which behaviours are bugs!

In order to do my work, it has to match some internal concepts I have
about correctness, elegance, robustness, all that stuff.  But in order
for other people to want to use my work, it has to match their concepts
of what is useful to them.

[2] CML1 is working in the field

Your view is that CML1 is as bad as a VM that crashes or locks up.
This view is rejected by a significant number of CML1 users, including a
lot of influential ones.  People are building kernels with CML1 every day.

Even if you believe that CML1 as a language has hopeless problems, you
should acknowledge that many users do not believe this.  So when you
show up and say "here, CML2 language will solve all your CML1 language
problems", you are offering a lot of people something negative or neutral
to them.

A month ago I was disenheartened about this.  It looked like CML1
language was going to be "good enough" for the entire lifespan of the
Linux kernel.  Now it turns out that there is a new customer requirement:
people want driver.conf files.  A new language has the opportunity to
define driver.conf files and that would be a significant advantage
over CML1.

[3] kernel development is highly multi-threaded with interesting locks

The kernel development process involves hundreds of people across several
trees.  It's fundamentally different from one person writing code on
one branch of one tree -- the same way that a massive multi-threaded
program running on a 256-processor server is programmed differently than
a single-threaded program on a uniprocessor.

I believe there are development locks.  I could probably write a
whole essay on the nature of these locks, the atomic operations in the
development process, the way that people use multi-phase protocols to
get something merged without grabbing giant locks, and so on.

Kbuild work has the unfortunate property that it sometimes needs big
locks.  I think that CML2 involves a giant lock: you want to lock every
Config.in file at once, modify it from top to bottom, and commit them
all at once.  Okay.  That's a huge lock, especially considering that
at any given moment, lots of people have unmerged work-in-progress,
as well as whole parallel trees.

Linus can acquire a lock that big, because sometimes he just grabs the
Big Kernel Development Lock, changes some interface, and relies on us
mortals to patch up the loose edges.  This works pretty well because
it leverages his vision by letting other people share the grunt work.
But I think that Linus prefers to avoid grabbing the BKDL, and it's no
use pushing him.

I think it would be good for you to think about the nature of this locking
process (starting with: is mec onto something here or is he delusional?)
Then think about how to get to the end vision of CML2 with a less
severe locking strategy.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
