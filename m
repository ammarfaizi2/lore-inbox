Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWCASaM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWCASaM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWCASaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:30:12 -0500
Received: from rtr.ca ([64.26.128.89]:58294 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750728AbWCASaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:30:09 -0500
Message-ID: <4405E83D.9000906@rtr.ca>
Date: Wed, 01 Mar 2006 13:30:21 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com>
In-Reply-To: <4405E42B.9040804@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
>
> haze:/usr/src# smartctl -data -o off /dev/sdc
> succeeds but gives me:
> 
> ata3: status=0x50 { DriveReady SeekComplete }
> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x04 { DriveStatusError }
> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x04 { DriveStatusError }
> ata3: translated op=0x85 ATA stat/err 0x51/04 to SCSI SK/ASC/ASCQ 0xb/00/00
> ata3: status=0x51 { DriveReady SeekComplete Error }
> ata3: error=0x04 { DriveStatusError }

"DriveStatusError" is "Command Aborted" in ac-speak.
 From the man page for smartctl, we read:

 >-o VALUE  Enables or disables SMART automatic offline test ...
 >Note that the SMART automatic offline test command is listed as "Obsolete" in every
 >version  of  the  ATA  and ATA/ATAPI Specifications.  It was originally part of the
 >SFF-8035i Revision 2.0 specification, but was never part of any ATA  specification.

There's a chance that your drives simply do not fully support this feature,
and are rejecting attempts to use it.

By the way, the latest 2.6.16-rc5-git4 is available,
and has FUA turned off by default now.  So it should
work with your drives, and *you* are expected to verify
that for us all now.

Cheers

-ml
