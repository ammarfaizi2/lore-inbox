Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262344AbRERPRX>; Fri, 18 May 2001 11:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262341AbRERPRN>; Fri, 18 May 2001 11:17:13 -0400
Received: from warden.digitalinsight.com ([208.29.163.2]:46759 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S262346AbRERPRC>; Fri, 18 May 2001 11:17:02 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Date: Fri, 18 May 2001 07:06:11 -0700 (PDT)
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010518105353.A13684@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0105180702300.17872-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if you punt in case C you should then have a mode where all dependancies
are ignored and all options are presented to the person ding the config.
This is FAR better then forcing them to hand-hack the config file.

possibly split the rules file into two parts.

part 1. absolute requirements (i.e. if you select a SCSI controller you
MUST select SCSI)

part 2. simplifications (i.e. if x86 and printer then x86_printer)

tehn have a mode where the part 2 rules are not evaluated to handle the
corner cases.

David Lang


 On Fri, 18 May 2001, Eric S.
Raymond wrote:

> Date: Fri, 18 May 2001 10:53:53 -0400
> From: Eric S. Raymond <esr@thyrsus.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Cc: Tom Rini <trini@kernel.crashing.org>,
>      Michael Meissner <meissner@spectacle-pond.org>,
>      Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
>      kbuild-devel@lists.sourceforge.net
> Subject: Re: CML2 design philosophy heads-up
>
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > I was under the impression the MVME had VME bus. So you can hang IDE off it
> > and other gunge. Its also a reference design so you may find MVME147 like
> > boards..
>
> Urk.  Alan is right, I misinterpreted the original question.  There is
> no on-board support for IDE or PCMCIA, but you could plug in an IDE
> daughterboard with an IDE drive or a PCMCIA slot.  This would be a
> pretty damn perverse thing to do, however -- there are newer, less
> expensive, faster, and generally better SBCs that have IDE/ATAPI and
> PCMCIA built in.  On top of that, VMEbus SBCs aren't normally used for
> consumer devices -- their market is basically industrial-control
> applications with a side of scientific instrumentation.
>
> That being the case, we do face a question of design
> philosophy, expressed as a policy question about how to design
> rulesets.  Actually two questions:
>
> 1. When we have a platform symbol for a reference design like MVME147, do
>    we stick to its spec sheet or consider it representative of all derivatives
>    (which may have other facilities)?
>
> I know my answer to this one, which I will implement unless there's
> strong consensus otherwise.  I go for explicitness.  If we're going to
> support MVME147 derivatives and variants in the ruleset, they get
> their own platform symbols.
>
> 2. How much extra tsuris should we accept in order to handle
>    perverse edge cases like this one?  There are three ways we
>    can cope:
>
>    (a) Back off the capability approach.  That is, accept that
>        people doing configuration are going to explicitly and
>        exhaustively specify low-level hardware.
>
>    (b) Add complexity to the ruleset.  Split SCSI into SCSI_MIDLEVEL and
>        SCSI_DRIVERS capabilities, make sure SCSI_DRIVERS is implied
>        whenever a SCSI card is configured, etc.
>
>    (c) Decide not to support this case and document the fact in the
>        rulesfile.  If you're going put gunge on the VME bus that replaces
>        the SBC's on-board facilities, you can hand-hack your own configs.
>
> I don't want to do (a); it conflicts with my design objective of
> simplifying configuration enough that Aunt Tillie can do it.  I won't
> do that unless I see a strong consensus that it's the only Right Thing.
>
> The larger question in choosing between (b) and (c) is one of the usual ones
> in programming -- that is, generality vs. maintainability.  Is it ever
> acceptable for the configuration system to deliberately punt an edge case
> like this one in order to keep from having a combinatorial-complexity
> explosion in the ruleset?
>
> I know what my sense of taste and proportion says.  But I'm not going
> to impose my vision on everybody.  If you have an opinion, I'd like
> to hear it.
> --
> 		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
>
> Whether the authorities be invaders or merely local tyrants, the
> effect of such [gun control] laws is to place the individual at the
> mercy of the state, unable to resist.
>         -- Robert Anson Heinlein, 1949
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
