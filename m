Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313831AbSDQMf4>; Wed, 17 Apr 2002 08:35:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313852AbSDQMfz>; Wed, 17 Apr 2002 08:35:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23814 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313831AbSDQMfy>; Wed, 17 Apr 2002 08:35:54 -0400
Message-ID: <3CBD5D93.30501@evision-ventures.com>
Date: Wed, 17 Apr 2002 13:33:39 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 IDE oops (TCQ breakage?)
In-Reply-To: <200204161749.TAA16333@harpo.it.uu.se> <3CBD45BD.4040209@evision-ventures.com> <20020417120817.GA800@suse.de> <20020417122502.GB800@suse.de>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 17 2002, Jens Axboe wrote:
> 
>>On Wed, Apr 17 2002, Martin Dalecki wrote:
>>
>>>Mikael Pettersson wrote:
>>>
>>>>I have a 486 box which ran 2.5.7 fine, but 2.5.8 oopses during
>>>>boot at the BUG_ON() in drivers/ide/ide-disk.c, line 360:
>>>>
>>>>	if (drive->using_tcq) {
>>>>		int tag = ide_get_tag(drive);
>>>>
>>>>		BUG_ON(drive->tcq->active_tag != -1);
>>>
>>>OK it could be that the tca goesn't get allocated if there
>>>was no chipset selected. Lets have a look...
>>
>>Add a drive->using_dma check to ide_dma_queued_on in ide-tcq.c, it needs
>>to look like this:
>>
>>ide_tcq_dmaproc()
>>{
>>
>>	...
>>
>>		case ide_dma_queued_off:
>>			enable_tcq = 0;
>>		case ide_dma_queued_on:
>>			if (!drive->using_dma)
>>				return 1;
>>			return ide_enable_queued(drive, enable_tcq);
>>		default:
>>			break;
>>	}
>>
>>that should fix it.

Yes I see. However for now I will just concentrate on ide-cd.c and
await you to merge up with IDE 37 OK? (It should be easy this time :-).

