Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWBXAuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWBXAuT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWBXAuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:50:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:61096 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932104AbWBXAuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:50:17 -0500
Subject: Re: [PATCH] Fix next_timer_interrupt() for hrtimer
From: john stultz <johnstul@us.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Russell King <linux@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <20060224004049.GD4578@atomide.com>
References: <20060224002653.GC4578@atomide.com>
	 <1140741472.1271.64.camel@cog.beaverton.ibm.com>
	 <20060224004049.GD4578@atomide.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 16:50:07 -0800
Message-Id: <1140742207.1271.67.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 16:40 -0800, Tony Lindgren wrote:
> * john stultz <johnstul@us.ibm.com> [060223 16:37]:
> > On Thu, 2006-02-23 at 16:26 -0800, Tony Lindgren wrote:
> > > +	tv = ktime_to_timespec(event);
> > > +
> > > +	/* Assume read xtime_lock is held, so we can't use getnstimeofday() */
> > > +	sec = xtime.tv_sec;
> > > +	nsec = xtime.tv_nsec;
> > > +	while (unlikely(nsec >= NSEC_PER_SEC)) {
> > > +		nsec -= NSEC_PER_SEC;
> > > +		++sec;
> > > +	}
> > > +	tv.tv_sec = sec;
> > > +	tv.tv_nsec = nsec;
> > 
> > Er, I think you should be able to nest readers. Thus getnstimeofday()
> > should be safe to call. Or is the comment wrong and you are assuming a
> > write lock is held?
> 
> Oops, it's a write lock as next_timer_interrupt gets called from
> arch/*/time.c.

Also the above code just overwrites tv. 

Do you intend instead to add xtime to tv? 

thanks
-john


