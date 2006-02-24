Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWBXAlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWBXAlN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWBXAlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:41:13 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:57223 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751607AbWBXAlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:41:12 -0500
X-ORBL: [67.117.73.34]
Date: Thu, 23 Feb 2006 16:40:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Russell King <linux@arm.linux.org.uk>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Fix next_timer_interrupt() for hrtimer
Message-ID: <20060224004049.GD4578@atomide.com>
References: <20060224002653.GC4578@atomide.com> <1140741472.1271.64.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140741472.1271.64.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john stultz <johnstul@us.ibm.com> [060223 16:37]:
> On Thu, 2006-02-23 at 16:26 -0800, Tony Lindgren wrote:
> > +	tv = ktime_to_timespec(event);
> > +
> > +	/* Assume read xtime_lock is held, so we can't use getnstimeofday() */
> > +	sec = xtime.tv_sec;
> > +	nsec = xtime.tv_nsec;
> > +	while (unlikely(nsec >= NSEC_PER_SEC)) {
> > +		nsec -= NSEC_PER_SEC;
> > +		++sec;
> > +	}
> > +	tv.tv_sec = sec;
> > +	tv.tv_nsec = nsec;
> 
> Er, I think you should be able to nest readers. Thus getnstimeofday()
> should be safe to call. Or is the comment wrong and you are assuming a
> write lock is held?

Oops, it's a write lock as next_timer_interrupt gets called from
arch/*/time.c.

Tony
