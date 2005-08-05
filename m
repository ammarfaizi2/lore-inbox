Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbVHEBne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbVHEBne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 21:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbVHEBnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 21:43:32 -0400
Received: from mail24.syd.optusnet.com.au ([211.29.133.165]:40601 "EHLO
	mail24.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262804AbVHEBna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 21:43:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] dyn-tick3 tweaks
Date: Fri, 5 Aug 2005 11:39:24 +1000
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org> <200508051023.38234.kernel@kolivas.org> <42F2B86D.8040701@yahoo.com.au>
In-Reply-To: <42F2B86D.8040701@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051139.25024.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005 10:53 am, Nick Piggin wrote:
> Con Kolivas wrote:
> > Something like this on top is cleaner and quieter. I'll add this to
> > pending changes for another version.
> >
> >
> > ------------------------------------------------------------------------
> >
> > Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c
> > ===================================================================
> > ---
> > linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-03
> > 11:29:29.000000000 +1000 +++
> > linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c	2005-08-05
> > 10:22:25.000000000 +1000 @@ -167,10 +167,20 @@ static void
> > delay_tsc(unsigned long loop
> >  	} while ((now-bclock) < loops);
> >  }
> >
> > +/* update the monotonic base value */
> > +static inline void update_monotonic_base(unsigned long long last_offset)
> > +{
> > +	unsigned long long this_offset;
> > +
> > +	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
> > +	monotonic_base += cycles_2_ns(this_offset - last_offset);
> > +	write_sequnlock(&monotonic_lock);
> > +}
> > +
>
> All else being equal, it is much better if you unlock in the
> same function that takes the lock. For readability.
>
> It looks like you should be able to leave all the flow control
> and locking the same, and use update_monotonic_base() to
> do the actual update?

Good advice, thanks. Will respin.

Cheers,
Con
