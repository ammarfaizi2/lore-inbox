Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313533AbSC3SsZ>; Sat, 30 Mar 2002 13:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313534AbSC3SsO>; Sat, 30 Mar 2002 13:48:14 -0500
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:21382 "EHLO
	swan.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S313533AbSC3Sr7>; Sat, 30 Mar 2002 13:47:59 -0500
Date: Sat, 30 Mar 2002 13:53:33 -0500
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, akpm@zip.com.au
Subject: Linux 2.4.19-pre5
Message-ID: <20020330135333.A16794@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This release has -aa writeout scheduling changes, which should improve IO
> performance (and interactivity under heavy write loads).

> _Please_ test that extensively looking for any kind of problems
> (performance, interactivity, etc).

2.4.19-pre5 shows a lot of improvement in the tests
I run.  dbench 128 throughput up over 50%

dbench 128 processes
2.4.19-pre4              8.4 ****************
2.4.19-pre5             13.2 **************************

Tiobench sequential writes: 
10-20% more throughput and latency is lower.  

Tiobench Sequential reads
Down 7-8%.   

Andrew Morton's read_latency2 patch improves tiobench 
sequential reads and writes by 10-35% in the tests I've 
run.  More importantly, read_latency2 drops max latency 
with 32-128 tiobench threads from 300-600+ seconds 
down to 2-8 seconds.  (2.4.19-pre5 is still unfair 
to some read requests when threads >= 32)

I'm happy with pre5 and hope more chunks of -aa show 
up in pre6.  Maybe Andrew will update read_latency2 for 
inclusion in pre6. :)  It helps tiobench seq writes too.
dbench goes down a little though.  

Max latency is the metric that stands out as "needs 
improvement" and "fix exists".

tiobench seq reads 128 threads
                   MB/s     max latency
2.4.19-pre1aa1     6.98     661.3 seconds
2.4.19-pre1aa1rl   9.55       7.8 seconds

tiobench seq writes 32 threads
                   MB/s     max latency
2.4.19-pre1aa1    15.46     26.1 seconds
2.4.19-pre1aa1rl  17.31     18.0 seconds

The read latency issue exists on a 4 way xeon
with 4GB ram too.  Max latency jumps to 270 seconds
with 32 tiobench threads, and is over  500 seconds when
threads >= 128.  (latency in milliseconds below)

Sequential Reads
               Num                    Avg       Maximum     Lat%     Lat% 
Kernel         Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s 
-------------- ---  ------------------------------------------------------
2.4.19-pre5      1   38.46 23.94%     0.302      111.14   0.00000  0.00000
2.4.19-pre5     32   30.24 21.69%     9.883   270391.48   0.01106  0.00915
2.4.19-pre5     64   30.08 21.67%    17.868   357219.21   0.01965  0.01807
2.4.19-pre5    128   30.40 22.77%    30.460   520607.27   0.02714  0.02569
2.4.19-pre5    256   29.07 21.96%    56.444   539381.86   0.05378  0.05197


The behemoth benchmark page:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

-- 
Randy Hron

