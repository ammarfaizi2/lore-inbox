Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVHYBaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVHYBaX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 21:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVHYBaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 21:30:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9712 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932473AbVHYBaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 21:30:22 -0400
Message-ID: <430D1F21.80401@mvista.com>
Date: Wed, 24 Aug 2005 18:30:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect CLOCK_TICK_RATE in 2.6 kernel
References: <430D0FDA.3060201@mvista.com> <1124930039.20820.123.camel@cog.beaverton.ibm.com>
In-Reply-To: <1124930039.20820.123.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Wed, 2005-08-24 at 17:24 -0700, George Anzinger wrote:
> 
>>CLOCK_TICK_RATE	is used by the kernel to compute LATCH, TICK_NSEC and 
>>tick_nsec.  This latter is used to update xtime each tick.  TICK_NSEC is 
>>then used to compute (at compile time) the conversion constants needed 
>>to convert to/from jiffies from/to timespec and timeval (and others).
>>
>>The problem is that, if the timer being used is either Cyclone or HPET, 
>>the wrong CLOCK_TICK_RATE is used.
> 
> 
> Err, the Cyclone does not generate interrupts. So this issue does not
> affect those systems.
> 
> As for the HPET, it sets its own interrupt frequency based off of
> KERNEL_TICK_USEC (which you're right, isn't quite what is used in the
> jiffies conversions).  Would it be easier to just adjust that value to
> use ACTHZ or CLOCK_TICK_RATE?

If you want to take that approach you would want the HPET to interrupt 
every TICK_NSEC nanoseconds, that being what xtime is pushed by each tick.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
