Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSEHL2N>; Wed, 8 May 2002 07:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313118AbSEHL2M>; Wed, 8 May 2002 07:28:12 -0400
Received: from [195.63.194.11] ([195.63.194.11]:16136 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313087AbSEHL2L>; Wed, 8 May 2002 07:28:11 -0400
Message-ID: <3CD8FCFF.2080008@evision-ventures.com>
Date: Wed, 08 May 2002 12:25:03 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
In-Reply-To: <20020508111256.27246@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Benjamin Herrenschmidt napisa?:
> (resent, I had the date screwed up previously, sorry about the
> inconvenience).
> 
> 
>>I don't see why all IDE-interfaces in the world have to be I/O-mapped just 
>>because the first PC implementations used that. Sure it was an extended 
>>ISA-bus but the ISA bus is long gone and we don't all run PC's anymore 
>>either.
>>
>>So the simple abstraction we need to hit IDE-bus registers is a macro or 
>>inline, instead of a call of an I/O-primitive. It was too much work to 
>>abstract this when I inserted the CRIS-arch IDE-driver in the first place 
>>so I found a workaround but now seems like a better time..
> 
> 
> No, not a macro. There are cases where you want different access methods
> on the same machine. For example, pmacs can have the "mac-io" (ide-pmac)
> controller, which is MMIO based, _and_ a PCI-based legacy IDE controller
> using inx/outx like IOs. (A typical example is the Blue&White G3 who has
> both on the motherboard).
> 
> Ultimately, you want the hwif (or what it becomes in 2.5) provide a set
> of functions for accessing taskfile registers and doing the PIO data
> stream read/writes (that is replace inb/outb and insw/outsw).

Terminology in 2.5:
We have a host chip set or shortly a host chip. This is implementing the
ATA interface on the side of the motherboard.
The host chip is providing two channels. A primary and a secondary
one. To a channel we can attach two devices, however we use the term
drive instead in code becouse the termi device is quite overloaded with
meaning already. The devices are enumerated as units. That's it.
Far more natural then hwif hwgrp and so on. IDE is the Integrated Device
Electronic - the microcontroller stuff I don't care that much about.



