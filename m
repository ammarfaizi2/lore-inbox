Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267526AbTAXE0q>; Thu, 23 Jan 2003 23:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbTAXE0q>; Thu, 23 Jan 2003 23:26:46 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:22223 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267526AbTAXE0p>; Thu, 23 Jan 2003 23:26:45 -0500
Date: Thu, 23 Jan 2003 23:41:19 -0500
To: akpm@digeo.com, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in 2.5.53-mm1
Message-ID: <20030124044119.GA15252@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew:
>> I have not been paying any attention to the I/O scheduler changes for a
>> couple of months, so I can't say exactly what caused this.  

OK.  The previous -mm I tested on the quad Xeon was 2.5.54-mm3, so if 
Nick's batch expiry is more recent, it explains the "sudden" tiobench
divergence with Linus' tree.

>> Possibly Nick's
>> batch expiry logic which causes the scheduler to alternate between reading
>> and writing with fairly coarse granularity.

Nick:
> Yes, however tiobench doesn't mix the two. The batch_expire helps
> probably by giving longer batches between servicing expired requests.

Andrew:
>>I _have_ been paying attention to the IO scheduler for the past few days. 
>>-mm5 will have the first draft of the anticipatory IO scheduler.  This of
>>course is yielding tremendous improvements in bandwidth when there are
>>competing reads and writes.

>I expect it will take another week or two to get the I/O scheduler changes
>>really settled down.  Your assistance in thoroughly benching that would be
>>appreciated.

The mixed workloads I run that vary the most are "memory shortage" tests.

qsbench creates heavy swap load and simultaneous ed build. (small gnu package 
"tar xzf/configure/make/make check").

Good numbers for this benchmark are open to interpretation, but more
ed builds in less time is better.  The "secs" column is how long it took
for qsbench to do it's thing. 

kernel                 ed_builds   secs   secs/build
2.4.20-rc2-ac1-rmap15-O1      38    373     9.82
2.4.19-rmap15                 50    445     8.90
2.4.20-rc2aa1-4m              47    597    12.70
2.4.20-pre8aa1                47    598    12.72
2.4.20aa1                     50    603    12.06
2.4.20-rc1-jam1               51    604    11.84
2.4.20-jam2                   50    609    12.18
2.4.20-pre11aa1o1             58    615    10.60
2.4.20-pre11aa1               55    632    11.49
2.4.20-rc2aa1                 55    648    11.78
2.4.20-rc1aa1                 61    678    11.11
2.4.20-rc4                    57    743    13.04
2.5.51-mm2                    63    761    12.08
2.5.58                        87    809     9.30
2.4.19-ck13                   86    822     9.56
2.4.20-pre10                  75    831    11.08
2.4.20-rc1                    85    938    11.04
2.5.50                       110    978     8.89
2.5.50bk8                    107    984     9.20
2.5.51-mm1                    87    985    11.32
2.5.46-mm2                    85   1000    11.76
2.5.59                       119   1088     9.14
2.5.55                       127   1127     8.87
2.5.54-mm2                    73   1135    15.55
2.5.52-mm2                   101   1202    11.90
2.5.59-mm2                   139   1263     9.09
2.5.53-mm1                   107   1297    12.12
2.5.54-mm3                    97   1361    14.03
2.5.52-wli-1                 200   1775     8.88
2.5.56                       222   1978     8.91
2.5.52bk7                    232   2085     8.99
2.5.49-mm1                   248   2731    11.01
2.5.39                       346   2949     8.52
2.5.44-mm5                   348   2996     8.61
2.5.42                       408   3528     8.65
2.5.44-mm6                   342   3680    10.76
2.5.43-mm2                   475   4209     8.86
2.5.40-mm1                   706   6131     8.68

--
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

