Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUGZPer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUGZPer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 11:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUGZPer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 11:34:47 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:62701 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265805AbUGZPGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 11:06:51 -0400
Date: Mon, 26 Jul 2004 17:06:15 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Cc: kladit@t-online.de
Subject: Re: dentry cache leak? Re: rsync out of memory 2.6.8-rc2
Message-ID: <20040726150615.GA1119@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ID: rCaU1cZBQex88aABdFqOl8eiAHslL1ainEFSWX554CudmFJ0x6Z76W
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Can you narrow the onset of the problem down to any particular kernel
>snapshot?

Did it and here is the answer.

kernel-2.6.7 and bk's up to 2.6.7-bk7 survived a du -s,
kernels starting with 2.6.7-bk8 did not.


Compiler gcc-3.4.1 
System SMP 2 Xeon-CPU's
Hardware Tyan 2665 Mobo 
/disc1 is a software raid-1, mirror of two 60GB IDE disks.

To be sure to have clean conditions, I recompiled 2.6.7 and
some subsequent -bk kernels.

The configuration of each kernel is of a copy of .config from 
2.6.7 and innovations during make oldconfig were answered using
the defaults.

Some observations while du -s is running:

With the 'good' kernels there is a freeze of about a second 
when memory usage (xosview) has grown up to about 1.4 GByte.
Not using irqbalance results in very high system load of CPU0.

Gathered data follows below. Please cc me.

--
Klaus

linux-2.6.7 (good)
===========
cat /proc/sys/fs/dentry-state
7015    4538    45      0       0       0
du -s /disc1/
42119916        /disc1/
cat /proc/sys/fs/dentry-state
719959  690331  45      0       0       0

cat /proc/vmstat
nr_dirty 6
nr_writeback 0
nr_unstable 0
nr_page_table_pages 417
nr_mapped 36574
nr_slab 219486
pgpgin 822287
pgpgout 125952
pswpin 0
pswpout 0
pgalloc_high 218904
pgalloc_normal 590088
pgalloc_dma 3534
pgfree 967065
pgactivate 182625
pgdeactivate 156250
pgfault 216065
pgmajfault 2694
pgrefill_high 0
pgrefill_normal 154846
pgrefill_dma 1404
pgsteal_high 0
pgsteal_normal 81532
pgsteal_dma 483
pgscan_kswapd_high 0
pgscan_kswapd_normal 130065
pgscan_kswapd_dma 721
pgscan_direct_high 0
pgscan_direct_normal 179566
pgscan_direct_dma 2425
pginodesteal 12160
slabs_scanned 2817088
kswapd_steal 51850
kswapd_inodesteal 1888
pageoutrun 1083
allocstall 2857
pgrotated 8111

linux-2.6.7-bk6 (good)
===============
du -s /disc1/
42120684        /disc1/
cat /proc/sys/fs/dentry-state
720795  691157  45      0       0       0

cat /proc/vmstat
nr_dirty 11
nr_writeback 0
nr_unstable 0
nr_page_table_pages 459
nr_mapped 42928
nr_slab 219592
pgpgin 848899
pgpgout 135604
pswpin 0
pswpout 0
pgalloc_high 256670
pgalloc_normal 619555
pgalloc_dma 3210
pgfree 1023837
pgactivate 185293
pgdeactivate 157150
pgfault 264830
pgmajfault 3024
pgrefill_high 0
pgrefill_normal 156851
pgrefill_dma 299
pgsteal_high 0
pgsteal_normal 82775
pgsteal_dma 397
pgscan_kswapd_high 0
pgscan_kswapd_normal 126659
pgscan_kswapd_dma 457
pgscan_direct_high 0
pgscan_direct_normal 147678
pgscan_direct_dma 365
pginodesteal 6491
slabs_scanned 2800364
kswapd_steal 55007
kswapd_inodesteal 8269
pageoutrun 1147
allocstall 2225
pgrotated 8831

linux-2.6.7-bk7 (good)
===============
cat /proc/sys/fs/dentry-state
6990    4522    45      0       0       0
du -s /disc1
..
some snapshoots of /proc/sys/fs/dentry-state
761894  723814  45      0       0       0
760283  722353  45      0       0       0
759821  721937  45      0       0       0
759872  722127  45      0       0       0
759742  722079  45      0       0       0
759666  722090  45      0       0       0
757161  719829  45      0       0       0
755236  718111  45      0       0       0
755639  718584  45      0       0       0
714917  683972  45      0       0       0
716095  685185  45      0       0       0
715329  684496  45      0       0       0
..
42121188      /disc1

cat /proc/vmstat
nr_dirty 7
nr_writeback 0
nr_unstable 0
nr_page_table_pages 469
nr_mapped 43769
nr_slab 219515
pgpgin 854375
pgpgout 136916
pswpin 0
pswpout 0
pgalloc_high 265027
pgalloc_normal 621919
pgalloc_dma 3790
pgfree 1031340
pgactivate 196742
pgdeactivate 169483
pgfault 288603
pgmajfault 3068
pgrefill_high 0
pgrefill_normal 169001
pgrefill_dma 482
pgsteal_high 0
pgsteal_normal 83976
pgsteal_dma 490
pgscan_kswapd_high 0
pgscan_kswapd_normal 134412
pgscan_kswapd_dma 738
pgscan_direct_high 0
pgscan_direct_normal 175212
pgscan_direct_dma 1310
pginodesteal 3476
slabs_scanned 2826482
kswapd_steal 55611
kswapd_inodesteal 6862
pageoutrun 1214
allocstall 2734
pgrotated 8730

linux-2.6.7-bk8 (bad)
===============

cat /proc/sys/fs/dentry-state
7357    4821    45      0       0       0
du -s /disc1/
After some processes wer killed ..
cat /proc/sys/fs/dentry-state
1090719 1035089 45      0       0       0

cat /proc/vmstat
nr_dirty 26
nr_writeback 0
nr_unstable 0
nr_page_table_pages 365
nr_mapped 29495
nr_slab 219834
pgpgin 594519
pgpgout 80416
pswpin 0
pswpout 0
pgalloc_high 199307
pgalloc_normal 489087
pgalloc_dma 3711
pgfree 868142
pgactivate 94618
pgdeactivate 65790
pgfault 227492
pgmajfault 3065
pgrefill_high 0
pgrefill_normal 65694
pgrefill_dma 96
pgsteal_high 0
pgsteal_normal 46724
pgsteal_dma 337
pgscan_kswapd_high 0
pgscan_kswapd_normal 49351
pgscan_kswapd_dma 331
pgscan_direct_high 0
pgscan_direct_normal 46908
pgscan_direct_dma 41
pginodesteal 2743
slabs_scanned 1186575
kswapd_steal 39703
kswapd_inodesteal 6800
pageoutrun 323
allocstall 1088
pgrotated 1382
