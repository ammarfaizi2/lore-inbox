Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbWHaBHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWHaBHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 21:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWHaBHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 21:07:42 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:28267 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932283AbWHaBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 21:07:41 -0400
Message-ID: <44F6365A.8010201@bigpond.net.au>
Date: Thu, 31 Aug 2006 11:07:38 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: balbir@in.ibm.com
CC: Martin Ohlin <martin.ohlin@control.lth.se>, linux-kernel@vger.kernel.org
Subject: Re: A nice CPU resource controller
References: <44F5AB45.8030109@control.lth.se> <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
In-Reply-To: <661de9470608300841o757a8704te4402a7015b230c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.128.202] using ID pwil3058@bigpond.net.au at Thu, 31 Aug 2006 01:07:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On 8/30/06, Martin Ohlin <martin.ohlin@control.lth.se> wrote:
>> To those interested
>>
>> I have been working on a CPU resource controller using the nice value as
>> a control signal. At the moment, the control is done on a
>> per-task-level, but I have plans to extend it to groups of tasks. The
>> control is based on a PI-controller (Proportional, Integral), using an
>> execution time measurement as input to the controller, and the output
>> from the controller as nice value.
>>
> 
> The CKRM e-series is a PID based CPU Controller. It did a good job of
> controlling and smoothing out the load (and variations) and even
> worked with groups. But it achieved all this through some amount of
> complexity. How do you plan to extend the idea to groups? Do you have
> any code that we can look at?
> 
> I do not understand controlling the nice value? Most cpu control the
> bandwidth/time - are there any advantages to controlling the nice
> value?

Trying to control CPU allocations purely using time allocations will 
only work well for CPU bound processes.  Furthermore, the faster CPUs 
become the more this will be the case.

> How does this interplay with dynamic priorities that the
> scheduler currently maintains?

But your implication here is valid.  It is better to fiddle with the 
dynamic priorities than with nice as this leaves nice for its primary 
purpose of enabling the sysadmin to effect the allocation of CPU 
resources based on external considerations.  Having said that I would 
also opine that the basic mechanism this author uses to fiddle the nice 
values could be applied to the dynamic priorities instead with the key 
difference being that nice can be fiddled from outside the scheduler but 
you really need to be inside the scheduler to fiddle with dynamic 
priorities.

> 
>> Using the controller, it is possible to make CPU reservations that in a
>> soft way guarante that tasks achieve as much resources as the
>> corresponding reference indicates.
>>
>> For those interested, the concept is described in more detail along with
>> experiments in the first part of my thesis available at:
>> http://www.control.lth.se/database/publications/article.pike?artkey=ohlin06lic 
>>
> 
> Read one more paper - time
> 
> Balbir
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
