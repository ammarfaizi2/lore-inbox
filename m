Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWGGTTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWGGTTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWGGTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 15:19:53 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:9856 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932275AbWGGTTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 15:19:52 -0400
Message-ID: <44AEB3CA.8080606@pobox.com>
Date: Fri, 07 Jul 2006 15:19:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Mark Lord <liml@rtr.ca>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <200607070908.44751.liml@rtr.ca> <Pine.LNX.4.64.0607070923130.4099@p34.internal.lan> <200607070943.17957.liml@rtr.ca> <Pine.LNX.4.64.0607071035310.5153@p34.internal.lan> <Pine.LNX.4.64.0607071452540.14371@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607071452540.14371@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> 
> 
> On Fri, 7 Jul 2006, Justin Piszcz wrote:
> 
>>
>>
>> On Fri, 7 Jul 2006, Mark Lord wrote:
>>
>>> Justin Piszcz wrote:
>>>>
>>>> had to change
>>>>
>>>> KERN_WARN -> KERN_WARNING
>>>>
>>>> then more errors
>>>
>>> Eh?  After fixing the KERN_WARN -> KERN_WARNING part,
>>> the patch compiles / links cleanly here on 2.6.17.
>>> (fixed copy below).   Still untested, though.
>>>
>>>> do you know who wrote the original patch?
>>>
>>> I did.
>>>
>>> Cheers
>>>
>>> --- linux/drivers/scsi/libata-scsi.c.orig    2006-06-19 
>>> 10:37:03.000000000 -0400
>>> +++ linux/drivers/scsi/libata-scsi.c    2006-07-07 09:06:57.000000000 
>>> -0400
>>> @@ -542,6 +542,7 @@
>>>     struct ata_taskfile *tf = &qc->tf;
>>>     unsigned char *sb = cmd->sense_buffer;
>>>     unsigned char *desc = sb + 8;
>>> +    unsigned char ata_op = tf->command;
>>>
>>>     memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
>>>
>>> @@ -558,6 +559,7 @@
>>>      * onto sense key, asc & ascq.
>>>      */
>>>     if (tf->command & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
>>> +        printk(KERN_WARNING "ata_gen_ata_desc_sense: failed 
>>> ata_op=0x%02x\n", ata_op);
>>>         ata_to_sense_error(qc->ap->id, tf->command, tf->feature,
>>>                    &sb[1], &sb[2], &sb[3]);
>>>         sb[1] &= 0x0f;
>>>
>>
>> Mark!! It did it again, here you go:
>>
>> ==> /p34/var/log/messages <==
>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: status=0x53 { 
>> DriveReady SeekComplete Index Error }
>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: error=0x04 { 
>> DriveStatusError }
>> ==> /p34/var/log/kern.log <==
>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: translated ATA 
>> stat/err 0x53/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: status=0x53 { 
>> DriveReady SeekComplete Index Error }
>> Jul  7 10:26:06 p34 kernel: [4296869.461000] ata4: error=0x04 { 
>> DriveStatusError }
>>
>> Does this help?
>>
>> Can we eliminate the cause of these errors now?
>>
>>
> 
> Jeff or Alan,
> 
> Does that ATA translation help in determining what *bad* commands are 
> being sent to the drive?

No, it needs the patch that Mark has been posting...

	Jeff



