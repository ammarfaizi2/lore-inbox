Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262413AbREUJPb>; Mon, 21 May 2001 05:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbREUJPL>; Mon, 21 May 2001 05:15:11 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:15635 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262413AbREUJPE>; Mon, 21 May 2001 05:15:04 -0400
Message-ID: <3B08DC75.C466BA66@idb.hist.no>
Date: Mon, 21 May 2001 11:14:29 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy
In-Reply-To: <20010518105353.A13684@thyrsus.com> <3B053B9B.23286E6C@redhat.com> <20010518112625.A14309@thyrsus.com> <20010518113726.A29617@devserv.devel.redhat.com> <20010518114922.C14309@thyrsus.com> <8485.990357599@redhat.com> <20010520111856.C3431@thyrsus.com> <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:

> 
> To reduce the problem further, I looked for symbols with missing
> entries that I could turn into derivations, eliminating their
> questions and the requirement for a help entry.  

Adding help entries is nice.  But please don't go around
making "unlikely" choices unconditional in order to avoid writing
help text.  Leaving the help blank for such questions
is better than eliminating the question.

[...]
> By doing this I killed two birds with one stone -- got rid of some holes
> in Configure.help and (more importantly) moved the configuration experience
> away from low-level, hardware-oriented questions towards where I think it
> ought to be. That is, you specify a platform and the services you want and
> the ruleset computes the low-level facilities to be linked in.
> 

> 3. The MVME derivations are correct *if* (and only if) you agree to ignore
> the possibility that somebody could want to ignore the onboard hardware,
> plug outboard disk or Ethernet cards into the VME-bus connector, and
> do something like running SCSI-over-ATAPI to the outboard device.
> (I missed these possibilities when I wrote the derivations.)
> 
> I used case 3 to explore a touchy question about design philosophy, which
> is really what caused all hell to break loose.  The question is this:
> holding down configuration complexity is a good thing, but supporting
> all hardware configurations that are conceivably possible is also a good
> thing.  How should we trade these good things off against one another?

I'd say support all possible configurations that is supposed to work.  
You never know what someone might want to make out of 
spare parts and dusty old things.  

Particularly, not compiling (or modularizing) the driver for a built-in 
device is always a valid way of saving memory.  I don't compile IDE on
my
home pc, because all my devices are scsi.  And the built-in floppy
controller is modularized because it is so rarely used.  Why give
it permanent unswappable memory?

Your trade-off considerations should be wether "odd but possible"
choices
belong in an EXPERT category or if they should be there for everybody.
Don't consider eliminating something that would work.  Of course you
don't have to worry too much about help texts for the expert stuff - let
the experts add that themselves if you don't want to write for
fringe cases.

> The MVME situation is an almost perfect test case, because while
> breaking the assumption behind that derivation is physically possible
> it would be a rather perverse thing to do.  The VME147 is an old
> design, dating from 1988; it's long since been superseded by MPCxxx
> SBCs based on the PowerPC that have a better processor, lower power
> consumption, and more on-board peripheral hardware.  IDE/ATAPI didn't
> exist during most of its design lifetime, and the only way anyone is
> ever going to hook an outboard device to one of these puppies again
> is if some hacker pulls a dusty one off a shelf for some garage project.

Hackers get things like this for free when companies get rid of them, 
then turns them into mp3 players or hobby device controllers.

> So the real question here is whether it is ever acceptable to say that
> a possible configuration is just silly and ruleset will ignore it, in
Maybe it is acceptable to say something is too silly.  You have to
come up with a better example though.  People may definitely want to 
not have a driver, or make a module instead of compiled-in.

And they may want to not use the built-in device because they
use something better.  Like a fast ethernet connected to 
that old vme box because the net they connect to
is fast even though the box may be too weak to really
take advantage of it.  Or wide scsi instead of the built-in thing.

> order to hold down ruleset complexity and simplify the user
> experience.  The cost of deciding that the answer to that question is

The user experience can be simplified by a NOVICE/EASY/SANE_DEFAULTS 
option, and perhaps a HACKER option for the really strange 
but _theoretically_ ok stuff.

> "yes, sometimes" is that on rare occasions like this one you might
> have to haul out a text editor to tweak something in your config.  But
> the cost of deciding that the answer is "no" will be some pretty
> serious complexity headaches both in the configuration user experience
> and (down the road) in the maintainability of the ruleset.

If EXPERT options makes it too complex, consider having some rules
that are advisory only.  The debian packaging system has 
both absolute dependancies, and "suggestions".
Consider:
suggest MVME16x_SCC from MVME16x & SERIAL
which means that someone who turns on MVME16x_SCC and SERIAL
get MVME16x_SCC turned on when they do so.  
But the choice is visible and
it is possible for the user to turn it off at will.  Maybe shown in 
a different color or with some other hint that it is a defaulted
but overrideable thing.

Configuration gets simple for the vast amount of common cases,
but experts can do whatever they want.  
You could even have a user-interface option for not showing
such defaulted options.  That wouldn't complicate the rulebase,
it would be a UI-thing only.

Now you get both the simple rulebase and the nice user interface.
And satisfied experts.

Helge Hafting
