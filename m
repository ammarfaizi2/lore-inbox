Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261872AbSJ0SNY>; Sun, 27 Oct 2002 13:13:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSJ0SNY>; Sun, 27 Oct 2002 13:13:24 -0500
Received: from franka.aracnet.com ([216.99.193.44]:3250 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261872AbSJ0SNW>; Sun, 27 Oct 2002 13:13:22 -0500
Date: Sun, 27 Oct 2002 10:16:58 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       mingo@redhat.com, habanero@us.ibm.com
cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3105925354.1035713817@[10.10.2.3]>
In-Reply-To: <3022997410.1035634489@[10.10.2.3]>
References: <3022997410.1035634489@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I went to your latest patches (just 1 and 2). And they worked!
> You've fixed the performance degradation problems for kernel compile
> (now a 14% improvement in systime), that core set works without 
> further futzing about or crashing, with or without TSC, on either 
> version of gcc ... congrats!

So I have a slight correction to make to the above ;-) Your patches
do work just fine, no crashes any more. HOWEVER ... turns out I only
had the first patch installed, not both. Silly mistake, but turns out
to be very interesting. 

So your second patch is the balance on exec stuff ... I've looked at 
it, and think it's going to be very expensive to do in practice, at
least the simplistic "recalc everything on every exec" approach. It 
does benefit the low end schedbench results, but not the high end ones,
and you can see the cost of your second patch in the system times of
the kernbench.

In summary, I think I like the first patch alone better than the 
combination, but will have a play at making a cross between the two.
As I have very little context about the scheduler, would appreciate
any help anyone would like to volunteer ;-)

Corrected results are:

Kernbench:
                             Elapsed        User      System         CPU
              2.5.44-mm4     19.676s    192.794s     42.678s     1197.4%
        2.5.44-mm4-hbaum     19.422s    189.828s     40.204s     1196.2%
      2.5.44-mm4-focht-1      19.46s    189.838s     37.938s       1171%
     2.5.44-mm4-focht-12      20.32s        190s       44.4s     1153.6%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       32.45       49.47      129.86        0.82
        2.5.44-mm4-hbaum       31.31       43.85      125.29        0.84
      2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
     2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       39.90       61.48      319.26        2.79
        2.5.44-mm4-hbaum       32.63       46.56      261.10        1.99
      2.5.44-mm4-focht-1       37.76       61.09      302.17        2.55
     2.5.44-mm4-focht-12       28.40       34.43      227.25        2.09

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       62.99       93.59     1008.01        5.11
        2.5.44-mm4-hbaum       49.78       76.71      796.68        4.43
      2.5.44-mm4-focht-1       51.69       60.23      827.20        4.95
     2.5.44-mm4-focht-12       51.24       60.86      820.08        4.23

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       88.13      194.53     2820.54       11.52
        2.5.44-mm4-hbaum       54.67      147.30     1749.77        7.91
      2.5.44-mm4-focht-1       56.71      123.62     1815.12        7.92
     2.5.44-mm4-focht-12       55.69      118.85     1782.25        7.28

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4      159.92      653.79    10235.93       25.16
        2.5.44-mm4-hbaum       65.20      300.58     4173.26       16.82
      2.5.44-mm4-focht-1       55.60      232.36     3558.98       17.61
     2.5.44-mm4-focht-12       56.03      234.45     3586.46       15.76


