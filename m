Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265070AbSKAQJZ>; Fri, 1 Nov 2002 11:09:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265072AbSKAQJQ>; Fri, 1 Nov 2002 11:09:16 -0500
Received: from nameservices.net ([208.234.25.16]:61000 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265070AbSKAQIi>;
	Fri, 1 Nov 2002 11:08:38 -0500
Message-ID: <3DC2A97C.D50C02E4@opersys.com>
Date: Fri, 01 Nov 2002 11:19:08 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: Rusty's Remarkably Unreliable List of Pending 2.6 Features
References: <20021101085148.E105A2C06A@lists.samba.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rusty Russell wrote:
> Removed ("vendor-driven" == "no", for purposes of the freeze)
>         Linux Trace Toolkit: "no"

I'm not sure exactly why this got a "no" this time around. For one thing,
LTT is certainly not "vendor-driven", I'm not getting paid a penny for
the work I'm putting in it ;)

In an earlier thread, Linus made the following statement with regards to LTT:
> I suspect we'll want to have some form of event tracing eventually, but
> I'm personally pretty convinced that it needs to be a per-CPU thing, and 
> the core mechanism would need to be very lightweight. It's easier to build 
> up complexity on top of a lightweight interface than it is to make a 
> lightweight interface out of a heavy one.

At that time we didn't have the per-CPU buffering, but I promissed
Linus we would. And as promised we do have it now and the numbers we
have published have clearly demonstrated the tracer is lightweight. So
I was a bit suprised to see Linus come out and say:
> I don't know what this buys us.

Within that lengthy (ongoing) thread about "What's left over" he also
mentioned a few criteria for admitting new patches:
>         In other words: the question is never EVER "Why shouldn't it be
>         accepted?", but it is always "Why do we really not want to live 
>         without this?"

I've answered this one a few times for LTT already. We don't want to
live without this because we have no other way to:
> - Debug synchronization problems among processes (there is no other
> tool to do this, not gdb, not strace, not printf, ...)
> - Measure exact time spent wainting for kernel and which other
> processes a process had to wait for.
> - Measure exact time it takes for an interrupt's effects to propagate
> throughout the entire system.
> - Understand the exact behavior the system has to input. (what is
> the exact sequence of processes that run when I press a key).
> - Identify sporadic problems in very saturated systems. (thousands
> of servers and one of them is doing weird stuff).
> - etc.

Linus also added:
>         There's a big "inertia" to features. It's often better to keep 
>         features _off_ the standard kernel if they may end up being
>         further developed in totally new directions.

That's not really the case here. In fact, it's the complete inverse that
is happening with LTT: Because I'm spending so much time having to deal
with patch updates, I have much less time to work on the user-space
analysis tools. These analysis tools are the heart of the tracing system
and it is these tools that make LTT such a great utility, not the kernel
patch itself. All the kernel patch does is act as a dumb data collector.
It's the analysis tools that make sense of all this data and help the
user pinpoint his problem.

To the question "did you convince anyone else of including LTT in their
distro before trying the LKML?", my answer is: We didn't have to, they
included it without asking. Within 2 days of releasing the first version
of LTT in July 1999, I got an email from Zentropix (which would later be
acquired by Lineo) that they were going to include it in their distro. At
that time we only supported the i386 and the user tools were nowhere near
what they are at today. Today, LTT is included by the following
distributions: MontaVista, Lineo, Debian, ELinos, Denx, and (to the best of
my knowledge) UnitedLinux. Are we part of, say, RedHat? No we aren't, most
folks I've spoken to have said that the LTT patch is far too big for them
to maintain it independtly. I do, nevertheless, get many mails from users
who ask: "Do you have an LTT patch for RedHat XYZ?" Obviously I don't,
I simply can't generate an LTT patch for every distro out there.

"Why aren't any users of LTT being heard on the LKML?". Well they usually
never have a problem with the kernel itself. I do, however, get tons
of messages saying "do you have an LTT patch for version XYZ of the kernel?"
or "patch version XYZ doesn't compile properly on architecture A."
LTT users don't want to have to bother with the kernel, they want to get
the trace data out of the kernel and into the visualizer in order to be
able to debug their system. These guys aren't kernel developers, most of
them are common application developers who need to identify serious
problems having to do with the system's dynamic behavior. Which is exactly
what LTT is about.

We do see, nevertheless, many folks come to the LKML and ask a question
about being able to do a particular task with the Linux kernel and being
told, by other people than myself, "take a look at LTT."

Over the past 3.5 years of working on LTT I've had the chance to discuss
it with a few prominent kernel developers. I won't name any names, you
know who you are. Many of those folks have shown interest in LTT. Even
within the "what's left" thread folks came out and supported LTT's
inclusion. I have yet to be explained why users _don't_ want to be able
to debug their inter-process synchronization problems!?!

Can LTT continue to live outside of the kernel forever? Not without
slowing down the development of the analysis tools significantly.
Integrating the LTT patch into the kernel will certainly not mean the
end of development of LTT because the LTT patch in and of itself is
useless. The really interesting part is all in the user-space tools.
That's what makes LTT a very important tool for users. The more time
I have to put creating patch updates, the less time I have to actually
work on the user-space tools.

Have a look for yourself (if you haven't already):
http://www.opersys.com/LTT/

And if you'd prefer something that speaks for itself:
http://www.opersys.com/LTT/screenshots.html

FWIW, please add this patch back. We've been very open to LKML feedback
and have responded positively to the comments made by Ingo Molnar,
Linus Torvalds, Roman Zippel, Christoph Hellwing, Pavel Machek, and many
others. Either these people actually had lots of time to waste by going
over our work and actually making suggestions, which is doubtfull. Either
LTT is actually a tool that is worth taking an in-depth look at. I'll
let you draw your own conclusions.

Meanwhile, we're all ears in regards to potential omissions and suggested
changes.

Best regards,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
