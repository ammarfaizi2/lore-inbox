Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264785AbSLFRam>; Fri, 6 Dec 2002 12:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSLFRam>; Fri, 6 Dec 2002 12:30:42 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:14505 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264785AbSLFRak>;
	Fri, 6 Dec 2002 12:30:40 -0500
Subject: Re: [PATCH 2.5.50] NUMA scheduler (1/2)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200212021629.39060.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
	<347990000.1037648441@flay> <200211191726.07214.efocht@ess.nec.de> 
	<200212021629.39060.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 09:39:36 -0800
Message-Id: <1039196377.27585.94.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-02 at 07:29, Erich Focht wrote:
> Here come the NUMA scheduler patches rediffed for 2.5.50. No
> functional changes since last version (
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103772346430798&w=2 ).

Tested on NUMAQ.  Ran into the problem of the missing CPU stats from
/proc/self/cpu so initial test results were worthless.  Applied Erich's
patch that restored this information and ran on NUMAQ.  As previous 
versions, result was a modest performance gain on kernbench and a more
significant performance gain on Erich's memory intensive test (fondly 
referred to here as schedbench).

Kernbench:
                             Elapsed        User      System         CPU
                stock50a      20.92s     194.12s      53.15s       1182%
                 sched50     20.002s    191.976s      51.17s       1215%

Schedbench 4:
                             AvgUser     Elapsed   TotalUser    TotalSys
                stock50a       29.50       43.11      118.02        0.83
                 sched50       33.93       47.17      135.76        0.74

Schedbench 8:
                             AvgUser     Elapsed   TotalUser    TotalSys
                stock50a       46.88       62.51      375.12        1.78
                 sched50       33.90       47.31      271.30        1.98

Schedbench 16:
                             AvgUser     Elapsed   TotalUser    TotalSys
                stock50a       56.26       71.17      900.32        6.23
                 sched50       57.22       73.34      915.76        4.53

Schedbench 32:
                             AvgUser     Elapsed   TotalUser    TotalSys
                stock50a       84.86      191.48     2715.76       10.93
                 sched50       57.36      130.88     1835.76       10.46

Schedbench 64:
                             AvgUser     Elapsed   TotalUser    TotalSys
                stock50a      114.91      474.55     7355.45       24.95
                 sched50       80.20      338.04     5133.56       22.70

In other testing we are seeing unexpectedly high idle times.  Andrea has
patches against 2.4 port of the O(1) scheduler that are suppose to help
with this.  I plan to try those out to see if they reduce our idle time.

                Michael

> 
> Regards,
> Erich
> ----

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

