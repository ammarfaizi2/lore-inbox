Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbTJWUXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 16:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTJWUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 16:23:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44284 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261807AbTJWUXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 16:23:20 -0400
Message-ID: <3F9838B4.5010401@mvista.com>
Date: Thu, 23 Oct 2003 13:23:16 -0700
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: john stultz <johnstul@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz>
In-Reply-To: <20031023081750.GB854@openzaurus.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>>+static int pit_resume(struct sys_device *dev)
>>>+{
>>>+	if (got_clock_diff) {	/* Must know time zone in order to set clock */
>>>+		xtime.tv_sec = get_cmos_time() + clock_cmos_diff;
>>>+		xtime.tv_nsec = 0; 
>>>+	} 
>>>+	return 0;
>>>+}
>>>+
> 
> ...
> 
>>Forgive me, I'm not totally familiar w/ the sysfs/pm stuff, but normally
>>you need to have the xtime_lock to safely manipulate xtime. Also,
>>couldn't you just call settimeofday() instead?  The bit about manually
>>setting the timezone also confuses me, as we don't normally do this at
>>bootup in the kernel.  
>>
> 
> 
> I took it straight from apm.c... But it is well possible that it needs
> some locking. OTOH this runs with interrupts disabled, perhaps
> thats enough?

I lost (never saw) the first of this thread, BUT, if this is 2.6, I strongly 
recommend that settimeofday() NOT be called.  It will try to adjust 
wall_to_motonoic, but, as this appears to be a correction for time lost while 
sleeping, wall_to_monotonic should not change.

As to locking, ints off for UP, but you need the full lock for SMP systems.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

