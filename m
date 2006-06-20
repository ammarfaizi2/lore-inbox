Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWFTPs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWFTPs1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFTPs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:48:27 -0400
Received: from lucidpixels.com ([66.45.37.187]:8362 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751343AbWFTPs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:48:26 -0400
Date: Tue, 20 Jun 2006 11:48:24 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: LibPATA/ATA Errors Continue - Will there be a fix for this?
In-Reply-To: <200606201815.54318.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0606201148110.2601@p34.internal.lan>
References: <200606201815.54318.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006, Al Boldi wrote:

> Justin Piszcz wrote:
>> On Tue, 20 Jun 2006, Mark Lord wrote:
>>> Justin Piszcz wrote:
>>>> Should someone comment this code out that produces the printk()'s as
>>>> these are useless information as there is no problem with the disk?
>>>
>>> MMm.. probably "barrier" commands that the drive doesn't like.
>>> Pity those messages don't also dump the failed opcode.
>>>
>>>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: status=0x51 {
>>>> DriveReady SeekComplete Error }
>>>> Jun 20 03:14:20 p34 kernel: [4339456.678000] ata3: error=0x04 {
>>>> DriveStatusError }
>>>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: no sense translation
>>>> for status: 0x51
>>>> Jun 20 03:36:44 p34 kernel: [4340801.772000] ata3: status=0x51 {
>>>> DriveReady SeekComplete Error }
>>
>> Mark, what would be the proper direction to move towards?  Is Jeff or
>> another SATA/ATA maintainer going to have to look at this or is there
>> something else I can do, or?
>
> I once sent a patch to -mm:
>
> Mark Lord wrote:
>> Al Boldi wrote:
>>> Also apply this one to get rid of this message:
>>>
>>> 	hdb: set_drive_speed_status: status=0x40 { DriveReady }
>>> 	ide: failed opcode was: unknown
>>>
>>> Maybe someone on the ide list can comment on this first though.
>>>
>>> --- 16/include/linux/ide.h.orig	2006-03-31 19:12:51.000000000 +0300
>>> +++ 16/include/linux/ide.h	2006-04-23 13:06:32.000000000 +0300
>>> @@ -120,7 +120,7 @@ typedef unsigned char	byte;	/* used ever
>>>  #define IDE_BCOUNTL_REG		IDE_LCYL_REG
>>>  #define IDE_BCOUNTH_REG		IDE_HCYL_REG
>>>
>>> -#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==(good))
>>> +#define OK_STAT(stat,good,bad)	(((stat)&((good)|(bad)))==((stat)&(good)))
>>>  #define BAD_R_STAT		(BUSY_STAT   | ERR_STAT)
>>>  #define BAD_W_STAT		(BAD_R_STAT  | WRERR_STAT)
>>>  #define BAD_STAT		(BAD_R_STAT  | DRQ_STAT)
>>
>> Assuming hdb is a CDROM/optical drive, then this change makes sense for
>> that. But I don't think it is a valid (good) change for regular ATA disks.
>>
>> A more complex patch is required, one which correctly handles each drive
>> type.
>
> Thanks!
>
> --
> Al
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Did the patch get applied to -mm?
