Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbTIKLFC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 07:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbTIKLFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 07:05:02 -0400
Received: from dyn-ctb-203-221-74-143.webone.com.au ([203.221.74.143]:6919
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261212AbTIKLE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 07:04:56 -0400
Message-ID: <3F6056CD.6040402@cyberone.com.au>
Date: Thu, 11 Sep 2003 21:04:45 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: habanero@us.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <200309102155.16407.habanero@us.ibm.com>
In-Reply-To: <200309102155.16407.habanero@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Theurer wrote:

>Robert Love <rml@tech9.net> wrote:
>
>>> There are a _lot_ of scheduler changes in 2.6-mm, and who knows which
>>> ones are an improvement, a detriment, and a noop?
>>>
>
>>We know that sched-2.6.0-test2-mm2-A3.patch caused the regression, and
>>we now that sched-CAN_MIGRATE_TASK-fix.patch mostly fixed it up.
>>
>
>>What we don't know is whether the thing which
>>sched-CAN_MIGRATE_TASK-fix.patch
>>fixed was the thing which sched-2.6.0-test2-mm2-A3.patch broke.
>>
>
>Sorry for jumping into this late.  I didn't even know the can_migrate patch 
>was being discussed, let alone in -mm :).  And to be fair, this really is 
>Ingo's aggressive idle steal patch.
>
>Anyway, these patches are somewhat related.  It would seem that A3's 
>shortening the tasks' run time would not only slow performance beacuse of 
>cache thrash, but could possibly break CAN_MIGRATE's cache warmth check, 
>right?  That in turn would stop load balancing from working well, leading to 
>more idle time, which the CAN_MIGRATE patch sort of bypassed for idle cpus.
>

Yeah thats probably right. Good thinking.

>
>I see Nick's balance patch as somewhat harmless, at least combined with A3 
>patch.  However, one concern is that the "ping-pong" steal interval is not 
>really 200ms, but 200ms/(nr_cpus-1), which without A3, could show up as a 
>problem, especially on an 8 way box.  In addition, I do think there's a 
>problem with num tasks we steal.  It should not be imbalance/2, it should be:  
>max_load - (node_nr_running / num_cpus_node).  If we steal any more than 
>this, which is quite possible with imbalance/2, then it's likely this_cpu now 
>has too many tasks, and some other cpu will steal again.  Using *imbalance/2 
>works fine on 2-way smp, but I'm pretty sure we "over steal" tasks on 4 way 
>and up.  Anyway, I'm getting off topic here...
>

IIRC max_load is supposed to be the number of tasks on the runqueue
being stolen from, isn't it?


