Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292968AbSCWNHx>; Sat, 23 Mar 2002 08:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292971AbSCWNHo>; Sat, 23 Mar 2002 08:07:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22290 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292968AbSCWNHX>; Sat, 23 Mar 2002 08:07:23 -0500
Message-ID: <3C9C7DAD.6080501@evision-ventures.com>
Date: Sat, 23 Mar 2002 14:05:49 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Langford <jcl@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <Pine.LNX.4.10.10203222105570.12156-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> On Fri, 22 Mar 2002, Martin Dalecki wrote:
> 
> 
>>I didn't look at the issue but anyway the following is still
>>obviously wrong. hwif->index should be hwif->channel
>>
>>Anyway please note the following:
>>
>>diff -urN linux-2.5.7/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
>>--- linux-2.5.7/drivers/ide/alim15x3.c	Thu Mar 21 23:54:16 2002
>>+++ linux/drivers/ide/alim15x3.c	Fri Mar 22 02:08:58 2002
>>@@ -247,8 +247,8 @@
>>  	int s_time, a_time, c_time;
>>  	byte s_clc, a_clc, r_clc;
>>  	unsigned long flags;
>>	int port = hwif->index ? 0x5c : 0x58;
>>	int portFIFO = hwif->channel ? 0x55 : 0x54;
>>
>>The usage of hwif->index *is* wrong.
> 
> 
> I stand corrected, it is a real bug and I let it slip in from the
> ali.com.tw folks.  I recant the point and error here is mine.
> 
> However, one should note this would only be found if a person was booting
> an add-in card.  This is why it has masked its self for so long.  Now the
> much harder issue trace is the following.  So I am impressed that you
> caught this very tiny bug that would be big and messy later.  Tip of the
> hat to you.
> 
> Noting that in the special case of who/what is allowed to have access to
> "ide0/ide1" this is an onboard host and generally would have the results:
> 
>  hwif->index == hwif->channel

Yes right of course. Becouse the values in index are consecutive 0,1,2
and so on... and fortunately the channels are discriminated by
the very same values 0,1.

> If and only if the host had rights and priviledges to "ide0/ide1", would
> it be masked.
> 
> So as the previous offer still stands point to have peace again, I am
> still waiting for a reply on are going to be able to work through the
> inital bumps an bangs from the beginning.

Ehhhh beleve me or not. At least I was *never* at war with you.
There is a difference between supporting my own opinnions and
having some disagreements then making *war* at somebody :-).

(I'm a European!!!)

