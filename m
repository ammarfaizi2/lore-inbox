Return-Path: <linux-kernel-owner+w=401wt.eu-S1030502AbXAMJkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbXAMJkm (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 04:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXAMJkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 04:40:42 -0500
Received: from lucidpixels.com ([66.45.37.187]:36620 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030331AbXAMJkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 04:40:41 -0500
Date: Sat, 13 Jan 2007 04:40:39 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Al Boldi <a1426z@gawab.com>
cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1:
 (211MB/s read & 195MB/s write)
In-Reply-To: <200701130911.38240.a1426z@gawab.com>
Message-ID: <Pine.LNX.4.64.0701130439590.23336@p34.internal.lan>
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan>
 <200701130000.48717.a1426z@gawab.com> <Pine.LNX.4.64.0701121628100.3655@p34.internal.lan>
 <200701130911.38240.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Jan 2007, Al Boldi wrote:

> Justin Piszcz wrote:
> > On Sat, 13 Jan 2007, Al Boldi wrote:
> > > Justin Piszcz wrote:
> > > > Btw, max sectors did improve my performance a little bit but
> > > > stripe_cache+read_ahead were the main optimizations that made
> > > > everything go faster by about ~1.5x.   I have individual bonnie++
> > > > benchmarks of [only] the max_sector_kb tests as well, it improved the
> > > > times from 8min/bonnie run -> 7min 11 seconds or so, see below and
> > > > then after that is what you requested.
> > >
> > > Can you repeat with /dev/sda only?
> >
> > For sda-- (is a 74GB raptor only)-- but ok.
> 
> Do you get the same results for the 150GB-raptor on sd{e,g,i,k}?
> 
> > # uptime
> >  16:25:38 up 1 min,  3 users,  load average: 0.23, 0.14, 0.05
> > # cat /sys/block/sda/queue/max_sectors_kb
> > 512
> > # echo 3 > /proc/sys/vm/drop_caches
> > # dd if=/dev/sda of=/dev/null bs=1M count=10240
> > 10240+0 records in
> > 10240+0 records out
> > 10737418240 bytes (11 GB) copied, 150.891 seconds, 71.2 MB/s
> > # echo 192 > /sys/block/sda/queue/max_sectors_kb
> > # echo 3 > /proc/sys/vm/drop_caches
> > # dd if=/dev/sda of=/dev/null bs=1M count=10240
> > 10240+0 records in
> > 10240+0 records out
> > 10737418240 bytes (11 GB) copied, 150.192 seconds, 71.5 MB/s
> > # echo 128 > /sys/block/sda/queue/max_sectors_kb
> > # echo 3 > /proc/sys/vm/drop_caches
> > # dd if=/dev/sda of=/dev/null bs=1M count=10240
> > 10240+0 records in
> > 10240+0 records out
> > 10737418240 bytes (11 GB) copied, 150.15 seconds, 71.5 MB/s
> >
> >
> > Does this show anything useful?
> 
> Probably a latency issue.  md is highly latency sensitive.
> 
> What CPU type/speed do you have?  Bootlog/dmesg?
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

> What CPU type/speed do you have?  Bootlog/dmesg?
Core Duo E6300

The speed is great since I have tweaked the various settings..
