Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315883AbSEZIfv>; Sun, 26 May 2002 04:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSEZIfu>; Sun, 26 May 2002 04:35:50 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18703
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315860AbSEZIfs>; Sun, 26 May 2002 04:35:48 -0400
Date: Sun, 26 May 2002 01:33:53 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
cc: linux-ide@vger.kernel.org
Subject: 2.4 s/w raid 0 benchmarks for kicks.
Message-ID: <Pine.LNX.4.10.10205260112290.2414-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greets All,

This is a simple four drive ultra 100 limited hardware, doing single ended
mode setups.  Using SMP and "taskfile IO" the original and correct
version.  Additional tricks are profile tuning of the ide-driver to permit
load balancing on the IO and also full tilt supercharged throughput.
The soon to be released stuff will be a partial of my production level
driver.  Please note this kind of performance requires SMP, otherwise it
gets ugly fast.

I think it is kind of cool to be capable of nearly 100MB/sec reading with
8 threads active under TIO Bench.  Also your mouse does not jump, it
glides nicely :-)


1792   4096    1  84.79 57.0% 0.963 1.91% 89.72 66.3% 3.373 1.94%
1792   4096    2  83.08 57.4% 1.179 1.92% 83.15 75.1% 3.449 2.42%
1792   4096    4  80.12 56.1% 1.398 2.11% 76.97 73.5% 3.482 2.89%
1792   4096    8  79.64 56.8% 1.595 2.50% 74.48 73.3% 3.525 2.82%
Writing intelligently...done: 158635 kB/s  76.9 %CPU
Reading intelligently...done:  93497 kB/s  53.9 %CPU
1792   4096    1  144.4 99.5% 1.070 1.30% 84.85 54.9% 3.530 2.48%
1792   4096    2  117.3 81.1% 1.332 1.61% 82.35 62.3% 3.509 3.14%
1792   4096    4  105.3 72.0% 1.541 1.94% 78.92 63.3% 3.521 3.23%
1792   4096    8  98.74 68.7% 1.778 2.02% 75.14 62.1% 3.582 3.38%
Writing intelligently...done: 150940 kB/s  68.2 %CPU
Reading intelligently...done: 172964 kB/s  99.0 %CPU
1792   4096    1  152.1 98.7% 1.068 1.09% 84.77 54.2% 3.417 2.18%
1792   4096    2  119.3 80.7% 1.341 1.75% 81.10 61.0% 3.502 2.68%
1792   4096    4  107.7 72.7% 1.607 1.92% 78.71 62.4% 3.490 3.05%
1792   4096    8  100.0 67.4% 1.822 2.01% 75.83 62.5% 3.520 3.04%
Writing intelligently...done: 145819 kB/s  64.8 %CPU
Reading intelligently...done: 176328 kB/s  99.6 %CPU

One of the problems is to get work done in DMA you need cpu cycles.
I will retest with some of the newer hba's which support mmio
transactions.  This does indicate I have a preproduction version which
seamless operates in iomio and mmio.  Currently working to add large DMA
transactions to support IDEMA's suggested 4Kb sector on physical, w/
logical now becoming 512b.  This shall include options to support 4K
sectors per request on native hardware.



Cheers,

Andre Hedrick
LAD Storage Consulting Group

