Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWCASMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCASMr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCASMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:12:47 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:20424 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1750759AbWCASMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:12:46 -0500
Message-ID: <4405E42B.9040804@dgreaves.com>
Date: Wed, 01 Mar 2006 18:12:59 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
In-Reply-To: <4405DDEA.7020309@rtr.ca>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> David Greaves wrote:
>
>>
>> I actually have 3 of those drives - one runs through sata_via and
>> doesn't have the same problem.
>>
>> (the sata_via ones *do* have :
>>  ata3: status=0x50 { DriveReady SeekComplete }
>>  ata3: PIO error
>> problems with SMART)
>
>
> And once again, not enough information in the error messages
> for anyone to actually do anything about it (not David's fault).
>
> What command do you use to get that bug to pop up?

(FYI I'm running 2.6.15 with both 'info' patches 'cos I'm scared of
2.6.16-rc4!)

haze:/usr/src# smartctl -data -s on /dev/sdc
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
SMART Enabled.

No messages in dmesg

haze:/usr/src# smartctl -data -o on /dev/sdc
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
Error SMART Enable Automatic Offline failed: Input/output error
Smartctl: SMART Enable Automatic Offline Failed.

dmesg contains this message repeated 31 times:
ata3: PIO error
ata3: status=0x50 { DriveReady SeekComplete }

haze:/usr/src# smartctl -data -o off /dev/sdc
succeeds but gives me:

ata3: status=0x50 { DriveReady SeekComplete }
ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }
ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }
ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x04 { DriveStatusError }

haze:/usr/src# smartctl -data -o on /dev/sdd
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=== START OF ENABLE/DISABLE COMMANDS SECTION ===
Error SMART Enable Automatic Offline failed: Input/output error
Smartctl: SMART Enable Automatic Offline Failed.

ata4: PIO error
ata4: status=0x50 { DriveReady SeekComplete }

# smartctl -data -o off /dev/sdd
ata4: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }
ata4: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
ata4: status=0x51 { DriveReady SeekComplete Error }
ata4: error=0x04 { DriveStatusError }



haze:/usr/src# hdparm --Istdout /dev/sdc

/dev/sdc:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 19457/255/63, sectors = 312581808, start = 0
0c5a 3fff c837 0010 0000 0000 003f 0000
0000 0000 334a 5332 4b53 4c33 2020 2020
2020 2020 2020 2020 0000 4000 0004 332e
3138 2020 2020 5354 3331 3630 3032 3341
5320 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 0000 0200 0200 0007 3fff 0010
003f fc10 00fb 0110 ffff 0fff 0000 0007
0003 0078 0078 00f0 0078 0000 0000 0000
0000 0000 0000 0000 0002 0000 0000 0000
007e 001b 346b 7d01 4003 3468 3c01 4003
407f 0000 0000 fefe 0000 0000 fe00 0000
0000 0000 0000 0000 9eb0 12a1 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 9eb0 12a1 9eb0 12a1 2020 0002 42b6
8000 008a 3c06 3c0a ffff 07c6 0100 0800
0ff0 1000 0002 0030 0000 0000 0000 fe06
0000 0002 0050 008a 954f 0000 0023 000b
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 7ea5


haze:/usr/src# hdparm --Istdout /dev/sdd

/dev/sdd:
 IO_support   =  0 (default 16-bit)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 24792/255/63, sectors = 398297088, start = 0
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 4234 3152 5643 3248 2020 2020
2020 2020 2020 2020 0003 4000 0004 4241
4e43 3142 5930 4d61 7874 6f72 2036 4232
3030 4d30 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0110 ffff 0fff 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 001f 0102 0000 0000 0000
00fe 001e 7c6b 7f09 4063 7c68 3e01 4063
407f 0000 0000 0000 fffe 0000 c0fe 0000
0000 0000 0000 0000 8800 17bd 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0113 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 a6a5



David

>
> BTW:
> hdparm-6.5 is now available (sourceforge),
> and should show all of the fancy features
> of your drives for comparism between versions.

OK - soonish...
