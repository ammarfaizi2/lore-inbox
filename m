Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTA1Wsi>; Tue, 28 Jan 2003 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbTA1Wsi>; Tue, 28 Jan 2003 17:48:38 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:21764 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id <S261660AbTA1Wsg>; Tue, 28 Jan 2003 17:48:36 -0500
Date: Tue, 28 Jan 2003 17:57:41 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@oddball.prodigy.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BENCHMARK] ctxbench Linux vs. 5.0 BSD
Message-ID: <Pine.LNX.4.44.0301281747160.27504-100000@oddball.prodigy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been hearing a bit of feedback from my BSD friends, several of whom 
are committers, about the superiority of freeBSD over Linux. Recently I 
got an earful of "BSD runs Linux binaries faster than Linux."

SO here's the result of measuring IPC speed on two machines, identical 
except one turns out to be a P=II-350 instead of 400. Doesn't matter, the 
test results are normalized to CPU speed on identical CPUs, and the BSD 
machine was faster so they can't claim a foul.

The results labeled "wcox1" are the test compiled native on BSD. The 
results labeled "wcox_lxexe" are the Linux executable running under the 
Linux environment of BSD. Other than the release of a shared memory 
segment failing in that mode, it did run fine.

I had to hack the Makefile and data extract script slightly to run on BSD, 
I didn't get bash in a default install and just made the Makefile a bit 
more portable. I'll merge that with some pthreads work I'm doing and try 
to release it by the end of the week as a new ctxbench version. All 
results were 1.10 release, compiled from the same source.



================================================================
    Run information
================================================================

Run: wcox1
  CPU_MHz              400
  CPUtype              P-II
  HostName             wcox.prodigy.com
  KernelName           FreeBSD 5.0-RELEASE
  Ncpu                 1
Run: wcox_lxexe
  CPU_MHz              400
  CPUtype              P-II
  HostName             wcox.prodigy.com
  KernelName           FreeBSD 5.0-RELEASE
  Ncpu                 1
Run: 2.5.52
  CPU_MHz              348.395
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           Linux 2.5.52
  Ncpu                 1
Run: 2.5.54
  CPU_MHz              348.444
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           Linux 2.5.54
  Ncpu                 1
Run: 2.5.56
  CPU_MHz              348.427
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           Linux 2.5.56
  Ncpu                 1
Run: 2.5.59n
  CPU_MHz              348.395
  CPUtype              Pentium II (Deschutes)
  HostName             oddball.prodigy.com
  KernelName           Linux 2.5.59-1n
  Ncpu                 1


================================================================
    Results by IPC type
================================================================

                                   loops/sec
SIGUSR1                     low       high    average    avg/MHz
  wcox1                       9        245         94      0.236
  wcox_lxexe                967      13799       5767     14.419
  2.5.52                  40961      41699      41290    118.517
  2.5.54                  39573      39699      39647    113.785
  2.5.56                  36875      36933      36909    105.932
  2.5.59n                 41310      41865      41542    119.239

                                   loops/sec
message queue               low       high    average    avg/MHz
  wcox1                   24485      24792      24653     61.634
  wcox_lxexe              23259      23259      23259     58.148
  2.5.52                  78427      79163      78675    225.823
  2.5.54                  74131      75390      74969    215.156
  2.5.56                  68177      71334      70228    201.557
  2.5.59n                 76381      76537      76472    219.500

                                   loops/sec
pipes                       low       high    average    avg/MHz
  wcox1                   31641      32284      32057     80.143
  wcox_lxexe              31085      31840      31463     78.658
  2.5.52                  77020      77586      77365    222.061
  2.5.54                  70445      70572      70489    202.297
  2.5.56                  66728      71280      69736    200.145
  2.5.59n                 67564      68632      67952    195.044

                                   loops/sec
semiphore                   low       high    average    avg/MHz
  wcox1                   36311      36962      36678     91.697
  wcox_lxexe              33709      34858      34502     86.255
  2.5.52                  84367      84639      84516    242.589
  2.5.54                  77304      77521      77379    222.072
  2.5.56                  77120      77358      77245    221.697
  2.5.59n                 83412      83720      83536    239.774

                                   loops/sec
spin+yield                  low       high    average    avg/MHz
  wcox1                   66551      71060      68807    172.018
  wcox_lxexe              64707      68347      66356    165.890
  2.5.52                 219279     219658     219470    629.947
  2.5.54                 160157     178830     172598    495.341
  2.5.56                 172703     173159     172973    496.440
  2.5.59n                181186     181848     181446    520.806

                                   loops/sec
spinlock                    low       high    average    avg/MHz
  wcox1                      50         50         50      0.125
  wcox_lxexe                 49         50         49      0.125
  2.5.52                      3          3          3      0.009
  2.5.54                      3          3          3      0.009
  2.5.56                      3          3          3      0.009
  2.5.59n                     3          3          3      0.009


