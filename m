Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVKONut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVKONut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 08:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbVKONut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 08:50:49 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:32402 "EHLO
	mailrelay2.tu-graz.ac.at") by vger.kernel.org with ESMTP
	id S932513AbVKONus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 08:50:48 -0500
Message-ID: <4379E7C5.8010601@derhammer.net>
Date: Tue, 15 Nov 2005 14:51:01 +0100
From: Michael Hammer <michael@derhammer.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clemens Koller <clemens.koller@anagramm.de>, linux-kernel@vger.kernel.org
Subject: Re: Probably problem with Promise SATA Controller
References: <43750DFD.4030808@derhammer.net> <4379D505.5050608@anagramm.de>
In-Reply-To: <4379D505.5050608@anagramm.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Koller wrote:

> Hello, Michael,
>
> You use:
>
>> - Mass storage controller: Promise Technology, Inc. 
>> PDC20518/PDC40518                                  (SATAII 150 TX4)
>>      -> with 3 Seagate Cheetah 7200.8 250 GB attached
>> The SATA HDDs from Seagate are working in an array
>
>
> And you got some errors:
>
>> Nov 11 21:30:39 artemis ata3: status=0x51 { DriveReady SeekComplete 
>> Error }
>> Nov 11 21:30:39 artemis ata3: called with no error (51)!
>> Nov 11 21:30:39 artemis ata4: status=0x51 { DriveReady SeekComplete 
>> Error }
>> Nov 11 21:30:39 artemis ata4: called with no error (51)!
>> ...
>> ata4: status=0x51 { DriveReady SeekComplete Error }
>> ata4: called with no error (51)!
>> ata1: status=0x51 { DriveReady SeekComplete Error }
>> ata1: called with no error (51)!
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: called with no error (51)!
>
>
> Maybe a similar problem was mine:
> I got also errors (very rarely):
>
> Oct 30 02:45:30 rio3 kernel: hdh: dma_timer_expiry: dma status == 0x61
> Oct 30 02:45:40 rio3 kernel: hdh: DMA timeout error
> Oct 30 02:45:40 rio3 kernel: hdh: dma timeout error: status=0xd0 { Busy }
> Oct 30 02:45:40 rio3 kernel:
> Oct 30 02:45:40 rio3 kernel: ide: failed opcode was: unknown
> Oct 30 02:45:40 rio3 kernel: hdg: DMA disabled
> Oct 30 02:45:40 rio3 kernel: hdh: DMA disabled
> Oct 30 02:45:40 rio3 kernel: PDC202XX: Secondary channel reset.
> Oct 30 02:45:41 rio3 kernel: ide3: reset: success
> Oct 30 02:46:11 rio3 kernel: hdh: irq timeout: status=0xd0 { Busy }
> Oct 30 02:46:11 rio3 kernel:
> Oct 30 02:46:11 rio3 kernel: ide: failed opcode was: unknown
> Oct 30 02:46:11 rio3 kernel: PDC202XX: Secondary channel reset.
> Oct 30 02:46:12 rio3 kernel: ide3: reset: success
> Oct 30 02:46:42 rio3 kernel: hdh: irq timeout: status=0xd0 { Busy }
> [... repeating about 20 times...]
>
> On a Promise PDC20269 Ultra133 TX2 PCI-Card (parallel ATA) soft-raid
> configuration with three hard disks attached as shown below:
>
> Primary Master: Maxtor MaxLine III 300GB (UDMA 133)
> Primary Slave: Maxtor DiamondMax 9 100GB (UDMA 100)
> Secondary Master: Maxtor MaxLine III 300GB (UDMA 133)
> Secondary Slave: none
>
> The raid1 consists of the two 300GB disks.
>
> This configuration was only used to get the data from the
> 100GB disk to the raid1. By doing a simple copy & verification.
> I've checked the data several times, the data is correct.
> I know that mixing DMA modes is a bad idea, but in my case it
> was just the way to get my work done. After the copy,
> I removed the 100GB disk and since then the machine is used
> in production without any problems.
>
> Maybe there is an issue with 2+1 disks on ata or ide-channels?
>
> Best greets,
>
Hi Clemens!

I am not very experienced on all the stuff around PATA and SATA but in 
my opinion there is difference between your case (you have an explicit 
error: "DMA timeout error") and my situation.

The problem for me is the messge: "ata : called with no error (51)!" 
This means not more than libata-scsi was not able to translate the error 
message from an ATA error to a scsi error. (that is only my point of 
view...  again I am not experienced on this topic) So it is very 
difficult to me to investigate the reason for the error. I would guess 
that your error really means some kind of problem with the dma modes of 
your hdds. In my case this shouldn't be a problem because the 3 disks 
are fully identical.

I am still searching for a solution, that's the reason for ataching your 
message and posting it to the kernel mailing list. I am still hoping for 
an advice to solve this issue.

Best regards and thank you for your interest,

Michael
