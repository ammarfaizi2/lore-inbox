Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132991AbRECQ7G>; Thu, 3 May 2001 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135735AbRECQ64>; Thu, 3 May 2001 12:58:56 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:1801 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132991AbRECQ6q>;
	Thu, 3 May 2001 12:58:46 -0400
Date: Thu, 3 May 2001 12:59:21 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Why recovering from broken configs is too hard
Message-ID: <20010503125921.A347@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010503034755.A27693@thyrsus.com> <15180.988884926@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15180.988884926@ocs3.ocs-net>; from kaos@ocs.com.au on Thu, May 03, 2001 at 08:15:26PM +1000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> On Thu, 3 May 2001 03:47:55 -0400, 
> "Eric S. Raymond" <esr@thyrsus.com> wrote:
> >OK, so you want CML2's "make oldconfig" to do something more graceful than
> >simply say "Foo! You violated this constraint! Go fix it!"
> 
> (i) Start with a valid config.  CML2 will not allow any changes that
>     violate the constraints.  Not a problem.

Right.  This is 99.9% of cases.  All this heat and argument is over a
very, very unusual situation.  Much more unusual than most of the 
people arguing about it realize.

(For those of you haven't caught up with this, *missing symbols do not
make a configuration invalid*.  Only inconsistencies between explicitly
set symbols can do that.)
 
> (ii) Start with a invalid config.  CML2 makes best effort at correcting
>      it.
> 
>      (a) Interactive mode (menuconfig, xconfig) - tell the user to fix
>          it.

The problem with this is that in order to support it I have to throw away the
configurator's central invariant -- which is that every change that does not
lead to a valid configuration is rejected (with an explanation).  

I'm not going to do that.  It's not worth it to handle a case this marginal.

>      (b) Batch mode (oldconfig).  Attempt to automatically correct the
>          config using these rules.
> 
>         (1) Earlier constraints take priority over later constraints.
>             That is, scan the constraints from top to bottom as listed
>             by the rules.
> 
>         (2) For valid constraints, freeze all variables in the
>             constraint, both guard and dependent.
> 
>         (3) For failing constraints, freeze the guard variables, change
>             the dependent variable to satisfy the constraint then
>             freeze it.

There's the problem.  You don't know which variable(s) are dependent.
That's not a well-defined notion here.  Consider the case that stimulated
this whole argument:

	(X86 and SMP) implies RTC!=n

You think you know that RTC is 'dependent', but this is an illusion created
by the presence of the asymmetrical `implies'.  Go look at the hierarchy.
You'll see what I mean.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Are we at last brought to such a humiliating and debasing degradation,
that we cannot be trusted with arms for our own defence?  Where is the
difference between having our arms in our own possession and under our
own direction, and having them under the management of Congress?  If
our defence be the *real* object of having those arms, in whose hands
can they be trusted with more propriety, or equal safety to us, as in
our own hands?
        -- Patrick Henry, speech of June 9 1788
