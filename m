Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283234AbRLOSRa>; Sat, 15 Dec 2001 13:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283268AbRLOSRU>; Sat, 15 Dec 2001 13:17:20 -0500
Received: from mustard.heime.net ([194.234.65.222]:17103 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S283234AbRLOSRL>; Sat, 15 Dec 2001 13:17:11 -0500
Date: Sat, 15 Dec 2001 19:16:41 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Jens Axboe <axboe@suse.de>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] RAID sub system
In-Reply-To: <20011214165303.GK1180@suse.de>
Message-ID: <Pine.LNX.4.30.0112151905360.17971-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sysrq-t output from a "hung" system would give some valuable info as to
> why it's stuck.

It never hangs. It just slows down the i/o to ~ 1MB/s

also ... I started out with 200 'dd' processes (as the script I sent
earlier). The i/o gets stuck, and ... strange ...

# killall dd

watching vmstat

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0 200  0      0   3280   4092 782072   0   0  1054     0  621   657   0   4  96
 0 200  0      0   3284   4092 782108   0   0  1042     0  631   665   1   1  98
 0 101  0      0   3672   4164 804600   0   0 17594     0  762   931   2   9  88
 0 56  1      0   3248   4180 815332   0   0 32598     0  897   727   0  10  90
 0 30  1      0   3276   4212 821640   0   0 33102    40  910   447   1   6  92
 0  1  1      0   3252   4236 829080   0   0 31692     0  947   301   1   9  90
 0  0  0      0   3296   4236 829320   0   0  2042     0  401   132   0   0 100
 0  0  0      0   3288   4244 829320   0   0     0    26  360   132   0   0 100
 0  0  0      0   3288   4244 829320   0   0     0     0  326   127   0   0 100
 0  0  0      0   3288   4244 829320   0   0     0     0  358   127   0   0 100


It speeds up again when the processes start to die, although the number of
processes started has no effect of the outcome. After a while the i/o
stops completely up (see above lines 1,2).

I also noted a quite a dramatic speed reduction in 2.4.17-rc1 compared to
2.4.16. 2.4.16 gave me up to 50 megs / sec, wheras 2.4.17-rc1 only gives
me around 35.

roy

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

