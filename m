Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSJETKH>; Sat, 5 Oct 2002 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262453AbSJETKG>; Sat, 5 Oct 2002 15:10:06 -0400
Received: from packet.digeo.com ([12.110.80.53]:46841 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262452AbSJETKE>;
	Sat, 5 Oct 2002 15:10:04 -0400
Message-ID: <3D9F3A52.4FB46701@digeo.com>
Date: Sat, 05 Oct 2002 12:15:30 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: conman@kolivas.net, linux-kernel@vger.kernel.org,
       rmaureira@alumno.inacap.cl, rcastro@ime.usp.br
Subject: Re: [BENCHMARK] contest 0.50 results to date
References: <20021005182850.31930.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Oct 2002 19:15:31.0287 (UTC) FILETIME=[927C1670:01C26CA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> And here are my results:
> noload:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [3]              128.8   97      0       0       1.01
> 2.4.19-0.24pre4 [3]     127.4   98      0       0       0.99
> 2.5.40 [3]              134.4   96      0       0       1.05
> 2.5.40-nopree [3]       133.7   96      0       0       1.04
> 
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [3]              194.1   60      134     40      1.52
> 2.4.19-0.24pre4 [3]     193.2   60      133     40      1.51
> 2.5.40 [3]              184.5   70      53      31      1.44
> 2.5.40-nopree [3]       286.4   45      163     55      2.24
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [3]              461.0   28      46      8       3.60
> 2.4.19-0.24pre4 [3]     235.4   55      26      10      1.84
> 2.5.40 [3]              293.6   45      25      8       2.29
> 2.5.40-nopree [3]       269.4   50      20      7       2.10
> 
> mem_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.19 [3]              161.1   80      38      2       1.26
> 2.4.19-0.24pre4 [3]     181.2   76      253     19      1.41
> 2.5.40 [3]              163.0   80      34      2       1.27
> 2.5.40-nopree [3]       161.7   80      34      2       1.26
> 

I think I'm going to have to be reminded what "Loads" and "LCPU"
mean, please.

For these sorts of tests, I think system-wide CPU% is an interesting
thing to track - both user and system.  If it is high then we're doing
well - doing real work.

The same isn't necessarily true of the compressed-cache kernel, because
it's doing extra work in-kernel, so CPU load comparisons there need
to be made with some caution.

Apart from observing overall CPU occupancy, we also need to monitor
fairness - one way of doing that is to measure the total kernel build
elapsed time.  Another way would be to observe how much actual progress
the streaming IO makes during the kernel build.

What is "2.4.19-0.24pre4"?

I'd suggest that more tests be added.  Perhaps

- one competing streaming read

- several competing streaming reads

- competing "tar cf foo ./linux"

- competing "tar xf foo"

- competing "ls -lR > /dev/null"

It would be interesting to test -aa kernels as well - Andrea's kernels
tend to be well tuned.
