Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264463AbRGNRik>; Sat, 14 Jul 2001 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264447AbRGNRib>; Sat, 14 Jul 2001 13:38:31 -0400
Received: from geos.coastside.net ([207.213.212.4]:48344 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S264433AbRGNRiK>; Sat, 14 Jul 2001 13:38:10 -0400
Mime-Version: 1.0
Message-Id: <p05100307b7762dc5d8ad@[207.213.214.37]>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
In-Reply-To: <E15LL3Y-0000yJ-00@the-village.bc.nu>
Date: Sat, 14 Jul 2001 10:33:44 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, andrewm@uow.edu.au (Andrew Morton)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [PATCH] 64 bit scsi read/write
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        adilger@turbolinux.com (Andreas Dilger),
        acahalan@cs.uml.edu (Albert D. Cahalan), bcrl@redhat.com (Ben LaHaise),
        kernel@ragnark.vestdata.no (Ragnar Kjxrstad),
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:45 AM +0100 2001-07-14, Alan Cox wrote:
>  > If, after a power outage, the IDE disk can keep going for long enough
>>  to write its write cache out to the reserved vendor area (which will
>>  only take 20-30 milliseconds) then the data may be considered *safe*
>>  as soon as it hits writecache.
>
>Hohohoho.
>
>>  In which case it is perfectly legitimate and sensible for the drive
>>  to ignore flush commands, and to ack data as soon as it hits cache.
>
>Since the flushing commands are 'optional' it can legitimately ignore them
>
>>  If I'm right then the only open question is: which disks do and
>>  do not do the right thing when the lights go out.
>
>As far as I can tell none of them at least in the IDE world

It's not so great in the SCSI world either. Here's a bit from the 
Ultrastar 73LZX functional spec (this is the current-technology 
Ultra160 73GB family):

>5.0 Data integrity
>The drive retains recorded information under all non-write operations.
>No more than one sector will be lost by power down during write 
>operation while write cache is
>disabled.
>If power down occurs before completion of data transfer from write 
>cache to disk while write cache is
>enabled, the data remaining in write cache will be lost. To prevent 
>this data loss at power off, the
>following action is recommended:
>* Confirm successful completion of SYNCHRONIZE CACHE (35h) command.

What's worse, though the spec is not explicit on this point, it 
appears that the write cache is lost on a SCSI reset, which is 
typically used by drivers for last-resort error recovery. And of 
course a SCSI bus reset affects all the drives on the bus, not just 
the offending one.
-- 
/Jonathan Lundell.
