Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRCLTkn>; Mon, 12 Mar 2001 14:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130187AbRCLTk0>; Mon, 12 Mar 2001 14:40:26 -0500
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:34379 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130029AbRCLTkO>; Mon, 12 Mar 2001 14:40:14 -0500
Message-ID: <3AAD2592.4060109@humboldt.co.uk>
Date: Mon, 12 Mar 2001 19:37:54 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0 i686; en-US; m18) Gecko/20010112
X-Accept-Language: en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: static scheduling - SCHED_IDLE?
In-Reply-To: <Pine.LNX.4.33.0103081747010.1314-100000@duckman.distro.conectiva> <3AA93124.EC22CC8A@mvista.com> <3AA93ABE.7000707@humboldt.co.uk> <20010312190527.A23065@pcep-jamie.cern.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

> Adrian Cox wrote:

>> Jamie Lokier's suggestion of raising priority when in the kernel doesn't 
>> help. You need to raise the priority of the task which is currently in 
>> userspace and will call up() next time it enters the kernel. You don't 
>> know which task that is.

> Dear oh dear.  I was under the impression that kernel semaphores are
> supposed to be used as mutexes only -- there are other mechanisms for
> signalling between processes.

I think most of the kernel semaphores are used as mutexes, with 
occasional producer/consumer semaphores. I think the core kernel code is 
fine, the risk mostly comes from miscellaneous character devices. I've 
written code that does this for a specialised device driver. I wanted 
only one process to have the device open at once, and for others to 
block on open. Using semaphores meant that multiple shells could do "cat 
 > /dev/mywidget" and be serialised.

Locking up users of this strange piece of hardware doesn't bring down 
the system, so your suggestion could work. We need a big fat warning in 
semaphore.h, and a careful examination of the current code.

- Adrian

