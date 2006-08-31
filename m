Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWHaGQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWHaGQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 02:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWHaGQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 02:16:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:18393 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750785AbWHaGQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 02:16:43 -0400
Message-ID: <44F67EE2.5060605@in.ibm.com>
Date: Thu, 31 Aug 2006 11:47:06 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Martin Ohlin <martin.ohlin@control.lth.se>, linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com> <44F6365A.8010201@bigpond.net.au>
In-Reply-To: <44F6365A.8010201@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

>> I do not understand controlling the nice value? Most cpu control the
>> bandwidth/time - are there any advantages to controlling the nice
>> value?
> 
> Trying to control CPU allocations purely using time allocations will 
> only work well for CPU bound processes.  Furthermore, the faster CPUs 
> become the more this will be the case.

The resource we are controlling is CPU bandwidth, what other parameters can we
use to control it?. Nice values indirectly control the time a task gets, but
also affects its priority. Even if a task is not CPU bound, we are only
interested in its CPU bandwidth utilization in the CPU resource controller.

> 
>> How does this interplay with dynamic priorities that the
>> scheduler currently maintains?
> 
> But your implication here is valid.  It is better to fiddle with the 
> dynamic priorities than with nice as this leaves nice for its primary 
> purpose of enabling the sysadmin to effect the allocation of CPU 
> resources based on external considerations.  Having said that I would 
> also opine that the basic mechanism this author uses to fiddle the nice 
> values could be applied to the dynamic priorities instead with the key 
> difference being that nice can be fiddled from outside the scheduler but 
> you really need to be inside the scheduler to fiddle with dynamic 
> priorities.
> 

The problem with controlling nice values that I see is that nice values do not
necessarily linearly map CPU time. Changing the nice value also changes the
priority, which impacts the order in which tasks are run.

It's my belief that time and priorities are orthogonal. Nice does a good job
of trying to mix the two,  but in the case of resource management it might not
be such a good idea.




-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
