Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276639AbRJUTSG>; Sun, 21 Oct 2001 15:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276632AbRJUTR5>; Sun, 21 Oct 2001 15:17:57 -0400
Received: from lilly.ping.de ([62.72.90.2]:57359 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S276639AbRJUTRl>;
	Sun, 21 Oct 2001 15:17:41 -0400
Date: 21 Oct 2001 21:17:26 +0200
Message-ID: <20011021211726.A476@planetzork.spacenet>
From: jogi@planetzork.ping.de
To: "Andrea Arcangeli" <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13pre5aa1
In-Reply-To: <20011019061914.A1568@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20011019061914.A1568@athlon.random>; from andrea@suse.de on Fri, Oct 19, 2001 at 06:19:14AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 06:19:14AM +0200, Andrea Arcangeli wrote:
> The vm part in particular is right now getting stressed on a 16G box kindly
> provided by osdlab.org and it didn't exibith any problem yet. This is a trace
> of the workload that is running on the machine overnight.

Hello Andrea,

I did some performance comparison on my machine (Athlon 1200, 256MB DDR,
IDE hdd). Basically all I did was time the complete build prozess of a
kernel:

#!/bin/bash

REV=`uname -r`-`date +%s`
LF="/usr/src/logfile-$REV"
PAR=100

tar xvIf /home/public/Linux/kernel/v2.4/linux-2.4.12.tar.bz2 >>$LF 2>&1
cd linux
bzip2 -cd /home/public/Linux/kernel/v2.4/patch-2.4.13-pre5.bz2 | patch -p1
>>$LF 2>&1
bzip2 -cd /home/public/Linux/kernel/v2.4/2.4.13pre5aa1.bz2 | patch -p1 >>$LF
2>&1
patch -p0 < ../Makefile.patch >>$LF 2>&1
cp ../config-2.4.13-pre5aa1 .config
(make oldconfig dep clean && make -j$PAR bzImage modules && cat /proc/loadavg &&
cat /proc/meminfo) >
>$LF 2>&1

I ran the above script five times in a row after a fresh reboot into single
user mode so that no other processes could interfere. Here are the results:

                    j25       j50       j75       j100
2.4.12-ac3:       4:52.16   5:21.15   6:22.85   10:26.70
2.4.12-ac3:       4:52.31   5:22.52   8:40.97   15:55.37
2.4.12-ac3:       4:51.51   5:18.04   6:08.80   7:09.85
2.4.12-ac3:       4:52.47   5:10.81   5:51.02   8:53.40
2.4.12-ac3:       4:53.24   5:06.96   6:36.49   7:53.92
2.4.13-pre3aa1:   4:52.08   5:57.43   9:43.07      *
2.4.13-pre3aa1:   4:54.22   5:04.17   10:30.56     *
2.4.13-pre3aa1:   4:53.95   5:21.08   11:07.44     *
2.4.13-pre3aa1:   4:55.26   5:30.01   9:53.16      *
2.4.13-pre3aa1:   4:54.39   6:00.32   10:15.06     *
2.4.13-pre5aa1:   4:54.61   5:10.38   5:19.68   5:40.37
2.4.13-pre5aa1:   4:56.39   5:12.39   5:31.16   5:59.54
2.4.13-pre5aa1:   4:55.12   5:11.00   5:13.37   5:43.99
2.4.13-pre5aa1:   4:56.24   5:10.85   5:16.17   5:50.78
2.4.13-pre5aa1:   4:57.05   5:10.97   5:26.41   6:06.42

* Kernel build did not complete because OOM killer was activated.

If further infos are interesting just send me an email.


Kind regards,

   Jochen


-- 

Well, yeah ... I suppose there's no point in getting greedy, is there?

    << Calvin & Hobbes >>
