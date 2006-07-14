Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161317AbWGNWeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWGNWeY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 18:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWGNWeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 18:34:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:10730 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161317AbWGNWeY (ORCPT <rfc822;linux-kerneL@vger.kernel.org>);
	Fri, 14 Jul 2006 18:34:24 -0400
Subject: Re: RT exec for exercising RT kernel capabilities
From: Lee Revell <rlrevell@joe-job.com>
To: markh@compro.net
Cc: linux-kerneL@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <448876B9.9060906@compro.net>
References: <448876B9.9060906@compro.net>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 18:34:15 -0400
Message-Id: <1152916456.3119.92.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 15:12 -0400, Mark Hounschell wrote:
> ftp://ftp.compro.net/public/rt-exec/

The high res timers do not seem to be working.  Using 2.6.17-rt3 and
glibc 2.3.6, I get the exact same (bad) results whether
CONFIG_HIGH_RES_TIMERS is enabled or not.

CONFIG_HIGH_RES_TIMERS=y, CONFIG_HIGH_RES_RESOLUTION=1000:

# Run 00:40:12:784  Posix-hrt   14:27:38  Work:200   CPU:14 Avg:14 Max:23 Pg:0
# DataPool:SHM      Exec Heart Beat Rate:1000Hz      Exec Revision:1.0.3-1
###############################################################################
#          Task Sched Cpu     Intr   Late         -Interrupt Latencies (usec)- 
# Taskname Type  Pr P Mask     Cnt    Cnt   Spare Current  Best   Worst  Determ
# exec      hrt   5 F  2   2412784      0     871       2     1      18      17
# task1     dth  29 F  2    603196      0    3993      19    17      70      53
# task2     dth  28 F  2    603196      1    3993      19    17     128     111
# task3     sth  25 F  2   1206392      0    1993      18    14      40      26
# task4     sth  24 F  2   1206392      0    1993      18    13      37      24
# task5     sem  23 F  2   2412784      0     993       4     3      28      25
# task6     sem  22 F  2   1206392      0    1993       4     3      10       7
# task7     sig  19 F  2   1206392      0    1993       7     7      17      10
# task8     sig  18 F  2   1206392      0    1993       8     6      18      12
# task9     hrt  17 R  2   1017659      0    1993     763   712    2185    1473
# task10    hrt  17 R  2   1017798      0    1993     771   717   13879   13162
# task11    hrn  14 R  2   1586789      0     993    1060   690   15817   15127
# task12    hrn  14 R  2   1586620      0     993    1024   689   15743   15054
# task13    hru  11 R  2   1557359      0     993    1053   689    2972    2283
# task14    hru  11 R  2   1561189      0     993    1018   690    3010    2320
# task15    bth   7 R  2   2412784      0     994      29    13      55      42
# task16    bth   7 R  2   2412784      0     993      14    13      56      43

CONFIG_HIGH_RES_TIMERS=n:

# Run 00:03:59:384  Posix-hrt   18:24:45  Work:200   CPU:14 Avg:14 Max:19 Pg:0
# DataPool:SHM      Exec Heart Beat Rate:1000Hz      Exec Revision:1.0.3-1
###############################################################################
#          Task Sched Cpu     Intr   Late         -Interrupt Latencies (usec)-
# Taskname Type  Pr P Mask     Cnt    Cnt   Spare Current  Best   Worst  Determ
# exec      hrt   5 F  2    239384      0     870       1     1      13      12
# task1     dth  29 F  2     59847      0    3993      19    17      39      22
# task2     dth  28 F  2     59846      0    3993      19    17      39      22
# task3     sth  25 F  2    119693      0    1993      18    17      37      20
# task4     sth  24 F  2    119692      0    1993      19    14      41      27
# task5     sem  23 F  2    239385      0     993       5     4      26      22
# task6     sem  22 F  2    119693      0    1993       5     4       9       5
# task7     sig  19 F  2    119693      0    1993       8     7      15       8
# task8     sig  18 F  2    119692      0    1993       8     6      15       9
# task9     hrt  17 R  2    104060      0    1992    1108   724   11439   10715
# task10    hrt  17 R  2    104057      0    1993    1102   726   12923   12197
# task11    hrn  14 R  2    161028      0     994    1056   705   13001   12296
# task12    hrn  14 R  2    160951      0     993    1019   704   12456   11752
# task13    hru  11 R  2    158334      0     993    1054   744    3109    2365
# task14    hru  11 R  2    158729      0     993    1020   709    3066    2357
# task15    bth   7 R  2    239385      0     993      29    13      54      41
# task16    bth   7 R  2    239385      0     993      15    13      55      42

Any idea what could be wrong?

Lee

