Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbSJVR7t>; Tue, 22 Oct 2002 13:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264803AbSJVR7m>; Tue, 22 Oct 2002 13:59:42 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:24336 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264799AbSJVR72>;
	Tue, 22 Oct 2002 13:59:28 -0400
Message-ID: <3DB59385.6050003@mvista.com>
Date: Tue, 22 Oct 2002 13:05:57 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, levon@movementarian.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Tue, Oct 22, 2002 at 03:10:06PM +0200, Corey Minyard wrote:
>  
>
>>>If it's possible (and I have no idea, not having looked at RCU at all)
>>>it seems the right way.
>>>
>>>      
>>>
>>I looked, and the rcu code relys on turning off interrupts to avoid 
>>preemption.  So it won't work.
>>
>>    
>>
>
>Hmm.. Let me see -
>
>You need to walk the list in call_nmi_handlers from nmi interrupt handler where
>preemption is not an issue anyway. Using RCU you can possibly do a safe
>walking of the nmi handlers. To do this, your update side code
>(request/release nmi) will still have to be serialized (spinlock), but
>you should not need to wait for completion of any other CPU executing
>the nmi handler, instead provide wrappers for nmi_handler
>allocation/free and there free the nmi_handler using an RCU callback
>(call_rcu()). The nmi_handler will not be freed until all the CPUs
>have done a contex switch or executed user-level or been idle.
>This will gurantee that *this* nmi_handler is not in execution
>and can safely be freed.
>
>This of course is a very simplistic view of the things, there could
>be complications that I may have overlooked. But I would be happy
>to help out on this if you want.
>
This doesn't sound any simpler than what I am doing right now.  In fact, 
it sounds more complex.  Am I correct?  What I am doing is pretty simple 
and correct.  Maybe more complexity would be required if you couldn't 
atomically update a pointer, but I think simplicity should win here.

Thanks,

-Corey

