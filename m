Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316075AbSEOOHg>; Wed, 15 May 2002 10:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316077AbSEOOHf>; Wed, 15 May 2002 10:07:35 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46089 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316075AbSEOOHe>; Wed, 15 May 2002 10:07:34 -0400
Message-ID: <3CE25CD7.1050509@evision-ventures.com>
Date: Wed, 15 May 2002 15:04:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Neil Conway <nconway.list@ukaea.org.uk>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Anton Altaparmakov <aia21@cantab.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177yXY-0001t9-00@the-village.bc.nu> <3CE263FF.FC17E7C0@ukaea.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Neil Conway napisa?:
> Alan Cox wrote:
> 
>>>The problem is that with the busy flag on we are wasting quite
>>>a significant amount of CPU time spinning around it for no good...
>>
>>Why spin on the busy flag. Instead you just let the person who clears
>>the flag check the pending work and do it.
> 
> 
> Isn't that what happens?  Since when are we spinning on busy?  Certainly
> not in vanilla 2.5.14, unless I'm much mistaken.
> 
> Martin - I haven't read your last couple of patches yet but did you
> really change it this drastically?

Yeep. Not quite that drastically but basically it's the
upper layer going down the driver and up again.

Anyway. This all will be gone soon, since I have just already
made the distinction between ata_queue and atapi_queue... and
well things turn out nicely at least in the lieu of code.
The synchronization between them can be done by deploying
precisely the same blk_queue_plug and blk_queue_unplug games
already played in tcq.c. And it's very likely that
we will end up unwinding the REQ_DRIVE_CMD and REQ_DRIVE_ACB
cases by just providing two different request handlers...
And thus finally unwinding ATA ver. ATAPI handling entierly,
which should indeed simplyfy things quite a lot...



