Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288920AbSAES6V>; Sat, 5 Jan 2002 13:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288924AbSAES6C>; Sat, 5 Jan 2002 13:58:02 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:42391
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288920AbSAES5x>; Sat, 5 Jan 2002 13:57:53 -0500
Date: Sat, 5 Jan 2002 13:44:15 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2-2.0.0 is available -- major release announcement
Message-ID: <20020105134415.A22465@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 2.0.0: Sat Jan  5 13:30:28 EST 2002
	* Added autoconfigurator.py derived from Giacomo Catenazzi's bash
	  script.  Combining this with CML2's rulebase knowledge allows us
	  to eliminate huge numbers of questions.
	* Rulebase and help sync with 2.4.18-pre1/2.5.2-pre7.
	* Clean out cruft in the top-level rules file.
	* Inequality value forcing now handles trits better.
	* It is now possible to declare symbols and menus *after* they occur.
	* 'private' declaration has been replaced with "label...with...";
	  see the reference manual for details.
	* 'choicegroup' declaration introduced.

After months of maintainance only, there was some kind of harmonic
convergence in the last few days where the need for a bunch of new
features all went past critical at the same time.  

The bug queue for CML2 itself is empty.  However, there are some known
rulebase bugs near the framebuffer code which are under investigation.
Also, the navigation bar in the optional tree-widget-based
configurator is not fully enabled.

			NEW LANGUAGE FEATURES

2.0.0 substantially extends the CML2 constraint language.

One new feature is choicegroups.  This generalizes the concept of choice
menus.  You can now constrain any group of symbols so that at most one 
can have a non-N value.

Another significant change is that the 'private' feature is gone.  It
turned out to be mis-designed -- since private symbols weren't saved
to config.out, they were getting re-queried for by make oldconfig.

Instead there is now a more general facility, label/with declarations,
that allows you to label symbols in the config file with specified
tags in a following comment.  These can be used to pass instructions
to configuration postprocessors.  One such instruction, "PRIVATE", is
now defined -- it tells configtrans.py not to propagate the associated
symbol into the generated autoconf.h.

As part of the label/with change, many ordering restrictions in the CML2
compiler have been removed.  It is now possible to use symbols or menu
identifiers *before* their prompt declaration.  This removes a technical
barrier to dispersing the symbols.cml file the way Linus wants (though
there are still reasons I don't think it's a good idea to do that) and
in general makes the language easier to use.

			AUTOCONFIGURATION

It's always been part of my plan to support autoconfiguration -- a
utility that would combine CML2's knowledge base with hardware and
software autoprobes to make configuring for the box you're running on
as painless as possible.

Giacomo Catenazzi had been working on an autoconfigure.sh utility that
included a lot of autoprobe knowledge -- over 2500 tests, in fact.  A few
day ago we realized that it needed to be combined with CML2.  The specific
issue was PCI devices -- since we know we can get a complete list of them,
the autoconfigurator should be able to deduce that all others are absent
and produce a configuration for a trimmer kernel.

We concluded that autoconfigure.sh needed access to the list of PCI 
dependents in the CML2 rulebase, and Giacomo said he'd decided as a 
consequence to rewrite it in Python.  And I'm sure he would have ... but
I got the bit in my teeth and did it first :-).  

The first version of autoconfigure.py is included with this release. I
have tested it on three machines (one dual Athlon box built in late
2000, one dual Pentium II box from 1998 and one Cyrix machine from
1996) and it is extremely effective.  Kudos to Giocomo for collecting
so many useful probes.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The danger (where there is any) from armed citizens, is only to the
*government*, not to *society*; and as long as they have nothing to
revenge in the government (which they cannot have while it is in their
own hands) there are many advantages in their being accustomed to the 
use of arms, and no possible disadvantage.
        -- Joel Barlow, "Advice to the Privileged Orders", 1792-93
