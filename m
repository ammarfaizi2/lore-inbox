Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWB0Ved@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWB0Ved (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 16:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWB0Ved
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 16:34:33 -0500
Received: from rtr.ca ([64.26.128.89]:1695 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751254AbWB0Vec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 16:34:32 -0500
Message-ID: <4403704E.4090109@rtr.ca>
Date: Mon, 27 Feb 2006 16:34:06 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>
In-Reply-To: <4401B560.40702@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
>> Mark Lord wrote:
>>
>>>> sdb: Current: sense key: Medium Error
>>>>     Additional sense: Unrecovered read error - auto reallocate failed
>>>> end_request: I/O error, dev sdb, sector 398283329
>>>> raid1: Disk failure on sdb2, disabling device.
>>>>         Operation continuing on 1 devices
> ..
>>> The command failing above is SCSI WRITE_10, which is being
>>> translated into ATA_CMD_WRITE_FUA_EXT by libata.
>>>
>>> This command fails -- unrecognized by the drive in question.
>>> But libata reports it (most incorrectly) as a "medium error",
>>> and the drive is taken out of service from its RAID.
>>>
>>> Bad, bad, and worse.

.. hold off on 2.6.16 because of this or not?

> 
> Well, no doubt whatsoever about it being a "regression",
> since the FUA code is *new* in 2.6.16 (not present in 2.6.15).
> 
> The FUA code should either get fixed, or removed from 2.6.16.

Actually, now that I've done a little more digging, this FUA stuff
is inherently dangerous as implemented.  A least a few SATA controllers
including pipelines and whatnot that rely upon recognizing the (S)ATA
opcodes being using.  And I sincerely doubt that any of those will
recognize the very newish (and aptly named..) FUA opcodes.

These may be unsafe in general, unless we tag controllers as
FUA-capable and NON-FUA-capable, in addition to tagging the drives.

:/
