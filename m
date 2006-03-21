Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWCUQbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWCUQbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWCUQbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:31:11 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:8126 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1030454AbWCUQbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:31:09 -0500
Message-ID: <44202A2C.505@cosmosbay.com>
Date: Tue, 21 Mar 2006 17:30:36 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: Jesper Dangaard Brouer <hawk@diku.dk>,
       Robert Olsson <Robert.Olsson@data.slu.se>, jens.laas@data.slu.se,
       hans.liss@its.uu.se, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
References: <Pine.LNX.4.61.0603202234400.27140@ask.diku.dk> <17439.65413.214470.194287@robur.slu.se> <Pine.LNX.4.61.0603211552590.28173@ask.diku.dk> <44201DAF.7090707@cosmosbay.com> <20060321154313.GA9992@in.ibm.com>
In-Reply-To: <20060321154313.GA9992@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 21 Mar 2006 17:30:39 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma a écrit :
> On Tue, Mar 21, 2006 at 04:37:19PM +0100, Eric Dumazet wrote:
>> Jesper Dangaard Brouer a écrit :
>>> There is definitly high memory pressure on this machine!
>>> Slab memory usage, range from 39Mb to 205Mb (at the moment on the 
>>> production servers).
>>>
>> Did you tried 2.6.16 ?
>>
>> It contains changes in kernel/rcupdate.c so that not too many RCU elems are 
>> queued (force_quiescent_state()). So in the case a rt_cache_flush is done, 
>> you have the guarantee all entries are not pushed into rcu at once.
> 
> Well, memory pressure or not, the oopses shouldn't be happening :)
> Perhaps we should look at them before we work around memory
> pressure through the rcu batch tuning stuff in 2.6.16 ?
> 
> One of the oopses looked like the rcu callback function pointer 
> getting corrupted indicating that it was double freed or
> problem with RCU itself.
> 

Yep, but as this is a production server, I believe its owner might want a fast 
way to have it back to life :)

And the RCU change in 2.6.16 is definitly a big improvement when a dump of 
million entries is done :)

If RCU quiescent state is forced, maybe the bug (in the route cache code) will 
trigger faster ?

Eric
