Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUJTPS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUJTPS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJTPSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:18:50 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:55018 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268045AbUJTPRT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:17:19 -0400
Message-ID: <41768175.9000909@mvista.com>
Date: Wed, 20 Oct 2004 08:17:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de> <1098258460.26595.4320.camel@d845pe>
In-Reply-To: <1098258460.26595.4320.camel@d845pe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Tue, 2004-10-19 at 23:05, Tim Schmielau wrote:
> 
>>I think we could do it in the following steps:
>>
>>  1. Sync up jiffies with the monotonic clock,...
>>  2. Decouple jiffies from the actual interrupt counter...
>>  3. Increase HZ all the way up to 1e9....
> 
> 
>>Thoughts?
> 
> 
> Yes, for long periods of idle, I'd like to see the periodic clock tick
> disabled entirely.  Clock ticks causes the hardware to exit power-saving
> idle states.
> 
> The current design with HZ=1000 gives us 1ms = 1000usec between clock
> ticks.  But some platforms take nearly that long just to enter/exit low
> power states; which means that on Linux the hardware pays a long idle
> state exit latency (performance hit) but gets little or no power savings
> from the time it resides in that idle state.


I (and MontaVista) will be expanding on the VST patches.  There are, currently, 
two levels of VST.  VST-I when entering the idle state (task) looks ahead in the 
timer list, finds the next event, and shuts down the "tick" until that time.  An 
interrupts resets things, be it from the end of the time counter or another source.

VST-II adds a call back list to idle entry and exit.  This allows one to add 
code to change (or even remove) timers on idle entry and restore them on exit.

We are doing this work to support deeply embedded applications that often times 
run on small batteries (think cell phone if you like).
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

