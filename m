Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286067AbRLHXbp>; Sat, 8 Dec 2001 18:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286068AbRLHXbf>; Sat, 8 Dec 2001 18:31:35 -0500
Received: from yuha.menta.net ([212.78.128.42]:2208 "EHLO yuha.menta.net")
	by vger.kernel.org with ESMTP id <S286067AbRLHXbW>;
	Sat, 8 Dec 2001 18:31:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ivanovich <ivanovich@menta.net>
To: Jens Axboe <axboe@suse.de>
Subject: Re: Impact of HIGHMEM?
Date: Sun, 9 Dec 2001 00:30:51 +0100
X-Mailer: KMail [version 1.2]
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3C1263FE.EBD973FA@starband.net> <01120820485101.01267@localhost.localdomain> <20011208200529.GA11567@suse.de>
In-Reply-To: <20011208200529.GA11567@suse.de>
MIME-Version: 1.0
Message-Id: <01120900305100.01329@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A Dissabte 08 Desembre 2001 21:05, Jens Axboe va escriure:
> On Sat, Dec 08 2001, Ivanovich wrote:
> > A Dissabte 08 Desembre 2001 20:03, war va escriure:
> > > Does anyone have any benchmarks as to how much HIGHMEM affects
> > > performance in Linux?
> You don't need lots of mem to test highmem impact, just grab the highmem
> debug patch from Andrea:
>
> kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.17pre4aa1/20_hig
>hmem-debug-7

ok, i made my homeworks, have tested highmem effect in my computer but i get 
some STRANGE results

kernel: 2.4.17-pre6 + preempt-kernel-rml-2.4.17-pre6-1.patch + 
lock-break-rml-2.4.17-pre6-1.patch (+ highmem for lowmem machines patch)
micro: pIII @ 935 Mhz
mem: 256Mb
L2 cache: 256Kb

i run cachebench (llcbench suite) Read/Modify/Write benchmark

results WITHOUT highmem:
size - Mb/sec
32768 - 4290.175472
49152 - 4277.256065
65536 - 4293.230743
98304 - 4294.457415
131072 - 4291.695324 <-
196608 - 2327.512263 <- 
262144 - 1177.041779 <-
393216 - 709.747398 <-
524288 - 591.464925 <-
786432 - 558.824848
1048576 - 573.862697
1572864 - 584.174573
2097152 - 575.021368
3145728 - 580.856111
4194304 - 581.096127
6291456 - 587.200702
8388608 - 583.293192
12582912 - 583.264028
16777216 584.326629

results WITH highmem:
size - Mb/sec
32768 - 4290.283522 <- all small values 
49152 - 4277.199336 <- similar to no-highmem
65536 - 4293.282408 <- due to cache
98304 - 4294.589967
131072 - 4291.831538 <- strange...
196608 - 4295.502217 <- 
262144 - 2020.226275 <- 
393216 - 605.011875 <-
524288 - 454.203301 <-
786432 - 438.363738
1048576 - 438.401140
1572864 - 438.595614
2097152 - 438.794817
3145728 - 439.164867
4194304 - 439.566675
6291456 - 440.364513
8388608 - 441.159194
12582912 - 442.724326
16777216 - 444.301898

aprox. 24% throughput drop with highmem in the read/modify/write bench when 
cache have no effect. of course this is a synthetic

but quite strange (for me) behaviour in the lines marked with "???":
no-highmem
131072 - 4291.695324 <-
196608 - 2327.512263 <- ???
262144 - 1177.041779 <- ???
393216 - 709.747398 <-
524288 - 591.464925 <-
highmem
131072 - 4291.831538 <-
196608 - 4295.502217 <- ???
262144 - 2020.226275 <- ???
393216 - 605.011875 <- 
524288 - 454.203301 <-

can anyone explain me why this happen? himem seems to be faster sometimes, 
and cache have something to do.... i have 256Kb L2
