Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263676AbTDNUSa (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263686AbTDNUSa (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:18:30 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:52888 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263676AbTDNUSX (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:18:23 -0400
Date: Mon, 14 Apr 2003 13:19:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: BUGed to death
Message-ID: <80690000.1050351598@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems all these bug checks are fairly expensive. I can get 1%
back on system time for kernel compiles by changing BUG to 
"do {} while (0)" to make them all compile away. Profiles aren't
very revealing though ... seems to be within experimental error ;-(

I was pondering CONFIG_RUN_WILD_NAKED_AND_FREE, but maybe we can
just nail a few of the hottest path ones instead (I think you did
a couple already recently). I guess that suggestion isn't much
use without more profile data though ;-)

M.

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.67-mjb2       43.34       76.24      563.55     1476.25
        2.5.67-mjb2-nobug       43.43       75.29      564.12     1471.75

Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.67-mjb2       43.91       85.05      570.61     1493.50
        2.5.67-mjb2-nobug       44.12       84.80      571.10     1485.00

Kernbench: (make -j vmlinux, maximal tasks)
                              Elapsed      System        User         CPU
              2.5.67-mjb2       44.01       85.12      570.10     1488.25
        2.5.67-mjb2-nobug       44.03       83.93      570.37     1485.25


DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         1.9%
        2.5.67-mjb2-nobug       104.1%         0.0%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         1.9%
        2.5.67-mjb2-nobug       106.4%         0.0%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         3.8%
        2.5.67-mjb2-nobug        97.1%         1.3%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         0.9%
        2.5.67-mjb2-nobug       100.7%         0.7%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         1.3%
        2.5.67-mjb2-nobug       102.8%         0.7%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         0.5%
        2.5.67-mjb2-nobug       100.8%         0.5%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         0.4%
        2.5.67-mjb2-nobug       100.6%         0.3%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
              2.5.67-mjb2       100.0%         0.1%
        2.5.67-mjb2-nobug       100.9%         0.2%


RMAPBENCH

rmapbench: 100x100-linear
                              Elapsed      System        User         CPU
              2.5.67-mjb2       44.24      470.00      211.26     1527.67
        2.5.67-mjb2-nobug       51.20      579.11      218.33     1533.33

rmapbench: 100x100-random
                              Elapsed      System        User         CPU
              2.5.67-mjb2        2.99       26.50        0.44      895.67
        2.5.67-mjb2-nobug        3.03       28.02        0.33      892.00

rmapbench: 1x10000-linear
                              Elapsed      System        User         CPU
              2.5.67-mjb2        2.53        1.32        0.19       59.67
        2.5.67-mjb2-nobug        2.37        1.17        0.19       57.00

