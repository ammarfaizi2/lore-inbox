Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTJVOdh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTJVOdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 10:33:37 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:11200 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S263470AbTJVOdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 10:33:35 -0400
Date: Wed, 22 Oct 2003 16:34:21 +0200 (DFT)
From: Simon Derr <Simon.Derr@bull.net>
X-X-Sender: derrs@isabelle.frec.bull.fr
To: William Lee Irwin III <wli@holomorphy.com>
cc: Stephen Hemminger <shemminger@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Sylvain Jeaugey <sylvain.jeaugey@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: (1/4) [PATCH] cpuset -- 2.6.0-test8
In-Reply-To: <20031022000808.GA14431@holomorphy.com>
Message-ID: <Pine.A41.4.53.0310221620420.139942@isabelle.frec.bull.fr>
References: <Pine.A41.4.53.0310131503500.173334@isabelle.frec.bull.fr>
 <20031021162019.7089cee4.shemminger@osdl.org> <20031022000808.GA14431@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot Stephen for your work and for sharing your wisdom with us.

Thank you also William for your remarks.

On Tue, 21 Oct 2003, William Lee Irwin III wrote:
> > +static const int N = (8*sizeof(cpumask_t));
> > +/* this is a cyclic version of next_cpu */
> > +static inline void _next_cpu(const cpumask_t mask, int * index)
> > +{
> > +	for(;;) {
> > +		if (++*index >= N) *index = 0;
> > +		if (cpu_isset(*index, mask)) return;
> > +	}
> > +}
> Best not to insist NR_CPUS % BITS_PER_LONG == 0.
Actually we don't, but you're right, NR_CPUS should definately be used
here.

> > +static void migrate_cpuset_processes(struct cpuset * cs)
> > +	/* This should be a RARE use of the cpusets.
> > +	 * therefore we'll prefer an inefficient operation here
> > +	 * (searching the whole process list)
> > +	 * than adding another list_head in task_t
> > +	 * and locks and list_add for each fork()
> Unfair rwlocks can take boxen out when abused by quadratic algorithms.

I don't see exactly which lock you are talking about here ?
Anyway, the current state of the cpusets is OK for a 'gentle' use. I'm
sure some improvements are needed to protect it from 'evil' users ;-)

	Simon.

