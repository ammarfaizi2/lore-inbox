Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSHEVcH>; Mon, 5 Aug 2002 17:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSHEVcH>; Mon, 5 Aug 2002 17:32:07 -0400
Received: from ns.suse.de ([213.95.15.193]:15627 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318839AbSHEVcG>;
	Mon, 5 Aug 2002 17:32:06 -0400
Date: Mon, 5 Aug 2002 23:35:42 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user  mode linux]
Message-ID: <20020805233542.A12753@wotan.suse.de>
References: <20020805163910.C7130@kushida.apsleyroad.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com.suse.lists.linux.kernel> <p73znw1i781.fsf@oldwotan.suse.de> <20020805223006.A8773@kushida.apsleyroad.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020805223006.A8773@kushida.apsleyroad.org>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 10:30:06PM +0100, Jamie Lokier wrote:
> Andi Kleen wrote:
> > +	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0], 
> > +				(ka->sa.sa_flags&SA_NOFP));
> 
> >  	err |= setup_sigcontext(&frame->uc.uc_mcontext, &frame->fpstate,
> > -			        regs, set->sig[0]);
> > +			        regs, set->sig[0], !!(ka->sa.sa_flags&SA_NOFP));
> 
> 1: Why the inconsistency between the two ways the SA_NOFP flag is checked?

I don't remember. Probably there was some reason in an earlier version
of the code. The !! could be probably removed now.

> 
> 2: What happens when the user's signal handler decides it wants to save
> the FPU state itself (after all) and proceed with some FPU use.  Will
> sigreturn restore the user-saved FPU state?  Just curious.

Nope it won't because there is no saved state. The previous context's FPU 
state will be silently corrupted.

-Andi
