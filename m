Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVITAo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVITAo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 20:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVITAo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 20:44:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31737 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964806AbVITAo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 20:44:28 -0400
Message-ID: <432F5B19.4050105@mvista.com>
Date: Mon, 19 Sep 2005 17:43:05 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       akpm@osdl.org, johnstul@us.ibm.com, paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0509191500040.27238@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 19 Sep 2005 tglx@linutronix.de wrote:
> 
> 
>>sources. Another astonishing implementation detail of the current time 
>>keeping is the fact that we get the monotonic clock (defined by POSIX as 
>>a continuous clock source which can not be set) by subtracting a variable 
>>offset from the real time clock, which can be set by the user and 
>>corrected by NTP or other mechanisms.

Why is this astonishing?  What it really indicates is the nature of 
Linux where in we have just (with 2.6) introduced the concept of 
monotonic time.  As such, and with few users, it made a LOT of sense to 
not upset too much code by making it the primary clock.  In the end, the 
difference between the two clocks is a constant offset and it is only an 
add in one path or the other.

An argument from the other side is that ntp works with CLOCK_REALTIME 
and so that is where and what it corrects.

Agreed, this can be turned around, however, one needs folks like John 
Stultz who take the time to understand ntp as well as all the other 
clock issues to turn things like this around.  Still, we should consider 
carefully IF we want to turn it around.

A far more astonishing thing, IMHO, is the cascade in the timers code...
> 
> 
> The benefit or drawback of that implementation depends which time is more 
> important: realtime or monotonic time. I think the most used time value is 
> realtime and not monotonic time. Having the real time value in xtime 
> saves one addition when retrieving realtime. 
> -
Both sides of this argument have merit.  Much as we would like to, we 
can not change user usage.  AND, in the end, they are, and will continue 
to make far more calls to get the time than the kernel does.  So, in raw 
cpu power (or time) consumed, the user get time will win over kernel 
usage.  Also, the time to do a gettimeofday is easily computed with the 
most simple program...
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
