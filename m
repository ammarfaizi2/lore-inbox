Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318686AbSHAJnA>; Thu, 1 Aug 2002 05:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318693AbSHAJlx>; Thu, 1 Aug 2002 05:41:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:13572 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318686AbSHAJjr>; Thu, 1 Aug 2002 05:39:47 -0400
Message-ID: <3D484493.8030908@evision.ag>
Date: Wed, 31 Jul 2002 22:12:03 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
References: <200207302010.NAA04198@baldur.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
> Martin Dalecki wrote:
> 
>>Adam J. Richter wrote:
> 
> 
>>>	That said, I think all the "lock group" logic in drivers/ide
>>>may be useless, and it would be pretty straightforward to delete all
>>>that code, have ata_channel->lock be a lock rather than a pointer to one,
>>>and have it be initialized before that first call to ch->tuneproc, in
>>>which case we could just have interrupts off and ch->lock held in all
>>>cases when ch->tuneproc is called.  I did not want to do this in my patch,
>>>because I wanted to keep my patch as small as possible, but perhaps it
>>>would be worth doing now just to simplify the rules for calling ch->tuneproc.
>>
> 
>>Not quite. It's not that easy becouse the same lock is used by the BIO
>>layer to synchronize between for example master and slave devices.
> 
> 
> 	Master and slave devices share the same channel, so
> 
> 		master->channel		== slave->channel
> 		&master->channel->lock	== &slave->channel->lock
> 
> 	So their queue->lock pointer would continue to point to
> the same lock: &channel->lock.
> 
> 
>>There are other problems with this but right now you can hardly do 
>>something about it.
> 
> 
> 	I'd be intersted in knowing what one of those other problems
> is.  Otherwise, I don't understand why I can't eliminate the "lock
> group" stuff.

Please have a look at the usage of the QUEU_FLAG_STOPPED
in the reuquest_queue struct. Lock is shared -> flag guaring
it is not. Just one example. *But* if you can make the
whole noting of shared locks go away -> then go ahead for it.
I would be glad to see it working.


