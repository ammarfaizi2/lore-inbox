Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbUCDU4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 15:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbUCDU4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 15:56:32 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:63245 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262145AbUCDU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 15:56:24 -0500
Message-ID: <40479AD2.60909@techsource.com>
Date: Thu, 04 Mar 2004 16:08:34 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Peter Williams <peterw@aurema.com>
CC: Bill Davidsen <davidsen@tmr.com>, Rik van Riel <riel@surriel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <Pine.LNX.3.96.1040228161308.8661A-100000@gatekeeper.tmr.com> <40412A6D.6060800@aurema.com>
In-Reply-To: <40412A6D.6060800@aurema.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Williams wrote:

> 
> The O(1) Entitlement Based Scheduler places the equivalent restrictions 
> on setting task attributes (i.e. shares and caps) as are placed on using 
> nice and renice.  I.e. ordinary users can only change settings on their 
> own processes and only if the change is more restricting than the 
> current setting.  In particular, they cannot increase a task's shares 
> only decrease them, they can impose or reduce a cap but not release or 
> increase it and they can change a soft cap to a hard cap but cannot 
> change a hard cap to a soft cap.
> 
> Additionally, only root can change the scheduler's tuning parameters.
> 
> I hope this alleviates your concerns,


I, for one, never had any such concerns.  My concern was about the 
unpriveledged user begin unable to run certain applications under load 
without prior approval.

Two philosophical points:

1) Perhaps we are trying too hard to please everyone.  As Linus said, 
perfect is the enemy of good.  A good scheduler won't work perfectly for 
everyone's application, but it will work very well for the most 
important ones.  Perhaps people writing schedulers should compete based 
on overall throughput and latency, rather than on how well it runs xmms 
(and other such apps).

2) Perhaps certain apps like xmms are 'broken' can be rewritten to 
behave better with the new scheduler.  For instance, more buffering, 
separating the mp3 decoding thread from the thread that feeds 
/dev/audio, more efficient decoder, a decoder that voluntarily sleeps 
when it's 'done enough', so that it doesn't get knocked down to a lower 
priority, a decoder that 'cheats' on audio quality just to maintain low 
CPU usage when it finds itself being preempted, etc.


It bears mentioning that many applications work well with 2.4 because 
they evolved to work well with the 2.4 scheduler.  The 2.6 scheduler is 
different.  We shouldn't constrain 2.6 for the sake of old apps.  Those 
old apps should be rewritten to adapt to the new environment.  "Working 
well under 2.6" doesn't require any more adaptation than with 2.4, but 
it does require _different_ adaptation.

This isn't to speak negatively of Con and Nick and others who have 
attempted to improve upon the 2.6 scheduler.  If they can make old apps 
work well without impacting the potential that new apps can get out of 
2.6, then more power to them!

