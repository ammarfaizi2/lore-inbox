Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292850AbSCELvO>; Tue, 5 Mar 2002 06:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292911AbSCELvG>; Tue, 5 Mar 2002 06:51:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:29196 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292850AbSCELut>; Tue, 5 Mar 2002 06:50:49 -0500
Message-ID: <3C84B093.5020401@evision-ventures.com>
Date: Tue, 05 Mar 2002 12:48:35 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <Pine.LNX.4.44.0203051307080.12437-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 5 Mar 2002, Martin Dalecki wrote:
> 
> 
>>- Disable configuration of the task file stuff. It is going to go away
>>   and will be replaced by a truly abstract interface based on
>>   functionality and *not* direct mess-up of hardware.
>>
> 
> Could you elaborate just a tad on that.

The task file stuff was basically providing a mapping between
every single possible ATA/ATAPI/whatever device command to the
ioctl interface. It was for example including mechanisms to initiate
DMA transfers into nirvana. This is not a good thing
for the following reasons:

1. The standard itself changes quite frequently.

2. I would rather expect that the cornercases (read: not used by Win32)
    of this interface will not be implemented properly or the
    implementations will be either broken or not complete. This is making
    this interface really questionable for general use.
    As an added bonus this is introducing magnificient possibilities for
    failure or even true hardware breakdown (possible).
    Bah. It is right now the fact that 80% of this stuff isn't
    implemented on older drives.

3. The code implementing it is of really really poor quality and very
    heavy wight. It makes it really hard to target the true problems the
    driver has on a far more trivial level.

4. One should have an ioctl setting the drivers silence policy based on
    a switch choice value for example instead of an ioctl, which contains
    the corresponding ATA command packet. This would allow for example
    to support drives in the future if the most common method of
    configuring this changes. Or one could for example identify silent
    operation mode of disks with rotation speed trottle on DVD drives.

5. It is necessary to integrate most features found there with other
    kernel functionality context (suspend and reset come to mind as
    first). It doesn't therefore make *any* sense to expose this
    interface to user space.

    (This is the abstraction problem.)

And infally:

5. No body is using it as of now and therefore nobody should miss it. No
    other OS out there has something similar, so maybe they don't need
    it? I find it allways ridiculous to see that Win32's ATA drivers are
    by the fact 3 smaller then the one found in linux.

6. Some special commands found there (unless issuing IRQ's) can be
    entierly handled in userspace.

Home it helps.

PS. If you are still in doubt, please:

1. Look at ide-taskfile.c and vommit ;-).
2. Try to show me a usufull programm using this.
3. Count the number of "options" of the IDE driver entry in menuconfig.

