Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWCZQ07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWCZQ07 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 11:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWCZQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 11:26:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:42647 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751396AbWCZQ06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 11:26:58 -0500
Date: Sun, 26 Mar 2006 18:24:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, torvalds@osdl.org,
       arjan@infradead.org
Subject: Re: [patch 04/10] PI-futex: scheduler support for PI
Message-ID: <20060326162421.GB15667@elte.hu>
References: <20060325184605.GE16724@elte.hu> <20060325190349.6b8fe5f3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325190349.6b8fe5f3.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> > +#ifdef CONFIG_RT_MUTEXES
> > +
> > +/*
> > + * rt_mutex_setprio - set the current priority of a task
> > + * @p: task
> > + * @prio: prio value (kernel-internal form)
> > + *
> > + * This function changes the 'effective' priority of a task. It does
> > + * not touch ->normal_prio like __setscheduler().
> > + *
> > + * Used by the rt_mutex code to implement priority inheritance logic.
> > + */
> > +void rt_mutex_setprio(task_t *p, int prio)
> > +{
> 
> This function is not really rt-mutex-related at all, is it?  It's just 
> a piece of new scheduler functionality which various things might use.

well, this particular function should only be used by the rt-mutex 
subsystem, because it sets the priority of a task unconditionally.  
Priority will vary depending on how other tasks block on a lock held by 
this task. So if some other subsystem changes the priority via this 
interface, it will both interfere with PI, and PI will interfere with 
this.

	Ingo
