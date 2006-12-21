Return-Path: <linux-kernel-owner+w=401wt.eu-S1422635AbWLUDTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422635AbWLUDTR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWLUDTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:19:17 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:45030 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422635AbWLUDTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:19:17 -0500
Subject: Re: 2.6.19.1-rt15: BUG in __tasklet_action at kernel/softirq.c:568
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Crocombe <rcrocomb@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20061220195008.GB14316@elte.hu>
References: <e6babb600612180948n7820c038k148a5a514d541b2e@mail.gmail.com>
	 <20061219175728.GA20262@elte.hu>
	 <e6babb600612200437n6c5ff4d4lf86e60c309dd1b6e@mail.gmail.com>
	 <20061220195008.GB14316@elte.hu>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 22:19:11 -0500
Message-Id: <1166671151.852.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 20:50 +0100, Ingo Molnar wrote:
> * Robert Crocombe <rcrocomb@gmail.com> wrote:
> 
> > On 12/19/06, Ingo Molnar <mingo@elte.hu> wrote:
> > >yeah. This is something that triggers very rarely on certain boxes. Not
> > >fixed yet, and it's been around for some time.
> > 
> > Is there anything you would like me to do to help diagnose this?
> 
> to figure out what the bug is :-/ Below is the tasklet redesign patch - 
> the bug must be in there somewhere.

> +static inline int tasklet_tryunlock(struct tasklet_struct *t)
> +{
> +	return cmpxchg(&t->state, TASKLET_STATEF_RUN, 0) == TASKLET_STATEF_RUN;
> +}
> +

This probably isn't it, but is cmpxchg available on all archs now?

-- Steve


