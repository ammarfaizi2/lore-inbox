Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUASSjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 13:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUASSjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 13:39:24 -0500
Received: from chaos.analogic.com ([204.178.40.224]:5510 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262960AbUASSjT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 13:39:19 -0500
Date: Mon, 19 Jan 2004 13:39:43 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bart Samwel <bart@samwel.tk>
cc: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <400C1682.2090207@samwel.tk>
Message-ID: <Pine.LNX.4.53.0401191311250.8046@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk>
 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Bart Samwel wrote:

> Richard B. Johnson wrote:
> >>>If somebody actually got a module, written in C++, to compile and
> >>>work on linux-2.4.nn, as you state, it works only by fiat, i.e., was
> >>>declared to work. There is no C++ runtime support in the kernel for
> >>>C++. Are you sure this is a module and not an application? Many
> >>>network processes (daemons) are applications and they don't require
> >>>any knowledge of kernel internals except what's provided by the
> >>>normal C/C++ include-files.
> >>
> >>Rest assured, ;) this is definitely a module. It includes a kernel patch that
> >>makes it possible to include a lot of the kernel headers into C++, stuff like
> >>changing asm :: to asm : : (note the space, :: is an operator in C++) and
> >>renaming "struct namespace" to something containing less C++ keywords. The
> >>module also includes rudimentary C++ runtime support code, so that the C++
> >>code will run inside the kernel. I'm afraid that the task of compiling it for
> >>2.6 is going to be pretty tough -- the kernel needs loads of patches to make
> >>it work within a C++ extern "C" clause, and it probably completely different
> >>patches from those needed by 2.4. Getting the build system to work is the
> >>least of the concerns.
> >
> > I can't imagine why anybody would even attempt to write a kernel
> > module in C++. Next thing it'll be Visual BASIC, then Java. The
> > kernel is written in C and assembly. The tools are provided. It
> > can only be arrogance because this whole C v.s. C++ thing was
> > hashed-over many times. Somebody apparently wrote something to
> > "prove" that it can be done. I'd suggest that you spend some
> > time converting it to C if you need that "module". The conversion
> > will surely take less time than going through the kernel headers
> > looking for "::".
>
> Just to make this clear: I'm not the original poster, so I'm not the one
> who is to be helped. I just happened to know the module, and I'd thought
> I'd give you a quick answer because I knew it. :)
>
> Now, let me try to add a bit of nuance to your suggested solution. Try
> porting 100s of C++ files (yes, it's that large) making heavy use of
> inheritance etc. to C. Then try to make a bit of C code usable as extern
> "C" in C++. Extern "C" was actually meant to be able to grok most C
> code, while C++ wasn't meant to be easily portable to C. So, for any
> moderately large module that uses any C++ features at all, it's probably
> easier to make small syntactic changes to the kernel than to port the
> module to C (which would amount to a full rewrite).
>
> I'll give you a bit of background about the specific situation. I'm not
> involved with the project, so I don't know all the details, but I do
> know the code and have worked on a "competing" system (as far as
> research systems compete). The choice for C++ for this project is really
> the most obvious choice, as the model is very OO. The module implements
> a router model that is configured as "clickable modules", i.e., very
> small elements with input and output ports and a bit of state that are
> connected to each other through small interfaces. Their element
> implementations are arranged hierarchically (as in C++ class hierarchies).
>
> I'm not familiar with the exact history of the project, but I expect
> that they decided to do C++ because the model they try to express is
> best modeled using C++. This design decision can be debated, because it
> is perfectly feasible (albeit with a lot more work) to implement an OO
> model in C. In fact, I have helped to implement a similar framework (the
> OKE CORRAL) which was written completely in C. But, the fact of the
> matter is, this useful (but huge) kernel module is there now (and it has
> been here since the early 2.2 kernels), and it was not written just to
> "prove" that it could be done, but because C++ seemed at the time to be
> the best language for the job. The start of this project may very well
> predate the many times that this was hashed-over on the LKML
> (disclaimer: I wasn't there, so I don't know). You refer to "what can
> only be" the arrogance of the writers, yet continue by claiming:
>
>  > I'd suggest that you spend some time converting it to C if you need
>  > that "module".
>
> and
>
>  > The conversion will surely take less time than going through the
>  > kernel headers looking for "::".
>
> Excuse me, but before calling somebody else arrogant, I would suggest
> that you might want check whether you're not calling the kettle black.
> It's not a sign of modesty when you assume without a trace of doubt that
> a module (that happened to have been developed over the course of four
> years by a team of people at MIT) is just a "\"module\"" and that it
> will take less time to port it to C than to make the kernel headers
> parse in a C++ extern "C" clause. In addition, imagine how you would
> feel if somebody referred to your work as a "\"module\""! The fact that
> you "can't imagine why anybody would even attempt to write a kernel
> module in C++" may just as well be due to a lack of imagination on your
> side, but in your statement I detect no trace of a doubt. And _yes_ you
> may very well be right about their initial decision being stupid (and
> you might not be -- I don't know), and _yes_ you are probably right
> about the whole thing being hashed-over many times (I don't know -- I
> wasn't there), and _yes_ there are people out there who would do
> anything just to prove they can do something others think is impossible
> or just filthy. So, yes, there _may_ be a point to what you're saying.
> _May_. I'm not saying you're wrong, and I'm not saying you're right.
> What I'm saying is that simply assuming that any C++ module is nothing
> more than a few lines of (de)glorified C and accusing the writers of
> being arrogant just because they wrote a kernel module in C++ is, in my
> opinion, jumping to conclusions based on
> technical-preference-turned-prejudice (at least, that's how it seems),
> and it's not very polite either.
>

The possibility that something may have been written by some MIT people
can't change the fact that C++ is not the tool that should have been
used within the kernel. I once worked on a project at Princeton. That
doesn't make me know anything about Relativity. Einstein didn't rub
off due to some proximity effect.

If the "MIT Team", as you so state, had actually inspected some
kernel code, and actually understood what a Linux/Unix kernel does,
then learned persons could not possibly have selected C++ for this
project.

If you review the project, you will probably also find that a
large percentage of the code should have been implemented in
user-mode (a daemon, or several). That's where C++ really shines.

However, it wasn't. Which, to me, means that the developers
were either clue-less or, once somebody actually figured out
how a kernel works, it was way too late to change (an all to common
problem).

The number of persons who worked on a project does not affect the
correctness of the tools nor the architecture chosen. Facts are
not democratic. You can't vote them into or out of existence.

> Unfortunately, this is how flame wars get started (as can be seen by the
> slightly agitated tone this message has taken, sorry about that! :) ).
> Just to make this clear to everyone: I'm not trying to instigate a flame
> war here about C vs. C++, as I don't really have an opinion on that
> subject. This posting has to do with my preferences w.r.t. personal
> style, and nothing with my technical preferences.
>

This is not about preferences. Most software engineers wish that
everything could be done using the first language they learned. Once
they try to write a state-machine in FORTRAN (my native language), they
begin to understand that there are other tools more suited for the
job. Unfortunately, especially for students at well-known universities,
learning a language often opens the door to a cult. I remember
the "Pascal cult", the "forth cult", the "C cult" the "C++ cult", and
now the "C# cult". Next year there may be "D" and the cycle will
continue.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


