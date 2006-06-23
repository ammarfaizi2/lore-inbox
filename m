Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932945AbWFWInl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932945AbWFWInl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbWFWInl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:43:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47582 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932945AbWFWInk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:43:40 -0400
Date: Fri, 23 Jun 2006 10:38:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 06/61] lock validator: add __module_address() method
Message-ID: <20060623083844.GC919@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212333.GF3155@elte.hu> <20060529183325.b2f02192.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183325.b2f02192.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Mon, 29 May 2006 23:23:33 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > +/*
> > + * Is this a valid module address? We don't grab the lock.
> > + */
> > +int __module_address(unsigned long addr)
> > +{
> > +	struct module *mod;
> > +
> > +	list_for_each_entry(mod, &modules, list)
> > +		if (within(addr, mod->module_core, mod->core_size))
> > +			return 1;
> > +	return 0;
> > +}
> 
> Returns a boolean.
> 
> >  /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
> >  struct module *__module_text_address(unsigned long addr)
> 
> But this returns a module*.
> 
> I'd suggest that __module_address() should do the same thing, from an 
> API neatness POV.  Although perhaps that's mot very useful if we 
> didn't take a ref on the returned object (but module_text_address() 
> doesn't either).
> 
> Also, the name's a bit misleading - it sounds like it returns the 
> address of a module or something.  __module_any_address() would be 
> better, perhaps?

yeah. I changed this to __is_module_address().

> Also, how come this doesn't need modlist_lock()?

indeed. I originally avoided taking that lock due to recursion worries - 
but in fact we use this only in sections that initialize a lock - hence 
no recursion problems.

i fixed this and renamed the function to is_module_address() :)

	Ingo
