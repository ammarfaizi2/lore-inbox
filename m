Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSFENaQ>; Wed, 5 Jun 2002 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSFENaP>; Wed, 5 Jun 2002 09:30:15 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:772 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315420AbSFENaP>; Wed, 5 Jun 2002 09:30:15 -0400
Date: Wed, 5 Jun 2002 09:26:04 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: jw schultz <jw@pegasys.ws>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] POSIX personality
In-Reply-To: <20020524170207.C9600@pegasys.ws>
Message-ID: <Pine.LNX.3.96.1020605091651.910A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 May 2002, jw schultz wrote:

> On Thu, May 23, 2002 at 10:09:28AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Thu, 23 May 2002, Bill Davidsen wrote:
> > >
> > > I think the reason which comes to mind is avoiding future problems. By
> > > having a single POSIX mode flag not only does the program not have to know
> > > about setting the "right" other bits today, but if we find that POSIX
> > > behaviour is needed in some other area in the future, the program doesn't
> > > need to be modified and recompiled, because the POSIX behaviour "is in
> > > there" for all things.
> > 
> > That's a nice argument in theory, but if you change the behaviour of
> > existing flags, you might fix some program for the real semantics, but you
> > might equally well _break_ some program that unwittingly depended on the
> > old semantics.
> > 
> > So I think your argument is fundamentally flawed. The binary has been
> > tested with the old behaviour, and assuming that you can "fix" existing
> > binaries by changing kernel behaviour is a seriously flawed argument.
> > 
> > Yes, it might work for some programs, but basically you're on very thin
> > ice.
> > 
> > Does Linux break stuff when absolutely required? Sure. But designing an
> > interface that _plans_ on changing semantics is just incredibly stupid,
> > and should absolutely not be done. Ever.
> > 
> > 			Linus
> 
> It seems to me that the biggest issue here is maintaining
> POSIX behavior without having to modify application source
> every time the flag set changes.
> 
> Perhaps a POSIX bitmask could be defined.
> 
> For a degree of binary compatibility a few unused flags
> could be reserved and the POSIX bitmask include them
> whether they had meaning yet or not. 

Obviously two ways of looking at things. Linus wants it to work the same
all the time, I want it to work the same on all POSIX systems, and if we
add (or find) a kernel change which isn't POSIX, and doing things in the
POSIX manner breaks the binary, the error is in the program. I have no
problem with bits to make little parts of Linux behave in a POSIX manner,
but I would like one POSIX bit which sets the most compliant behaviour
available.

I shouldn't have to recompile every time another instance of POSIX
behaviour is added, and I fail to see that bits are so precious that there
couldn't be one POSIX bit in addition to the bits allowing a monmgrel
hybred of POSIX and non-POSIX behaviour.

if (environ & OPTION_POSIX_FOO) { standard... } else { non-standard }
  is no faster than 
if (environ & (OPTION_POSIX | OPTION_POSIX_FOO)) ...
  and I fail to see why Linus is fighting the idea so hard. If correct
behaviour breaks my portable program it wasn't portable and the program is
in error. I set the bit, I have no complaint.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

