Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317347AbSHENvO>; Mon, 5 Aug 2002 09:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318459AbSHENvO>; Mon, 5 Aug 2002 09:51:14 -0400
Received: from barry.mail.mindspring.net ([207.69.200.25]:58406 "EHLO
	barry.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S317347AbSHENvN>; Mon, 5 Aug 2002 09:51:13 -0400
Message-ID: <3D4E8387.3000704@mindspring.com>
Date: Mon, 05 Aug 2002 06:54:15 -0700
From: Walt H <waltabbyh@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Raid0 slowdown from 2.4.19-rc1
References: <Pine.LNX.4.33.0208050040120.15213-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, should have said more about raid arrays. Drives are partitioned 
as follows:

hda1, hdc1 = 4GB
hda2, hdc2 = Extended part - remainder of drive
hda5, hdc5 = 2GB = raid1, md0 /boot
hda6, hdc6 = ~15GB = raid0, md1 /usr
hda7, hdc7 = ~15GB = raid0, md2 /home
hda8, hdc8 = 1.5GB = raid0, /
hda9, hdc9 = remainder = swap

I agree, it seems as though you could see preempt lower performance, but 
again, I haven't seen that either. In fact, the 2.4.18 kernel I was 
using before was compiled with preempt also and showed ~68MB/Sec on md1,md2.

As for changes I may have made to .config? Nothing new. 2.4.19-rc1 
compiled with xfs and preempt worked well also. I tried looking for 
differences in raid drivers, but there were none to the raid0 driver. 
ide-pdc202xx.c contained many changes, but I'm not a kernel hacker and 
couldn't spot anything that might have affected this. Odd that it shows 
up even under hdparm. Interestingly, when testing with bonnie++, the 
overall sequential output was similar to the higher performing older 
kernels. However, creates, deletes, and rewrites were all down 
significantly.

-Walt


Mark Hahn wrote:
>>Final 2.4.19 was patched with XFS and preempt and compiled using 
> 
> 
> it's easy to imagine cases where preempt would produce lower performance,
> though I haven't seen any hard evidence of that.
> 
> 
>>cutting out preempt patches. First md1 array consists of two partitions 
>>from hda & hdc. hdparm for both drives looks fine by themselves:
> 
> 
> are they the first two partitions in hda/c?
> 
> 
>>/dev/hda:
>>  Timing buffered disk reads:  64 MB in  1.66 seconds = 38.55 MB/sec
>>/dev/hdc:
>>  Timing buffered disk reads:  64 MB in  1.65 seconds = 38.79 MB/sec
> 
> 
> such a disk will normally degrade to around half that performance
> in the tail of the disk.
> 
> 
>>/dev/md1:
>>  Timing buffered disk reads:  64 MB in  1.44 seconds = 44.44 MB/sec
>>
>>In 2.4.18 and up through 2.4.19-rc1 I saw 66-70MB/sec from this array. 
>>Starting in rc2 it dropped to the mid 40's. I've also ran bonnie++ and 
> 
> 
> nothing else changed?
> 

