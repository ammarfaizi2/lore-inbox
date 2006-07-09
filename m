Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161150AbWGIVF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161150AbWGIVF5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161152AbWGIVF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:05:57 -0400
Received: from lucidpixels.com ([66.45.37.187]:10420 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1161147AbWGIVF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:05:56 -0400
Date: Sun, 9 Jul 2006 17:05:55 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Mark Lord <liml@rtr.ca>
cc: Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: LibPATA code issues / 2.6.15.4 (found the opcode=0x35)!
In-Reply-To: <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <44AEB3CA.8080606@pobox.com>
 <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan> <200607091224.31451.liml@rtr.ca>
 <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>
 <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>
 <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>
 <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Justin Piszcz wrote:

>
>
> On Sun, 9 Jul 2006, Justin Piszcz wrote:
>
>> I made my own patch (following Mark's example) but also added that printk 
>> in that function.
>> 
>> Jul  9 16:37:52 p34 kernel: [4294810.556000] ata_gen_fixed_sense: failed 
>> ata_op=0x35
>> Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: translated ATA stat/err 
>> 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> Jul  9 16:37:52 p34 kernel: [4294810.556000] ata_gen_ata_desc_sense: failed 
>> ata_op=0x51
>> Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: status=0x51 { DriveReady 
>> SeekComplete Error }
>> Jul  9 16:37:52 p34 kernel: [4294810.556000] ata4: error=0x04 { 
>> DriveStatusError }
>> 
>> Now that we have found the ata_op code of 0x35, what does this mean?  Is it 
>> generated from a bad FUA/unsupported command from the kernel/SATA driver?
>> 
>> Justin.
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 
>
> In /usr/src/linux/include/linux/ata.h:
>
>  ATA_CMD_WRITE_EXT = 0x35,
>
> Perhaps these drives do not support this command or do not support it 
> properly?
>
> Any idea, Jeff/Alan?
>
> Justin.
>
>

Here are all the errors (when reading/writing heavily):

[4294810.556000] ata_gen_fixed_sense: failed ata_op=0x35
[4294810.556000] ata4: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4294810.556000] ata_gen_ata_desc_sense: failed ata_op=0x51
[4294810.556000] ata4: status=0x51 { DriveReady SeekComplete Error }
[4294810.556000] ata4: error=0x04 { DriveStatusError }
[4295514.668000] ata_gen_fixed_sense: failed ata_op=0x35
[4295514.668000] ata3: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 
0xb/00/00
[4295514.668000] ata_gen_ata_desc_sense: failed ata_op=0x51
[4295514.668000] ata3: status=0x51 { DriveReady SeekComplete Error }
[4295514.668000] ata3: error=0x04 { DriveStatusError }

Jeff/Mark, from these errors can we reach a consensus as to the cause of 
these errors and how to eliminate the problem?

Thanks,

Justin.
