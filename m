Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVDCTXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVDCTXp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDCTXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:23:45 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:56518 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261868AbVDCTXn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:23:43 -0400
Message-ID: <425042B2.4080403@colorfullife.com>
Date: Sun, 03 Apr 2005 21:23:30 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack size
References: <424EFD2A.6060305@colorfullife.com>	 <1112480132.27149.55.camel@localhost.localdomain>	 <424F96DD.2070307@colorfullife.com> <1112551304.27149.126.camel@localhost.localdomain>
In-Reply-To: <1112551304.27149.126.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:

>On Sun, 2005-04-03 at 09:10 +0200, Manfred Spraul wrote:
>
>  
>
>>Yes - sem or spin locks are quicker as long as no cache line transfers 
>>are necessary. If the semaphore is accessed by multiple cpus, then 
>>kmalloc would be faster: slab tries hard to avoid taking global locks. 
>>I'm not speaking about contention, just the cache line ping pong for 
>>acquiring a free semaphore.
>>    
>>
>
>Without contention, is there still a problem with cache line ping pong
>of acquiring a free semaphore?
>
>I mean, say only one task is using a given semaphore. Is there still
>going to be cache line transfers for acquiring it? Even if the task in
>question stays on a CPU. Is the "LOCK" on an instruction that expensive
>even if the other CPUs haven't accessed that location of memory.
>
>  
>
No. If everything is cpu-local, then there are obviously no cache line 
transfers. LOCK is not that expensive. On a Pentium 3, it was 20 cpu 
cycles. On an Athlon 64, it's virtually free.

--
    Manfred

