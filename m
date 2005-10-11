Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVJKMcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVJKMcO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVJKMcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:32:14 -0400
Received: from main.gmane.org ([80.91.229.2]:55271 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932082AbVJKMcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:32:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: i386 spinlock fairness: bizarre test results
Date: Tue, 11 Oct 2005 08:31:33 -0400
Message-ID: <digb50$4bd$1@sea.gmane.org>
References: <4WjCM-7Aq-7@gated-at.bofh.it> <434B404F.9020508@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <434B404F.9020508@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Chuck Ebbert wrote:
> 
>>   After seeing Kirill's message about spinlocks I decided to do my own
>> testing with the userspace program below; the results were very strange.
>>
>>   When using the 'mov' instruction to do the unlock I was able to 
>> reproduce
>> hogging of the spinlock by a single CPU even on Pentium II under some
>> conditions, while using 'xchg' always allowed the other CPU to get the
>> lock:
> 
> 
> This might not necessarily be a win in all situations. If two CPUs A and 
>  B are trying to get into a spinlock-protected critical section to do 5 
> operations, it may well be more efficient for them to do AAAAABBBBB as 
> opposed to ABABABABAB, as the second situation may result in cache lines 
> bouncing between the two CPUs each time, etc.
> 
> I don't know that making spinlocks "fairer" is really very worthwhile. 
> If some spinlocks are so heavily contented that fairness becomes an 
> issue, it would be better to find a way to reduce that contention.
> 

You're right that it wouldn't be an issue on a system with relatively few
cpu's since that amount of contention would cripple the system.  Though
with 100's of cpu's you could get contention hotspots with some spin locks
being concurrently accessed by some subset of the cpu's for periods of time.

The real issue is scalability or how gracefully does a system degrade
when it starts to hit its contention limits.  It's not a good thing when
a system appears to run fine and then catastrophically hangs when it
bumps across its critical limit.  It's better when a system exhibit's
some sort of linear degradation.  The former exhibits bistable behavior
which requires a drastic, probably impossible, reduction in work load
to regain normal performance.  Reboots are the normal course of correction.
The linearly degrading systems just require moderation of the workload
to move back into acceptable performance.

Anyway, if you want to build a scalable system, it makes sense to build it
out of scalable components.  Right?

Joe Seigh


