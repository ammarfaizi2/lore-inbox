Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRECSao>; Thu, 3 May 2001 14:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRECSaf>; Thu, 3 May 2001 14:30:35 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:26889 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S130900AbRECSaQ>;
	Thu, 3 May 2001 14:30:16 -0400
Date: Thu, 3 May 2001 14:30:37 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
Message-ID: <20010503143037.A1822@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Keith Owens <kaos@ocs.com.au>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503125921.A347@thyrsus.com> <E14vND4-0005u6-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14vND4-0005u6-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, May 03, 2001 at 06:48:10PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> If you get a conflict, turn the second feature in config file order off/on
> as appropriate then tell the user you did it.  Then continue to verify.

> Actually I think the problem is different. You are trying to solve a 
> mathematical graph theory problem elegantly. Make oldconfig solves a real
> world problem by a mixture of brutality and heuristics. 

You want brutality and heuristics?  I'll give you brutality and heuristics...

I could just treat a config as a sequence of assignments, as though
the user had typed them in sequence, rejecting any later ones that
throw constraint violations.  That way we can avoid ever accepting or
having to deal with an invalid configuration.  The invariant that every
symbol assignment either augments a valid configuration or is rejected
would be conserved.

This isn't "recovery", it's more like high-handedly throwing away
assignments that don't happen to fit stuff bound earlier in the tree
traverse that defines symbol print order.  And it's going to give odd,
"brutal" results in some cases because guard symbols are ordered
before their dependents.

But if all you want is brutality and heuristics, it might do.


I guess you didn't know that I trained as a mathematical logician.  On the
one hand, that predisposes me to try to find "elegant" solutions where 
you might regard brutality and heuristics as more appropriate.

On the other hand, without that kind of background you don't get
people building constraint-satisfaction systems to give you
provably-correct results, either.  So perhaps, on the whole,
mine is a more positive predisposition than not ;-).
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Men trained in arms from their infancy, and animated by the love of liberty,
will afford neither a cheap or easy conquest.
        -- From the Declaration of the Continental Congress, July 1775.
