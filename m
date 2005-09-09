Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbVIIMrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbVIIMrN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVIIMrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:47:13 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47504 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751398AbVIIMrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:47:12 -0400
Date: Fri, 9 Sep 2005 05:47:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] x86_64: Add notify_die() to another spot in do_page_fault()
Message-ID: <20050909124711.GA3041@smtp.west.cox.net>
References: <20050908163840.GR3966@smtp.west.cox.net> <200509091001.01325.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509091001.01325.ak@suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 10:01:00AM +0200, Andi Kleen wrote:
> On Thursday 08 September 2005 18:38, Tom Rini wrote:
> > This adds a call to notify_die() in the "no context" portion of
> > do_page_fault() as someone on the chain might care and want to do a fixup.
> >
> > ---
> >
> >  linux-2.6.13-trini/arch/x86_64/mm/fault.c |    4 ++++
> >  1 files changed, 4 insertions(+)
> >
> > diff -puN arch/x86_64/mm/fault.c~x86_64-no_context_hook
> > arch/x86_64/mm/fault.c ---
> > linux-2.6.13/arch/x86_64/mm/fault.c~x86_64-no_context_hook	2005-09-01
> > 12:00:43.000000000 -0700 +++
> > linux-2.6.13-trini/arch/x86_64/mm/fault.c	2005-09-01 12:00:43.000000000
> > -0700 @@ -514,6 +514,10 @@ no_context:
> >  	if (is_errata93(regs, address))
> >  		return;
> >
> > +	if (notify_die(DIE_PAGE_FAULT, "no context", regs, error_code, 14,
> > +				SIGSEGV) == NOTIFY_STOP)
> > +		return;
> > +
> 
> But how would the chain users distingush this from the DIE_PAGE_FAULT
> reported at the beginning of the page fault handler? I don't see how
> it can work. If anything you would need a DIE_NO_CONTEXT or somesuch, no? 

"no context" is passed to the functions as well, and in KGDB we strcmp
on that.

-- 
Tom Rini
http://gate.crashing.org/~trini/
