Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUEGUoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUEGUoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUEGUmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 16:42:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17137 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263777AbUEGUl6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 16:41:58 -0400
Message-ID: <409BF486.40500@mvista.com>
Date: Fri, 07 May 2004 13:41:42 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: ganzinger@mvista.com, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Andrew Morton <akpm@osdl.org>, kaukasoi@elektroni.ee.tut.fi,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403D0F63.3050101@mvista.com>	 <1077760348.2857.129.camel@cog.beaverton.ibm.com>	 <403E7BEE.9040203@mvista.com>	 <1077837016.2857.171.camel@cog.beaverton.ibm.com>	 <403E8D5B.9040707@mvista.com>	 <1081895880.4705.57.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>	 <1081967295.4705.96.camel@cog.beaverton.ibm.com>	 <20040415103711.GA320@elektroni.ee.tut.fi>	 <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>	 <20040415161436.GA21613@elektroni.ee.tut.fi>	 <Pine.LNX.4.53.0405011540390.25435@gockel.physik3.uni-rostock.de>	 <20040501184105.2cd1c784.akpm@osdl.org>	 <Pine.LNX.4.53.0405020352480.26994@gockel.physik3.uni-rostock.de>	 <1083638458.9664.134.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0405040804180.2215@gockel.physik3.uni-rostock.de>	 <1083682764.4324.33.camel@leatherman>  <409AD95F.8080502@mvista.com> <1083892878.9664.226.camel@cog.beaverton.ibm.com>
In-Reply-To: <1083892878.9664.226.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Thu, 2004-05-06 at 17:33, George Anzinger wrote:
> 
>>john stultz wrote:
>>
>>>Roughly, I'd like to see the time code for all arches in 2.7 to look
>>>like:
>>>
>>>u64 system_time 	/* NTP adjusted nanosecs since boot */
>>>u64 wall_time_offset	/* offset to system_time for time of day */
>>>u64 offset_base		/* last read raw hw value */
>>
>>Hm.  In 2.6 we use an NTP adjusted wall time and a wall_to_monotonic offset.  I 
>>don't really see the advantage here.  Does this change buy us something?
>>For what its worth, I introduced the wall_to_monotonic offset just because it 
>>was easier to do (and understand, I think) in the current kernel.
> 
> 
> Well, in my opinion it seems much cleaner. Right now any time we adjust
> xtime, we have to remember to adjust wall_to_monotonic. I believe we've
> had issues where a change was made to just one and not the other. 
> 
> This is easier and has simpler rules. system_time always increments and
> is only modified by the periodic time_interrupt_hook(). Then
> wall_time_offset is only changes by do_settimeofday(). In fact, I hope
> to make these values static to the time code, so that all in-kernel
> users must go through the monotonic_clock() and do_gettimeofday()
> interfaces. 

All that is fine for the kernel coder and such, but the fact remains that 
gettimeofday() is the BIG user and I keep seeing folks trying to make it faster. 
  Also xtime.tv_sec is used a LOT in the kernel under the name: get_seconds().
~>
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

