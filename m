Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVAUVUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVAUVUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVAUVUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:20:24 -0500
Received: from gizmo12ps.bigpond.com ([144.140.71.43]:64441 "HELO
	gizmo12ps.bigpond.com") by vger.kernel.org with SMTP
	id S262508AbVAUVUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:20:16 -0500
Message-ID: <41F17208.5000709@bigpond.net.au>
Date: Sat, 22 Jan 2005 08:20:08 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>,
       "Marc E. Fiuczynski" <mef@CS.Princeton.EDU>
CC: Jens Axboe <axboe@suse.de>, Valdis.Kletnieks@vt.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>
Subject: Re: [ANNOUNCE][RFC] plugsched-2.0 patches ...
References: <NIBBJLJFDHPDIBEEKKLPIEDNDIAA.mef@cs.princeton.edu> <41F13120.60108@kolivas.org>
In-Reply-To: <41F13120.60108@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Marc E. Fiuczynski wrote:
> 
>> Paraphrasing Jens Axboe:
>>
>>> I don't think you can compare [plugsched with the plugio framework].
>>> Yes they are both schedulers, but that's about where the 'similarity'
>>> stops. The CPU scheduler must be really fast, overhead must be kept
>>> to a minimum. For a disk scheduler, we can affort to burn cpu cycles
>>> to increase the io performance. The extra abstraction required to
>>> fully modularize the cpu scheduler would come at a non-zero cost as
>>> well, but I bet it would have a larger impact there. I doubt you
>>> could measure the difference in the disk scheduler.
>>
>>
>>
>> Modularization usually is done through a level of indirection (function
>> pointers).  I have a can of "indirection be gone" almost ready to 
>> spray over
>> the plugsched framework that would reduce the overhead to zero at 
>> runtime.
>> I'd be happy to finish that work if it makes it more palpable to 
>> integrate a
>> plugsched framework into the kernel?
> 
> 
> The indirection was a minor point. On modern cpus it was suggested by 
> wli that this would not be a demonstrable hit in perormance. Having said 
> that, I'm sure Peter would be happy for another developer. I know how 
> tiring and lonely it can feel maintaining such a monster.

Indeed, the more hands the lighter the load.

Another issue (than indirection) that I think needs to be addressed at 
some stage is freeing up the memory occupied by the code of the 
schedulers that were unlucky not to be picked.  Something like what 
__init offers only more selective.

And the option of allowing more than one CPU per run queue is another 
direction that needs addressing.  This could allow a better balance 
between the good scheduling fairness that is obtained by using a single 
run queue with the better scalability obtained by using separate run queues.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
