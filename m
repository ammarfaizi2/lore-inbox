Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSE3MAd>; Thu, 30 May 2002 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314707AbSE3MAc>; Thu, 30 May 2002 08:00:32 -0400
Received: from spook.vger.org ([213.204.128.210]:16290 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S314548AbSE3MAb>; Thu, 30 May 2002 08:00:31 -0400
Date: Thu, 30 May 2002 14:37:53 +0200 (CEST)
From: me@vger.org
To: linux-kernel@vger.kernel.org
cc: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Strange RAID2 behavier...
In-Reply-To: <Pine.LNX.4.21.0205301353210.16022-100000@kenny.worldonline.se>
Message-ID: <Pine.LNX.4.21.0205301435390.20123-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made the md2 a linear raid of one drive, now I can stop the md3.
This means that for example making md0 and md3 will make md3 unstoppable,
has this bug already been reported?

----- new raidtab -----
raiddev /dev/md0
        raid-level                      0
        nr-raid-disks                   2
        persistent-superblock           1
        chunk-size                      4
        device                          /dev/hde1
        raid-disk                       0
        device                          /dev/hdi1
        raid-disk                       1

raiddev /dev/md1
        raid-level                      0
        nr-raid-disks                   2
        persistent-superblock           1
        chunk-size                      4
        device                          /dev/hdf1
        raid-disk                       0
        device                          /dev/hdj1
        raid-disk                       1

raiddev /dev/md2
        raid-level                      linear
        nr-raid-disks                   1
        persistent-superblock           1
        chunk-size                      4
        device                          /dev/hdk1
        raid-disk                       0

raiddev /dev/md3
        raid-level                      0
        nr-raid-disks                   2
        persistent-superblock           1
        chunk-size                      4
        device                          /dev/hdh1
        raid-disk                       0
        device                          /dev/hdl1
        raid-disk                       1
-------------------------

On Thu, 30 May 2002 me@vger.org wrote:

> Ive got strange raid2 behaiver happening, ive got this raidtab:
> 
> ----- raidtab -----
> raiddev /dev/md0
>         raid-level                      0
>         nr-raid-disks                   2
>         persistent-superblock           1
>         chunk-size                      8
>         device                          /dev/hde1
>         raid-disk                       0
>         device                          /dev/hdi1
>         raid-disk                       1
> 
> raiddev /dev/md1
>         raid-level                      0
>         nr-raid-disks                   2
>         persistent-superblock           1
>         chunk-size                      8
>         device                          /dev/hdf1
>         raid-disk                       0
>         device                          /dev/hdj1
>         raid-disk                       1
> 
> # not in use right now
> #raiddev /dev/md2
> #       raid-level                      0
> #       nr-raid-disks                   2
> #       persistent-superblock           1
> #       chunk-size                      8
> #       device                          /dev/hdg1
> #       raid-disk                       0
> #       device                          /dev/hdk1
> #       raid-disk                       1
> 
> raiddev /dev/md3
>         raid-level                      0
>         nr-raid-disks                   2
>         persistent-superblock           1
>         chunk-size                      8
>         device                          /dev/hdh1
>         raid-disk                       0
>         device                          /dev/hdl1
>         raid-disk                       1
> ----- raidtab -----
> 
> Im missing one disk on the md2 so im not using that right now but that
> should not affect the raid2 or make this happen:
> 
> # raidstop --all /dev/md3
> /dev/md3: Device or resource busy
> 
> # cat /proc/mdstat 
> Personalities : [linear] [raid0] [raid1] [raid5] [multipath] 
> read_ahead 1024 sectors
> md3 : active raid0 hdl1[1] hdh1[0]
>       240688000 blocks 8k chunks
>       
> unused devices: <none>
> 
> md0 and md1 gets turned off just fine, but not md3 ????
> 
> I will try and rebuild the raid and mode md3 disks to md2 and see what
> happens.
> 
> # uname -a
> Linux odd 2.4.19-pre9 #1 SMP Wed May 29 08:46:00 CEST 2002 i686 unknown
> 
> There is no new 2.4.19-pre patch out from what i can find.
> 
> Thanks in advance for the help.
> 
> 
> 

