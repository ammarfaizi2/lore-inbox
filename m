Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313019AbSEHLTv>; Wed, 8 May 2002 07:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313032AbSEHLTu>; Wed, 8 May 2002 07:19:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:10760 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313019AbSEHLTu>; Wed, 8 May 2002 07:19:50 -0400
Message-ID: <3CD8FB08.1040004@evision-ventures.com>
Date: Wed, 08 May 2002 12:16:40 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Bjorn Wesen <bjorn.wesen@axis.com>
CC: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <Pine.LNX.4.33.0205081227100.30573-100000@godzilla.axis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bjorn Wesen napisa?:
> On Wed, 8 May 2002, Martin Dalecki wrote:
> 
>>BTW> I would really love it if the cris architecture people could
>>"lend me" some small developement system for they interresting CPU.
> 
> 
> We'll consider it :) However,
> 
> 
>>This unfortunately is the somehow most wired ATA interface
>>around. Which is due to the fact that the interface cell is directly mapped to
>>some CPU registers. As a CPU design I think it's a fine approach. Don't
>>take me wrong. You save yourself the whole silicon which is needed
>>for BM access arbitration and general handling and so on... Very nice tought
>>out. But on the software side this is a bit wired, since you can't use
>>the generic I/O primitives of the arch in question.
> 
> 
> I don't see why all IDE-interfaces in the world have to be I/O-mapped just 
> because the first PC implementations used that. Sure it was an extended 
> ISA-bus but the ISA bus is long gone and we don't all run PC's anymore 
> either.

Hey I agree and anticipate the design decisions for the Cris CPU
as good and surprisingly refreshing. Like for example the whole
concept of the compacted command set and so on. They are just *cute*...
It's about a year ago I did study the public available documentation
on it.

> So the simple abstraction we need to hit IDE-bus registers is a macro or 
> inline, instead of a call of an I/O-primitive. It was too much work to 
> abstract this when I inserted the CRIS-arch IDE-driver in the first place 
> so I found a workaround but now seems like a better time..

I don't think that it's always the proper aproach for hardware
portability to do it on the "micro operation" level. That's good
for generics like inb outb. In the case of the ATA interface it's
better to do it on the "functional" level above... Just like you did
with ata_read() and ata_write() as they are called now. You can
see I picked it up and when I sort the transport method detecion/setting
out I will apply it to the other friends from the ata_read_xxx family as well.
And then we have the same aproach in the udma_ familiy I just
introduced.

> Similarily, there is no reason at all why the CPU has to do _polling_ just 
> because the IDE _bus_ is using a PIO-mode. It probably does that on legacy 
> PC's but HW designed, hrm, more optimally can use DMA. Hence the hooks for 
> the ide_func_t.

Well right now I think if you look at the IDE 58 patch you will see
that ide_func_t is a 'bit ugly', simple becouse it is introducing
just another entity to the game. We don't need it.
struct ata_chanell *is* the central entitiy for operations from
the host view. In my whole expierence as a programmer it always turned
out to be most sane to make the software design be a homological mapping
of the generalized hardware design on this level of coding.
It's just natural functions are there to serve a specific purpose.

> So I'd figure the software side really would be _easier_ to implement with 
> those assumptions about how an IDE-interface is supposed to work gone.
> 
> 
>>This makes my  cleanup of the portability layer a bit hard
>>to finish on the software side.
> 
> 
> I understand that, so lets keep the discussion going and I'll check over 
> your current cleanup.

Well please consider: iff I had access to the hardware it would possibly save
you  a lot of reading through bad english ;-).

> /Bjorn

Regards.

