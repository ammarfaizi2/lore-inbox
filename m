Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTAXScX>; Fri, 24 Jan 2003 13:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTAXScX>; Fri, 24 Jan 2003 13:32:23 -0500
Received: from dial-ctb05175.webone.com.au ([210.9.245.175]:11529 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S261908AbTAXScW>;
	Fri, 24 Jan 2003 13:32:22 -0500
Message-ID: <3E3188EB.4050807@cyberone.com.au>
Date: Sat, 25 Jan 2003 05:41:47 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: David Mansfield <lkml@dm.cobite.com>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59mm5, raid1 resync speed regression.
References: <Pine.LNX.4.44.0301241311350.32240-100000@admin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mansfield wrote:

>>David Mansfield wrote:
>>
>>
>>>Hi Andrew, list,
>>>
>>>I'm booting 2.5.59mm5 to run a database workload benchmark that I've been
>>>running against various kernels.  I'll post those results if they are
>>>interesting later, but I did notice that the raid1 resync is proceeding at
>>>half the speed (at best) that it usually does (vs. 2.5.59 that is).
>>>
>>>It currently at about 4-8 mb/sec (and falling as resync progresses),
>>>usually at 12-15 mb/sec.
>>>
>>>System is SMP 2xPIII 866mhz, 2GB ram, raid1 is two 15k U160 (running only
>>>an Ultra speed :-( because the onboard controller sucks) SCSI disks, same
>>>channel on aic7xxx.
>>>
>>>Kernel is 2.5.59-mm5 compiled with gcc version 2.96 20000731 (Red Hat 
>>>Linux 7.3 2.96-112)
>>>
>>>David
>>>
>>>
>>Thanks for the report. Please do post any results you get.
>>
>>What disk workload exactly does a RAID1 resync consist of?
>>
>>
>
>Well, I don't know the internals of it, but it goes something like: 
>
>decide which half of the mirror is more current.  Read blocks from this 
>partition, write to other.  Periodically update raid-superblock or 
>something.  The partitions in my case are on separate SCSI disks.
>
>The thing about it is, it attempts to throttle the sync speed to not
>interfere too much with operation of the system (background resync could
>suck up all i/o 'cycles' and make a system unusable) by monitoring the
>amount of requests through the raid device itself.  The sysadmin can set a
>'speed limit' in /proc to control this, but I have it really high, so it
>*should* be syncing at max speed regardless of any i/o happening to the
>raid device itself.
>
>So it's a bit complicated.  You'd have to look at the code or ask someone 
>(Neil Brown) who knows more about it.
>
>.... I'm rebooting and looking at it again.  Here's something strange, if 
>I let the system sit completely idle, the resync speed increases almost to 
>the 'normal' rate, but causing any (minor) disk activity in another window 
>causes the rate to plummet for minutes.
>
>I think there's some strange interaction with the speed-limit code in the 
>raid1 resync.
>
Perhaps. I think there is something up with request expiry that might
cause a disk to choke up like this. Especially writes. I'll fix that
over the weekend if I can.

>
>
>David
>
>P.S. I'll post my benchmark date if/when available.
>
>
>  
>

