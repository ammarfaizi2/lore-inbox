Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315800AbSEEBB0>; Sat, 4 May 2002 21:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315801AbSEEBBZ>; Sat, 4 May 2002 21:01:25 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31498 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315800AbSEEBBY>; Sat, 4 May 2002 21:01:24 -0400
Message-ID: <3CD475A1.7070809@evision-ventures.com>
Date: Sun, 05 May 2002 01:58:25 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.13 IDE and preemptible kernel problems
In-Reply-To: <Pine.LNX.4.44.0205031110550.1602-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Fri, 3 May 2002, Martin Dalecki wrote:
> 
> 
>>Uz.ytkownik Andi Kleen napisa?:
>>
>>>Hi,
>>>
>>>When booting an preemptible kernel 2.5.13 kernel on x86-64 I get
>>>very quickly an scheduling in interrupt BUG. It looks like the
>>>preempt_count becomes 0 inside the ATA interrupt handler. This
>>>could happen when save_flags/restore_flags and friends are unmatched
>>>and you have too many flags restores in IDE.
>>
>>Thank you for pointing out. I will re check it.
> 
> 
> Martin, may I suggest that the next line of cleanups should be to remove
> all vestiges of the old global interrupt locking from the IDE driver?

Right agreed. I forgot that this is just presumably a "workaround
for borken hardware", which in fact is a long standing workarodund
for driver reentrancy problems.

> Including, for example, the crap "PCI method 1" access stuff in CMD640x..

Naj... I could try.

> Also, if you turn on spinlock debugging, that tends to help find the
> really silly things faster (leaving the harder races to be solved by
> brainforce ;)

Indeed... thank you for this hint.

