Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbVHXAaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbVHXAaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932513AbVHXAaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:30:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23282 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932512AbVHXAaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:30:05 -0400
Message-ID: <430BBF82.2010209@mvista.com>
Date: Tue, 23 Aug 2005 17:29:54 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: john stultz <johnstul@us.ibm.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, benh@kernel.crashing.org,
       Anton Blanchard <anton@samba.org>, frank@tuxrocks.com,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC - 0/9] Generic timekeeping subsystem  (v. B5)
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>  <1123726394.32531.33.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508152115480.3728@scrub.home>  <1124151001.8630.87.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508162337130.3728@scrub.home>  <1124241449.8630.137.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508182213100.3728@scrub.home>  <1124505151.22195.78.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508202204240.3728@scrub.home>  <1124737075.22195.114.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508230134210.3728@scrub.home>  <1124830262.20464.26.camel@cog.beaverton.ibm.com>  <Pine.LNX.4.61.0508232321530.3728@scrub.home> <1124838847.20617.11.camel@cog.beaverton.ibm.com> <Pine.LNX.4.61.0508240134050.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508240134050.3743@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Tue, 23 Aug 2005, john stultz wrote:
> 
> 
>>I'm assuming gettimeofday()/clock_gettime() looks something like:
>>   xtime + (get_cycles()-last_update)*(mult+ntp_adj)>>shift
> 
> 
> Where did you get the ntp_adj from? It's not in my example.
> gettimeofday() was in the previous mail: "xtime + (cycle_offset * mult +
> error) >> shift". The difference between system time and reference 
> time is really important. gettimeofday() returns the system time, NTP 
> controls the reference time and these two are synchronized regularly.
> I didn't see that anywhere in your example.
> 
John,
If I read your example right, the problem is when the NTP adjustment 
changes while the two clocks are out of sync (because of a late tick). 
It would appear that gettimeofday would need to know that the NTP 
adjustment is changing  (and to what).  It would also appear that this 
is known by the ntp code and could be made available to gettimeofday. 
If it is changing due to an NTP call, that system call, itself, 
should/must force synchronization.  So the only case gettimeofday needs 
to worry/know about is that an adjustment is to change at time X to 
value Y.  Also, me thinks there is only one such change that can be 
present at any given time.

Hope this helps...
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
