Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314164AbSDRNm5>; Thu, 18 Apr 2002 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314350AbSDRNm4>; Thu, 18 Apr 2002 09:42:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:274 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S314164AbSDRNm4>;
	Thu, 18 Apr 2002 09:42:56 -0400
Message-ID: <3CBEBEC2.1070304@evision-ventures.com>
Date: Thu, 18 Apr 2002 14:40:34 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020417132852.4cf20276.sebastian.droege@gmx.de> <3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de> <3CBEABEF.1030009@evision-ventures.com> <20020418125757.GF2492@suse.de> <3CBEB51F.90105@evision-ventures.com> <20020418130743.GH2492@suse.de> <3CBEB754.6010205@evision-ventures.com> <20020418131248.GI2492@suse.de> <3CBEB909.7000306@evision-ventures.com> <20020418132650.GJ2492@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>>>through the request buffer but IDE-CD is passing them through
>>>>request special field... argh!
>>>
>>>
>>>So kill ->special usage in ide-cd and use ->buffer?
>>
>>That's the idea, but the caching code mentioned above
>>is abusing it already in a way I can't grasp wholly immediately.
> 
> 
> It's most definitely _not_ abusing it, in fact it's a pretty regular
> usage of ->buffer. ide-cd never does highmem I/O, so ->buffer always
> points to the transfer address for a block request.
> cdrom_read_from_buffer() is simply copying data from the internal 2kb
> cache to rq->buffer, eod.

Either way it's ide-floppy doing the abuse then :-(.
I think the best sollution to this is anyway just to remove
the struct packet_command altogeter and just add the required fields
to struct ata_request - makes ata_request bigger but provides much less
pointer tossing as a benefit.

> 



-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

