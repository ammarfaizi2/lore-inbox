Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSGXO3U>; Wed, 24 Jul 2002 10:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317307AbSGXO3U>; Wed, 24 Jul 2002 10:29:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:54030 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317306AbSGXO3T>; Wed, 24 Jul 2002 10:29:19 -0400
Message-ID: <3D3EB940.2010708@evision.ag>
Date: Wed, 24 Jul 2002 16:27:12 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
References: <Pine.SOL.4.30.0207241619020.15605-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Wed, 24 Jul 2002, Marcin Dalecki wrote:
> 
> 
>>>Jens, the same is in cciss.c.
>>>Please remove locking from blk_stop_queue() (as you suggested) or intrduce
>>>unlocking in request_functions.
>>>
>>
>>Bartek I think the removal is just for reassertion that the
>>locking is the problem. You can't remove it easly from
>>blk_stop_queue() unless you make it mandatory that blk_stop_queue
>>has to be run with the lock already held. Or in other words
>>basically -> Don't use blk_stop_queue() outside of ->request_fn.
> 
> 
> Yep, that how it should be only used.
> However you are right these stop/start need some checking.
> 
> About idea of using QUEUE_FLAG_STOPPED as IDE_BUSY right now is no go
> and will never be.

Hold on please. Becouse if you think one step further ->
not blocking blk_stop_queue() in do_request or more
precisely at places where the IDE_BUSY get's set 8-) you suddenly get 
completely rid of it if you replace the "back-calls" to do_request() in 
ata_irq_request() and ide_timer_expiry() with blk_start_queue()...
No direct manipulation whatsever.

