Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbUCRPel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 10:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262696AbUCRPel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 10:34:41 -0500
Received: from peabody.ximian.com ([130.57.169.10]:60133 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262694AbUCRPeh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 10:34:37 -0500
Subject: Re: CONFIG_PREEMPT and server workloads
From: Robert Love <rml@ximian.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040318145129.GA2246@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	 <20040318060358.GC29530@dualathlon.random>
	 <20040318015004.227fddfb.akpm@osdl.org>
	 <20040318145129.GA2246@dualathlon.random>
Content-Type: text/plain
Message-Id: <1079624062.2136.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Thu, 18 Mar 2004 10:34:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 09:51, Andrea Arcangeli wrote:

> Note, the work you and the other preempt developers did with preempt was
> great, it wouldn't be possible to be certain that it wasn't worthwhile
> until we had the thing working and finegrined (i.e. in all in_interrupt
> etc..), and now we know it doesn't payoff and in turn I'm going to try
> the explicit-preempt that is to explicitly enable preempt in a few
> cpu-intensive kernel spots where we don't take locks (i.e. copy-user),
> the original suggestion I did 4 years ago, I believe in such places an
> explicit-preempt will work best since we've already to check every few
> bytes the current->need_resched, so adding a branch there should be very
> worthwhile. Doing real preempt like now is overkill instead and should
> be avoided IMHO.

I think you are really blowing the overhead of kernel preemption out of
proportion.  The numbers Marinos J. Yannikos are reported are definitely
a bug, an issue, something that will be fixed.  The numbers everyone
else has historically shown are in line with Andrew: slight changes and
generally a small improvement to kernel compiles, dbench runs, et
cetera.

I also feel you underestimate the improvements kernel preemption gives. 
Yes, the absolute worst case latency probably remains because it tends
to occur under lock (although, it is now easier to pinpoint that latency
and work some magic on the locks).  But the variance of the latency goes
way down, too.  We smooth out the curve.  And these are differences that
matter.

And it can be turned off, so if you don't care about that and are not
debugging atomicity (which preempt is a big help with, right?) then turn
it off.

Oh, and if the PREEMPT=n overhead is really an issue, then I agree that
needs to be fixed :)

	Robert Love


