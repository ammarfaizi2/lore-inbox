Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTJWXJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 19:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTJWXJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 19:09:43 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30450 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261850AbTJWXJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 19:09:41 -0400
Message-ID: <3F985FB0.1070901@mvista.com>
Date: Thu, 23 Oct 2003 16:09:36 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Pavel Machek <pavel@suse.cz>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <20031022233306.GA6461@elf.ucw.cz>	 <1066866741.1114.71.camel@cog.beaverton.ibm.com>	 <20031023081750.GB854@openzaurus.ucw.cz>  <3F9838B4.5010401@mvista.com> <1066942532.1119.98.camel@cog.beaverton.ibm.com>
In-Reply-To: <1066942532.1119.98.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2003-10-23 at 13:23, George Anzinger wrote:
> 
> 
>>I lost (never saw) the first of this thread, BUT, if this is 2.6, I strongly 
>>recommend that settimeofday() NOT be called.  It will try to adjust 
>>wall_to_motonoic, but, as this appears to be a correction for time lost while 
>>sleeping, wall_to_monotonic should not change.
> 
> 
> While suspended should the notion monotonic time be incrementing? If
> we're not incrementing jiffies, then uptime isn't being incremented, so
> to me it doesn't follow that the monotonic time should be incrementing
> as well. 

Uh, not moving jiffies?  What does this say about any timers that may be 
pending?  Say for cron or some such?  Like I said, I picked up this thread a bit 
late, but, seems to me that if time is passing, it should pass on both the 
jiffies AND the wall clocks.
> 
> It may very well be a POSIX timers spec issue, but it just strikes me as
> odd.

The spec thing would relate to any sleeps or timers that are pending.  The spec 
would seem to say they should complete somewhere near the requested wall time, 
but NEVER before.  By not moving jiffies, I think they will be a bit late.  Now, 
if they were to complete during the sleep, well those should fire at completion 
of the sleep.  If the are to complete after the sleep, then, it seems to me, 
they should fire at the requested time.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

