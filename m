Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313760AbSDPQeE>; Tue, 16 Apr 2002 12:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313762AbSDPQeD>; Tue, 16 Apr 2002 12:34:03 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:40898 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313760AbSDPQeC>; Tue, 16 Apr 2002 12:34:02 -0400
Message-ID: <3CBC5264.5010701@antefacto.com>
Date: Tue, 16 Apr 2002 17:33:40 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <Pine.LNX.4.33.0204160857470.1244-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 16 Apr 2002, Alan Cox wrote:
> 
>>>Please use a the network block device, and teach the ndb deamon to just
>>>byteswap each word.
>>
>>You need to use loop not nbd - loopback nbd can deadlock. Byteswap as a
>>new revolutionary crypto system for the loopback driver isnt hard
> 
> 
> Even better - I did indeed miss the "security" aspect of the byteswapping
> ;)
> 
> And I know from personal experience that allowing partitioning of a
> loopback thing would certainly have made some things a _lot_ easier (ie
> not having to figure out the damn offsets in order to mount a filesystem
> on a loopback volume), so having support for partitioning would be good.

gpart is good for this:
For e.g:

$gpart -vgd partitions.img

dev(partitions.img) mss(512)

Primary partition(1)
    type: 131(0x83)(Linux ext2 filesystem)
    size: 2mb #s(4576) s(32-4607)
    chs:  (0/1/1)-(8/15/32)d (0/0/0)-(0/0/0)r
    hex:  00 01 01 00 83 0F 20 08 20 00 00 00 E0 11 00 00

Primary partition(2)
    type: 131(0x83)(Linux ext2 filesystem)
    size: 59mb #s(121856) s(4608-126463)
    chs:  (9/0/1)-(246/15/32)d (0/0/0)-(0/0/0)r
    hex:  00 00 01 09 83 0F 20 F6 00 12 00 00 00 DC 01 00

The pertinent info here is s(32-4607) & s(4608-126463).
Blocks are 512 bytes so in this e.g. the offsets for
the first and second partitions respectively are:
16384 & 2359296

> Although I do have this suspicion that that partitioning support should be
> in user space (along with all the rest of the partitioning support, but
> that's another matter and has some rather more serious backwards
> compatibility issues, of course. Is anybody still working on the new early
> initrd?).
> 
> 		Linus

Padraig.

