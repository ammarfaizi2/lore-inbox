Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262565AbTCPIPX>; Sun, 16 Mar 2003 03:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262584AbTCPIPX>; Sun, 16 Mar 2003 03:15:23 -0500
Received: from franka.aracnet.com ([216.99.193.44]:16790 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262565AbTCPIPV>; Sun, 16 Mar 2003 03:15:21 -0500
Date: Sun, 16 Mar 2003 00:25:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <23900000.1047803147@[10.10.2.4]>
In-Reply-To: <m365qk1gzx.fsf@lexa.home.net>
References: <m365qk1gzx.fsf@lexa.home.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> here is the patch for ext2 concurrent inode allocation. should be applied
> on top of previous concurrent-balloc patch. tested on dual p3 for several
> hours of stress-test + fsck. hope someone test it on big iron ;)

OK ... now you're scaring me. This puppy is accellerating too fast ;-)
I'm sure 196% on SDET is against some rule or other ... ;-)
(16x NUMA-Q off a single disk on node 0)

              2.5.64-mjb3  baseline
         2.5.64-mjb3-ext2  with concurrent balloc
    2.5.64-mjb3-ext2_plus  with concurrent balloc + ialloc

dbench32:
	2.5.64-mjb3
Throughput 187.637 MB/sec (NB=234.546 MB/sec  1876.37 MBit/sec)  32 procs
	2.5.64-mjb3-ext2
Throughput 378.664 MB/sec (NB=473.33 MB/sec  3786.64 MBit/sec)  32 procs
	2.5.64-mjb3-ext2-plus
Throughput 514.092 MB/sec (NB=642.615 MB/sec  5140.92 MBit/sec)  32 procs

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         1.8%
         2.5.64-mjb3-ext2       102.0%         1.1%
    2.5.64-mjb3-ext2_plus       105.4%         0.7%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         3.7%
         2.5.64-mjb3-ext2       106.1%         3.1%
    2.5.64-mjb3-ext2_plus       105.3%         3.3%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         1.5%
         2.5.64-mjb3-ext2       101.1%         2.1%
    2.5.64-mjb3-ext2_plus       103.7%         1.9%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         0.2%
         2.5.64-mjb3-ext2       113.3%         0.7%
    2.5.64-mjb3-ext2_plus       118.8%         0.2%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         1.1%
         2.5.64-mjb3-ext2       167.1%         0.8%
    2.5.64-mjb3-ext2_plus       187.7%         0.6%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         0.9%
         2.5.64-mjb3-ext2       170.7%         0.1%
    2.5.64-mjb3-ext2_plus       196.3%         0.2%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         0.7%
         2.5.64-mjb3-ext2       157.2%         0.5%
    2.5.64-mjb3-ext2_plus       177.4%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.5.64-mjb3       100.0%         0.3%
         2.5.64-mjb3-ext2       151.3%         0.8%
    2.5.64-mjb3-ext2_plus       161.3%         0.1%

