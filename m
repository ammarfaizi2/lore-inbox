Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136136AbRECHEe>; Thu, 3 May 2001 03:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136137AbRECHEZ>; Thu, 3 May 2001 03:04:25 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:36358 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136136AbRECHEU>;
	Thu, 3 May 2001 03:04:20 -0400
Date: Thu, 3 May 2001 03:04:31 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: John Stoffel <stoffel@casc.com>
Cc: cate@dplanet.ch, Peter Samuelson <peter@cadcamlab.org>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Hierarchy doesn't solve the problem
Message-ID: <20010503030431.A25141@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	Peter Samuelson <peter@cadcamlab.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <200 <3AF00C53.5EEE8E01@math.ethz.ch> <20010502134955.A19257@thyrsus.com> <15088.27159.630786.913424@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15088.27159.630786.913424@gargle.gargle.HOWL>; from stoffel@casc.com on Wed, May 02, 2001 at 04:12:07PM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <stoffel@casc.com>:
> He's saying that when you find the first invalid assertion, such as
> not having CONFIG_RTC defined, when reading the .config file, you
> should prompt for a fix.  Then once the input is taken, continue your
> checks, prompting for each following problem as needed. 

The problem lies in that innocent-sounding phrase "prompt for a fix".
Generating such a prompt is a far deeper problem than you seem to realize.
  
> No, we're just asking you to make the CML2 parser more tolerant of old
> and possibly broken configs.

The parser is not the problem.  The parser tolerates old, broken
configs quite happily.  Gives you a nice pop-up message when it hits
an invalid symbol.  No, the problem is that y*ou're asking me to make
the deduction machinery solve a problem that is (a) ill-defined and
(b) subject to a 3^n combinatorial explosion.
 
> I haven't looked at the parser in any detail, but I assume that there
> are heirarchal configuration settings.  When there is a mis-match,
> where a sub-option conflicts with an upper option, how hard would it
> be to print a warning, and just reset the sub-option to an acceptable
> state?

Clever idea -- not so clever that stupid me didn't think of it six months
ago, but clever.  Might even work if the constraints always obeyed a neat
hierarchy.  They don't. The constraints can reach across the tree.

In many cases there is no way to define "upper" or "lower".  (X86 and
SMP) implies RTC!=n is actually a good example.  Here's where they fit
in the tree:

 main                   'Linux Kernel Configuration System'
     arch               'Processor type'
         X86            'Intel or compatible 80x86 processor'
     generic            'Architecture-independent feature selections'
         SMP            'Symmetric Multi-Processing support'
     archihacks         'Architecture-specific hardware hacks'
         RTC            'Enhanced Real Time Clock Support'

Yes, that's right -- they're all at the same level.  OK, X86 is frozen
by hypothesis.  So now give me a rule for telling which of SMP and RTC
is "superior".  Note that in order to make the rule usable by the
deducer, it can't know anything about the semantics of the symbols.

Do you sense an abyss yawning beneath you yet?  If not, hold on.
You'll see it shortly.

I started to write up a full explanation but I think I'm going to post
that separately.  It's long.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Never could an increase of comfort or security be a sufficient good to be
bought at the price of liberty.
	-- Hillaire Belloc
