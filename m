Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752275AbWCEMlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbWCEMlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 07:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751712AbWCEMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 07:41:32 -0500
Received: from lucidpixels.com ([66.45.37.187]:64969 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750798AbWCEMlb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 07:41:31 -0500
Date: Sun, 5 Mar 2006 07:41:29 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: David Greaves <david@dgreaves.com>
cc: Mark Lord <lkml@rtr.ca>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <Pine.LNX.4.64.0603050637110.30164@p34>
Message-ID: <Pine.LNX.4.64.0603050740500.3116@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 5 Mar 2006, Justin Piszcz wrote:

> On Wed, 1 Mar 2006, David Greaves wrote:
>
>> David Greaves wrote:
>> 
>>> Mark Lord wrote:
>>> 
>>> 
>>> 
>>>> By the way, the latest 2.6.16-rc5-git4 is available,
>>>> and has FUA turned off by default now.  So it should
>>>> work with your drives, and *you* are expected to verify
>>>> that for us all now.
>>>> 
>>>> 
>>> Yeah, I know - I've got it on the machine... but it's my wife's machine.
>>> I've asked nicely but she's editing a Hercule Poirot video so I'm not
>>> allowed to reboot it for a while...
>>> 
>>> I've told her I'm not making pancakes until I've tested it so expect a
>>> report Real Soon Now...
>>> 
>>> 
>> OK that worked (the pancakes - the kernel's not doing so well...)
>> 
>> haze:~# uname -a
>> Linux haze 2.6.16-rc5-git4 #2 PREEMPT Wed Mar 1 19:07:58 UTC 2006 i686
>> GNU/Linux
>> 
>> The boot is pretty clean.
>> I ran an xfs_repair -n on the lvm volume and got the following errors.
>> The repair reported a clean filesystem and the drive was not booted from
>> the raid so that's a big improvement.
>> 
>> I was not able to trigger similar messages on ata1 but a simple dd
>> doesn't trigger the messages on ata2 either (and for various reasons,
>> xfs_repair wouldn't run on ata1 - I thought I'd leave it and report this
>> first)
>> 
>> ata2: translated ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: error=0x04 { DriveStatusError }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> ata2: no sense translation for status: 0x51
>> ata2: translated ATA stat/err 0x51/00 to SCSI SK/ASC/ASCQ 0x3/11/04
>> ata2: status=0x51 { DriveReady SeekComplete Error }
>> 
>> David
>> 
>> -- 
>> 
>
> Using 2.6.16-rc5-git4 and removing a directory of around 5.0GB of files while 
> streaming a 1MB/s video stream on another (SATA disk), the I/O seemed to 
> freeze up for a moment and I got this error:
>
> [4342671.839000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x22
>
> Only 1 in dmesg, any idea what causes this error?
>
>

The drive it occured on was a 74GB raptor on an ICH5 controller.

[4294673.245000]   Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
0000:00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA 
Controller (rev 02)


