Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314432AbSDRTUD>; Thu, 18 Apr 2002 15:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314431AbSDRTUC>; Thu, 18 Apr 2002 15:20:02 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:43268 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S314430AbSDRTUC>; Thu, 18 Apr 2002 15:20:02 -0400
Date: Thu, 18 Apr 2002 21:20:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Doug Ledford <dledford@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
        jh@suse.cz, linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
        ak@suse.de, pavel@atrey.karlin.mff.cuni.cz,
        References:20020417194249.B23438@redhat.com,
        20020418072615.I14322@dualathlon.random
Subject: Re: SSE related security hole
Message-ID: <20020418192003.GE11220@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020418072615.I14322@dualathlon.random> <20020418094444.A2450@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > +		asm volatile("xorq %%mm0, %%mm0;
> > > +			      xorq %%mm1, %%mm1;
> > > +			      xorq %%mm2, %%mm2;
> > > +			      xorq %%mm3, %%mm3;
> > > +			      xorq %%mm4, %%mm4;
> > > +			      xorq %%mm5, %%mm5;
> > > +			      xorq %%mm6, %%mm6;
> > > +			      xorq %%mm7, %%mm7");
> > 
> > This mean the mmx isn't really backwards compatible and that's
> > potentially a problem for all the legacy x86 multiuser operative
> > systems.  That's an hardware design bug, not a software problem.  In
> > short running a 2.[02] kernel on a MMX capable CPU isn't secure, the
> > same potentially applies to windows NT and other unix, no matter of SSE.
> 
> Why is that not backwards compatible?  I've never heard of anywhere that 
> specifies that the starting value in the mmx registers will be anything of 
> consequence?  Also, even though register space is (possibly) shared with 
> the FP register stack, clearing out the MMX registers does not actually 
> harm the FP register stack since the fninit already blows the stack away, 
> which forces the application to load fp data before it can use the fpu 
> again.

It introduces security hole: Unrelated tasks now have your top secret
value you stored in one of your registers.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
