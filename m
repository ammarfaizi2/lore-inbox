Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318696AbSHAKex>; Thu, 1 Aug 2002 06:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318699AbSHAKex>; Thu, 1 Aug 2002 06:34:53 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59908 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318696AbSHAKex>; Thu, 1 Aug 2002 06:34:53 -0400
Message-ID: <3D490E5D.3070501@evision.ag>
Date: Thu, 01 Aug 2002 12:33:01 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: IDE from current bk tree, UDMA and two channels...
References: <9B9F331783@vcnet.vc.cvut.cz> <3D48420F.5050407@evision.ag> <20020801095609.GE1096@suse.de> <3D4905DB.70305@evision.ag> <20020801100553.GA13494@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>that would work, but I think it would seriously starve the other device
>>>on the same channel.
>>
>>We starve anyway, becouse the kernel isn't real time and we can't
>>guarantee "sleeping" for some maximum time and comming back.
>>We don't reschedule the kernel during this kind of "sleeping".
>>And we can't know that a command on the "mate" will not take 
>>extraordinary amounts of time. It's only a problem if mixing travan
>>tapes with disks on a channel.
> 
> 
> I'm thinking about the alternation of the devices so one device can't
> starve the other device off the channel.

Ah so you are thinking about two equally powered devices
competing for the channel. Something I would call the "sumo fight"
situation. Well disks didn't use the "sleeping" mechanism at all anyway
and the chances someone would do cp from CD-ROM to CD-ROM are low.

Finally I think that the proper granularity of scheduling requests to
the drive is, well, the request layer. The queue processing layer should
handle this becouse otherwise we would have two "competing" optimization
mechanisms. And there we are indeed able to actually relinquish some CPU 
time. If you look at an request processing optimization as a low pass
signal filter it's immediately obvious that the effects of chaining them
can be, well at least "counter intuitive".




