Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWDMLFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWDMLFe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964880AbWDMLFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:05:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:56460 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964878AbWDMLFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:05:33 -0400
X-Authenticated: #14349625
Subject: Re: [patch][rfc] quell interactive feeding frenzy
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: bert hubert <bert.hubert@netherlabs.nl>,
       lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Peter Williams <pwil3058@bigpond.net.au>
In-Reply-To: <200604132016.45512.kernel@kolivas.org>
References: <1144402690.7857.31.camel@homer>
	 <1144681009.8493.17.camel@homer> <1144914061.9352.25.camel@homer>
	 <200604132016.45512.kernel@kolivas.org>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 13:05:24 +0200
Message-Id: <1144926324.7556.18.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 20:16 +1000, Con Kolivas wrote:
> On Thursday 13 April 2006 17:41, Mike Galbraith wrote:
> > This way also allowed me to eliminate the interactive agony of an array
> > switch when at 100% cpu.  Seems to work well.  No more agony, only tiny
> > pin pricks.
> >
> 
> Comments.
> 
> > +repeat:
> > +	while ((idx = find_next_bit(bitmap, MAX_PRIO, idx)) < MAX_PRIO) {
> 
> ...
> 
> > +		goto repeat;
> 
> ...
> 
> > +               if (rq->nr_running > 1)
> > +                       requeue_starving(rq, now);
> 
> An O(n) function in scheduler_tick is probably not the way to tackle this.

Why not?  It's one quick-like-bunny stop per occupied queue per slice
completion.

	-Mike

