Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293467AbSCFLJG>; Wed, 6 Mar 2002 06:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293466AbSCFLI5>; Wed, 6 Mar 2002 06:08:57 -0500
Received: from [195.63.194.11] ([195.63.194.11]:50438 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S293463AbSCFLIp>; Wed, 6 Mar 2002 06:08:45 -0500
Message-ID: <3C85F872.7050306@evision-ventures.com>
Date: Wed, 06 Mar 2002 12:07:30 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: benh@kernel.crashing.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16iPUx-0004vD-00@the-village.bc.nu> <20020306091552.19301@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

benh@kernel.crashing.org wrote:

> I would add to that than rather than killing the taskfile stuff, it
> should instead be generalized and any IDE access be done via a taskfile.
> 
> I don't comment on the actual implementation quality as I didn't look
> into it closely, but the point of passing requests as taskfile's
> down to the lowest level driver allow more consistency between the
> various pieces of the driver, more easily hooking of the low level
> taskfile "apply" code to accomodate MMIO or strangely mapped IDE
> controllers, etc...
> 
> Alan: BTW, Apple's Darwin has a nice ATA layer implementation that
> happens to be completely taskfile based :) Ask Andre what he thinks
> about their ATA & SCSI layer, except from bloat due to their C++
> implementation, their overall design is actually really nice !

I have looked at it and come to the following conclusions:

1. Indeed the code quality found there is *excellent* nothing comparable
    with the messy crude found currently in linux.

    The state machine (the finite automata one i mean) is *sweet*
    and can be even a subject to proper formal validation. This is
    quite contrary to the interrupt handler pointer passing games done
    under linux right now. There are clearly defined command
    categories determined by device state instead of the particular
    transport layer. (reset, synchroneous, asynchronous).
    There is proper separation between the device types using the
    same hardware bus layer but completely different transport
    layers (ATA vers ATAPI - which is SCSI in disguise).

2. It convinced me that the current task-file interface in linux
    is inadequate. So Alan please bear with me if your CF format
    microdrive will have to not wakeup properly for some time...
    The current mess will just have to go before something more
    adequate can go in.

3. Someone had too much time at apple, becouse the C++ found
    there doesn't apparently contain anything that couldn't
    be expressed without any pain in plain C with structs containing
    function pointers ;-).

