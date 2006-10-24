Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965184AbWJXUih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbWJXUih (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWJXUih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:38:37 -0400
Received: from iriserv.iradimed.com ([69.44.168.233]:57179 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S965184AbWJXUih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:38:37 -0400
Message-ID: <453E79D1.6070703@cfl.rr.com>
Date: Tue, 24 Oct 2006 16:38:41 -0400
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Martin Peschke <mp3@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/5] I/O statistics through request queues
References: <1161435423.3054.111.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20061023113728.GM8251@kernel.dk> <453D05C3.7040104@de.ibm.com> <20061023200220.GB4281@kernel.dk> <453E38FE.1020306@de.ibm.com> <20061024162050.GK4281@kernel.dk>
In-Reply-To: <20061024162050.GK4281@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2006 20:38:47.0371 (UTC) FILETIME=[67C001B0:01C6F7AC]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14772.000
X-TM-AS-Result: No--20.412600-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This discussion seems to involve two different solutions to two 
different problems.  If it is a simple counter you want to be able to 
poll, then sysfs/debugfs is an appropriate place to make the count 
available.  If it is a detailed log of IO requests that you are after, 
then blktrace is appropriate.

I did not read the patch to see, so I must ask: does it merely keep 
statistics or does it log events?  If it is just statistics you are 
after, then clearly blktrace is not the appropriate tool to use.

Jens Axboe wrote:
> On Tue, Oct 24 2006, Martin Peschke wrote:
>> Jens Axboe wrote:
>>>> Our tests indicate that the blktrace approach is fine for performance
>>>> analysis as long as the system to be analysed isn't too busy.
>>>> But once the system faces a consirable amount of non-sequential I/O
>>>> workload, the plenty of blktrace-generated data starts to get painful.
>>> Why haven't you done an analysis and posted it here? I surely cannot fix
>>> what nobody tells me is broken or suboptimal.
>> Fair enough. We have tried out the silly way of blktrace-ing, storing
>> data locally. So, it's probably not worthwhile discussing that.
> 
> You'd probably never want to do local traces for performance analysis.
> It may be handy for other purposes, though.
> 
>>> I have to say it's news to
>>> me that it's performance intensive, tests I did with Alan Brunelle a
>>> year or so ago showed it to be quite low impact.
>> I found some discussions on linux-btrace (Feburary 2006).
>> There is little information on how the alleged 2 percent impact has
>> been determined. Test cases seem to comprise formatting disks ...hmm.
> 
> It may sound strange, but formatting a large drive generates a huge
> flood of block layer events from lots of io queued and merged. So it's
> not a bad benchmark for this type of thing. And it's easy to test :-)
> 
>>>> If the system runs I/O-bound, how to write out traces without
>>>> stealing bandwith and causing side effects?
>>> You'd be silly to locally store traces, send them out over the network.
>> Will try this next and post complaints, if any, along with numbers.
> 
> Thanks! Also note that you do not need to log every event, just register
> a mask of interesting ones to decrease the output logging rate. We could
> so with some better setup for that though, but at least you should be
> able to filter out some unwanted events.
> 
>> However, a fast network connection plus a second system for blktrace
>> data processing are serious requirements. Think of servers secured
>> by firewalls. Reading some counters in debugfs, sysfs or whatever
>> might be more appropriate for some one who has noticed an unexpected
>> I/O slowdown and needs directions for further investigation.
> 
> It's hard to make something that will suit everybody. Maintaining some
> counters in sysfs is of course less expensive when your POV is cpu
> cycles.
> 

