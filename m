Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbTCSILu>; Wed, 19 Mar 2003 03:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262973AbTCSILt>; Wed, 19 Mar 2003 03:11:49 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:5616 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262972AbTCSILs>;
	Wed, 19 Mar 2003 03:11:48 -0500
Message-ID: <3E7828C3.2070304@mvista.com>
Date: Wed, 19 Mar 2003 00:22:27 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: async@cc.gatech.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] limits on SCHED_FIFO tasks
References: <20030318185135.D1361@tokyo.cc.gatech.edu>	<3E77C40D.4090700@mvista.com> <20030318190407.37a39db1.akpm@digeo.com>
In-Reply-To: <20030318190407.37a39db1.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> george anzinger <george@mvista.com> wrote:
> 
>>If the issue is regaining control after some RT task goes into a loop, 
>>the way this is usually done is to keep a session around with a higher 
>>priority.  Using this concept, one might provide tools that, from 
>>userland, insure that such a session exists prior to launching the 
>>"suspect" code.  I fail to see the need for this sort of code in the 
>>kernel.
> 
> 
> That works, until your shell calls ext3_mark_inode_dirty(), which blocks on
> kjournald activity.  kjournald is SCHED_OTHER, and never runs...
> 
That is classic priority inversion.  It would be "nice" to find a fix 
for that :)  I think that the proposed action should not be triggered 
until there is some "notice" that something is wrong.  I suppose it 
could be a watchdog timer of some sort.  Still, if the priority 
inversion issue were solved, all the rest could be done in user land.

> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

