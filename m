Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136650AbREAQa4>; Tue, 1 May 2001 12:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136653AbREAQaq>; Tue, 1 May 2001 12:30:46 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:30480 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S136650AbREAQa2>;
	Tue, 1 May 2001 12:30:28 -0400
Date: Tue, 1 May 2001 12:31:12 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Giacomo A. Catenazzi" <cate@dplanet.ch>
Cc: Peter Samuelson <peter@cadcamlab.org>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
Message-ID: <20010501123112.A7699@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Giacomo A. Catenazzi" <cate@dplanet.ch>,
	Peter Samuelson <peter@cadcamlab.org>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010427193501.A9805@thyrsus.com> <15084.12152.956561.490805@gargle.gargle.HOWL> <20010429183526.B32748@thyrsus.com> <15085.37569.205459.898540@gargle.gargle.HOWL> <20010430133932.B28849@thyrsus.com> <20010430141623.A15821@cadcamlab.org> <20010430152536.A29699@thyrsus.com> <3AEE80A3.EB0ACEB1@dplanet.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AEE80A3.EB0ACEB1@dplanet.ch>; from cate@dplanet.ch on Tue, May 01, 2001 at 11:23:47AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi <cate@dplanet.ch>:
> I think that a fundamental requirment is that 'make oldconfig' should
> validate any configurations (also the wrong conf).
> (If you correct your rules, our old .config can be invalid on a new
> kernel, and we don't want regualary edit our .config).

Validating is exactly what it's doing now.  What you really want is for it to
semi-automatically *correct* broken configurations, which is very
different and much harder.

> My proposal is instaed of complain about configuration violatation,
> you just wrote the possible correct configuration and prompt user to
> select the correct configuration.
> In the case you cite, e.g. oldconfig shoud prompt:
>   1) SMP=n
>   2) RTC=m
>   3) RTC=y
> (assuming the ARCH is invariant).

You, and the other person who proposed this previously, are getting
way too hung up on this particular easy case and not thinking about
the general problem.

The number of prompts goes up with the number of variables in the constraint. 
But the number of possible correct configurations goes up as 2**n -- actually,
3**n because we have trits.

What you're saying, in effect, is that if f is number of frozen variables
in the constraint then the configurator ought to generate 3 ** (n - f)
possible correct models and prompt for one of them.  Since f typically 
equals just 1 that number goes up really fast with n.

And what if one of the variables in the constraint is of integer or
string type?  In that case the number of possible models to be
prompted for is effectively infinite.  (Finite but very very large).

You are proposing an interface that will handle easy cases but blow
up in the user's face in any hard one.  That's poor design, frustrating
the user exactly when he/she most needs help.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The bearing of arms is the essential medium through which the
individual asserts both his social power and his participation in
politics as a responsible moral being..."
        -- J.G.A. Pocock, describing the beliefs of the founders of the U.S.
