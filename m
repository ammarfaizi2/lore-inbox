Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbTCaSfY>; Mon, 31 Mar 2003 13:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261767AbTCaSfY>; Mon, 31 Mar 2003 13:35:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:41610 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261765AbTCaSfX>;
	Mon, 31 Mar 2003 13:35:23 -0500
Subject: Re: [PATCH] linux-2.5.66_monotonic-clock_A3
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <p73el4qzjtx.fsf@oldwotan.suse.de>
References: <1048892109.975.150.camel@w-jstultz2.beaverton.ibm.com.suse.lists.linux.kernel>
	 <p73el4qzjtx.fsf@oldwotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1049135948.971.177.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 Mar 2003 10:39:09 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 23:57, Andi Kleen wrote:
> john stultz <johnstul@us.ibm.com> writes:
> 
> > +	do {
> > +		seq = read_seqbegin(&xtime_lock);
> > +		ret = timer->monotonic_clock();
> > +	} while (read_seqretry(&xtime_lock, seq));
> 
> Why does it need to check xtime lock ? xtime should be independent 
> of the monotonic time because it can be changed. 

Ok, fair enough. I was using the xtime lock to protect monotonic_base in
(updated in mark_offset()), but since that isn't obvious I should be
more explicit and use a different lock. 

> Also doing seqlocks around hardware register reads is quite nasty,
> because a hardware register read can be hundreds of cycles and you're
> very likely to get retries. If you really need a seqlock I would
> move it into the low level function and do it after the hardware access.
> But as far as I can see it can be just removed.

I should be able to use a regular rwlock w/o troubles. I change that and
resubmit. 

thanks for the feedback!
-john



