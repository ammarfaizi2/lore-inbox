Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313566AbSDQLe2>; Wed, 17 Apr 2002 07:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313567AbSDQLe1>; Wed, 17 Apr 2002 07:34:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47365 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313566AbSDQLeZ>; Wed, 17 Apr 2002 07:34:25 -0400
Message-ID: <3CBD4F2F.6090308@evision-ventures.com>
Date: Wed, 17 Apr 2002 12:32:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Sebastian Droege <sebastian.droege@gmx.de>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #4
In-Reply-To: <20020415125606.GR12608@suse.de>	<02db01c1e498$7180c170$58dc703f@bnscorp.com>	<20020416102510.GI17043@suse.de>	<20020416200051.7ae38411.sebastian.droege@gmx.de>	<20020416180914.GR1097@suse.de>	<20020416204329.4c71102f.sebastian.droege@gmx.de>	<3CBD28D1.6070702@evision-ventures.com> <20020417132852.4cf20276.sebastian.droege@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege wrote:
> On Wed, 17 Apr 2002 09:48:33 +0200
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
> 
>>Sebastian Droege wrote:
>>
>>>On Tue, 16 Apr 2002 20:09:14 +0200
>>>Jens Axboe <axboe@suse.de> wrote:
>>>
>>>
>>>
>>>>On Tue, Apr 16 2002, Sebastian Droege wrote:
>>>>
>>>>
>>>>>Hi,
>>>>>just one short question:
>>>>>My hda supports TCQ but my hdb doesn't
>>>>>Is it safe to enable TCQ in kernel config?
>>>>
>>>>yes, should be safe.
>>>>
>>>>-- 
>>>>Jens Axboe
>>>>
>>>
>>>Ok it really works ;)
>>>But there's another problem in 2.5.8 with ide patches until 37 applied (they don't appear with 2.5.8 and ide patches until 35), the unexpected interrupts (look at the relevant dmesg output at the bottom). They appear with and without TCQ enabled.
>>>If you need more informations, just ask :)
>>
>>They are not a problem. They are just diagnostics for us and will
>>go away at some point in time.
> 
> Ok but there are actually 2 real problems then...
> 1.
> TCQ on hda is enabled with queue depth 32 and CONFIG_BLK_DEV_IDE_TCQ_FULL enabled
> When I do many transfers on the hard disk I get a "ide_dma_queued_start: abort (stat=d0)" after some time and the IDE system doesn't respond anymore :(
> 2.
> when I cat /proc/ide/ide1/hdc/identify I get 2 unexpected interrupts
> hdc and hdd are both cdrom drives (accessed via scsi-emulation if relevant) but the problem shows up only with hdc
> 
> and maybe a third problem ;)
> in /proc/ide/ide0/hda/tcq there is written:
> DMA status: not running
> but DMA is explicitly enabled by hdparm and shows up in /proc/ide/ide0/hda/settings

Basically right now DMA on CD-ROM devices is "disabled" due to the
fact that ide-cd.c is pasing struct packet_command through the rq->special
field. This is subject to change soon becouse I'm right now adpting ide-cd
to use the recently introduced struct ata_request stuff.
So it doesn't make much sense if you test it - becouse the issues are just well
known. However if you see an IDE xx which contains a "fix ide-cd blah blah" in
the log - I would be really glad if you could have a look in to it.

