Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268232AbTALEZe>; Sat, 11 Jan 2003 23:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268235AbTALEZe>; Sat, 11 Jan 2003 23:25:34 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:13806 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S268232AbTALEZc>; Sat, 11 Jan 2003 23:25:32 -0500
Date: Sat, 11 Jan 2003 20:21:25 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Rob Wilkens <robw@optonline.net>
cc: Ryan Anderson <ryan@michonline.com>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: The GPL, the kernel, and everything else.
In-Reply-To: <1042344930.1034.161.camel@RobsPC.RobertWilkens.com>
Message-ID: <Pine.LNX.4.44.0301112006430.30519-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, there are problems with your first statement here.

1. some developers are militant about not wanting to have binary drivers
(as is shown by this flamewar)

2. modules not only need to be called with the correct parameters, they
also need to do the proper locking. as locking evolves what needs to be
done by the module changes. This can only be solved by every module doing
locking 'just in casee' at which point the unessasary locking becomes a
significant performance issue (Larry McVoy has written a document about
why locking is bad and why excessive locking is very bad, search archives
for the link to his site)

3. you say that 'all that is needed' is to design an API that covers every
possible function a module needs. the problem is that if you try doing
this you end up with several results.

A. the API is very complex (since it does cover every possible
application)

B. the glue logic to translate the API to and from the internal kernel
implementations adds additional complexity (with probable errors) and robs
performance from the system (especially over time as the internel kernel
structures change)

C. the API includes a lot of things that are never used (remember it
covers everything you can think someone may possibly want to do, not just
the things that people actually do) unused code is a bad thing, it never
gets tested so bugs can live there for a LONG time, and it eats up memory
that the system should use for doing actual work.

4. since no designer (or group of designers) can think of everything your
API is going to be incomplete anyway. you can either pretend this isn't
the case and limit yourself to the things that you origionally imagined,
change your API (and now what do you do with things that used the
origional one, support two different versions of the API??? that's a
disaster for performance), or recognise up front that kernel modules are
very dependant on the exact implementation of the kernel internals at
which point it doesn't make sense to try and define a specific API, they
are just part of the kernel that's not always loaded (this is what Linux
has chosen to do)

as for signing kernel modules as being 'good' you have a serious problem
in the Linux world that there is no central authority to do any such
signing. the closest there is to that is when the module is made part of a
core source tree and then gets supported and maintained along with
everything else, but binary-only modules can't be done that way.

David Lang



 On Sat, 11 Jan 2003, Rob Wilkens wrote:

> Date: Sat, 11 Jan 2003 23:15:31 -0500
> From: Rob Wilkens <robw@optonline.net>
> To: Ryan Anderson <ryan@michonline.com>
> Cc: Linux kernel list <linux-kernel@vger.kernel.org>
> Subject: Re: The GPL, the kernel, and everything else.
>
> On Sat, 2003-01-11 at 20:06, Ryan Anderson wrote:
> > Because, to a large extent, for the core kernel developers, the existing
> > system is fine.
>
> If you're designing a system for kernel developers use, then that's
> fine.  But if you want to see linux proliferate to the average desktop
> (and I do), then you've got to look at the bigger picture.  There
> _should_ be a way for a company like nvidia to build a binary driver,
> adn ship it in binary form, maybe even digitally signed the way
> microsoft allows digital signing of drivers so you know the driver is
> legit and OK.
>
> > progress.  ("Stream of consciousness" might not be a bad analogy)
>
> It's actually a good analogy.  What mailing list (if not the kernel
> mailing list) do I sign up for if I want to read about the design
> aspects of the kernel.  I realize and understand if this is an exclusive
> members-only list that doesn't allow the likes of me into its
> membership.
>
> > There is, but it's not CVS.  CVS has... issues when you get into complex
>
> I just read about bitkeeper in the "Virtual Memory Manager" document
> someone posted tonight (of all the places to learn about it)...
>
> Anyway, I've put that document aside, but will probably get back to it
> later.
>
> -Rob
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
