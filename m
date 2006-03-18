Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751942AbWCRHzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWCRHzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 02:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751986AbWCRHzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 02:55:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40682 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751942AbWCRHzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 02:55:04 -0500
Date: Fri, 17 Mar 2006 23:52:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
Message-Id: <20060317235206.122e687a.akpm@osdl.org>
In-Reply-To: <1142668119.7787.7.camel@homer>
References: <1142658480.8262.38.camel@homer>
	<20060317211529.26969a16.akpm@osdl.org>
	<1142661030.8937.7.camel@homer>
	<20060317222203.06d7f450.akpm@osdl.org>
	<1142666985.7881.5.camel@homer>
	<20060317233327.787b4d07.akpm@osdl.org>
	<1142668119.7787.7.camel@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> wrote:
>
> On Fri, 2006-03-17 at 23:33 -0800, Andrew Morton wrote:
> > > +static int expired_starving(runqueue_t *rq)
> > 
> > I'll make that inline..
> > 
> 
> Oops, I understood you to want that uninlined.
> 

It has just one callsite.  Modern gcc should inline it anyway, but older
versions tend to need help.

> > > +{
> > > +	int limit;
> > > +
> > > +	/*
> > > +	 * Arrays were recently switched, all is well.
> > > +	 */
> > > +	if (!rq->expired_timestamp)
> > > +		return 0;
> > > +
> > > +	limit = STARVATION_LIMIT * rq->nr_running;
> > 
> > In the previous iteration you had, effectively,
> > 
> > 	if (!limit)
> > 		return 0;
> > 
> > in here.   But it's now gone.   Deliberate?
> 
> Yes.  I see no way for it to be zero.  I think that was just a leftover.
> 

ok..
