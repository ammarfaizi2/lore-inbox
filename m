Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbRFJWEZ>; Sun, 10 Jun 2001 18:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262988AbRFJWEP>; Sun, 10 Jun 2001 18:04:15 -0400
Received: from web5204.mail.yahoo.com ([216.115.106.85]:12041 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262934AbRFJWEE>; Sun, 10 Jun 2001 18:04:04 -0400
Message-ID: <20010610220402.9080.qmail@web5204.mail.yahoo.com>
Date: Sun, 10 Jun 2001 15:04:02 -0700 (PDT)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: Break 2.4 VM in five easy steps
To: linux-kernel@vger.kernel.org
Cc: linux@ansa.hostings.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I realize that assembly is platform-specific. Being 
>that I use the IA32 class machine, that's what I 
>would write for. Others who use other platforms could
>do the deed for their native language.

Meaning we'd still need a good C implementation anyway
for the 75% of platforms nobody's going to get around
to writing an assembly implementation for this year,
so we might as well do that first, eh?

As for IA32 being everywhere, 16 bit 8086 was
everywhere until 1990 or so.  And 64 bitness is right
around the corner (iTanic is a pointless way of
de-optimizing for memory bus bandwidth, which is your
real bottleneck and not whatever happens inside a chip
you've clock multiplied by a factor of 12 or more. 
But x86-64 looks seriously cool if AMD would get off
their rear and actually implement sledgehammer in
silicon within our lifetimes.  And that's probably
transmeta's way of going 64 bit eventually too.  (And
that was obvious even BEFORE the cross licensing
agreement was announced.))

And interestingly, an assembly routine optimized for
386 assembly just might get beaten by C code compiled
for Athlon optimization.  It's not JUST "IA32". 
Memory management code probably has to know about the
PAE addressing extensions, different translation
lookaside buffer versions, and interacting with the
wonderful wide world of DMA.  Luckily in kernel we
just don't do floating point (MMX/3DNow/whatever it
was they're so proud of in Pentium 4 whose acronym
I've forgotten at the moment.  Not SLS, that was a
linux distribution...)

If your'e a dyed in the wool assembly hacker, go help
the GCC/EGCS folks make a better compiler.  They could
use you.  The kernel isn't the place for assembly
optimization.

>Being that most users are on the IA32 platform, I'm 
>sure they wouldn't reject an assembly solution to 
>this problem.

If it's unreadable to C hackers, so that nobody
understands it, so that it's black magic that
positively invites subtle bugs from other code that
has to interface with it...

Yes they darn well WOULD reject it.  Simplicity and
clarity are actually slightly MORE important than raw
performance, since if you just six months the midrange
hardware gets 30% faster.

The ONLY assembly that's left in the kernel is the
stuff that's unavoidable, like boot sectors and the
setup code that bootstraps the first kernel init
function in C, or perhaps the occasional driver that's
so amazingly timing dependent it's effectively
real-time programming at the nanosecond level.  (And
for most of those, they've either faked a C solution
or restricted the assembly to 5 lines in the middle of
a bunch of C code.  Memo: this is the kind of thing
where profanity gets into kernel comments.)  And of
course there are a few assembly macros for half-dozen
line things like spinlocks that either can't be done
any other way or are real bottleneck cases where the
cost of the extra opacity (which is a major cost, that
is definitely taken into consideration) honestly is
worth it.

> As for kernel acceptance, that's an
>issue for the political eggheads. Not my forte. :-)

The problem in this case is an O(n^2) or worse
algorithm is being used.  Converting it to assembly
isn't going to fix something that gets exponentially
worse, it just means that instead of blowing up at 2
gigs it now blows up at 6 gigs.  That's not a long
term solution.

If eliminating 5 lines of assembly is a good thing,
rewriting an entire subsystem in assembly isn't going
to happen.  Trust us on this one.

Rob

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail - only $35 
a year!  http://personal.mail.yahoo.com/
