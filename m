Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261535AbRFAWn4>; Fri, 1 Jun 2001 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbRFAWnq>; Fri, 1 Jun 2001 18:43:46 -0400
Received: from dev.audiogalaxy.com ([64.245.48.170]:44553 "EHLO
	dev.audiogalaxy.com") by vger.kernel.org with ESMTP
	id <S261535AbRFAWn0>; Fri, 1 Jun 2001 18:43:26 -0400
Date: Fri, 1 Jun 2001 17:43:28 -0500 (CDT)
From: Michael Merhej <michael@audiogalaxy.com>
To: <linux-kernel@vger.kernel.org>
Subject: More data on 2.4.5 VM issues
Message-ID: <Pine.LNX.4.30.0106011735550.13776-100000@dev.audiogalaxy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.4.5 with Andrea Arcangeli's aa1 patch compiled with himem:

Why is kswapd using so much CPU?  If you reboot the machine and run the
same user process kswapd CPU usage is almost 0% and none of the swap is
used.  This machine was upgraded from 2.2 and we did not have the luxury of
re-partitioning it support the "new" 2.4 swap size requirements.

After running for a few days with relatively constant memory usage:
vmstat:
  procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 2  0  1 136512   5408    504 209744   0   0     0     2   19    49  10
26  64



top:

  5:38pm  up 3 days, 19:44,  2 users,  load average: 2.08, 2.13, 2.15
34 processes: 32 sleeping, 2 running, 0 zombie, 0 stopped
CPU0 states: 16.0% user, 56.4% system, 16.2% nice, 26.3% idle
CPU1 states: 11.1% user, 57.0% system, 11.0% nice, 31.3% idle
Mem:  1028804K av, 1023744K used,    5060K free,       0K shrd,     504K
buff
Swap:  136512K av,  136512K used,       0K free                  209876K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
28442 root      18  10  898M 812M 36188 R N  56.0 80.9 296:12
gateway.smart.5
28438 root      16  10  898M 811M 35084 S N  43.7 80.7 291:03
gateway.smart.5
    5 root       9   0     0    0     0 SW   37.6  0.0 164:58 kswapd
 2509 root      18   0   492  492   300 R     2.5  0.0   0:00 top
    1 root       9   0    68    0     0 SW    0.0  0.0   0:08 init
    2 root       9   0     0    0     0 SW    0.0  0.0   0:00 keventd
    3 root      19  19     0    0     0 SWN   0.0  0.0   1:11
ksoftirqd_CPU0
    4 root      19  19     0    0     0 SWN   0.0  0.0   1:04
ksoftirqd_CPU1
    6 root       9   0     0    0     0 SW    0.0  0.0   0:00 kreclaimd
    7 root       9   0     0    0     0 SW    0.0  0.0   0:00 bdflush
    8 root       9   0     0    0     0 SW    0.0  0.0   0:07 kupdated
   11 root       9   0     0    0     0 SW    0.0  0.0   0:00 scsi_eh_0
  315 root       9   0   100    0     0 SW    0.0  0.0   0:00 syslogd


Hope this helps


