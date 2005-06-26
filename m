Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbVFZKxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbVFZKxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 06:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVFZKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 06:53:08 -0400
Received: from [203.171.93.254] ([203.171.93.254]:54500 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261287AbVFZKxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 06:53:04 -0400
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing
	usable for other purposes
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Christoph Lameter <christoph@lameter.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       raybry@engr.sgi.com, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050626023053.GA2871@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net>
	 <20050625025122.GC22393@atrey.karlin.mff.cuni.cz>
	 <Pine.LNX.4.62.0506242311220.7971@graphe.net>
	 <20050626023053.GA2871@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1119783254.8083.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 26 Jun 2005 20:54:14 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, 2005-06-26 at 12:30, Pavel Machek wrote:
> > Index: linux-2.6.12/arch/i386/kernel/signal.c
> > ===================================================================
> > --- linux-2.6.12.orig/arch/i386/kernel/signal.c	2005-06-25 05:01:26.000000000 +0000
> > +++ linux-2.6.12/arch/i386/kernel/signal.c	2005-06-25 05:01:28.000000000 +0000
> > @@ -608,10 +608,8 @@ int fastcall do_signal(struct pt_regs *r
> >  	if (!user_mode(regs))
> >  		return 1;
> >  
> > -	if (current->flags & PF_FREEZE) {
> > -		refrigerator(0);
> > +	if (try_to_freeze)
> >  		goto no_signal;
> > -	}
> >  
> 
> This is not good. Missing ().

Thanks!

I was just going to begin a search to find out why, after applying it,
everything stopped dead in the water :>

Nigel

