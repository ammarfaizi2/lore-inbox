Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315631AbSENMOV>; Tue, 14 May 2002 08:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSENMOU>; Tue, 14 May 2002 08:14:20 -0400
Received: from [195.63.194.11] ([195.63.194.11]:33292 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315631AbSENMOU>; Tue, 14 May 2002 08:14:20 -0400
Message-ID: <3CE0F0D0.7050404@evision-ventures.com>
Date: Tue, 14 May 2002 13:11:12 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177b8s-0007lm-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>Something here smells fishy here - you shouldn't hold a spinlock for a long
>>time (a long time === spinlocking, setting up the drive, possibly scheduling,
> 
> 
> You can't hold it while scheduling or you may deadlock
> 
> 
>>transferring data, getting status, then unlocking).  Also, remember,
>>spinlocks are no-ops on uniprocessor systems.
> 
> 
> Its possible it can be done with a semaphore but the whole business is
> pretty tricky. IDE command processing occurs a fair bit at interrupt level
> and you definitely don't want to block interrupts for long periods.

... Becouse the chances are fscking high - that you will miss command
completion interrupts for the "other drive" on the same channel.
The dready heritage of "dangling ISA bus" with *idiotic* edge triggered
interrupts bite us here. Someone just please shoot this enginer
who saved the few pullup resistors in the head or send him alternatively
for "hunting white bears" in Siberia... about 15 years would be fine in my
opinnion.

> If the queue abstraction is right then the block layer should do all the
> synchronization work that is required. It may cost a few cycles on the odd
> case you can do overlapped command setup but that versus a nasty locking
> mess its got to be better to lose those few cycles.
> 
> I don't even Martin here, the ide locking is currently utterly vile

Don't worry - I got your point.

