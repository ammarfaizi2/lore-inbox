Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSIOV2R>; Sun, 15 Sep 2002 17:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318266AbSIOV2Q>; Sun, 15 Sep 2002 17:28:16 -0400
Received: from packet.digeo.com ([12.110.80.53]:49813 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318249AbSIOV2Q>;
	Sun, 15 Sep 2002 17:28:16 -0400
Message-ID: <3D85004E.59A4AE9F@digeo.com>
Date: Sun, 15 Sep 2002 14:49:02 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>, linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Subject: Re: Revealing benchmarks and new version of contest.
References: <1032087616.3d846840e6eb1@kolivas.net> <3D84F2D3.2FDB1368@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Sep 2002 21:33:06.0308 (UTC) FILETIME=[7A995440:01C25CFF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ..
> I'll go see if Jens' deadline-iosched-5 patch fixes it.

Can't tell. It triggers the "IDE-fails-to-deliver-IO-completion"
lockup which has been lurking around the tree for a couple of months.

#0  io_schedule () at /usr/src/25/include/asm/atomic.h:122
#1  0xc01305b4 in __lock_page (page=0xc10b6df0) at filemap.c:370
#2  0xc013164e in read_cache_page (mapping=0xc3e0e244, index=0, filler=0xc01495e0 <blkdev_readpage>, data=0x0)
    at /usr/src/25/include/linux/pagemap.h:86
#3  0xc016c352 in read_dev_sector (bdev=0xc3cf7f60, n=0, p=0xc3fcbec4) at check.c:447
#4  0xc016c764 in msdos_partition (state=0xc3cf6000, bdev=0xc3cf7f60) at msdos.c:397
#5  0xc016c016 in check_partition (hd=0xc3da6800, bdev=0xc3cf7f60) at check.c:241
#6  0xc016c134 in register_disk (disk=0xc3da6800, dev={value = 5632}, minors=64, ops=0xc0340cf0, size=120064896) at check.c:381
#7  0xc0221bb0 in idedisk_attach (drive=0xc03b0230) at ide-disk.c:1710
#8  0xc021df60 in ata_attach (drive=0xc03b0230) at ide.c:2449
#9  0xc021ed15 in ide_register_driver (driver=0xc0340de0) at ide.c:3427
#10 0xc0221bd1 in idedisk_init () at ide-disk.c:1725
#11 0xc034c8d4 in do_initcalls () at main.c:483
#12 0xc034c903 in do_basic_setup () at main.c:515

No quick fix here; this is all going to take some time to
work through :(
