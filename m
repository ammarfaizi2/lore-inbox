Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTBYFTp>; Tue, 25 Feb 2003 00:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267612AbTBYFTp>; Tue, 25 Feb 2003 00:19:45 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:39572 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267645AbTBYFTo>; Tue, 25 Feb 2003 00:19:44 -0500
Date: Tue, 25 Feb 2003 00:35:47 -0500
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: Re: IO scheduler benchmarking
Message-ID: <20030225053547.GA1571@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Executive question: Why does 2.5.62-mm2 have higher sequential
write latency than 2.5.61-mm1?

tiobench numbers on uniprocessor single disk IDE:
The cfq scheduler (2.5.62-mm2 and 2.5.61-cfq) has a big latency
regression.

2.5.61-mm1		(default scheduler (anticipatory?))
2.5.61-mm1-cfq		elevator=cfq
2.5.62-mm2-as		anticipatory scheduler
2.5.62-mm2-dline	elevator=deadline
2.5.62-mm2		elevator=cfq

                    Thr  MB/sec   CPU%     avg lat      max latency
2.5.61-mm1            8   15.68   54.42%     5.87 ms     2.7 seconds
2.5.61-mm1-cfq        8    9.60   15.07%     7.54      393.0
2.5.62-mm2-as         8   14.76   52.04%     6.14        4.5
2.5.62-mm2-dline      8    9.91   13.90%     9.41         .8
2.5.62-mm2            8    9.83   15.62%     7.38      408.9
2.4.21-pre3           8   10.34   27.66%     8.80        1.0
2.4.21-pre3-ac4       8   10.53   28.41%     8.83         .6
2.4.21-pre3aa1        8   18.55   71.95%     3.25       87.6


For most thread counts (8 - 128), the anticipatory scheduler has roughly 
45% higher ext2 sequential read throughput.  Latency was higher than 
deadline, but a lot lower than cfq.

For tiobench sequential writes, the max latency numbers for 2.4.21-pre3
are notably lower than 2.5.62-mm2 (but not as good as 2.5.61-mm1).  
This is with 16 threads.  

                    Thr  MB/sec   CPU%      avg lat     max latency
2.5.61-mm1           16   18.30   81.12%     9.159 ms     6.1 seconds
2.5.61-mm1-cfq       16   18.03   80.71%     9.086        6.1
2.5.62-mm2-as        16   18.84   84.25%     8.620       47.7
2.5.62-mm2-dline     16   18.53   84.10%     8.967       53.4
2.5.62-mm2           16   18.46   83.28%     8.521       40.8
2.4.21-pre3          16   16.20   65.13%     9.566        8.7
2.4.21-pre3-ac4      16   18.50   83.68%     8.774       11.6
2.4.21-pre3aa1       16   18.49   88.10%     8.455        7.5

Recent uniprocessor benchmarks:
http://home.earthlink.net/~rwhron/kernel/latest.html

More uniprocessor benchmarks:
http://home.earthlink.net/~rwhron/kernel/k6-2-475.html

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html
latest quad xeon benchmarks:
http://home.earthlink.net/~rwhron/kernel/blatest.html

