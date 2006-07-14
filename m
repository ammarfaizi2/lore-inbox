Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161127AbWGNPdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161127AbWGNPdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWGNPdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:33:53 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:30593 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1161122AbWGNPdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:33:52 -0400
Message-ID: <44B7B958.9030703@dgreaves.com>
Date: Fri, 14 Jul 2006 16:33:44 +0100
From: David Greaves <david@dgreaves.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Mark Lord <liml@rtr.ca>,
       Jeff Garzik <jgarzik@pobox.com>, Sander <sander@humilis.net>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>, htejun@gmail.com
Subject: Re: LibPATA code issues / 2.6.17.3 (What is the next step?)
References: <Pine.LNX.4.64.0602140439580.3567@p34>  <44AEB3CA.8080606@pobox.com>  <Pine.LNX.4.64.0607071520160.2643@p34.internal.lan>  <200607091224.31451.liml@rtr.ca>  <Pine.LNX.4.64.0607091327160.23992@p34.internal.lan>  <Pine.LNX.4.64.0607091612060.3886@p34.internal.lan>  <Pine.LNX.4.64.0607091638220.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091645480.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091704250.2696@p34.internal.lan>  <Pine.LNX.4.64.0607091802460.2696@p34.internal.lan>  <Pine.LNX.4.64.0607100958540.3591@p34.internal.lan>  <1152545639.27368.137.camel@localhost.localdomain>  <Pine.LNX.4.64.0607101145030.3591@p34.internal.lan>  <Pine.LNX.4.64.0607110926150.858@p34.internal.lan> <1152634324.18028.21.camel@localhost.localdomain> <44B57373.2030907@dgreaves.com> <Pine.LNX.4.64.0607121828290.11285@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607121828290.11285@p34.internal.lan>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> On Wed, 12 Jul 2006, David Greaves wrote:
> 
>> Alan Cox wrote:
>>> Ar Maw, 2006-07-11 am 09:28 -0400, ysgrifennodd Justin Piszcz:
>>>> Alan/Jeff/Mark,
>>>>
>>>> Is there anything else I can do to further troubleshoot this problem
>>>> now
>>>> that we have the failed opcode(s)?  Again, there is never any
>>>> corruption
>>>> on these drives, so it is more of an annoyance than anything else.
>>>
>>> Nothing strikes me so far other than the data not making sense. Possibly
>>> it will become clearer later if/when we see other examples.
>>
>> For me it's SMART related.
>>
>> smartctl -data -o on /dev/sda reliably gets a similar message.
>> Justin - does this smartctl command trigger a message for you?
>>
>> I've been mailing on and off since January-ish.
>> (http://marc.theaimsgroup.com/?l=linux-ide&w=2&r=7&s=libpata&q=b)
>>
>> Back in March I was running 2.6.16 (with a different version of Mark's
>> opcode patch) and I sent an email with the following info:
>>
> Unfortunately not, the correct patch you need is attached to get the
> ata_op code, against 2.6.17.3.

[mutter, mutter, getting a teeny bit fed up with applying the same
diagnostic patch (thanks Mark) and reporting this and getting no real
feedback (apart from Erik - ta - who was off base, it doesn't appear to
be BIOS and here's the pair of commands :) ... Ok, added Tejun to the
list since he's been doing EH for libata and this is some kind of E that
needs better H]

2.6.17.3 with op-code patch

smartctl -data --smart=on /dev/sda
no dmesg output
smartctl -data -o on /dev/sda
dmesg:
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }
ata1: PIO error
ata_gen_ata_desc_sense: failed ata_op=0xb0
ata1: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata_gen_ata_desc_sense: failed ata_op=0x51
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x04 { DriveStatusError }

David

-- 
