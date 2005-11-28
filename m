Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVK1Q1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVK1Q1N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVK1Q1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:27:12 -0500
Received: from ns2.suse.de ([195.135.220.15]:10449 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751280AbVK1Q1M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:27:12 -0500
Date: Mon, 28 Nov 2005 17:27:09 +0100
From: Andi Kleen <ak@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128162709.GC20775@brahms.suse.de>
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com> <20051128160547.GA20775@brahms.suse.de> <20051128161747.GA4359@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128161747.GA4359@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:47:47PM +0530, Dipankar Sarma wrote:
> On Mon, Nov 28, 2005 at 05:05:47PM +0100, Andi Kleen wrote:
> >   *
> >   *	Returns zero on success, or %-ENOENT on failure.
> >   */
> > @@ -175,6 +181,7 @@
> >  
> 
> There should be an smp_read_barrier_depends() here for the first
> dereferencing of the notifier block head, I think.

Why? The one at the top of the block should be enough, shouldn' it?

-Andi


> 
> >  	while(nb)
> >  	{
> > +		smp_read_barrier_depends();
> >  		ret=nb->notifier_call(nb,val,v);
> >  		if(ret&NOTIFY_STOP_MASK)
> >  		{
> 
> Thanks
> Dipankar
