Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314332AbSDRMWa>; Thu, 18 Apr 2002 08:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314333AbSDRMW3>; Thu, 18 Apr 2002 08:22:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:14609 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314332AbSDRMW2>; Thu, 18 Apr 2002 08:22:28 -0400
Message-ID: <3CBEABEF.1030009@evision-ventures.com>
Date: Thu, 18 Apr 2002 13:20:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de>	<02db01c1e498$7180c170$58dc703f@bnscorp.com>	<20020416102510.GI17043@suse.de>	<20020416200051.7ae38411.sebastian.droege@gmx.de>	<20020416180914.GR1097@suse.de>	<20020416204329.4c71102f.sebastian.droege@gmx.de>	<3CBD28D1.6070702@evision-ventures.com>	<20020417132852.4cf20276.sebastian.droege@gmx.de>	<3CBD519F.7080207@evision-ventures.com> <20020418141746.2df4a948.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege wrote:
> On Wed, 17 Apr 2002 12:42:39 +0200
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> 
>>>2.
>>>when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
>>>hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) 
>>
>> > but the problem shows up only with hdc
>>
>>Duh oh... This is actually a good hint. I will look after
>>this.
>>
>>
>>>and maybe a third problem ;)
>>>in /proc/ide/ide0/hda/tcq there is written:
>>>DMA status: not running
>>
>>This is harmless it just shows that there was no DMA transfer in flight the
>>time you have cat-ed this file.
>>
>>
>>>but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings
>>>
>>>I'll do some more testings later the day
>>
> Hi again,
> after some playing with hdparm I found something bad :(
> 
> ide_tcq_intr_timeout: timeout waiting for interrupt
> ide_tcq_intr_timeout: hwgroup not busy
> hda: invalidating pending queue
> ide_tcq_invalidate_queue: done
> 
> and then... nothing works anymore -> total lockup of the IDE system
> This happens only (?) when I put hdparm -qa1 -qA1 -qc1 -qd1 -qm16 -qu1 -qW1 /dev/hda (the same with hdb) in my bootscripts
> When I start hdparm later everything works fine first, but after a while (and when I'm under X) the IDE system is crashed
> 
> I have enabled following options:
> CONFIG_BLK_DEV_IDE_TCQ=y
> CONFIG_BLK_DEV_IDE_TCQ_FULL=y
> CONFIG_BLK_DEV_IDE_TCQ_DEFAULT=y
> CONFIG_BLK_DEV_IDE_TCQ_DEPTH=32
> 
> I hope this helps somehow but I don't know what further informations I can provide
> 
> BTW: I think we should create devfs entries for ide-scsi devices (because hdparm doesn't take scdX ;) )
> 
> Bye

I don't know whatever you have already tryed the recend patches for 2.5.8.
The problem in place is presumably fixed there (tough there are still
problems with ide-cd remaining which I'm working on right now.)

BTW>  Jens: Do you have any idea what the "sector chaing" in ide-cd is
good for?! I would love to just get rid of it alltogether!




-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort: ru_RU.KOI8-R

