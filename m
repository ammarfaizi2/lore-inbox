Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTFUA1c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 20:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265059AbTFUA1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 20:27:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53759 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265055AbTFUA1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 20:27:31 -0400
Subject: Re: [Bug 764] New: btime in /proc/stat wobbles (even over 30
	seconds)
From: john stultz <johnstul@us.ibm.com>
To: Kingsley Cheung <kingsley@aurema.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030612112011.C29095@aurema.com>
References: <205830000.1054566142@[10.10.2.4]>
	 <20030612112011.C29095@aurema.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056155679.1028.22.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 17:34:39 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 18:20, Kingsley Cheung wrote:

> I see that there has been a fix made for this since 2.5.70-bk13 or
> 2.5.70-bk14 that solves this problem by using the seqlock to ensure
> that the jiffies and time of day are atomically read.

And further then that, we loose less precision in some of the math so we
don't have the single second wobbles that were initially seen. 


> However, wouldn't it be better to have the boottime calculated only
> once so that it is independent of changes in the system time that may
> occur later?  Even with the fix with seqlock, the boottime can still
> change back or forwards whenever the system time is set back or
> forwards.  IMHO an unchanging boottime that is independent of the time
> of day is the best approach.  Maybe something like the patch against
> 2.5.70-bk14 that I've attached.
> 
> What do people think?

Really, I'm fine with the current semantics. At boot time the system
clock may not have been correct, and was corrected only after NTP
started up later in the boot sequence. So you could have some very funky
btimes. 

Even the current definition of btime = now - uptime has its own quirks
(when systems are suspended uptime doesn't increment, etc) but I think
its more likely to be correct then any other method (assuming the time
now is more accurate then time at boot thanks to ntp or whatnot). 

I'm curious, how are people using the btime value? I'd think uptime and
gettimeofday would be more useful bits of info, so I'd like to hear
more.

thanks
-john


