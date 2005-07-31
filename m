Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVGaNof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVGaNof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 09:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGaNnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 09:43:05 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:64980 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261761AbVGaNkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 09:40:35 -0400
Date: Sun, 31 Jul 2005 09:35:38 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [sched, patch] better wake-balancing, #2
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-ia64 <linux-ia64@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Message-ID: <200507310938_MC3-1-A602-740A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005 at 08:29:27 +0200, Ingo Molnar wrote:

> > I tested this with Volanomark on dual-processor PII Xeon -- the 
> > results were very bad:
>
> which patch have you tested? The mail you replied to above is for patch
> #2, while on SMT/HT boxes it's patch #3 that is the correct approach.

 Since my system is not HT, I used patch #2.

> furthermore, which base kernel have you applied the patch to?

 2.6.13-rc3

 Results for -rc4 follow, with the latest patchsets:

Volanomark results for 2.6.13-rc4
System: Dell Workstation 610 (i440GX)
2 x Pentium II Xeon 2MB cache 350MHz

[Sun Jul 31 06:58:31 EDT 2005] Test started.
Kernel: 2.6.13-rc4a #1 SMP
Patches: sched-rollup + better-wake-balance
test-1.log: Average throughput = 4905 messages per second
test-2.log: Average throughput = 5583 messages per second
test-3.log: Average throughput = 5624 messages per second
test-4.log: Average throughput = 5526 messages per second
test-1.log: Average throughput = 5584 messages per second
test-2.log: Average throughput = 5430 messages per second
test-3.log: Average throughput = 5263 messages per second
test-4.log: Average throughput = 5425 messages per second
[Sun Jul 31 07:17:02 EDT 2005] Test ended.
timestamp 76174
cpu0 0 0 6 6 78 17319 6612 5663 5236 6510 621 10707
domain0 3 144251 144099 138 3156 15 3 0 144099 84 82 2 18 0 0 0 82 6622 6546 66 631 10 1 0 6546 2 2 0 0 0 0 0 0 0 486 449 0
cpu1 0 0 0 0 50 7888 2914 1984 1498 2008 1576 4974
domain0 3 146154 146000 121 2226 33 17 0 146000 62 58 2 24 2 0 0 58 2926 2824 89 953 15 5 0 2824 0 0 0 0 0 0 0 0 0 427 407 0
version 12
timestamp 357112
cpu0 6903 32226 44787 3345829 56425 6652018 20466 14097 11629 162123 21377675 6631552
domain0 3 269777 267819 1353 194144 6129 602 0 267819 4041 2818 70 1305809 164558 75 0 2818 37869 15488 4978 14472687 1280712 1583 0 15488 2 2 0 0 0 0 0 0 0 2198 1290 0
cpu1 7764 33269 44559 3354402 57092 6697864 19910 12189 9991 155123 21297442 6677954
domain0 3 274148 272109 1433 180072 4066 441 0 272109 3981 2775 60 1259541 167938 99 0 2775 37372 14157 5752 14238933 1278568 1334 0 14157 0 0 0 0 0 0 0 0 0 2468 1438 0

[Sun Jul 31 07:33:09 EDT 2005] Test started.
Kernel: 2.6.13-rc4a #2 SMP
Patches: sched-rollup
test-1.log: Average throughput = 5112 messages per second
test-2.log: Average throughput = 5662 messages per second
test-3.log: Average throughput = 5809 messages per second
test-4.log: Average throughput = 5977 messages per second
test-1.log: Average throughput = 5976 messages per second
test-2.log: Average throughput = 6008 messages per second
test-3.log: Average throughput = 5855 messages per second
test-4.log: Average throughput = 6017 messages per second
[Sun Jul 31 07:51:00 EDT 2005] Test ended.
version 12
timestamp 4294911410
cpu0 0 0 0 0 56 6018 1969 3037 1846 4008 5751 4049
domain0 3 14739 14634 99 2000 8 4 0 14634 31 30 1 10 0 0 0 30 1971 1921 48 443 2 0 0 1921 2 1 1 0 0 0 0 0 0 1247 502 0
cpu1 0 0 0 0 40 5357 1792 2832 1583 1176 1568 3565
domain0 3 14867 14788 76 1520 3 1 0 14788 35 34 1 5 0 0 0 34 1797 1749 42 411 7 3 0 1749 0 0 0 0 0 0 0 0 0 1191 469 0
version 12
timestamp 212533
cpu0 10030 29290 30736 3372251 41704 6164156 19216 2636963 2026635 148591 23876540 6144940
domain0 3 138859 136778 1343 139015 3507 558 0 136778 3404 2644 49 704633 103491 32 0 2644 28623 15546 3670 4623415 467816 1395 0 15546 2 1 1 0 0 0 0 0 0 595792 264363 0
cpu1 4739 24137 31111 3387783 36850 6143087 12792 2610468 2014674 145416 24188585 6130295
domain0 3 139219 137155 1287 133527 3930 457 0 137155 3366 2714 46 569294 85214 46 0 2714 22259 8839 3952 4783355 487041 1084 0 8839 0 0 0 0 0 0 0 0 0 610328 262829 0

[Sun Jul 31 08:39:05 EDT 2005] Test started.
Kernel: 2.6.13-rc4a #3 SMP
Patches: none
test-1.log: Average throughput = 5243 messages per second
test-2.log: Average throughput = 5816 messages per second
test-3.log: Average throughput = 5886 messages per second
test-4.log: Average throughput = 6039 messages per second
test-1.log: Average throughput = 5911 messages per second
test-2.log: Average throughput = 5934 messages per second
test-3.log: Average throughput = 5928 messages per second
test-4.log: Average throughput = 6053 messages per second
[Sun Jul 31 08:56:52 EDT 2005] Test ended.
version 12
timestamp 4294911037
cpu0 0 0 0 0 44 5715 1877 2877 1656 1196 1427 3838
domain0 3 14886 14817 57 70 13 0 0 14817 29 29 0 0 0 0 0 29 1878 1866 11 12 1 0 0 1866 0 0 0 0 0 0 0 0 0 1168 551 0
cpu1 0 0 0 0 55 4498 1522 2269 1099 550 131 2976
domain0 3 15108 15066 37 42 5 0 0 15066 16 16 0 0 0 0 0 16 1523 1513 8 10 2 0 0 1513 2 2 0 0 0 0 0 0 0 1221 532 0
version 12
timestamp 211196
cpu0 1784 20283 27831 3378283 31894 6122681 18841 2586384 2080058 145291 24152181 6103840
domain0 3 138711 136342 402 22486 21019 25 0 136342 3689 3115 17 16077 15996 0 0 3115 21229 18330 511 21079 19823 19 0 18330 0 0 0 0 0 0 0 0 0 502182 219444 0
cpu1 10295 29015 28139 3391580 40743 6142466 18965 2589921 2087737 143278 24294054 6123501
domain0 3 140333 137972 378 22362 20974 11 0 137972 3623 3075 20 15786 15695 1 0 3075 21435 18517 447 19642 18459 48 0 18517 2 2 0 0 0 0 0 0 0 506326 221459 0

__
Chuck
