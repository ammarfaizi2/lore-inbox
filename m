Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132405AbRDDAMi>; Tue, 3 Apr 2001 20:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132560AbRDDAMa>; Tue, 3 Apr 2001 20:12:30 -0400
Received: from ns2.auctionwatch.com ([64.14.24.2]:21773 "EHLO
	whitestar.auctionwatch.com") by vger.kernel.org with ESMTP
	id <S132405AbRDDAMV>; Tue, 3 Apr 2001 20:12:21 -0400
Message-ID: <5179B27750A9D411B968009027E06E27012D6FAB@exback.corp.auctionwatch.com>
From: "Michael S. Fischer" <michael@auctionwatch.com>
To: "'mingo@redhat.com'" <mingo@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: md driver doesn't notice disk going out
Date: Tue, 3 Apr 2001 17:12:29 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to say, we're running kernel 2.4.3 + Sistina LVM patch 0.9.1b6.

> -----Original Message-----
> From: Michael S. Fischer 
> Sent: Tuesday, April 03, 2001 5:09 PM
> To: 'mingo@redhat.com'; 'linux-kernel@vger.kernel.org'
> Subject: md driver doesn't notice disk going out
> 
> 
> Hello,
> 
> We're testing lvm over md (RAID 1) for a database 
> application.  Part of our tests include simulating failure.  
> So, we pulled the power on one of the drives, and the kernel 
> reported...
> 
> hdd: status error: status=0x00 { }
> hdd: drive not ready for command
> ...
> ide1: reset timed-out, status=0x80
> hdd: lost interrupt
> hdd: lost interrupt
> hdd: lost interrupt
> ...
> 
> However, /proc/mdstat still reports:
> 
> Personalities : [linear] [raid0] [raid1] [raid5] 
> read_ahead 1024 sectors
> md1 : active raid1 hdd[1] hdb[0]
>       19925760 blocks [2/2] [UU]
>       
> md0 : active raid1 hdc[1] hda[0]
>       19925760 blocks [2/2] [UU]
> 
> It appears the md driver just didn't bother to notice -- and 
> now all writes to the filesystem are blocked.
> 
> In case it matters, here's our lvm config:
> 
> --- Volume group ---
> VG Name               data0_vg
> VG Access             read/write
> VG Status             available/resizable
> VG #                  0
> MAX LV                256
> Cur LV                1
> Open LV               1
> MAX LV Size           255.99 GB
> Max PV                256
> Cur PV                2
> Act PV                2
> VG Size               38 GB
> PE Size               4 MB
> Total PE              9728
> Alloc PE / Size       7680 / 30 GB
> Free  PE / Size       2048 / 8 GB
> VG UUID               6XH7Nq-JL9u-cbjw-rUoP-Kx9o-hlZN-LPhdmj
> 
> --- Logical volume ---
> LV Name                /dev/data0_vg/data0_lv
> VG Name                data0_vg
> LV Write Access        read/write
> LV Status              available
> LV #                   1
> # open                 1
> LV Size                30 GB
> Current LE             7680
> Allocated LE           7680
> Stripes               2
> Stripe size (KByte)   16
> Allocation             next free
> Read ahead sectors     120
> Block device           58:0
> 
> 
> --- Physical volumes ---
> PV Name (#)           /dev/md0 (1)
> PV Status             available / allocatable
> Total PE / Free PE    4864 / 1024
> 
> PV Name (#)           /dev/md1 (2)
> PV Status             available / allocatable
> Total PE / Free PE    4864 / 1024
> 
> Please CC: me on replies.  Thanks.
> 
> --
> Michael S. Fischer / michael at auctionwatch.com / 
http://www.auctionwatch.com
Systems Engineer, AuctionWatch.com Inc. / Phone: +1 650 808 5842  
