Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbWEaQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbWEaQEv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbWEaQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:04:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:63974 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751621AbWEaQEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:04:51 -0400
Message-ID: <447DBD44.5040602@in.ibm.com>
Date: Wed, 31 May 2006 21:29:00 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
Cc: Peter Williams <pwil3058@bigpond.net.au>,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Kingsley Cheung <kingsley@aurema.com>, Ingo Molnar <mingo@elte.hu>,
       Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>	 <20060526042051.2886.70594.sendpatchset@heathwren.pw.nest> <661de9470605262348s52401792x213f7143d16bada3@mail.gmail.com> <44781167.6060700@bigpond.net.au> <447D95DE.1080903@sw.ru>
In-Reply-To: <447D95DE.1080903@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:
>>> Using a timer for releasing tasks from their sinbin sounds like a  bit
>>> of an overhead. Given that there could be 10s of thousands of tasks.
>>
>>
>>
>> The more runnable tasks there are the less likely it is that any of 
>> them is exceeding its hard cap due to normal competition for the 
>> CPUs.  So I think that it's unlikely that there will ever be a very 
>> large number of tasks in the sinbin at the same time.
> 
> for containers this can be untrue... :( actually even for 1000 tasks (I 
> suppose this is the maximum in your case) it can slowdown significantly 
> as well.

Do you have any documented requirements for container resource management?
Is there a minimum list of features and nice to have features for containers
as far as resource management is concerned?


> 
>>> Is it possible to use the scheduler_tick() function take a look at all
>>> deactivated tasks (as efficiently as possible) and activate them when
>>> its time to activate them or just fold the functionality by defining a
>>> time quantum after which everyone is worken up. This time quantum
>>> could be the same as the time over which limits are honoured.
> 
> agree with it.

Thinking a bit more along these lines, it would probably break O(1). But I guess a good
algorithm can amortize the cost.

> 
> Kirill
> 
-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
