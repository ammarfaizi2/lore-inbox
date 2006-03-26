Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWCZXcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWCZXcn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWCZXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:32:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:61890 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932129AbWCZXcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:32:42 -0500
Date: Mon, 27 Mar 2006 01:30:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org, simlo@phys.au.dk
Subject: Re: [patch] PI-futex: -V2
Message-ID: <20060326233000.GA21711@elte.hu>
References: <20060325184612.GF16724@elte.hu> <20060325220728.3d5c8d36.akpm@osdl.org> <20060326160353.GA13282@elte.hu> <20060326111645.3cf2c206.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060326111645.3cf2c206.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > > > +	for (;;) {
> >  > > +		if (top_waiter)
> >  > > +			plist_del(&top_waiter->pi_list_entry,
> >  > > +				  &owner->pi_waiters);
> >  > > +
> >  > > +		if (waiter && waiter == rt_mutex_top_waiter(lock)) {
> >  > 
> >  > rt_mutex_top_waiter() can never return NULL, so the test for NULL 
> >  > could be removed.
> > 
> >  it might be NULL if adjust_pi_chain() is called from remove_waiter(), 
> >  and next_waiter there is NULL (because !rt_mutex_has_waiters() after the 
> >  removal of the current waiter).
> 
> Yes, `waiter' might be NULL.  But rt_mutex_top_waiter() will never 
> return NULL.  So it might be possible to just do
> 
> 	if (waiter == rt_mutex_top_waiter(lock))

ah, indeed, you are right.

> Which might actually be less efficient, and more obscure.  Just 
> pointing it out.

ok, i left it as-is for now.

	Ingo
