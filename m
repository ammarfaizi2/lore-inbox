Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267566AbTAGXZm>; Tue, 7 Jan 2003 18:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267098AbTAGXZl>; Tue, 7 Jan 2003 18:25:41 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:27088 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267566AbTAGXZg>;
	Tue, 7 Jan 2003 18:25:36 -0500
Subject: Re: [PATCH 2.5.53] NUMA scheduler (1/3)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>, Stephen Hemminger <shemminger@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200301071227.09985.efocht@ess.nec.de>
References: <200211061734.42713.efocht@ess.nec.de>
	<234590000.1041833252@titus> <1041906222.21653.50.camel@kenai> 
	<200301071227.09985.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Jan 2003 15:35:17 -0800
Message-Id: <1041982519.24867.71.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 03:27, Erich Focht wrote:
> Hi Michael and Martin,
> 
> thanks a lot for the testing!
> 
> I rechecked the changes and really don't see any reason for a
> slowdown. Michael's measurements seem to confirm that this is just a
> statistical effect. I suggest: when in doubt, do 10 kernel compiles
> instead of 5. A simple statistical error estimation as I did for
> schedbench might help, too. Guess I've sent you the script a while
> ago.
> 
One more set of test results, this time including schedbench.  Previous
runs did not have the cputimes_stat patch, so the schedbench numbers
were not particularly useful.

Kernbench:
                        Elapsed       User     System        CPU
          oldsched54     29.75s    287.02s    82.876s    1242.8%
             sched54    29.112s   283.888s     82.84s    1259.4%
             stock54    31.348s   303.134s    87.824s    1247.2%
             sched50     29.96s   288.308s    83.606s    1240.8%
             stock50    31.074s   303.664s    89.194s    1264.2%

Schedbench 4:
                        AvgUser    Elapsed  TotalUser   TotalSys
          oldsched54      20.44      37.41      81.81       0.93
             sched54      22.03      34.90      88.15       0.75
             stock54      49.35      57.53     197.45       0.86
             sched50      22.00      35.50      88.04       0.86
             stock50      27.18      45.99     108.75       0.87

Schedbench 8:
                        AvgUser    Elapsed  TotalUser   TotalSys
          oldsched54      31.98      51.59     255.88       1.93
             sched54      27.95      37.12     223.66       1.50
             stock54      43.14      62.97     345.18       2.12
             sched50      32.05      46.81     256.45       1.81
             stock50      44.75      63.68     358.09       2.55

Schedbench 16:
                        AvgUser    Elapsed  TotalUser   TotalSys
          oldsched54      58.39      80.29     934.38       4.30
             sched54      55.37      69.58     886.10       3.79
             stock54      66.00      81.25    1056.25       7.12
             sched50      55.34      70.74     885.61       4.09
             stock50      65.36      80.72    1045.94       5.92

Schedbench 32:
                        AvgUser    Elapsed  TotalUser   TotalSys
          oldsched54      54.53     119.71    1745.37      11.70
             sched54      57.93     132.11    1854.01      10.74
             stock54      77.81     173.26    2490.31      12.37
             sched50      59.47     139.77    1903.37      10.24
             stock50      84.51     194.89    2704.83      12.44

Schedbench 64:
                        AvgUser    Elapsed  TotalUser   TotalSys
          oldsched54      79.57     339.88    5093.31      20.74
             sched54      72.91     308.87    4667.03      21.06
             stock54      86.68     368.55    5548.57      25.73
             sched50      63.55     276.81    4067.65      21.58
             stock50      99.68     422.06    6380.04      25.92

Row names are the same as before (see below).  Numbers seem to be
fairly consistent.

> I understand from your emails that the 2.5.53 patches apply and work
> for 2.5.54, therefore I'll wait for 2.5.55 with a rediff.

It is fine with me to wait for 2.5.55 to rediff.  I'm getting patch
errors now with the cputime_stat patch, so a rediff of that with
2.5.55 would be handy (although I suppose I should quit being lazy
and just do that myself).
> 
> Regards,
> Erich

             Michael
> 
> 
> On Tuesday 07 January 2003 03:23, Michael Hohnbaum wrote:
> > On Sun, 2003-01-05 at 22:07, Martin J. Bligh wrote:
> > > >> > Kernbench:
> > > >> >                         Elapsed       User     System        CPU
> > > >> >              sched50     29.96s   288.308s    83.606s    1240.8%
> > > >> >              sched52    29.836s   285.832s    84.464s    1240.4%
> > > >> >              sched53    29.364s   284.808s    83.174s    1252.6%
> > > >> >              stock50    31.074s   303.664s    89.194s    1264.2%
> > > >> >              stock53    31.204s   306.224s    87.776s    1263.2%
> > > >
> > > > sched50 = linux 2.5.50 with the NUMA scheduler
> > > > sched52 = linux 2.5.52 with the NUMA scheduler
> > > > sched53 = linux 2.5.53 with the NUMA scheduler
> > > > stock50 = linux 2.5.50 without the NUMA scheduler
> > > > stock53 = linux 2.5.53 without the NUMA scheduler
> > >
> > > I was doing a slightly different test - Erich's old sched code vs the new
> > > both on 2.5.54, and seem to have a degredation.
> > >
> > > M.
> >
> > Martin,
> >
> > I ran 2.5.54 with an older version of Erich's NUMA scheduler and
> > with the version sent out for 2.5.53.  Results were similar:
> >
> > Kernbench:
> >                         Elapsed       User     System        CPU
> >              sched54    29.112s   283.888s     82.84s    1259.4%
> >           oldsched54    29.436s   286.942s    82.722s    1256.2%
> >
> > sched54 = linux 2.5.54 with the 2.5.53 version of the NUMA scheduler
> > oldsched54 = linux 2.5.54 with an earlier version of the NUMA scheduler
> >
> > The numbers for the new version are actually a touch better, but
> > close enough to be within a reasonable margin of error.
> >
> > I'll post numbers against stock 2.5.54 and include schedbench, tomorrow.
> >
> >                Michael
> 
> 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

