Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261422AbSJMDyL>; Sat, 12 Oct 2002 23:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261423AbSJMDyK>; Sat, 12 Oct 2002 23:54:10 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:531 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261422AbSJMDyJ>; Sat, 12 Oct 2002 23:54:09 -0400
Date: Sat, 12 Oct 2002 23:52:08 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Benchmark results from resp1 trivial response time test
Message-ID: <Pine.LNX.3.96.1021012234904.30780A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been using and developing a trivial response benchmark which is
intended to give a reproducable measure of system response to trivial
tasks, such as uncovering a window or typing a small command such as
'ls' requiring modest memory and CPU.

The benchmark runs a noload case, then forks a load process (or
processes) in the background, pauses long enough to simulate user
interaction (and get swapped out if the system is memory stressed), then
reports the time it took to complete, including the ratio of loaded to
noload time.

I got some results so bad I thought the program was in error, but
running ls by hand convinced me that the system could easily be orders
of magnitude slower under some load.

Here are some results, the 2.5.41-mm2v is Con's patch on top of 41-mm2.
The program and some detailed results from the standard test machine are
at http://pages.prodigy.net/davidsen/ if anyone cares. 2.5.41-ac2
crashed every time I tried the benchmark, I'm building the same kernels
on an SMP machine to get a set of SMP results.


2.4.18-5.out
  Starting 1 CPU run with 92 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    238.745    247.882    239.419    240.904    0.004    1.000
     smallwrite    259.114    412.260    345.788    326.670    0.056    1.356
     largewrite    279.599   2018.226   1155.189   1140.001    0.865    4.732
        cpuload    238.958    326.137    239.678    257.048    0.039    1.067
      spawnload    227.693    294.703    229.801    246.484    0.029    1.023
       8ctx-mem    914.206  26547.601   4402.521   9767.470   10.440   40.545
       2ctx-mem    296.088   9228.024   3445.643   4133.895    2.892   17.160

2.5.38-mm2-1.out
  Starting 1 CPU run with 92 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    249.844    251.639    250.326    250.462    0.001    1.000
     smallwrite  28972.832  89778.196  69264.628  60491.810   24.170  241.521
     largewrite  31667.273  97387.471  34728.573  47237.857   28.243  188.603
        cpuload    249.531    674.218    249.920    334.724    0.190    1.336
      spawnload    225.724    294.523    225.860    239.641    0.031    0.957
       8ctx-mem   1310.153  16910.239  13054.624  11026.391    6.351   44.024
       2ctx-mem   3551.369  15704.619   9219.185   9445.208    5.805   37.711

2.5.41-ac1-1.out
  Starting 1 CPU run with 91 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    244.534    250.900    250.526    249.541    0.002    1.000
     smallwrite  25594.642 105430.087  64438.179  68740.681   29.479  275.468
     largewrite  42475.273 128347.772  65505.753  73467.393   32.260  294.410
        cpuload    249.360   1866.355    249.854    573.019    0.723    2.296
      spawnload    225.845    296.056    226.379    240.173    0.031    0.962
       8ctx-mem    287.816  12466.608   7685.832   6212.891    4.021   24.897
       2ctx-mem   2383.892  18277.275   2979.035   6685.271    6.807   26.790

2.5.41-mm2.out
  Starting 1 CPU run with 91 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    251.327    252.137    251.860    251.768    0.000    1.000
     smallwrite    281.416    468.787    336.952    353.652    0.069    1.405
     largewrite    269.577   2328.442    756.294    937.793    0.748    3.725
        cpuload    248.970    330.523    249.991    265.903    0.036    1.056
      spawnload    226.116    306.816    227.464    242.903    0.036    0.965
       8ctx-mem   4360.954  11087.563   6240.896   6575.003    2.724   26.115
       2ctx-mem   4716.368   9847.308   7721.747   7642.746    1.639   30.356

2.5.41-mm2v.out
  Starting 1 CPU run with 91 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    249.779    256.051    249.983    251.590    0.003    1.000
     smallwrite    288.109    382.038    348.342    338.549    0.039    1.346
     largewrite    276.960    627.196    421.086    413.242    0.146    1.643
        cpuload    250.098    329.824    250.630    266.666    0.035    1.060
      spawnload    227.521    300.357    228.143    242.750    0.032    0.965
       8ctx-mem   1748.992   7175.653   3942.950   4188.664    2.071   16.649
       2ctx-mem   2336.009  12493.007   4941.117   6052.204    3.689   24.056

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

