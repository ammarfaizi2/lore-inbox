Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSEXWT1>; Fri, 24 May 2002 18:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312457AbSEXWT0>; Fri, 24 May 2002 18:19:26 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25618 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312447AbSEXWTZ>; Fri, 24 May 2002 18:19:25 -0400
Message-ID: <3CEEAD8C.1060202@evision-ventures.com>
Date: Fri, 24 May 2002 23:15:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alexander Viro <viro@math.psu.edu>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] change of ->bd_op->open() semantics
In-Reply-To: <Pine.LNX.4.44.0205241323240.11918-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Fri, 24 May 2002, Alexander Viro wrote:
> 
>>	It has an additional benefit of killing the array of default
>>queues on the same pass - a thing we will need to do sooner or later
>>anyway.
> 
> 
> I'd like to see this, because we want to make the "find the right queue" a
> much more expensive operation (no longer some fairly simple mapping from
> major number - a more dynamic and general "register this queue for minors
> xxxx-yyyy of major zzz").
> 
> Doing it just once at open() time allows for that to happen without any
> performance downside.
> 
> 		Linus

Current ATA code says about this:
/*
  * Returns the queue which corresponds to a given device.
  *
  * FIXME: this should take struct block_device * as argument in future.
  */
static request_queue_t *ata_get_queue(kdev_t dev)
{
	struct ata_channel *ch = (struct ata_channel *)blk_dev[major(dev)].data;

	/* FIXME: ALLERT: This discriminates between master and slave! */
	return &ch->drives[DEVICE_NR(dev) & 1].queue;
}

Guess who did spill the FIXME: entiers there?
So of course plese plese go ahead as soon as possible!.
I would love to don't have to look at the above any longer.

