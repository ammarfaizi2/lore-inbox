Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268873AbTBZSO7>; Wed, 26 Feb 2003 13:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268871AbTBZSNj>; Wed, 26 Feb 2003 13:13:39 -0500
Received: from franka.aracnet.com ([216.99.193.44]:15232 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268855AbTBZSNA>; Wed, 26 Feb 2003 13:13:00 -0500
Date: Wed, 26 Feb 2003 10:23:09 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, lse-tech@projects.sourceforge.net, akpm@digeo.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] New dcache / inode hash tuning patch
Message-ID: <15730000.1046283789@[10.10.2.4]>
In-Reply-To: <20030226164904.GA21342@wotan.suse.de>
References: <20030226164904.GA21342@wotan.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It actually seems a fraction slower (see systimes for Kernbench-16,
for instance).

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       43.92      557.65       94.12     1483.50
         2.5.62-mjb3-andi       44.28      557.90       95.79     1475.67

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       45.21      560.46      114.58     1492.67
         2.5.62-mjb3-andi       45.39      561.29      117.73     1495.67

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         3.1%
              2.5.62-mjb3-andi       101.8%         6.6%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         4.0%
              2.5.62-mjb3-andi        96.4%         4.8%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         2.0%
              2.5.62-mjb3-andi       100.4%         2.4%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         4.6%
              2.5.62-mjb3-andi       100.3%         2.3%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         2.7%
              2.5.62-mjb3-andi        96.6%         4.3%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         0.9%
              2.5.62-mjb3-andi        97.0%         2.1%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         1.1%
              2.5.62-mjb3-andi       100.2%         0.6%


Diffprofile (+ worse with your patch, - better)

       500     3.1% total
       138     6.9% .text.lock.file_table
       103     2.2% default_idle
        73     9.3% d_lookup
        50    11.0% __copy_to_user_ll
        45    27.4% file_move
        40    28.2% path_lookup
...        
	-7    -3.9% do_schedule
        -9    -2.0% get_empty_filp
       -10    -8.6% dput
       -10    -9.8% link_path_walk

That text.lock.file_table has been bugging me for a bit, and I need to
drill down into it some more.

M.

