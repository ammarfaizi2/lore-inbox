Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313480AbSDLJzi>; Fri, 12 Apr 2002 05:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313483AbSDLJzh>; Fri, 12 Apr 2002 05:55:37 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16659 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313480AbSDLJzg>; Fri, 12 Apr 2002 05:55:36 -0400
Message-ID: <3CB6A083.3090501@evision-ventures.com>
Date: Fri, 12 Apr 2002 10:53:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: VIA, 32bit PIO and 2.5.x kernel
In-Reply-To: <Pine.LNX.4.10.10204120154480.489-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> On Fri, 12 Apr 2002, Jens Axboe wrote:
> 
> 
>>On Fri, Apr 12 2002, Petr Vandrovec wrote:
>>
>>>I believe that there must be some reason for doing that... And 
>>>do not ask me why it worked in 2.4.x, as it cleared io_32bit
>>>in task_out_intr too.
>>
>>Because 2.4 doesn't use that path for fs requests. And be glad that it
>>doesn't otherwise _everybody_ would have much worse problems than you
>>are currently seeing.
> 
> 
> Maybe if everyone ever bothered to look at the code base and not assume
> they know everything ... and enjoying feable attempts to cast me as a
> fool.  Better yet maybe understand the hardware ...
> 
> ata_input_data
> 
>         io_32bit = drive->io_32bit;
> 
>         if (io_32bit)
> 		insl(IDE_DATA_REG, buffer, wcount);
> 	else
>                 insw(IDE_DATA_REG, buffer, wcount<<1);
> 
> or 
> 
> ata_output_data
> 
>         io_32bit = drive->io_32bit;
> 
>         if (io_32bit)
>                 outsl(IDE_DATA_REG, buffer, wcount);
>         else
>                 outsw(IDE_DATA_REG, buffer, wcount<<1);
> 
> 
> WHOA is it not obvious it is the total number of calls to the same damn
> DATA-TASKFILE-REGISTER-PORT
> 
> Which is only SIXTEEN BITS WIDE!
> 
> So please contine to write 32 bits to a 16 bit wide address...
> Legacy or not the physical layer to the device, so please go look there.
> Why do I even bother, all of you are so much smarter than me.

The physical register on the side of the device may very well be
only 16 bit's wide. Most propably it's simple implementation dependant.
I saw many 68000 derivatives on IDE controllers but those days there
are many 32 bit controllers there as well.

But please note that the ata host-chip xor the CPU (think 386sx)
is multiplexing the access to it. Otherwise it wouldn't be possible to do 32 bit
transfers over a cable with only 16 data lines at all.

Apparently you don't even understand the physical transport layer,
which explains the presence of the bug in question.

