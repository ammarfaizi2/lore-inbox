Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262609AbSI0WWv>; Fri, 27 Sep 2002 18:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262612AbSI0WWu>; Fri, 27 Sep 2002 18:22:50 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:18884 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262609AbSI0WWs>;
	Fri, 27 Sep 2002 18:22:48 -0400
Message-ID: <1033165685.3d94db75cbefa@kolivas.net>
Date: Sat, 28 Sep 2002 08:28:05 +1000
From: Con Kolivas <conman@kolivas.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Benchmark] Contest 0.37 2.5.28-mm2-preemptionON vs    2.5.28-mm2-preemptionOFF
References: <20020927193815.7164.qmail@linuxmail.org>
In-Reply-To: <20020927193815.7164.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> Hi all,
> here goes the results of contest0.37 against:
> 2.4.19                  
> 2.4.19-0.24pre4
> 2.4.19-ck7              
> 2.5.32-mm2-Nopre  
> 2.5.38-mm2
> 
> The goal of this test is compare preemption ON against preemption OFF
> 
> -mm2 io_load was repeated 6 times, then I added the average.
> Pay attention that the results are passed through
> sort.
> 
> Comments, suggestion are more then welcome.
> 
> noload:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  130.39          100%            1.00
> 2.4.19-0.24pre4         130.53          100%            1.00
> 2.4.19-0.24pre4         130.64          99%             1.00
> 2.4.19-ck7              129.76          99%             1.00
> 2.5.32-mm2-Nopre        133.29          100%            1.02
> 2.5.38-mm2              134.45          100%            1.03
> 
> process_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  156.95          81%             1.20
> 2.4.19-0.24pre4         156.99          81%             1.20
> 2.4.19-0.24pre4         157.42          81%             1.21
> 2.4.19-ck7              147.41          87%             1.13
> 2.5.32-mm2-Nopre        150.13          88%             1.15
> 2.5.38-mm2              151.41          88%             1.16
> 
> io_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  376.46          35%             2.89
> 2.4.19-0.24pre4         203.49          66%             1.56
> 2.4.19-0.24pre4         218.82          62%             1.68
> 2.4.19-ck7              785.55          16%             6.02

This is something I'm well aware of. Since ck7 has some of the performance
things that increase file IO, it makes ck7 prone to the write starves read
problem in 2.5.38 (and fixed in mm2+). There isn't a fix that has been ported to
2.4.x (obviously real 2.5.x development has taken precedence).

> 2.5.32-mm2-Nopre        176.52          77%             1.35
> 2.5.32-mm2-Nopre        181.21          75%             1.39
> 2.5.32-mm2-Nopre        189.31          72%             1.45
> 2.5.32-mm2-Nopre        198.59          70%             1.52
> 2.5.32-mm2-Nopre        198.96          68%             1.53
> 2.5.32-mm2-Nopre        204.19          67%             1.57
> 	average:	191.46
> 
> 2.5.38-mm2              190.04          72%             1.46
> 2.5.38-mm2              195.49          70%             1.50
> 2.5.38-mm2              199.44          69%             1.53
> 2.5.38-mm2              200.14          69%             1.53
> 2.5.38-mm2              221.99          61%             1.70
> 2.5.38-mm2              263.03          52%             2.02
> 	average:	211.68
> mem_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  170.79          78%             1.31
> 2.4.19-0.24pre4         197.17          76%             1.51
> 2.4.19-0.24pre4         212.25          74%             1.63
> 2.4.19-ck7              175.24          75%             1.34
> 2.5.32-mm2-Nopre        161.05          84%             1.24
> 2.5.38-mm2              169.33          80%             1.30
> 

Ok I've done a quick statistical analysis on your data which hints that preempt
is worse than no preempt:

The probability of this result, assuming the null hypothesis, is 0.057

NoPre:
Mean = 191.
95% confidence interval for Mean: 179.9 thru 203.0
Standard Deviation = 11.0
Median = 194.
Average Absolute Deviation from Median = 9.12

Pre:
Mean = 212.
95% confidence interval for Mean: 182.9 thru 240.5
Standard Deviation = 27.4
Median = 200.
Average Absolute Deviation from Median = 16.7

In Summary there isn't a statistically significant difference in these numbers.

Con
