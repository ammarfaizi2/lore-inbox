Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265499AbUEVATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUEVATy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 20:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264596AbUEVAQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 20:16:41 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:26523 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265503AbUEVANv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 20:13:51 -0400
Message-ID: <40ADB671.8060904@yahoo.com.au>
Date: Fri, 21 May 2004 17:57:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: FabF <Fabian.Frederick@skynet.be>
CC: axboe@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.6-mm4-ff1] I/O context isolation
References: <1085124268.8064.15.camel@bluerhyme.real3>	 <40ADB20C.8090204@yahoo.com.au> <1085125564.8071.23.camel@bluerhyme.real3>
In-Reply-To: <1085125564.8071.23.camel@bluerhyme.real3>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FabF wrote:
> On Fri, 2004-05-21 at 09:38, Nick Piggin wrote:
> 
>>FabF wrote:
>>
>>>Jens,
>>>
>>>	Here's ff1 patchset to have generic I/O context.
>>>ff1 : Export io context operations from blkdev/ll_rw_blk (ok)
>>>ff2 : Make io_context generic plateform by importing IO stuff from
>>>as_io.
>>>
>>
>>Can I just ask why you want as_io_context in generic code?
>>It is currently nicely hidden away in as-iosched.c where
>>nobody else needs to ever see it.
> 
> I do want I/O context to be generic not the whole as_io.
> That export should bring:
> 	-All elevators to use io_context
> 	-source tree to be more self-explanatory
> 	-have a stronger elevator interface
> 

Sorry, my mistake. as_io_context is not nicely hidden away at
the moment. I can't remember why, I think it is only needed
for the declaration... I'll look into moving it into as-iosched.c

*But*, io_context is already exported to all elevators and generic
code.

> 
>>>	AFAICS, cfq_queue for instance could disappear when using io_context
>>>but I think elv_data should remain elevator side....
>>>I don't want to go in the wild here so if you've got suggestions, don't
>>>hesitate ;)
>>>
>>
>>cfq_queue is per-queue-per-process. io_context is just
>>per-process, so it isn't a trivial replacement.
> 
> But I guess we can merge that stuff to have "a one way, one place" code
> rather than repeat code in all elv.
> 

I quite like things how they sit right now. The io_context thing
is quite generic so that is fine... CFQ's cfq_queue is fairly
specialised and trying to make it generic is not a very good idea,
especially as no other elevators would make use of it.
