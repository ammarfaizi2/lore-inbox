Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265251AbUD3UPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265251AbUD3UPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUD3UPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:15:45 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:28375 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S265251AbUD3UPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:15:39 -0400
Message-ID: <4092B3D8.30501@watson.ibm.com>
Date: Fri, 30 Apr 2004 16:15:20 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [ckrm-tech] Re: [RFC] Revised CKRM release
References: <Pine.LNX.4.44.0404301527400.6976-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0404301527400.6976-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 30 Apr 2004, Shailabh Nagar wrote:
> 
>>Rik van Riel wrote:
> 
> 
>>>User Mode Linux could definitely be an option for implementing
>>>resource management, provided that the overhead can be kept
>>>low enough.
>>
>>....and provided the groups of processes that are sought to be 
>>regulated as a unit are relatively static.
> 
> 
> Good point, I hadn't thought of that one.
> 
> It works for most of the workloads I had in mind, but
> you're right that it's not good enough for eg. the
> university shell server.
> 
> 
>>>For these purposes, "low enough" could be as much as 30%
>>>overhead, since that would still allow people to grow the
>>>utilisation of their server from a typical 10-20% to as
>>>much as 40-50%.
>>
>>In overhead, I presume you're including the overhead of running as 
>>many uml instances as expected number of classes. Not just the 
>>slowdown of applications because they're running under a uml instance 
>>(instead of running native) ?
>>
>>I think UML is justified more from a fault-containment point of view 
>>(where overheads are a lower priority) than from a performance 
>>isolation viewpoint.
>>
>>In any case, a 30% overhead would send a large batch of higher-end 
>>server admins running to get a stick to beat you with :-)
> 
> 
> True enough, but from my pov the flip side is that
> merging the CKRM memory resource enforcement module
> has the potential of undoing lots of the performance
> tuning that was done to the VM in 2.6.


Agreed - CKRM's memory controller logic needs major rework for it to
be acceptable....but I'm sure you can do something about it, Rik ! :-)

The cpu and I/O controllers will also have to be reworked since we now 
have the hierarchical class requirement as well as lower and upper 
bounds for shares.

 >
 > That could result in bad performance even for the
 > people who aren't using workload management at all...

Even with the earlier logic, the hope was that if people are not using
workload management at all, then the only overhead they would see 
would be the extra indirection into "find next class to schedule" (in 
any controller) since there would be only one default class in the 
system. In the cpu case, this overhead had been shown to be as low as 
1-2% but memory overhead had not been measured.

Keeping overheads low (or zero) for those who don't care to use CKRM 
functionality is a high-priority design goal. Keeping it proportional 
to number of classes (with more significant degradations seen if the 
number of hierarchy levels increase) comes next.


Also, will the 2.6 VM improvements continue to work as designed if 
multiple UML instances are running, each replicating a large memory 
user (like say a JVM or a database server) ? Taking the application 
server serving a number of different customers. If we have to 
replicate the app server for each customer class (one on each UML 
instance), the app server's memory needs would get added to the 
equation n times and the benefits of 2.6 VM tuning might be lost.

-- Shailabh

