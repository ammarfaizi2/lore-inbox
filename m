Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261749AbSJZAYp>; Fri, 25 Oct 2002 20:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261750AbSJZAYp>; Fri, 25 Oct 2002 20:24:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:50883 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261749AbSJZAYn>; Fri, 25 Oct 2002 20:24:43 -0400
Subject: Re: [PATCH] NUMA scheduler 1/2
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Theurer <habanero@us.ibm.com>
In-Reply-To: <200210251937.53335.efocht@ess.nec.de>
References: <200210111954.30447.efocht@ess.nec.de> 
	<200210251937.53335.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 25 Oct 2002 17:29:18 -0700
Message-Id: <1035592159.9367.1696.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 10:37, Erich Focht wrote:
> Here come the rediffed (for 2.5.44) patches for my version of the
> NUMA scheduler extensions. I'm only sending the first two parts of
> the complete set of 5 patches (which make the node affine NUMA scheduler
> with dynamic homenode selection). The two patches lead to a pooling
> NUMA scheduler with initial load balancing at exec().
> 

These patches produced a kernel that built and booted first try for
me.  Thanks.  I ran kernbench and your numa_test (schedbench) on 
this numa scheduler (erich44), my simple numa scheduler (hbaum44), and 
a stock kernel (stock44).

Kernbench:
                             Elapsed        User      System         CPU
                 stock44      21.08s     196.80s      58.14s     1208.8%
                 hbaum44      20.49s     192.57s      50.32s     1184.8%
                 erich44      21.01s     193.47s      56.71s     1191.0%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock44       39.47       49.99      157.94        0.96
                 hbaum44       38.43       48.76      153.77        1.12
                 erich44       24.28       36.10       97.15        0.79

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock44       49.46       71.07      395.77        1.92
                 hbaum44       37.52       57.99      300.25        2.17
                 erich44       30.67       47.93      245.48        2.59

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock44       64.17       81.48     1026.94        6.41
                 hbaum44       52.23       73.23      835.81        5.18
                 erich44       52.25       61.20      836.12        4.69

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock44       72.45      165.86     2318.84       12.78
                 hbaum44       56.74      137.58     1816.17        8.81
                 erich44       55.98      121.19     1791.58        9.35

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
                 stock44      110.31      461.29     7060.60       26.02
                 hbaum44       58.30      255.90     3732.08       20.10
                 erich44       56.94      237.09     3644.95       21.26

The results seem fairly consistent with what we have been seeing all
along.  Erich's scheduler tends to be about the same as stock on 
kernbench, while mine is roughly 5% better.
  
On schedbench Erich's does better on small loads, but as 
the load increases to one task per cpu it becomes a dead heat between
the two.

It is probably worth noting that my scheduler change is a bit smaller
with 146 insertions, 27 deletions across 3 files, versus 432 insertions,
127 deletions across 4 files.  But that should be expected, as my goal
was to keep the changes as small as possible, while still providing 
measureable performance gains.
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

