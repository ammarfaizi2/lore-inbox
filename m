Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSCIWKE>; Sat, 9 Mar 2002 17:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292963AbSCIWJy>; Sat, 9 Mar 2002 17:09:54 -0500
Received: from [195.63.194.11] ([195.63.194.11]:62732 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292957AbSCIWJl>; Sat, 9 Mar 2002 17:09:41 -0500
Message-ID: <3C8A87DF.7020407@evision-ventures.com>
Date: Sat, 09 Mar 2002 23:08:31 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend support for IDE
In-Reply-To: <20020308180204.GA7035@elf.ucw.cz> <E16jPEs-00073F-00@the-village.bc.nu> <20020309210319.GA691@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

> Wake from S3 or S4 should look like power-up from disks perspective. I
> should need no commands to do that.
> 
> Restoring right UDMA mode... Well, I'll need to do that,
> probably. (What I have there is just enough to prevent disk
> corruption. I'm still likely to see some bus resets, but no longer
> data loose, I believe.)

Yeep. But doing this will only be possible in few weeks, when
the corresponding setup code is really modularized and note
the current "ifdef whatever" buch of collected fixes.
However for certain your patch is a starting point and
we are in odd series anyway...

>>The suspend order similarly is important - finish the current
>>command,
>>
> 
> The while loop above should make sure no command is happening just
> now, right?

Beware of the long houl interrupts found by ide_add_timer

>>then flush the disk cache, then when it completes you can tell the
>>drive
>>
> 
> Disks that need cache flush are broken, anyway -- they lied us on
> command completion -- right?

;-)... And the games they wan't to play on the data registers are
silly as well... if you ask me... well personally they are running
directly into a "backword compatibility to our own mistakes" trap.
The only comparable thing to this was the QIC interfaces abusing the
floppy disk stepper line for *serial* command transfer.

