Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTKOAFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 19:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbTKOAFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 19:05:49 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:54242 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S264145AbTKOAFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 19:05:46 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: 2.6.0-test9 VFAT problem
Date: Fri, 14 Nov 2003 19:05:44 -0500
User-Agent: KMail/1.5.1
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Patrick Beard <patrick@scotcomms.co.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0311142124460.14447-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0311142124460.14447-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311141905.44612.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.12.17] at Fri, 14 Nov 2003 18:05:45 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 November 2003 15:30, Maciej Zenczykowski wrote:
>> No, but here it is, on both sda and sda1:
>>
>> [root@coyote root]# dosfsck /dev/sda
>> dosfsck 2.8, 28 Feb 2001, FAT32, LFN
>> Logical sector size is zero.
>
>We've already determined that /dev/sda is the partition table and
> should thus fail.
>
>> [root@coyote root]# dosfsck /dev/sda1
>> dosfsck 2.8, 28 Feb 2001, FAT32, LFN
>> /dev/sda1: 2 files, 2/3997 clusters
>
>Hmm so it passes.
>Could you try passing -v (for verbose) to the fsck...

I could, but a much larger problem is that cups managed to self 
destruct on a reboot, and I now have no printing facility at all, and 
thats more important since I like to print my bank activities for my 
records in case things get out of synch.  However, that shouldn't 
take too much time so here goes.

[root@coyote cups-1.1.20rc6]# dosfsck -v /dev/sda1
dosfsck 2.8 (28 Feb 2001)
dosfsck 2.8, 28 Feb 2001, FAT32, LFN
Boot sector contents:
System ID "        "
Media byte 0xf8 (hard disk)
       512 bytes per logical sector
     16384 bytes per cluster
         1 reserved sector
First FAT starts at byte 512 (sector 1)
         2 FATs, 12 bit entries
      6144 bytes per FAT (= 12 sectors)
Root directory starts at byte 12800 (sector 25)
       256 root directory entries
Data area starts at byte 20992 (sector 41)
      3997 data clusters (65486848 bytes)
32 sectors/track, 8 heads
        55 hidden sectors
    127945 sectors total
Checking for unused clusters.
/dev/sda1: 2 files, 2/3997 clusters
------------------------
The card is now empty, so that looks reasonable to me.  But what do I 
know about a messydos filesystem?  Zilch is what...


>Also perhaps just do
>  cat /dev/sda1 > /tmp/file
>  dosfsck -v /tmp/file
>  mount -o loop /tmp/file /mnt/somewhere
>and see if that fails, if so the bug is pure vfat
>then try bzipping the /tmp/file and posting it somewhere and pass
> the link and I'll take a look...
>
>> That first one doesn't look kosher to me!
>> Q: Is FAT32 the same as VFAT?
>
>FAT32 is one possibility of VFAT - VFAT is any FAT(12,16,32) with
> long filenames.
>
>Cheers,
>MaZe.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

