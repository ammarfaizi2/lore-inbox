Return-Path: <linux-kernel-owner+w=401wt.eu-S1030498AbXALU7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbXALU7R (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbXALU7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:59:17 -0500
Received: from [212.12.190.123] ([212.12.190.123]:33304 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030487AbXALU7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:59:16 -0500
From: Al Boldi <a1426z@gawab.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1: (211MB/s read & 195MB/s write)
Date: Sat, 13 Jan 2007 00:00:48 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan> <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan> <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701130000.48717.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Btw, max sectors did improve my performance a little bit but
> stripe_cache+read_ahead were the main optimizations that made everything
> go faster by about ~1.5x.   I have individual bonnie++ benchmarks of
> [only] the max_sector_kb tests as well, it improved the times from
> 8min/bonnie run -> 7min 11 seconds or so, see below and then after that is
> what you requested.
>
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/md3 of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 399.352 seconds, 26.9 MB/s
> # for i in sde sdg sdi sdk; do   echo 192 >
> /sys/block/"$i"/queue/max_sectors_kb;   echo "Set
> /sys/block/"$i"/queue/max_sectors_kb to 192kb"; done
> Set /sys/block/sde/queue/max_sectors_kb to 192kb
> Set /sys/block/sdg/queue/max_sectors_kb to 192kb
> Set /sys/block/sdi/queue/max_sectors_kb to 192kb
> Set /sys/block/sdk/queue/max_sectors_kb to 192kb
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/md3 of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 398.069 seconds, 27.0 MB/s
>
> Awful performance with your numbers/drop_caches settings.. !

Can you repeat with /dev/sda only?

With fresh reboot to shell, then:
$ cat /sys/block/sda/queue/max_sectors_kb
$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/sda of=/dev/null bs=1M count=10240

$ echo 192 > /sys/block/sda/queue/max_sectors_kb
$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/sda of=/dev/null bs=1M count=10240

$ echo 128 > /sys/block/sda/queue/max_sectors_kb
$ echo 3 > /proc/sys/vm/drop_caches
$ dd if=/dev/sda of=/dev/null bs=1M count=10240

> What were your tests designed to show?

A problem with the block-io.


Thanks!

--
Al

