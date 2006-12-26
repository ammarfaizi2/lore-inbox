Return-Path: <linux-kernel-owner+w=401wt.eu-S932853AbWLZXnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbWLZXnG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 18:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932860AbWLZXnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 18:43:05 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:48288 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932853AbWLZXnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 18:43:04 -0500
Date: Wed, 27 Dec 2006 00:40:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1-rt15: BUG in __tasklet_action at kernel/softirq.c:568
Message-ID: <20061226234045.GC6003@elte.hu>
References: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com> <20061219175728.GA20262@elte.hu> <e6babb600612200437n6c5ff4d4lf86e60c309dd1b6e@mail.gmail.com> <20061220195008.GB14316@elte.hu> <1166671151.852.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166671151.852.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2006-12-20 at 20:50 +0100, Ingo Molnar wrote:
> > * Robert Crocombe <rcrocomb@gmail.com> wrote:
> > 
> > > On 12/19/06, Ingo Molnar <mingo@elte.hu> wrote:
> > > >yeah. This is something that triggers very rarely on certain boxes. Not
> > > >fixed yet, and it's been around for some time.
> > > 
> > > Is there anything you would like me to do to help diagnose this?
> > 
> > to figure out what the bug is :-/ Below is the tasklet redesign patch - 
> > the bug must be in there somewhere.
> 
> > +static inline int tasklet_tryunlock(struct tasklet_struct *t)
> > +{
> > +	return cmpxchg(&t->state, TASKLET_STATEF_RUN, 0) == TASKLET_STATEF_RUN;
> > +}
> > +
> 
> This probably isn't it, but is cmpxchg available on all archs now?

yeah, it's probably not related, i saw these failures on plain i686 too, 
which definitely has cmpxchg support. The failures i saw happened on a 
hyperthreading CPU, so i guess it must be some sort of narrow race.

	Ingo
