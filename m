Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310394AbSCLFGM>; Tue, 12 Mar 2002 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310405AbSCLFGD>; Tue, 12 Mar 2002 00:06:03 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28431 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310402AbSCLFFv>;
	Tue, 12 Mar 2002 00:05:51 -0500
Message-ID: <3C8D8C9C.3060208@mandrakesoft.com>
Date: Tue, 12 Mar 2002 00:05:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203112023410.18739-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 11 Mar 2002, Linus Torvalds wrote:
>
>> - attach to one or more request queue(s). Notice that you should not have
>>   _one_ module that handles all request queues, because the filter module
>>   obviously has to be different for an ATA disk than for a SCSI disk, and
>>   in fact it might be different for an IBM ATA disk than for a Maxtor ATA
>>   disk, for example.
>>
>
>Btw, to tie this back to the other IDE thread, namely the suspend/resume 
>thing, I think things like that should also just push commands down the 
>request list. In particular, instead of waiting until the handler is NULL, 
>it should do something like
>
> - create a "sync" request
> - do the equivalent of
>
>	DECLARE_COMPLETION(wait);
>	rq->waiting = &wait;
>	q->elevator.elevator_add_req_fn(q, rq, queue_head);
>	wait_for_completion(&wait);
>
>which automatically synchronizes with any outstanding requests (simply 
>by virtue of the elevator knowing not to re-order/merge special requests, 
>so when the sync command in finished, we know all other commands have 
>finished too).
>

Dumb question, why create a separate request?

Why not just have some way to wait for request X (and flag it for 
no-merge/barrier treatment, etc.)?  bios have end_io callbacks...

    Jeff





