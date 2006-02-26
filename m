Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbWBZNTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbWBZNTS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 08:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWBZNTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 08:19:18 -0500
Received: from mail.gmx.de ([213.165.64.20]:29332 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751114AbWBZNTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 08:19:17 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
From: MIke Galbraith <efault@gmx.de>
To: "Daniel K." <daniel@cluded.net>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Con Kolivas <kernel@kolivas.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <44019075.2000205@cluded.net>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <44019075.2000205@cluded.net>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 14:19:35 +0100
Message-Id: <1140959975.7658.9.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 11:26 +0000, Daniel K. wrote:
> MIke Galbraith wrote:
> > On Fri, 2006-02-17 at 14:45 +0100, MIke Galbraith wrote: 
> > +/*
> > + * Masks for p->slice_info, formerly p->first_time_slice.
> > + * SLICE_FTS:   0x80000000  Task is in it's first ever timeslice.
> > + * SLICE_NEW:   0x40000000  Slice refreshed.
> > + * SLICE_SPA:   0x3FFF8000  Spare bits.
> > + * SLICE_LTS:   0x00007F80  Last time slice
> > + * SLICE_AVG:   0x0000007F  Task slice_avg stored as percentage.
> > + */
> > +#define SLICE_AVG_BITS    7
> > +#define SLICE_LTS_BITS   10
> > +#define SLICE_SPA_BITS   13
> > +#define SLICE_NEW_BITS    1
> > +#define SLICE_FTS_BITS    1
> 
> I count 8 and 15 bits in the documentation of LTS/SPA respectively, not 
> 10 and 13.

Dang, fixed the stupid bug, but forgot to wipe the evidence ;-)  Fixed.

> 
> >  	}
> >  
> >  	if (likely(sleep_time > 0)) {
> > +
> 
> Extra line

Fixed.

> 
> > +	{
> > +		.ctl_name	= KERN_SCHED_THROTTLE1,
> > +		.procname	= "sched_g1",
> > +		.data		= &sched_g1,
> > +		.maxlen		= sizeof (int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &proc_dointvec_minmax,
> > +		.strategy	= &sysctl_intvec,
> > +		.extra1		= &zero,
> > +		.extra2		= &sched_g2_max,
> 
> sched_g2_max is possibly badly named, as it is used in connection with 
> sched_g1 here.
> 
> > +	},
> > +	{
> > +		.ctl_name	= KERN_SCHED_THROTTLE2,
> > +		.procname	= "sched_g2",
> > +		.data		= &sched_g2,
> > +		.maxlen		= sizeof (int),
> > +		.mode		= 0644,
> > +		.proc_handler	= &proc_dointvec_minmax,
> > +		.strategy	= &sysctl_intvec,
> > +		.extra1		= &zero,
> > +		.extra2		= &sched_g2_max,
> > +	},

I suppose sched_grace_max would fit better.

Thanks for taking a look.

	-Mike

