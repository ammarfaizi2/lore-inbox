Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310835AbSENNdh>; Tue, 14 May 2002 09:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSENNdg>; Tue, 14 May 2002 09:33:36 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19725 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310835AbSENNdf>; Tue, 14 May 2002 09:33:35 -0400
Message-ID: <3CE10362.3090300@evision-ventures.com>
Date: Tue, 14 May 2002 14:30:26 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk@arm.linux.org.uk>,
        Neil Conway <nconway.list@ukaea.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177bhp-0007qR-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Alan Cox napisa?:
>>>Its possible it can be done with a semaphore but the whole business is
>>>pretty tricky. IDE command processing occurs a fair bit at interrupt level
>>>and you definitely don't want to block interrupts for long periods.
>>
>>... Becouse the chances are fscking high - that you will miss command
>>completion interrupts for the "other drive" on the same channel.
> 
> 
> The shared IRQ capable IDE ards I am aware of all do have proper tristates
>  but you still have to handle the edge trigger very carefully.
> 
> If you can miss a command completion interrupt you have a bug. Since you
> know each drive on the bus you can poll each afflicted device for interrupts
> until you reach a point where you completed an entire poll loop and nobody
> had an IRQ pending.
> 
> At that point you know an edge transition has occurred and that a real
> IRQ will be posted when the next event occurs because that too will cause
> an edge.
> 
> A good place for examples of this in the DOS world is things like serial
> drivers, many of which could handle broken shared IRQ ISA setups correctly
> using this technique.
> 
> In the case without tristates the stronger driver tends to win the argument
> about the line in either direction and nothing works at all.


Well anyway. What we have right now, looking for the channel perspective,
is indeed some nIEN tricks done here and there. However the problem is
that we postpone the disabling of interface interrupts now until the
time a next request gets queued. In addition the driver is doing quite
a lot of polling for the next expected interrutp as well.

Right now the consequences are indeed very simple for me. The time I
started to sanitize the data structures I first had to paint down
diagram of pointers between them. Now it's simple time to write down
a state diagram for the IRQ / request handling code paths :-).


