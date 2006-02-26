Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWBZOEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWBZOEY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 09:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWBZOEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 09:04:24 -0500
Received: from rtr.ca ([64.26.128.89]:47851 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750883AbWBZOEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 09:04:22 -0500
Message-ID: <4401B560.40702@rtr.ca>
Date: Sun, 26 Feb 2006 09:04:16 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: David Greaves <david@dgreaves.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
In-Reply-To: <44017B4B.3030900@dgreaves.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:
> Mark Lord wrote:
> 
>>> sdb: Current: sense key: Medium Error
>>>     Additional sense: Unrecovered read error - auto reallocate failed
>>> end_request: I/O error, dev sdb, sector 398283329
>>> raid1: Disk failure on sdb2, disabling device.
>>>         Operation continuing on 1 devices
..
>> The command failing above is SCSI WRITE_10, which is being
>> translated into ATA_CMD_WRITE_FUA_EXT by libata.
>>
>> This command fails -- unrecognized by the drive in question.
>> But libata reports it (most incorrectly) as a "medium error",
>> and the drive is taken out of service from its RAID.
>>
>> Bad, bad, and worse.
..
> Thanks Mark
> 
> I'm glad it's a bug and not bad hardware.
> 
> I am quite concerned that the basic effect of just booting a practically
> vanilla 2.6.16-rc4 like this was to fry my raid array.
> 
> Luckily it dropped 2 (of  3) disks so quickly that the event counter was
> the same allowing an easy rebuild.
> 
> 2.6.15 has similar issues but they seem to happen *very* infrequently by
> comparison - this hit me several times during a single boot.
> 
> Should Linus (cc'ed) hold off on 2.6.16 because of this or not?

Well, no doubt whatsoever about it being a "regression",
since the FUA code is *new* in 2.6.16 (not present in 2.6.15).

The FUA code should either get fixed, or removed from 2.6.16.

Cheers
