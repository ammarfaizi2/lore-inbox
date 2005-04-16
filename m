Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVDPNLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVDPNLZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 09:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVDPNLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 09:11:25 -0400
Received: from mail.timesys.com ([65.117.135.102]:35161 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262658AbVDPNLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 09:11:23 -0400
Message-ID: <42610DAC.5070506@timesys.com>
Date: Sat, 16 Apr 2005 09:05:48 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sven Dietrich <sdietrich@mvista.com>
CC: "'Steven Rostedt'" <rostedt@goodmis.org>,
       "'Inaky Perez-Gonzalez'" <inaky@linux.intel.com>,
       robustmutexes@lists.osdl.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, "'Esben Nielsen'" <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
References: <000801c54230$73a0f940$c800a8c0@mvista.com>
In-Reply-To: <000801c54230$73a0f940$c800a8c0@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Apr 2005 13:06:48.0093 (UTC) FILETIME=[25B994D0:01C54285]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich wrote:
>>>	/** A fuqueue, a prioritized wait queue usable from
>>
>>kernel space. */
>>
>>>	struct fuqueue {
>>>	        spinlock_t lock;        
>>>	        struct plist wlist;
>>>	        struct fuqueue_ops *ops;
>>>	};
>>>
>>
>>Would the above spinlock_t be a raw_spinlock_t? This goes
>>back to my first question. I'm not sure how familiar you are 
>>with Ingo's work, but he has turned all spinlocks into 
>>mutexes, and when you really need an original spinlock, you 
>>declare it with raw_spinlock_t.  
>>
> 
> 
> This one probably should be a raw_spinlock. 
> This lock is only held to protect access to the queues.
> Since the queues are already priority ordered, there is
> little benefit to ordering -the order of insertion-
> in case of contention on a queue, compared with the complexity.

The choice of lock type should derive from both the calling
context and the length of time the lock is expected to be held.

-john


-- 
john.cooper@timesys.com
