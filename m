Return-Path: <linux-kernel-owner+w=401wt.eu-S1161020AbXALVka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbXALVka (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 16:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbXALVka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 16:40:30 -0500
Received: from lucidpixels.com ([66.45.37.187]:57787 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161020AbXALVk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 16:40:29 -0500
Date: Fri, 12 Jan 2007 16:40:27 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1:
 (211MB/s read & 195MB/s write)
In-Reply-To: <200701130000.48717.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0701121628100.3655@p34.internal.lan>
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
 <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan>
 <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan> <200701130000.48717.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2007, Al Boldi wrote:

> Justin Piszcz wrote:
> > Btw, max sectors did improve my performance a little bit but
> > stripe_cache+read_ahead were the main optimizations that made everything
> > go faster by about ~1.5x.   I have individual bonnie++ benchmarks of
> > [only] the max_sector_kb tests as well, it improved the times from
> > 8min/bonnie run -> 7min 11 seconds or so, see below and then after that is
> > what you requested.
> >
> > # echo 3 > /proc/sys/vm/drop_caches
> > # dd if=/dev/md3 of=/dev/null bs=1M count=10240
> > 10240+0 records in
> > 10240+0 records out
> > 10737418240 bytes (11 GB) copied, 399.352 seconds, 26.9 MB/s
> > # for i in sde sdg sdi sdk; do   echo 192 >
> > /sys/block/"$i"/queue/max_sectors_kb;   echo "Set
> > /sys/block/"$i"/queue/max_sectors_kb to 192kb"; done
> > Set /sys/block/sde/queue/max_sectors_kb to 192kb
> > Set /sys/block/sdg/queue/max_sectors_kb to 192kb
> > Set /sys/block/sdi/queue/max_sectors_kb to 192kb
> > Set /sys/block/sdk/queue/max_sectors_kb to 192kb
> > # echo 3 > /proc/sys/vm/drop_caches
> > # dd if=/dev/md3 of=/dev/null bs=1M count=10240
> > 10240+0 records in
> > 10240+0 records out
> > 10737418240 bytes (11 GB) copied, 398.069 seconds, 27.0 MB/s
> >
> > Awful performance with your numbers/drop_caches settings.. !
> 
> Can you repeat with /dev/sda only?
> 
> With fresh reboot to shell, then:
> $ cat /sys/block/sda/queue/max_sectors_kb
> $ echo 3 > /proc/sys/vm/drop_caches
> $ dd if=/dev/sda of=/dev/null bs=1M count=10240
> 
> $ echo 192 > /sys/block/sda/queue/max_sectors_kb
> $ echo 3 > /proc/sys/vm/drop_caches
> $ dd if=/dev/sda of=/dev/null bs=1M count=10240
> 
> $ echo 128 > /sys/block/sda/queue/max_sectors_kb
> $ echo 3 > /proc/sys/vm/drop_caches
> $ dd if=/dev/sda of=/dev/null bs=1M count=10240
> 
> > What were your tests designed to show?
> 
> A problem with the block-io.
> 
> 
> Thanks!
> 
> --
> Al
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Here you go:

For sda-- (is a 74GB raptor only)-- but ok.

# uptime
 16:25:38 up 1 min,  3 users,  load average: 0.23, 0.14, 0.05
# cat /sys/block/sda/queue/max_sectors_kb
512
# echo 3 > /proc/sys/vm/drop_caches
# dd if=/dev/sda of=/dev/null bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 150.891 seconds, 71.2 MB/s
# 


# 
# 
# echo 192 > /sys/block/sda/queue/max_sectors_kb
# echo 3 > /proc/sys/vm/drop_caches
# dd if=/dev/sda of=/dev/null bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 150.192 seconds, 71.5 MB/s
# echo 128 > /sys/block/sda/queue/max_sectors_kb
# echo 3 > /proc/sys/vm/drop_caches
# dd if=/dev/sda of=/dev/null bs=1M count=10240
10240+0 records in
10240+0 records out
10737418240 bytes (11 GB) copied, 150.15 seconds, 71.5 MB/s


Does this show anything useful?


Justin.
