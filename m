Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbWE1W5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbWE1W5R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWE1W5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 18:57:17 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:39887 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751015AbWE1W5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 18:57:17 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
Date: Mon, 29 May 2006 08:57:08 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <0p9k72l0tjpe0bg5mc8vept9dor17r9d1t@4ax.com>
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com> <4479925C.2070909@rtr.ca>
In-Reply-To: <4479925C.2070909@rtr.ca>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2006 08:06:52 -0400, Mark Lord <lkml@rtr.ca> wrote:

>Grant Coady wrote:
>> Hi there,
>> 
>> Have an old Thinkpad 365X laptop that 'hdparm -i' tells me is 
>> running mdma2 but it refuses to set dma mode.  2.6.16.18 also 
>> refuses to set dma.
>...
>
>No luck with "hdparm -d1 /dev/hda" ??

~# hdparm -d1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Operation not permitted
 using_dma    =  0 (off)

2.6.16.18 gives the same result, am I supposed to try hdparm -d1 
early in the startup scripts, before / gets remounted rw?

>> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>> PIIXa: IDE controller at PCI slot 00:01.0
>> PIIXa: chipset revision 2
>> PIIXa: not 100% native mode: will probe irqs later
>> PIIXa: neither IDE port enabled (BIOS)
>> hda: TOSHIBA MK6014MAP, ATA DISK drive
>> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>> hda: attached ide-disk driver.
>> hda: host protected area => 1
>> hda: 11733120 sectors (6007 MB), CHS=776/240/63
>> Partition check:
>>  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
>...
>
>Mmm.. there's a curious line: "PIIXa: neither IDE port enabled (BIOS)".
>Can you enable DMA in the BIOS?

The IBM pretty BIOS with a bird shaped mouse pointer flapping wings 
as it moves?  ;)  No, the BIOS hasn't much config options.

Installed the ms-dos PS2 utility, no joy there either:
PS2 DISK sets HDD idle standby delay in minutes
PS2 DMA selects DMA channel for audio and printer

Nothing looks like HDD DMA enable in there.  Same HDD in another 
box via IDE adapter does udma2 (well, it wanted to go faster but 
I slowed it down with hdparm -X to suit the HDD spec.).

>  The IDE driver seems to be unwilling
>to set up the bus-master DMA (BMDMA) portion of the chip unless
>it was already initialized by the BIOS (paranoia, I suppose, or maybe a bug).

Perhaps a buglet, why I cc'd Alan.  I'll check if 2.6.17-rc5 boots 
on the thing...

Thanks,
Grant.
