Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287170AbRL2JR0>; Sat, 29 Dec 2001 04:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287169AbRL2JRQ>; Sat, 29 Dec 2001 04:17:16 -0500
Received: from dubb05h09-0.dplanet.ch ([212.35.36.9]:49158 "EHLO
	dubb05h09-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S287168AbRL2JRH>; Sat, 29 Dec 2001 04:17:07 -0500
Message-ID: <3C2D8A4C.5FFA95C0@dplanet.ch>
Date: Sat, 29 Dec 2001 10:18:04 +0100
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system
In-Reply-To: <20011228170840.A20254@thyrsus.com> <Pine.LNX.4.33.0112281429010.23445-100000@penguin.transmeta.com> <20011228175832.C20254@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Linus Torvalds <torvalds@transmeta.com>:
> > Eric, this is the _wrong_approach_. I want /local/ files, not global ones.
> 
> First: where should the prompt-string definitions for capability
> symbols that occur in multiple port trees live?

Proposal:
the main cml script in linux root dir  should be as little as possible.
it will include all the arch/*/ cml files (for really specifific
options) and you move other item into the subdir drivers/
(the natural place, all file who should not be in driver/ are
by definition arch specific).

> 
> Second: Forward references, and references across the tree, mean that
> there is a class of symbols that have theoretically natural home directories
> but which would have to be declared elsewhere in order to be defined at
> the point of first reference.
> 
> (A potential solution to this would be to improve the CML2 compiler's
> handling of forward references.)

No. CML2 could be improved to handle che forward references, but
not user that will use line config.


> Third: I could hack my installer to break Configure.help up into
> a bunch of little component CML files distributed through the tree...
> but Configure.help doesn't currently contain any markup that says
> where to direct each entry to.

The Makefile should help you. 

> Fourth: There's still the localization issue.  If it's your ukase
> that this is not an important problem, then I'll accept that -- but
> I haven't heard you say that yet, so I'm not sure you've considered
> it enough.

PROPOSAL: You add a tool to build a big file from the sparse
symbols.cml. Translator will use this file as references,
adn your CML2 will use translated big files or the default
sparse little files.

This should not be a problem, because a translator will read
documentation (unlike the most user), so you can explain
how to do this work. (And the 'diff' could be a friend
to the translators).


kbuild-2.5 have already support for 'clean' driver
(clean: driver that don't touch existing files). 
I like it. If CML2 could handle natively also these
change it would great.
The problem is the use of multiple sources dir.
I think you and Keith should coordinate this
work.
And I find clean if also configuration files go
into makefiles.


	giacomo

PS:

Keith: How you handle the obsolete files?
(foo.c in the main source. the patch in
 source src1 will remove this file).
Actually I have create a shell script
kpatch: a new implementation of
scripts/patch-kernel, that handles
normal, testing and testing/incr patches,
dont-use patches, multiple sources  and
new (and clean) destination dir).
