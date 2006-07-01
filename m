Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932833AbWGALia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWGALia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 07:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWGALia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 07:38:30 -0400
Received: from tornado.reub.net ([202.89.145.182]:7336 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S932833AbWGALi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 07:38:29 -0400
Message-ID: <44A65EB7.5020201@reub.net>
Date: Sat, 01 Jul 2006 23:38:31 +1200
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 3.0a1 (Windows/20060627)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Weird RAID/SATA problem [ once was Re: 2.6.17-mm3 ]
References: <20060630105401.2dc1d3f3.akpm@osdl.org>	<44A5C1D5.20200@reub.net>	<17573.50871.307879.557218@cse.unsw.edu.au>	<44A5D079.6070505@reub.net>	<17573.55937.866300.638738@cse.unsw.edu.au>	<44A6390E.1030608@reub.net>	<17574.15295.828980.278323@cse.unsw.edu.au>	<44A64BD8.90906@reub.net> <17574.21399.979888.127483@cse.unsw.edu.au>
In-Reply-To: <17574.21399.979888.127483@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/07/2006 10:51 p.m., Neil Brown wrote:
> On Saturday July 1, reuben-lkml@reub.net wrote:
>>>> md: super_written gets error=-5, uptodate=0
>>>>
>>>> messages on the console that didn't seem to want to stop...
>>> '5' == EIO 
>>>
>>> We try to write the superblock and we get EIO - something wrong somewhere.
>>>
>>> What sort of device are we writing to here?  What controller, what
>>> driver (if you know), what drives?
>> The two raid-1 disks are the Seagate ST380817AS SATA disks on the onboard
>> controller.  The motherboard is an Intel D945GNT motherboard.  See dmesg..
>>
>>> Can you write to the device without using md?
>> Yes.
>>
> 
> So... When md writes a superblock to this device, it reliably (or
> close to reliably) gets EIO.  When mkfs writes, it works fine.
> 
> Only difference I can think of is still barriers... Does this patch
> make any difference?

You will be happy to know that yes, it does make a difference.

Applied to -mm4, RAID-1 now comes up with all arrays in sync and everything 
looking good.  Tried it twice, and both times raid-1 came up perfectly with

md0 : active raid1 sdc2[1] sda2[0]
       24410688 blocks [2/2] [UU]
       bitmap: 0/187 pages [0KB], 64KB chunk

for each md.

reuben
