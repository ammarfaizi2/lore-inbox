Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282988AbRLQWrQ>; Mon, 17 Dec 2001 17:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282993AbRLQWrH>; Mon, 17 Dec 2001 17:47:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:25103 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S282988AbRLQWqx>; Mon, 17 Dec 2001 17:46:53 -0500
Date: Mon, 17 Dec 2001 14:48:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112151603180.4493-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40.0112151934410.1014-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Linus Torvalds wrote:

> I just don't find it very interesting. The scheduler is about 100 lines
> out of however-many-million (3.8 at least count), and doesn't even impact
> most normal performace very much.

Linus, sharing queue and lock between CPUs for a "thing" highly frequency
( schedule()s + wakeup()s ) accessed like the scheduler it's quite ugly
and it's not that much funny. And it's not only performance wise, it's
more design wise.


> We'll clearly do per-CPU runqueues or something some day. And that worries
> me not one whit, compared to thigns like VM and block device layer ;)

Why not 2.5.x ?


> I know a lot of people think schedulers are important, and the operating
> system theory about them is overflowing - ...

It's no more important of anything else, it's just one of the remaining
scalability/design issues. No, it's not more important than VM but
there're enough people working on VM. And the hope is to get the scheduler
right with an ETA of less than 10 years.


> it's one of those things that people can argue about forever, ...

Yes, i suppose that if something is not addressed, it'll come up again and
again.


> yet is conceptually simple enough that people aren't afraid of it.
         ^^^^^^^^^^^^^^^^^^^

1, ...


> Let's face it - the current scheduler has the same old basic structure
> that it did almost 10 years ago, and yes, it's not optimal, but there
> really aren't that many real-world loads where people really care. I'm
> sorry, but it's true.

Moving to 4, 8, 16 CPUs the run queue load, that would be thought insane
for UP systems, starts to matter. Just to leave out cache line effects.
Just to leave out the way the current scheduler moves tasks around CPUs.
Linus, it's not only about performance benchmarks with 2451 processes
jumping on the run queue, that i could not care less about, it's just a
sum of sucky "things" that make an issue. You can look at it like a
cosmetic/design patch more than a strict performance patch if you like.


> And you have to realize that there are not very many things that have
> aged as well as the scheduler. Which is just another proof that
> scheduling is easy.
  ^^^^^^^^^^^^^^^^^^

..., 2, ...


> We've rewritten the VM several times in the last ten years, and I expect
> it will be changed several more times in the next few years. Withing five
> years we'll almost certainly have to make the current three-level page
> tables be four levels etc.
>
> In comparison to those kinds of issues, I suspect that making the
> scheduler use per-CPU queues together with some inter-CPU load balancing
> logic is probably _trivial_.
                    ^^^^^^^^^

... 3, there should be a subliminal message inside but i'm not able to
get it ;)
I would not call selecting the right task to run in an SMP system trivial.
The difference between selecting the right task to run and selecting the
right page to swap is that if you screw up with the task the system
impact is lower. But, if you screw up, your design will suck in both cases.
Anyway, given that 1) real men do VM ( i thought they didn't eat quiche )
and easy-coders do scheduling 2) the schdeuler is easy/trivial and you do
not seem interested in working on it 3) whoever is doing the scheduler
cannot screw up things, why don't you give the responsibility for example
to Alan or Ingo so that a discussion ( obviously easy ) about the future
of the schdeuler can be started w/out hurting real men doing VM ?
I'm talking about, you know, that kind of discussions where people bring
solutions, code and numbers, they talk about the good and bad of certain
approaches and they finally come up ( after some sane fight ) with a much
or less widely approved solution. The scheduler, besides the real men
crap, is one of the basic components of an OS, and having a public
debate, i'm not saying every month and neither every year, but at least
once every four years ( this is the last i remember ) could be a nice thing.
And no, if you do not give to someone that you trust the "power" to
redesign the scheduler, no schdeuler discussions will start simply
because people don't like the result of a debate to be dumped to /dev/null.


> Patches already exist, and I don't feel that people can screw up the few
> hundred lines too badly.

Can you point me to a Linux patch that implements _real_independent_
( queue and locking ) CPU schedulers with global balancing policy ?
I searched very badly but i did not find anything.




Your faithfully,
Jimmy Scheduler





