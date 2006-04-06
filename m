Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWDFQIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWDFQIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 12:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWDFQIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 12:08:45 -0400
Received: from zcars04f.nortel.com ([47.129.242.57]:50585 "EHLO
	zcars04f.nortel.com") by vger.kernel.org with ESMTP
	id S1751254AbWDFQIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 12:08:44 -0400
Message-ID: <44353D00.3070802@nortel.com>
Date: Thu, 06 Apr 2006 10:08:32 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Darren Hart <darren@dvhart.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: help? converting to single global prio_array in scheduler, ran
 into snag
References: <4433F636.3090705@nortel.com> <4433FCF5.7080604@nortel.com> <200604052034.02962.darren@dvhart.com>
In-Reply-To: <200604052034.02962.darren@dvhart.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Apr 2006 16:08:32.0350 (UTC) FILETIME=[59D067E0:01C65994]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart wrote:

> First thing that comes to mind, did you look for every place that accesses the 
> arrays via the rq->lock and make it use the new global array_lock?

Yep.  All places where any of "arrays[i]", "expired", or "active" were 
accessed are now protected (as far as I can tell) by the new lock.

I'm just wondering if there are any "gotchas" that jump out at people 
based on what I'm trying to do, or if it should just be a matter of 
changing the data structures and getting the locking right.  It's only 
when I try to run with multiple cpus that it breaks, so either there's 
something wrong in the initialization of the second cpu or else it's a 
locking issue.

When I let it use both cpus I get partway through kernel initialization, 
then it hangs.  Adding instrumentation lets me get further in, which 
makes me suspect some kind of race condition.

> It would 
> help if you would post your initial patch for review (designating it as RFC, 
> not intended for inclusion).

Unfortunately my patch is against a heavily modified version of the 
kernel, so I'm not sure how useful it would be.  I suppose I could redo 
it against a vanilla version of 2.6.10, but that would take some time. 
If you think it would be useful I could certainly do it.

Chris
