Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSAYAPy>; Thu, 24 Jan 2002 19:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288662AbSAYAPo>; Thu, 24 Jan 2002 19:15:44 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:23731 "EHLO
	hawk.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290465AbSAYAPg>; Thu, 24 Jan 2002 19:15:36 -0500
Date: Thu, 24 Jan 2002 19:19:27 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020124191927.A809@earthlink.net>
In-Reply-To: <20020124002342.A630@earthlink.net> <E16ToWW-0002mf-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16ToWW-0002mf-00@starship.berlin>; from phillips@bonn-fries.net on Thu, Jan 24, 2002 at 07:27:43AM +0100
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > http://home.earthlink.net/~rwhron/kernel/k6-2-475.html
> 
> Even when mostly uncached, dbench still produces flaky results.

dbench results are not perfectly repeatable.  I agree that dbench
results that vary by 20% or so may not be meaningful.  I think 
dbench is of some value though. In some cases the difference
between kernels is 200% or more.

Below are results from a couple of aa releases, and a few rmap
releases.  Some of the tests were ran twice.  You can see that 
there is some variation between "identical" runs.  You can see
that aa kernels do extremely well with large numbers of processes,
and as the number of processes increases from 64 -> 128 -> 192,
the throughput drops in a predictable way.

rmap, when compared with most other kernels does well with 64 processes.
At 192, rmap doesn't do as well.  That may be useful information for the 
people developing rmap.

dbench 64 processes
2.4.18pre4aa1      ************************************************** 25.2 MB/sec
2.4.18pre2aa2      ******************************************** 22.2 MB/sec
2.4.17rmap11a      **************************** 14.2 MB/sec
2.4.17rmap11a      *************************** 13.9 MB/sec
2.4.17rmap12a      *************************** 13.7 MB/sec
2.4.18pre3rmap11b  ********************** 11.4 MB/sec
2.4.17rmap11c      ********************* 10.8 MB/sec
2.4.17rmap11c      ********************* 10.6 MB/sec
2.4.17rmap11b      ******************* 9.7 MB/sec

dbench 128 processes
2.4.18pre4aa1      ******************************** 16.4 MB/sec
2.4.18pre2aa2      ******************************** 16.3 MB/sec
2.4.18pre2aa2      ***************************** 14.9 MB/sec
2.4.17rmap11a      ************ 6.1 MB/sec
2.4.17rmap11a      ************ 6.1 MB/sec
2.4.18pre3rmap11b  ********** 5.1 MB/sec
2.4.17rmap11b      ********* 5.0 MB/sec
2.4.17rmap12a      ********* 4.5 MB/sec
2.4.17rmap11c      ******** 4.2 MB/sec
2.4.17rmap11c      ******** 4.2 MB/sec

dbench 192 processes
2.4.18pre2aa2      ***************** 8.8 MB/sec
2.4.18pre4aa1      **************** 8.2 MB/sec
2.4.18pre2aa2      *************** 7.7 MB/sec
2.4.17rmap11a      ******** 4.4 MB/sec
2.4.17rmap11a      ******** 4.3 MB/sec
2.4.18pre3rmap11b  ******* 3.8 MB/sec
2.4.17rmap11b      ******* 3.8 MB/sec
2.4.17rmap12a      ****** 3.1 MB/sec
2.4.17rmap11c      ***** 3.0 MB/sec
2.4.17rmap11c      ***** 2.9 MB/sec


On the other hand, rmap does very well with sequential reads 
on tiobench, which is running a lot fewer processes than dbench.

       Read, Write, and Seeks are MB/sec

 	       Num     Seq Read     Rand Read      Seq Write   Rand Write
 	       Thr    Rate (CPU%)  Rate (CPU%)    Rate (CPU%)  Rate (CPU%)
 	       ---  -------------  -----------  -------------  -----------
2.4.17rmap12a    1   22.85  32.2%   1.15  2.2%   13.10  83.5%   0.71  1.6%
2.4.18pre2aa2    1   11.96  23.1%   2.24  3.2%   12.90  76.8%   0.71  1.6%
2.4.18pre4aa1    1   11.23  21.3%   3.12  4.8%   11.92  66.1%   0.66  1.3%

2.4.17rmap12a    2   22.07  32.1%   1.20  2.2%   12.84  80.4%   0.71  1.6%
2.4.18pre2aa2    2   11.09  22.0%   2.57  3.2%   13.10  76.3%   0.70  1.6%
2.4.18pre4aa1    2   10.68  20.9%   3.39  4.4%   12.14  67.9%   0.67  1.3%

2.4.17rmap12a    4   21.75  32.0%   1.20  2.2%   12.69  78.5%   0.71  1.6%
2.4.18pre2aa2    4   10.52  21.1%   2.82  3.6%   12.84  73.9%   0.69  1.5%
2.4.18pre4aa1    4   10.48  20.4%   3.56  4.2%   12.28  69.0%   0.67  1.4%

2.4.17rmap12a    8   21.34  31.8%   1.23  2.3%   12.57  77.3%   0.71  1.7%
2.4.18pre2aa2    8   10.24  19.5%   3.01  4.0%   12.94  74.1%   0.70  1.6%
2.4.18pre4aa1    8   10.08  18.9%   3.63  4.5%   12.24  68.8%   0.67  1.4%

I added bonnie++ to the list of tests a day or so ago.
I'll begin putting those results up in the near future.

-- 
Randy Hron

