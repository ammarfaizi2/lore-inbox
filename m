Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWARAbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWARAbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbWARAbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:31:35 -0500
Received: from relay.bostream.com ([81.26.227.9]:24528 "EHLO
	endeavour.mit.um.bostream.net") by vger.kernel.org with ESMTP
	id S932533AbWARAbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:31:34 -0500
Message-ID: <43CD8C64.4080909@letterboxes.org>
Date: Wed, 18 Jan 2006 01:31:32 +0100
From: =?UTF-8?B?Q2hyaXN0ZXIgQsOkY2tzdHLDtm0=?= 
	<cbackstrom@letterboxes.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.1.20060mdk (X11/20050322)
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: amd64 cdrom access locks system
References: <S1750841AbWAQXWc/20060117232242Z+104@vger.kernel.org>
In-Reply-To: <S1750841AbWAQXWc/20060117232242Z+104@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Aric Cyr <Aric.Cyr () gmail ! com> writes:
> > Bartlomiej Zolnierkiewicz <bzolnier <at> gmail.com> writes:
> 
>> 
>> On 6/14/05, Jeff Wiegley <jeffw <at> cyte.com> wrote:
>> > using "dev=/dev/hda" yeilds the exact same behavior...
>> > 
>> >    Jun 14 03:21:50 localhost kernel: ide-cd: cmd 0x3 timed out
>> >    Jun 14 03:21:50 localhost kernel: hda: lost interrupt
>> >    Jun 14 03:22:50 localhost kernel: ide-cd: cmd 0x3 timed out
>> >    Jun 14 03:22:50 localhost kernel: hda: lost interrupt
>> >    Jun 14 03:23:30 localhost kernel: hda: lost interrupt
>> 
>> Jens, any idea?
>> 
>> > And I'm a little confused by Robert's suggestion... Should it
>> > ever be possible for a user-space application to cause lost
>> > interrupts and other kernel state problems regardless of what
>> > "interface" is used?? Sure, if the application uses the wrong
>> > interface it should get spanked somehow but should it be able to
>> > mess up the kernel for other applications as well? (Like now
>> > I can't read or eject.)
>> 
>> It shouldn't be possible unless it is "raw" interface
>> (requires CAP_SYS_RAWIO) w/o checking all possible
>> parameters (it is not always possible) or device is buggy.
>> 
>> Also it is quite unlikely that somebody will fix obsolete
>> interface (hey, it got obsoleted for some reason .
>> 
>> Bartlomiej
>> 
> 
> Has this problem been fixed at all or any workarounds known?  I am having the
> exact same issue with similar hardware and the alim15x3 driver.  In my case it
> does not matter which method I use for cdrecord (ATA:, ATAPI: or dev=/dev/hda),
> I will always get the lost interrupts from the command "cdrecord -atip".  I have
> tried other drives without success so I don't believe that is the problem. 
> Interestingly cdrdao does not have any problems at all and burns perfectly, so I
> suspect that cdrecord might be throwing some command that ide-cd or the IDE
> drive doesn't like and fails to recover from.  However, disabling DMA on the
> drive via hdparm makes cdrecord work perfectly, so I suspect the alim15x3 driver
> more than anything else.  I can play DVDs for hours with DMA enabled just fine
> though... go figure.  My current kernel is 2.6.14-gentoo-r6, but I have had this
> problem since I first had got the system (around 2.6.12).

Exactly the same problems here, on a laptop (Amd64, Mandriva 2006, 
linux-2.6.15) with an:

ALi Corporation M5229 IDE (rev c7)

The cd-writer locks up if the DMA is enabled, as above. But the drive is 
usable if it is disabled.

The only other potential problem I've found is that the UDMA timings for 
the /dev/hda is "???" (see below).

----------------------------------------------
#> cat /proc/ide/ali

                                 Ali M15x3 Chipset.
                                 ------------------
PCI Clock: 0.
CD_ROM FIFO:No , CD_ROM DMA:Yes
FIFO Status: contains 1 Words, runs.

----------------primary channel---------secondary channel---------

channel status:       Off			Off
both channels togth:  Yes			Yes
Channel state:        busy			OK
Add. Setup Timing:    1T			1T
Command Act. Count:   3T			3T
Command Rec. Count:   1T			1T

----------------drive0----------drive1----------drive0----------drive1------

DMA enabled:	Yes		No		Yes		No
FIFO threshold:	4 Words		4 Words		4 Words		4 Words
FIFO mode:	FIFO Off	FIFO Off	FIFO Off	FIFO Off
Dt RW act. Cnt	3T		8T		3T		8T
Dt RW rec. Cnt	1T		16T		1T		16T

-----------------------------------UDMATimings--------------------------------

UDMA:		OK		No		OK		No
UDMA timings:	???		1.5T		2.5T		1.5T

--------------------------------------

> 
> I'm really anxious to track this down so if anyone has any information, or need
> something from me (logs or debugging) please don't hesitate to ask.
> 

The same situation here. I've seen a few reports about this behaviour 
with the alim15x3 driver before, so I just wanted to report my problems 
too. If someone has any idea what's happening I'd be glad to try out any 
patches. Please CC me, as I am not subscribed to the list.

/Chris
> Regards,
>   Aric
> 
