Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSG3JSw>; Tue, 30 Jul 2002 05:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSG3JSw>; Tue, 30 Jul 2002 05:18:52 -0400
Received: from [195.63.194.11] ([195.63.194.11]:5135 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S315440AbSG3JSv>;
	Tue, 30 Jul 2002 05:18:51 -0400
Message-ID: <3D465995.4090100@evision.ag>
Date: Tue, 30 Jul 2002 11:17:09 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: alan@lxorguk.ukuu.org.uk, martin@dalecki.de, linux-kernel@vger.kernel.org
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
References: <200207292018.NAA05025@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter wrote:
>>>	With this change, I believe I can remove all of the
>>>cli()...restore_flags() pairs from the channel->tuneproc functions of
>>>each IDE driver.  I have also removed what appear to be some
>>
> 
>>Some tuning locks are needed because an interrupt during the magic
>>tuning sequence will break stuff
> 
> 
> 	Let me make sure I understand your statement properly.
> 
> 	Under my patch, ch->tuneproc is called with interrupts disabled and
> ch->lock held, except when when channel_probe in drivers/ide/probe.c
> is initially trying to detect IDE hardware.  The IO ports are already
> reserved at that time, so nothing else should poke at those registers,
> but interrupts are enabled.

Right.

>
> 	That said, I think all the "lock group" logic in drivers/ide
> may be useless, and it would be pretty straightforward to delete all
> that code, have ata_channel->lock be a lock rather than a pointer to one,
> and have it be initialized before that first call to ch->tuneproc, in
> which case we could just have interrupts off and ch->lock held in all
> cases when ch->tuneproc is called.  I did not want to do this in my patch,
> because I wanted to keep my patch as small as possible, but perhaps it
> would be worth doing now just to simplify the rules for calling ch->tuneproc.

Not quite. It's not that easy becouse the same lock is used by the BIO
layer to synchronize between for example master and slave devices.
There are other problems with this but right now you can hardly do 
something about it.

> 
>>For the CMD640 please see the patch I posted. It has to use pci_lock and
>>it needs other 2.4 fixes forward porting which I did
> 
> 
> 	I had looked at it.  It looked mostly indepenent of what I was
> doing, I thought that perhaps Martin [M: do you prefer Marcin?] might
> have already integrated it and it would just cause confusion for me to
> merge the patch in, but I would be happy to include your cmd640 changes
> in my patch.

Yes - next round.

> 	Now that you've made me learn what "memory write invalidate enable"
> PCI transactions are, yes, please post or send me your diff.  If you think
> I should try to integrate.  Martin, if you have a strong preference on
> whether you want this stuff as a series of small diffs or if its OK to
> merge them into a one diff, please let me know.

Please just send me a single diff against 2.5.29 + 108 + 109 just
posted. This would make me happy. Thanks.

