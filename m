Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265395AbUFXPAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265395AbUFXPAF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265398AbUFXO76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:59:58 -0400
Received: from [213.171.41.46] ([213.171.41.46]:53523 "EHLO
	kaamos.homelinux.net") by vger.kernel.org with ESMTP
	id S265395AbUFXO7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:59:16 -0400
From: Alexey Kopytov <alexeyk@mysql.com>
Organization: MySQL AB
To: linux-kernel@vger.kernel.org
Subject: Followup to random file I/O regressions
Date: Thu, 24 Jun 2004 18:58:23 +0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406241858.23356.alexeyk@mysql.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

As a follow-up to my previous benchmark results posted a while back, I ran 
some more benchmarks on 2.4.27-rc1 and 2.6.7. Basically I was trying to spot 
a reason for remaining regressions. Summing up the results, 2.6.7 performs 
much better on this workload as compared to previous 2.6 kernels, but it 
seems like large file sizes and large numbers of files cause 2.6 to perform 
slower than 2.4 in the sysbench fileio tests.

Test setup was an IDE hard drive with an ext3 partition with data=ordered, 
anticipatory scheduler for 2.6.7, LinuxThreads. The filesystem was remounted 
before each test run. All results below are average execution times of 3 
sequential test runs with the same parameters.

16 threads, 128 files, variable total file size:
        2.4.27-rc1      2.6.7
1 GB    73.78           75.75
2 GB    86.8            88.09
4 GB    99.02           108.99
8 GB    115.07          124.53
16 GB   134.69          136.63

It's interesting that 2.6 shows a significant regression on 4 and 8 GB, but 
only a minor regression on 16 GB.

1 thread, 4 GB total file size, variable number of files:
        2.4.27-rc1      2.6.7
1       94              93.02
2       95.03           93.37
4       94.27           93.94
8       95.55           94.28
16      95.67           95.36
32      95.87           96.93
64      97.39           99.39
128     99.36           101.89
256     103.51          103.8

Here 2.6 shows better results for small number of files but worse for 32 and 
above files.

1 file, 4 GB total file size, variable number of threads:
        2.4.27-rc1      2.6.7
1       94              93.02
2       96.6            93.26
4       94.93           90.16
8       89.49           87.45
16      86.25           86.2
32      88.14           85.13

Here 2.6 performs better in all tests.

Formatted results and graphs are published on the sysbench homepage at 
http://sysbench.sourceforge.net/results/fileio/20040623.html

Regards,
Alexey.

-- 
Alexey Kopytov, Software Developer
MySQL AB, www.mysql.com

Are you MySQL certified?  www.mysql.com/certification
