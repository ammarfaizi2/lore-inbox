Return-Path: <linux-kernel-owner+w=401wt.eu-S1762614AbWLKHYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762614AbWLKHYb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 02:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762619AbWLKHYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 02:24:31 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:38333 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762614AbWLKHYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 02:24:30 -0500
Date: Mon, 11 Dec 2006 08:23:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jarek Poplawski <jarkao2@o2.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] lockdep: fix possible races while disabling lock-debugging
Message-ID: <20061211072302.GA31962@elte.hu>
References: <20061207132903.GA341@elte.hu> <20061208062725.GA1012@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061208062725.GA1012@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jarek Poplawski <jarkao2@o2.pl> wrote:

> > @@ -567,12 +601,10 @@ static noinline int print_circular_bug_t
> >  	if (debug_locks_silent)
> >  		return 0;
> >  
> > -	/* hash_lock unlocked by the header */
> > -	__raw_spin_lock(&hash_lock);
> >  	this.class = check_source->class;
> >  	if (!save_trace(&this.trace))
> >  		return 0;
> > -	__raw_spin_unlock(&hash_lock);
> > +
> 
> IMHO lock is needed here for save_trace.

indeed. I'll do a fix for this.

	Ingo
