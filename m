Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVDPO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVDPO5d (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 10:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVDPO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 10:57:33 -0400
Received: from mail.timesys.com ([65.117.135.102]:55713 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262676AbVDPO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 10:57:28 -0400
Message-ID: <4261268A.3070003@timesys.com>
Date: Sat, 16 Apr 2005 10:51:54 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Sven Dietrich <sdietrich@mvista.com>,
       "'Inaky Perez-Gonzalez'" <inaky@linux.intel.com>,
       robustmutexes@lists.osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, "'Esben Nielsen'" <simlo@phys.au.dk>,
       john cooper <john.cooper@timesys.com>
Subject: Re: FUSYN and RT
References: <000801c54230$73a0f940$c800a8c0@mvista.com>	 <42610DAC.5070506@timesys.com> <1113661385.4294.136.camel@localhost.localdomain>
In-Reply-To: <1113661385.4294.136.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2005 14:52:53.0218 (UTC) FILETIME=[F7A29420:01C54293]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> On Sat, 2005-04-16 at 09:05 -0400, john cooper wrote:
> 
>>Sven Dietrich wrote:
> 
> [...]
> 
>>>This one probably should be a raw_spinlock. 
>>>This lock is only held to protect access to the queues.
>>>Since the queues are already priority ordered, there is
>>>little benefit to ordering -the order of insertion-
>>>in case of contention on a queue, compared with the complexity.
>>
>>The choice of lock type should derive from both the calling
>>context and the length of time the lock is expected to be held.
>>
> 
> 
> In this case, I don't think time matters for choice of lock. Time
> matters to keep it short since it does need the raw_spin_lock.  This
> lock is part of the whole locking scheme, and would be similar to not
> using raw_spin_locks in the implementation of rt_mutex.  Well, not
> exactly the same, but if we want the fusyn code to use the same code as
> rt_mutex for PI, then it will need to be a raw_spin_lock.

Ok, I was missing the context -- it does need to be a raw lock.
Is the scope of this lock limited to manipulating the list or
is it held to serialize other operations?

-john


-- 
john.cooper@timesys.com
