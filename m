Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266574AbUJUNm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266574AbUJUNm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266648AbUJUNjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:39:44 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:49657 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S262085AbUJTOv2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:51:28 -0400
Message-ID: <41767B60.4050409@mvista.com>
Date: Wed, 20 Oct 2004 07:51:12 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Jerome Borsboom <j.borsboom@erasmusmc.nl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: process start time set wrongly at boot for kernel 2.6.9
References: <Pine.LNX.4.61.0410192015420.6471@knorkaan.xs4all.nl>	 <1098216701.20778.78.camel@cog.beaverton.ibm.com>	 <Pine.LNX.4.53.0410200233280.9510@gockel.physik3.uni-rostock.de> <1098233967.20778.93.camel@cog.beaverton.ibm.com>
In-Reply-To: <1098233967.20778.93.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2004-10-19 at 17:42, Tim Schmielau wrote:
> 
>>On Tue, 19 Oct 2004, john stultz wrote:
>>
>>
>>>On Tue, 2004-10-19 at 11:21, Jerome Borsboom wrote:
>>>
>>>>Starting with kernel 2.6.9 the process start time is set wrongly for 
>>>>processes that get started early in the boot process. Below is a dump from 
>>>>my 'ps' command. Note the start time for processes 1-12. After process 12 
>>>>the start time is set right.
>>>
>>>How reproducible is this? Are the correct and incorrect time values
>>>always off by the same amount? 
>>>
>>>Are you running NTP? I'm curious if you are changing your system time
>>>during boot. 
>>
>>I'd bet that some process early in the boot adjusts your system time.
> 
> 
> He claims that's not the case (you weren't CC'ed on his reply, but its
> on lkml). He believes the time changes before NTP starts up. Might be
> something else, but I'm not sure.
> 
> 
>>Then this is expected behavior. This is why I would have preferred the 
>>simple back-out patch for the boot times problem.
>>
>>I'm sorry I fell of the net for so long and didn't stand up for the 
>>simpler change in this case. Oh well.
>>
>>I'll probably supply a back-out patch for -mm then, after wading through
>>my multi-megabyte email backlog (sorry John, still need to read your time
>>keeping proposal and all its discussion).
> 
> 
> I've begun to agree with you about this issue. It seems that until we
> can catch every use of jiffies for time, doing one by one is going to
> cause consistency problems.  So I'd support the full backout of the
> do_posix_clock_monotonic_gettime changes to the proc interface. 
> 
> George, would you protest this?

It seems to me that if we do that we will stop making any changes at all.  I.e. 
we will not see the rest of the "jiffies for time" code, as it will not "hurt" 
any more.

Also, the orgional change was made for a reason...

-g
> 
> As for the timeofday overhaul, I've had zero time to work on it
> recently. I hate that I dropped code and then went missing for weeks.
> I'll have to see if I can get a few cycles at home to sync up my current
> tree and send it out. 
> 
> thanks
> -john
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

