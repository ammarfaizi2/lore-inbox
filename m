Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310579AbSCLLlW>; Tue, 12 Mar 2002 06:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310561AbSCLLlM>; Tue, 12 Mar 2002 06:41:12 -0500
Received: from [195.63.194.11] ([195.63.194.11]:8968 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S310646AbSCLLky>;
	Tue, 12 Mar 2002 06:40:54 -0500
Message-ID: <3C8DE900.8040807@evision-ventures.com>
Date: Tue, 12 Mar 2002 12:39:44 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203112023410.18739-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Mon, 11 Mar 2002, Linus Torvalds wrote:
> 
>> - attach to one or more request queue(s). Notice that you should not have
>>   _one_ module that handles all request queues, because the filter module
>>   obviously has to be different for an ATA disk than for a SCSI disk, and
>>   in fact it might be different for an IBM ATA disk than for a Maxtor ATA
>>   disk, for example.
>>
> 
> Btw, to tie this back to the other IDE thread, namely the suspend/resume 
> thing, I think things like that should also just push commands down the 
> request list. In particular, instead of waiting until the handler is NULL, 
> it should do something like
> 
>  - create a "sync" request
>  - do the equivalent of
> 
> 	DECLARE_COMPLETION(wait);
> 	rq->waiting = &wait;
> 	q->elevator.elevator_add_req_fn(q, rq, queue_head);
> 	wait_for_completion(&wait);
> 
> which automatically synchronizes with any outstanding requests (simply 
> by virtue of the elevator knowing not to re-order/merge special requests, 
> so when the sync command in finished, we know all other commands have 
> finished too).
> 
> Note that this should be the same code as for a shutdown as well - we
> should finish with a flush buffers request and wait for it to have
> completed.
> 
> I'd like a _lot_ of stuff to stop using "do_xxx_command()", and move toa 
> higher layer so that more code can be shared between different subsystems 
> (all of these "sync" issues are really completely generic, and should 
> _not_ be duplicated across drivers or subsystems).
> 

"Amen Brother" to this. Getting device id strings and others are in the
same gang.

BTW.> Would you dare to care to splow out a 2.5.7-pre1 just to allow
synchronization without bitkeeper?

