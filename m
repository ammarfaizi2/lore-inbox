Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSFTK63>; Thu, 20 Jun 2002 06:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313698AbSFTK62>; Thu, 20 Jun 2002 06:58:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43530 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313628AbSFTK61> convert rfc822-to-8bit; Thu, 20 Jun 2002 06:58:27 -0400
Message-ID: <3D11B551.9090201@evision-ventures.com>
Date: Thu, 20 Jun 2002 12:58:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE booting problems with 2.5.23
References: <16471.1024566396@warthog.cambridge.redhat.com> <3D11A6BB.8030705@evision-ventures.com> <20020620103532.GA812@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Jens Axboe napisa³:
> On Thu, Jun 20 2002, Martin Dalecki wrote:
> 
>>BTW> Jens did you notice that the IDE_DMA flag is a "read only"
>>flag? I see basically only TQC code checking it. I would
>>like to replace the drive->waiting_for_dma flag field by the
>>proper usage of the IDE_DMA bit. Any way this could bite TCQ code?
>>The checks there appear to be only sanity checks anyway.
> 
> 
> At first I did just add them as sanity checks, but later on I had the
> same thought myself (get rid of drive->waiting_for_dma). So go ahead
> with that.

OK.

> BTW, I see you renamed the flags to channel->active. I think that's a
> bit misleading, can't you just call it ->state or ->flags (or
> ->state_flags? :-)

My reasoning behind this is - state is for device state
register and active is well for the state of the driver. All the other
names seemed for me to be too opaque for the purpose of it or already used.
flags souns static to me.
And you have to agree that it is *very* special
purpose if you look at the IDE_BUSY bit.
And finally - I took this name from the FreeBSD
code to make it look a bit more similar.

Another tought:

- We will have then an IDE_DMA which will indicate clearly
that we are expecting some async event for the sake of DMA.

But we have IDE_BUSY overloaded with both:

- Flagging that we are expecting an IRQ to arrive during
   PIO io (in conjencture with ->handler != NULL).

- Flagging that the do_request code path should be reentered
   immediately or is busy.

I thihink its hard but worth it to split the semantic overload.
In esp. a very fragile change. But I *feel* like it would
be worth it. Suggestions opinnions?

