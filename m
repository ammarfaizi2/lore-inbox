Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbREROzk>; Fri, 18 May 2001 10:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbREROza>; Fri, 18 May 2001 10:55:30 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45576 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S262105AbREROzY>;
	Fri, 18 May 2001 10:55:24 -0400
Date: Fri, 18 May 2001 10:53:53 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518105353.A13684@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Michael Meissner <meissner@spectacle-pond.org>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518034307.A10784@thyrsus.com> <E150fV9-0006q1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E150fV9-0006q1-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 18, 2001 at 09:20:47AM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> I was under the impression the MVME had VME bus. So you can hang IDE off it
> and other gunge. Its also a reference design so you may find MVME147 like
> boards..

Urk.  Alan is right, I misinterpreted the original question.  There is
no on-board support for IDE or PCMCIA, but you could plug in an IDE
daughterboard with an IDE drive or a PCMCIA slot.  This would be a
pretty damn perverse thing to do, however -- there are newer, less
expensive, faster, and generally better SBCs that have IDE/ATAPI and
PCMCIA built in.  On top of that, VMEbus SBCs aren't normally used for
consumer devices -- their market is basically industrial-control
applications with a side of scientific instrumentation.

That being the case, we do face a question of design
philosophy, expressed as a policy question about how to design
rulesets.  Actually two questions:

1. When we have a platform symbol for a reference design like MVME147, do 
   we stick to its spec sheet or consider it representative of all derivatives
   (which may have other facilities)?

I know my answer to this one, which I will implement unless there's
strong consensus otherwise.  I go for explicitness.  If we're going to
support MVME147 derivatives and variants in the ruleset, they get
their own platform symbols.

2. How much extra tsuris should we accept in order to handle
   perverse edge cases like this one?  There are three ways we
   can cope:

   (a) Back off the capability approach.  That is, accept that 
       people doing configuration are going to explicitly and 
       exhaustively specify low-level hardware.

   (b) Add complexity to the ruleset.  Split SCSI into SCSI_MIDLEVEL and 
       SCSI_DRIVERS capabilities, make sure SCSI_DRIVERS is implied
       whenever a SCSI card is configured, etc.

   (c) Decide not to support this case and document the fact in the
       rulesfile.  If you're going put gunge on the VME bus that replaces
       the SBC's on-board facilities, you can hand-hack your own configs.

I don't want to do (a); it conflicts with my design objective of
simplifying configuration enough that Aunt Tillie can do it.  I won't 
do that unless I see a strong consensus that it's the only Right Thing.

The larger question in choosing between (b) and (c) is one of the usual ones
in programming -- that is, generality vs. maintainability.  Is it ever 
acceptable for the configuration system to deliberately punt an edge case
like this one in order to keep from having a combinatorial-complexity
explosion in the ruleset?

I know what my sense of taste and proportion says.  But I'm not going
to impose my vision on everybody.  If you have an opinion, I'd like
to hear it.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Whether the authorities be invaders or merely local tyrants, the
effect of such [gun control] laws is to place the individual at the 
mercy of the state, unable to resist.
        -- Robert Anson Heinlein, 1949
