Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWCCURj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWCCURj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 15:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWCCURj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 15:17:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:13293 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932148AbWCCURi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 15:17:38 -0500
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
	aliasing problem)
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, Andi Kleen <ak@muc.de>
In-Reply-To: <20060302190408.1e754f12.akpm@osdl.org>
References: <20060302.230227.25910097.anemo@mba.ocn.ne.jp>
	 <Pine.LNX.4.64.0603021108220.5829@schroedinger.engr.sgi.com>
	 <20060303.114406.64806237.nemoto@toshiba-tops.co.jp>
	 <20060302190408.1e754f12.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 12:17:28 -0800
Message-Id: <1141417048.9727.60.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 19:04 -0800, Andrew Morton wrote:
> I'm actually creaking under the load of timer patches over here.  A lot of
> the above code has been heavily redone in John's time patches.  I guess the
> above optimisation is still relevant after John's work (?) but we need to
> decide what to do.   Now is as good a time as any.
> 
> John, that timer stuff is so fundamental and hits on code which has
> historically been so fragile that I'm not sure it's even 2.6.17 material. 
> In which case we should sneak patches like the above underneath it all.
>
> Or we decide to take your work into 2.6.17, in which case the above needs
> to be redone for that context.

I'm not opposed to queuing it up as it seems like a logical cleanup. I'd
be fine with it going in before my patch, however it still needs to
address i386 lost tick compensation.  I worry that addressing that issue
before my patchset (which makes the lost tick compensation unnecessary)
might be a bit more complex. I think it would be easier going in after
my patch. I do think the barrier fix (with a comment) is a good short
term fix.

Atsushi: Your thoughts? 


> I'm not sure how to resolve this, really.  Worried.  Have you socialised
> those changes with architecture maintainers?  If so, what was the feedback?

As to the larger issue of if my patch set is 2.6.17 ready, I'd like to
think it is. There are some optimizations I'm working on that Roman has
suggested that should improve some of the periodic_hook overhead and the
NTP accuracy, but so far I've not noticed the changes helping or hurting
much (also I haven't gotten any feedback on my last attempt). I plan on
continuing that work, but I feel the benefits (as in the number of real
problems that it would resolve) for pushing the patchset that is in -mm
without the finer performance tuning is large enough for it to be
considered.

But again, you're concerns are valid, there appears to be a lack of
enthusiasm in the community both for and against the changes. And I
understand, as I've got lots of other things I need to do as well, and
reviewing a large change like this can take some time that I'm sure
folks are short on.

Maybe I should work on selling it more, I just have been at it for so
long with this patch set that I feel I'm boring folks with the constant
and repetitive "provides robust behavior in the face of lost ticks and
enables other development like high-res timers and realtime" schtick.

But I guess I'll try to ping some folks individually see if I can't stir
up some discussion and get some additional feedback on the issue.

thanks
-john


