Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbVASScz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbVASScz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbVASScy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:32:54 -0500
Received: from waste.org ([216.27.176.166]:60043 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261814AbVASScw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:32:52 -0500
Date: Wed, 19 Jan 2005 10:32:02 -0800
From: Matt Mackall <mpm@selenic.com>
To: "Jack O'Quin" <joq@io.com>
Cc: Ingo Molnar <mingo@elte.hu>, Chris Wright <chrisw@osdl.org>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
Message-ID: <20050119183202.GM12076@waste.org>
References: <871xcmuuu4.fsf@sulphur.joq.us> <20050116231307.GC24610@elte.hu> <87vf9xdj18.fsf@sulphur.joq.us> <20050117100633.GA3311@elte.hu> <87llaruy6m.fsf@sulphur.joq.us> <20050118080218.GB615@elte.hu> <87pt02pt0r.fsf@sulphur.joq.us> <20050119082433.GE29037@elte.hu> <20050119143927.GA11950@elte.hu> <87651tmhwv.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87651tmhwv.fsf@sulphur.joq.us>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -3211,6 +3211,12 @@ static inline task_t *find_process_by_pi
> >  static void __setscheduler(struct task_struct *p, int policy, int prio)
> >  {
> >  	BUG_ON(p->array);
> > +	if (prio == 1 && policy != SCHED_NORMAL) {
> > +		p->policy = SCHED_NORMAL;
> > +		p->static_prio = NICE_TO_PRIO(-20);
> > +		p->prio = p->static_prio;
> > +		return;
> > +	}
> >  	p->policy = policy;
> >  	p->rt_priority = prio;
> >  	if (policy != SCHED_NORMAL)
> >
> 
> JACK actually uses three different priorities, the defaults are 9, 10
> and 20.  How about if I change this test?
> 
> 	if (prio <= 20 && policy != SCHED_NORMAL) {
> 
> Or, should that be?
> 
> 	if (prio > 0 && prio <= 20 && policy != SCHED_NORMAL) {

Or you can just drop the 'prio == 1 &&' part for this test. Ingo was
trying to be clever to allow some RT bits, but that's not really
necessary.

-- 
Mathematics is the supreme nostalgia of our time.
