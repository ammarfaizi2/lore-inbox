Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268656AbTBZGE1>; Wed, 26 Feb 2003 01:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268659AbTBZGE1>; Wed, 26 Feb 2003 01:04:27 -0500
Received: from franka.aracnet.com ([216.99.193.44]:8660 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268656AbTBZGEZ>; Wed, 26 Feb 2003 01:04:25 -0500
Date: Tue, 25 Feb 2003 22:14:29 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>
cc: zilvinas@gemtek.lt, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 2.5.62-mm3] objrmap fix for X
Message-ID: <40780000.1046240068@[10.10.2.4]>
In-Reply-To: <453440000.1046214174@[10.1.1.5]>
References: <20030223230023.365782f3.akpm@digeo.com>
 <3E5A0F8D.4010202@aitel.hist.no><20030224121601.2c998cc5.akpm@digeo.com>
 <20030225094526.GA18857@gemtek.lt><20030225015537.4062825b.akpm@digeo.com>
 <131360000.1046195828@[10.1.1.5]>
 <20030225132755.241e85ac.akpm@digeo.com><359700000.1046209586@[10.1.1.5]>
 <453440000.1046214174@[10.1.1.5]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Keep the flag for now, find the escaped page under X, remove the flag
>>> later?
>> 
>> It occurred to me I'm already using (abusing?) the flag for nonlinear
>> pages, so I have to keep it.  I'll chase solutions for X.
> 
> Ok, the vm_ops->nopage function is set in drivers like drm and agp.  I
> don't think it's reasonable to require all of them to set PageAnon.  So
> here's a patch that tests the page on do_no_page and sets the flag
> appropriately.

Well, it runs fine, but I get truly freaky performance results. My machine
might have gone wacko on me or something - the patch seems perfectly simple
to me. Kernbench is all over the map - user and elapsed way up, system is
down. Ummm .. probably all too strange to be true, and I've made a mistake,
but if some more sane person than I could run a quick test, would help.

Thanks,

M.

Kernbench-2: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       43.92      557.65       94.12     1483.50
                     test       68.61      923.78       90.19     1477.33

Kernbench-16: (make -j N vmlinux, where N = 16 x num_cpus)
                              Elapsed        User      System         CPU
              2.5.62-mjb3       45.21      560.46      114.58     1492.67
                     test       69.04      927.20      100.56     1488.17

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         3.1%
                          test        83.9%         1.7%

SDET 2  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         4.0%
                          test        87.0%         3.8%

SDET 4  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         2.0%
                          test        90.3%         2.1%

SDET 8  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         4.6%
                          test        95.6%         6.3%

SDET 16  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         2.7%
                          test       103.0%         3.4%

SDET 32  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         0.9%
                          test        96.6%         1.0%

SDET 64  (see disclaimer)
                                Throughput    Std. Dev
                   2.5.62-mjb3       100.0%         1.1%
                          test        94.8%         0.6%

