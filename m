Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313611AbSDHNH7>; Mon, 8 Apr 2002 09:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313612AbSDHNH6>; Mon, 8 Apr 2002 09:07:58 -0400
Received: from [195.63.194.11] ([195.63.194.11]:44812 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313611AbSDHNH6>; Mon, 8 Apr 2002 09:07:58 -0400
Message-ID: <3CB187AC.2040604@evision-ventures.com>
Date: Mon, 08 Apr 2002 14:06:04 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][CFT] IDE tagged command queueing support
In-Reply-To: <20020408120713.GB25984@suse.de> <3CB1806F.9090103@evision-ventures.com> <20020408125350.GE25984@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Apr 08 2002, Martin Dalecki wrote:
> 
>>Jens Axboe wrote:
>>
>>>Hi,
>>>
>>>I've implemented tagged command queueing for ATA disk drives, and it's
>>>now ready for people to give it a test spin. As it has had only limited
>>>testing so far, please be very careful with it. It has been tested on
>>>two drives so far, a GXP75-30gb and a GXP120-40gb, and with a PIIX4
>>>controller:
>>
>>OK after a cursory look I see that the patch contains quite
>>a lot of ideas for the generic code itself. Do you think that it would
>>be worth wile to extract them first or should the patch be just included
>>in mainline. (I don't intent to interferre too much with your efforts to
>>do something similar in 2.4.xx.)....
> 
> 
> Good question, I've asked myself that too... Yeah I see some of my ideas
> as being nice to have in mainline even without TCQ. The big one being
> ata_request_t of course, there are some parts to this:

Sure ;-).

> - Separate scatterlist and dma table out from hwgroup. This is not
>   really needed for TCQ, but saves doing a blk_rq_map_sg on a request
>   more than once. If future ATA hardware would support more than one
>   pending DMA operation per hwgroup, this would be useful even without
>   TCQ.

Agreed.

> - Use ata_request_t as the main request command. This is where I really
>   want to go. I'm not saying that we need a complete IDE mid layer, but
>   a private request type is a nice way to unify the passing of a general
>   command around. So the taskfile stuff would remain very low level,
>   ata_request would add the higher level parts. I could expand lots more
>   on this, but I'm quite sure you know where I'm going :-)

Well I can assure you that we are not dragging the towell in two different
directions - please see for example my notes about the ata_taskfile
function having too much parameters ;-).

> Note that the ata_request_t usage is a bit messy in the current patch,

I noted it already ;-)

> that's merely because I was more focused on getting TCQ stable than
> designing this out right now. So I think we should let it mature in the
> TCQ patch for just a while before making any final commitments. Agreed?

No problem with me. I will just pull out the generally good stuff
out of it OK? I hope this will not make the tracking of the
alpha patches too difficult for you...

> Of course this will leave me with the pain of merging with your IDE
> stuff every time a new -pre comes out (updating this patch from
> 2.5.1-pre where I last used it was _not_ funny! :-), but I can handle
> that.

Well, there is *no question* you are capable to do this...

> In addition, there are small buglet fixes in the patch that should go to
> general. I will extract these, I already send you one of these earlier
> today.

Yes I have noticed this as well. However let's wait and see
whatever maybe I'm able to save you the trobule and pull them
out myself. Your alpha patch is "interresting" enough to have me
a walk over it line by line anyway :-).

I have to catch up with 2.5.8-pre2 anyway, since apparently this
weekend was more about alcohol consumption for me then hacking...

