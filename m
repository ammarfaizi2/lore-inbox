Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbTCLSKJ>; Wed, 12 Mar 2003 13:10:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCLSKJ>; Wed, 12 Mar 2003 13:10:09 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:995 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261811AbTCLSJi>;
	Wed, 12 Mar 2003 13:09:38 -0500
Message-ID: <3E6F7A49.50709@colorfullife.com>
Date: Wed, 12 Mar 2003 19:19:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: bio too big device
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens wrote:

>On Wed, Mar 12 2003, Andre Hedrick wrote:
>> 
>> So lets dirty list the one drive by Paul G. and be done.
>> Can we do that?
>
>Who cares, really? There's not much point in doing it, we're talking 248
>vs 256 sectors in reality. I think it's a _bad_ idea, lets just keep it
>at 255 and avoid silly drive bugs there.
>  
>
I think a black list would be the right thing:

linux/drivers/ide/ide-probe.c:

>#ifdef CONFIG_BLK_DEV_PDC4030
>	max_sectors = 127;
>#else
>	max_sectors = 255;
>#endif
>	blk_queue_max_sectors(q, max_sectors);
>
>  
>
IDE uses 127 sector requests if support for PDC4030 is compiled it, 
otherwise 255. It seems someone started with a blacklist, but never 
completed it.
Does any distro enable PDC4030 support?

--
    Manfred

