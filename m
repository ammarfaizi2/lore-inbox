Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSFEQJ3>; Wed, 5 Jun 2002 12:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315472AbSFEQJ2>; Wed, 5 Jun 2002 12:09:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42246 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315198AbSFEQJ1>; Wed, 5 Jun 2002 12:09:27 -0400
Message-ID: <3CFE29FE.90402@evision-ventures.com>
Date: Wed, 05 Jun 2002 17:10:54 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.20 IDE 85
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <3CFE0C16.1020203@evision-ventures.com> <20020605141717.GB16257@suse.de> <3CFE1974.9080509@evision-ventures.com> <20020605154853.GF16600@suse.de> <20020605155241.GD16257@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Jun 05 2002, Jens Axboe wrote:
> 
>>On Wed, Jun 05 2002, Martin Dalecki wrote:
>>
>>>Jens Axboe wrote:
>>>
>>>>On Wed, Jun 05 2002, Martin Dalecki wrote:
>>>>
>>>>AFAICS, you just introduced some nasty list races in the interrupt
>>>>handlers. You must hold the queue locks when calling
>>>>blkdev_dequeue_request() and end_that_request_last(), for instance.
>>>>
>>>
>>>No. Please be more accurate. Becouse:
>>>
>>>1. If anything I have made existing races only "obvious".
>>
>>If anything, you've made a race you introduced earlier more obvious.
>>
>>
>>>2. It is called in the context of do_ide_request or ide_raw_taskfile
>>>   where we already have the lock.
>>
>>?? Both tcq and ata_special_intr look like interrupt handlers to me.
> 
> 
> BTW, I wanted to look at the code (and not just read the patch), but
> it's not clear from the patch what it is against. Where do you keep
> older patches so I can get them? Maybe the ide code could do with a bit
> of peer review :-)
> 

Well IDE 83 and 84 are already inside the bk repository at linux.bkbits.com.
No as far as of now I don't have any public FTP or whatever area for
the patches (Well send you everything in one go.)
And I of course agree that the code needs a peer review in this area.
Adding the locking isn't difficult.
However I wonder a bit whatever we couldn't just blkdev_dequeue_request()
once at request handling start? We drag drive->rq around anyway...


