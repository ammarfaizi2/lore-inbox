Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWCRHq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWCRHq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 02:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbWCRHq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 02:46:57 -0500
Received: from mail.gmx.de ([213.165.64.20]:12995 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751765AbWCRHq4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 02:46:56 -0500
X-Authenticated: #14349625
Subject: Re: [2.6.16-rc6 patch] fix interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060317233327.787b4d07.akpm@osdl.org>
References: <1142658480.8262.38.camel@homer>
	 <20060317211529.26969a16.akpm@osdl.org> <1142661030.8937.7.camel@homer>
	 <20060317222203.06d7f450.akpm@osdl.org> <1142666985.7881.5.camel@homer>
	 <20060317233327.787b4d07.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 18 Mar 2006 08:48:39 +0100
Message-Id: <1142668119.7787.7.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 23:33 -0800, Andrew Morton wrote:
> > +static int expired_starving(runqueue_t *rq)
> 
> I'll make that inline..
> 

Oops, I understood you to want that uninlined.

> > +{
> > +	int limit;
> > +
> > +	/*
> > +	 * Arrays were recently switched, all is well.
> > +	 */
> > +	if (!rq->expired_timestamp)
> > +		return 0;
> > +
> > +	limit = STARVATION_LIMIT * rq->nr_running;
> 
> In the previous iteration you had, effectively,
> 
> 	if (!limit)
> 		return 0;
> 
> in here.   But it's now gone.   Deliberate?

Yes.  I see no way for it to be zero.  I think that was just a leftover.

	-Mike

