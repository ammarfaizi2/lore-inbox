Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbTAQSJM>; Fri, 17 Jan 2003 13:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTAQSJM>; Fri, 17 Jan 2003 13:09:12 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58619 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267624AbTAQSJL>;
	Fri, 17 Jan 2003 13:09:11 -0500
Subject: Re: [patch] sched-2.5.59-A2
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Erich Focht <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Andrew Theurer <habanero@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0301171607510.10244-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Jan 2003 10:19:37 -0800
Message-Id: <1042827580.27149.379.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 07:11, Ingo Molnar wrote:

> agreed, i've attached the -B0 patch that does this. The balancing rates
> are 1 msec, 2 msec, 200 and 400 msec (idle-local, idle-global, busy-local,
> busy-global).
> 
> 	Ingo

Ran this patch on a 4 node (16 CPU, 16 GB memory) NUMAQ.  Results don't
look encouraging.  I would suggest not applying this patch until the
degradation is worked out.

stock59 = linux 2.5.59
ingo59 = linux 2.5.59 with Ingo's B0 patch

Kernbench:
                        Elapsed       User     System        CPU
             stock59    29.668s   283.762s    82.286s      1233%
              ingo59    37.736s   338.162s   153.486s    1302.6%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock59       0.00      24.44      68.07       0.78
              ingo59       0.00      62.14     163.32       1.93

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock59       0.00      48.26     246.75       1.64
              ingo59       0.00      68.17     376.85       6.42

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock59       0.00      56.51     845.26       2.98
              ingo59       0.00     114.38    1337.65      18.89

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock59       0.00     116.95    1806.33       6.23
              ingo59       0.00     243.46    3515.09      43.92

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
             stock59       0.00     237.29    3634.59      15.71
              ingo59       0.00     688.31   10605.40     102.71

-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

