Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130658AbRCIUVw>; Fri, 9 Mar 2001 15:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130662AbRCIUVm>; Fri, 9 Mar 2001 15:21:42 -0500
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:25152 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130658AbRCIUVa>; Fri, 9 Mar 2001 15:21:30 -0500
Message-ID: <3AA93ABE.7000707@humboldt.co.uk>
Date: Fri, 09 Mar 2001 20:19:10 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010112
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Rik van Riel <riel@conectiva.com.br>,
        Boris Dragovic <lynx@falcon.etf.bg.ac.yu>,
        Oswald Buddenhagen <ob6@inf.tu-dresden.de>,
        linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva> <3AA93124.EC22CC8A@mvista.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:


> Seems like you are sneaking up on priority inherit mutexes.  The locking
> over head is not so bad (same as spinlock, except in UP case, where it
> is the same as the SMP case).  The unlock is, however, the same as the
> lock overhead.  It is hard to beat the store of zero which is the
> spin_unlock.

Unfortunately the kernel is already full of counting semaphores. 
Priority inheritance won't save you, as the task which is going to call 
up() need not be the same one that called down().

Jamie Lokier's suggestion of raising priority when in the kernel doesn't 
help. You need to raise the priority of the task which is currently in 
userspace and will call up() next time it enters the kernel. You don't 
know which task that is.

There are three solutions I can think of:
1) don't have SCHED_IDLE
2) promote all SCHED_IDLE tasks into SCHED_OTHER whenever *any* task is 
waiting on a semaphore.
3) an audit of semaphores for 2.5

I'm quite fond of option 1.

- Adrian

