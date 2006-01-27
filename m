Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWA0WLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWA0WLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422649AbWA0WLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:11:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:60814 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422646AbWA0WL3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:11:29 -0500
Subject: Re: [PATCH] timer tsc ensure we allow for initial tsc and tsc sync
From: john stultz <johnstul@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060120125342.GA7632@shadowen.org>
References: <20060120125342.GA7632@shadowen.org>
Content-Type: text/plain
Date: Fri, 27 Jan 2006 14:11:26 -0800
Message-Id: <1138399887.14289.107.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-20 at 12:53 +0000, Andy Whitcroft wrote:
> We have been seeing "BUG: soft lockup detected on CPU#0!" messages
> from testing runs of mainline for some time.  This has only been
> showing on a very small subset of the systems under test, as it
> turns out the slower ones.
> 
> Resolving this issue is complex, not because the fix itself is
> complex but because of the timer rework which is currently pending
> in -mm.  As a result this patch is against 2.6.16-rc1.  So far
> we have had no such errors from runs against -mm, but I am unsure
> whether that system eliminates this issue, or mearly is lucky as
> faster systems are currently with mainline.

Hey Andy, Sorry for the slow reply.

The timekeeping rework is not going to go into 2.6.16 and is currently
out of -mm until I can resolve a few laptop issues. 


> John perhaps you could comment?  Also, how experimental is the timer
> code, is it likely to go into 2.6.16 or is it more experimental
> than that?  If so perhaps we need to try and slip a fix like this
> underneath it.

I'd def try to push a fix in for the issue. I'll just merge my code
around the fix.



> timer tsc ensure we allow for initial tsc and tsc sync
> 
> During early initialisation we select the timer source to use for
> the high resolution time source.  When selecting the TSC we don't
> take into account the initial value of the TSC, this leads to a
> jump in the clock at the next clock tick.  We also fail to take into
> account that the TSC synchronisation in an SMP system resets the TSC.
> 
> In both cases this will lead to the timer believing that 0-N TSC
> ticks have passed since the last real timer tick.  This will lead
> to the clock jumping ahead by nearly the maximum time represented
> by the lower 32bits of the TSC.  For a 1GHz machine this is close to
> 4s, on slower boxes this can exceed 10s and trip the softlock tests.


This sounds very similar to bugme bug #5366
http://bugzilla.kernel.org/show_bug.cgi?id=5366


There's a test patch in there that maybe you could try?


thanks
-john

