Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSHEV0k>; Mon, 5 Aug 2002 17:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSHEV0k>; Mon, 5 Aug 2002 17:26:40 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:17578 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318881AbSHEV0j>; Mon, 5 Aug 2002 17:26:39 -0400
Date: Mon, 5 Aug 2002 22:30:06 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user  mode linux]
Message-ID: <20020805223006.A8773@kushida.apsleyroad.org>
References: <20020805163910.C7130@kushida.apsleyroad.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com.suse.lists.linux.kernel> <p73znw1i781.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <p73znw1i781.fsf@oldwotan.suse.de>; from ak@suse.de on Mon, Aug 05, 2002 at 06:46:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of questions.

Andi Kleen wrote:
> +	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0], 
> +				(ka->sa.sa_flags&SA_NOFP));

>  	err |= setup_sigcontext(&frame->uc.uc_mcontext, &frame->fpstate,
> -			        regs, set->sig[0]);
> +			        regs, set->sig[0], !!(ka->sa.sa_flags&SA_NOFP));

1: Why the inconsistency between the two ways the SA_NOFP flag is checked?

2: What happens when the user's signal handler decides it wants to save
the FPU state itself (after all) and proceed with some FPU use.  Will
sigreturn restore the user-saved FPU state?  Just curious.

-- Jamie
