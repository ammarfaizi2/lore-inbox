Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269712AbRHQGRH>; Fri, 17 Aug 2001 02:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269731AbRHQGQ5>; Fri, 17 Aug 2001 02:16:57 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:22156 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S269712AbRHQGQz>; Fri, 17 Aug 2001 02:16:55 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 16 Aug 2001 23:17:08 -0700
Message-Id: <200108170617.XAA07293@baldur.yggdrasil.com>
To: gibbs@scsiguy.com
Subject: Re: Patch: remove DB dependence of linux-2.4.9/drives/scsi/aic7xxx/aicasm
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From gibbs@scsiguy.com Thu Aug 16 21:54:22 2001

>>	1. It eliminates another dependence for doing a complete source build.

>In the past, although firmware was available in source form, the tools
>were not.  You always had to rely on the precompiled firmware to build
>a kernel.  If you really insist on building the firmware, you're probably
>an aic7xxx developer (okay, you're an exception, but I don't understand
>why your so interested in building it...),

	The importance of source code and being able to rebuild all of
it is integral to all sorts of efficiencies in free software.  I hope
you can just accept the stipulation that other people do see it as
important so we don't have to invest our time in on a common
tangential discussion which is probably probably already well covered
in the usenet flamewar archives like dejanews.com.


>and are willing to understand
>what's involved in tweaking the firmware, its assembler, etc.  Prior to
>the new driver coming into the tree, did you pull down the FreeBSD sources
>to the aicasm utility and port it to Linux so you could build everything
>from source? 8-)

	I did not, but your older Linux driver's not building from
source was a deficiency.  Back then (and until now, frankly) I did
not know that there was a time when the FreeBSD driver built the aic7xxx
uploaded code from source and Linux driver did not.  Had I know, in all
honesty, porting that facility from FreeBSD probably would not have
been a higher priority than whatever tasks I was doing at the time,
but it might have been.  Certainly, now, because I want to have a
system that could build evolution and the Linux kernel completely
from source, I needed to do this solve this problem.

>>	2. It potentially eliminates a dependence on a GPL'ed library,
>>	   a policy preference of at least one Linux distribution that I
>>	   can think of (Debian), and probably a preference of some users.

>DB v1.85 isn't GPLed.

>>	3. (New) it's a handy fallback in case somone finds a buggy
>>	   DB implementation.

>There is always DB 1.85...

	As I explained in my previous email, I am having problems
getting db-1.85 and db-3.x (which evolution currently requires) to
cohibitate on the same system.  Although is a db and evolution problem,
the use of db in the kernel build has always been a minor portability
impediment that has annoyed me, and, at the moment, the most direct
way to address this problem.

>>	Anyhow, I've done it.

>And unfortunately its GPLed.  The rest of the driver and assembler are
>available, optionally, under the more lenient BSD style copyright.  As
>the driver runs on multiple platforms, many of which dislike the GPL, I
>cannot allow GPL only code into the core portions of the driver.

	It's not a core portion of the driver.  It only modifies a
Linux-specific Makefile.  So, it shouldn't be a problem to just have
it for the Linux version.  However, If you want to include this
facility in the *BSD versions and that would make the difference in
getting you to include it in the Linux version now, then I would be
willing to grant permission under the new BSD copying conditions.

>Additional code, is, well, additional code - to understand and/or
>maintain.

	I have committed this change to cvs here and plan to maintain it.

>Libraries were invented to avoid this problem.  So I used
>a library, along with several other tools (yacc, lex), to make my life
>easier.

	I think the yacc and lex decisions were good trade-offs.
Parsers and lexers are complex to build and maintain directly.  Based
on _your_ time prioritizations, db probably was the right trade-off
too.  The time you saved you probably put toward other positive
purposes.  However, your application of db is trivial enough to be
comparable in desirability against the negative of being dependent on
one more facility for a complete source build.  I'm not talking about
the trade-off of you writing the trivialdb code.  I have already
written it.  I am just talking about your applying my patch so that
other people can avoid some occasional db compatability problems, and,
who knows, maybe, for someone, a db availability issue.

	Come to think of it, the trivialdb availability probably makes
your aicasm more easily portable to other platforms, whether or not
related to its application to the *BSD and Linux drivers.  (Yes,
this though is a "solution in search of a problem", but it might
be relevant to you anyhow.)

>These decisions don't make aicasm a good bootstraping utility, but
>aicasm isn't needed to bootstrap the system.  It isn't needed to build
>the kernel.  You seem to have a solution in search of a problem.

	It has solved an immediate build problem for me.  Hopefully,
gnome Evolution will be improved so as not to require the 3.x version
of Berkeley DB, or maybe db-3.x will be improved to cohabitate better
with db-1.85 (I know it tries).  If not, then, gradually, more people
who want to build the kernel completely from source on a system that
also has evolution will experience this problem.

	It's obviously not the most urgent thing in the world, but I
think, on the balance, you ought to apply my patch.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
