Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262679AbTJaBCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 20:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTJaBCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 20:02:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:19128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262679AbTJaBCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 20:02:38 -0500
Date: Thu, 30 Oct 2003 17:02:37 -0800 (PST)
From: Judith Lebzelter <judith@osdl.org>
To: <linux-kernel@vger.kernel.org>
Subject: OSDL Tiobench scheduler comparison - Random Reads Bad
Message-ID: <Pine.LNX.4.33.0310301653140.16485-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello;

We have run tiobench-0.3.3 in Scalable Test Platform at OSDL against the
latest 2.6.0-test kernels and against the base versions of the 2.4 kernel.
Random reads performance at the 128k block size stood out because the
2.4 kernels performed much better than the 2.6 kernels.

The test measures throughput in Mbytes/sec.  I have summarized it here to
show the percent difference from the baseline, which is linux-2.6.0-test7
with the deadline scheduler. The other kernels use their default
schedulers.  The numbers in parentheses are the number of threads.
Bigger numbers are better.  Negative is bad.

Random Reads/128k Block Size
Kernel                       Lowest %   Highest % Ave %   Options
-------------------------------------------------------------------------
linux-2.6.0-test7 (baseline)   0.00(1)  0.00(1)    0.00 elevator=deadline
linux-2.6.0-test7            -67.07(8)  24.42(1) -33.23
linux-2.6.0-test8            -66.28(8)  30.62(1) -31.13 profile=2
2.6.0-test8-mm1                3.23(8) 170.62(1)  64.77 profile=2
linux-2.6.0-test9            -66.34(8)  48.14(1) -27.66 profile=2
linux-2.6.0-test9            -66.46(8)  22.12(1) -33.65 profile=2
linux-2.4.18                  93.48(8) 211.68(1) 156.81 profile=2
linux-2.4.19                 109.39(8) 216.11(1) 162.67 profile=2
linux-2.4.20                 111.40(8) 215.40(1) 163.98


For random reads the Deadline scheduler is better for multiple threads.
The mm1 is better in general.  The 2.4 kernels are a lot better.  (The
test9-mm1 is currently queued)

The results with links to the data are posted at:
http://www.osdl.org/archive/judith/tests/tiobench/new/2.4_2.6/tiobench.2-CPU.ext2.128.html
http://www.osdl.org/archive/judith/tests/tiobench/new/2.4_2.6/tiobench.2-CPU.ext2.4.html


An explanation of the report is at:
   http://developer.osdl.org/judith/tiobench_index.html

We used tiobench-0.3.3 on 2-CPU hosts with 1G of RAM; here are the
options:
   /usr/bin/time -o /root/tiobench/results/tiobench.jfs.times ../tiobenchx.pl --size 2643 --block 4096 --block 131072 --numruns 5 --dir /mnt/sdc


Thanks;

Judith Lebzelter
OSDL



