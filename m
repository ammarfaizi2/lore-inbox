Return-Path: <linux-kernel-owner+w=401wt.eu-S1161177AbXAMGPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbXAMGPf (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 01:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbXAMGPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 01:15:35 -0500
Received: from [82.147.213.6] ([82.147.213.6]:33003 "EHLO raad.intranet"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161177AbXAMGPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 01:15:34 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jan 2007 01:15:32 EST
From: Al Boldi <a1426z@gawab.com>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1: (211MB/s read & 195MB/s write)
Date: Sat, 13 Jan 2007 09:11:38 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan> <200701130000.48717.a1426z@gawab.com> <Pine.LNX.4.64.0701121628100.3655@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0701121628100.3655@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701130911.38240.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> On Sat, 13 Jan 2007, Al Boldi wrote:
> > Justin Piszcz wrote:
> > > Btw, max sectors did improve my performance a little bit but
> > > stripe_cache+read_ahead were the main optimizations that made
> > > everything go faster by about ~1.5x.   I have individual bonnie++
> > > benchmarks of [only] the max_sector_kb tests as well, it improved the
> > > times from 8min/bonnie run -> 7min 11 seconds or so, see below and
> > > then after that is what you requested.
> >
> > Can you repeat with /dev/sda only?
>
> For sda-- (is a 74GB raptor only)-- but ok.

Do you get the same results for the 150GB-raptor on sd{e,g,i,k}?

> # uptime
>  16:25:38 up 1 min,  3 users,  load average: 0.23, 0.14, 0.05
> # cat /sys/block/sda/queue/max_sectors_kb
> 512
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/sda of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 150.891 seconds, 71.2 MB/s
> # echo 192 > /sys/block/sda/queue/max_sectors_kb
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/sda of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 150.192 seconds, 71.5 MB/s
> # echo 128 > /sys/block/sda/queue/max_sectors_kb
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/sda of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 150.15 seconds, 71.5 MB/s
>
>
> Does this show anything useful?

Probably a latency issue.  md is highly latency sensitive.

What CPU type/speed do you have?  Bootlog/dmesg?


Thanks!

--
Al

