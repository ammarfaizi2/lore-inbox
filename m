Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRKEP3c>; Mon, 5 Nov 2001 10:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281190AbRKEP3P>; Mon, 5 Nov 2001 10:29:15 -0500
Received: from heffalump.fnal.gov ([131.225.9.20]:47712 "EHLO fnal.gov")
	by vger.kernel.org with ESMTP id <S281186AbRKEP3B>;
	Mon, 5 Nov 2001 10:29:01 -0500
Date: Mon, 05 Nov 2001 09:29:00 -0600
From: Jason Allen <jallen@fnal.gov>
Subject: 2.4.13 Mem Related Hangs
To: linux-kernel@vger.kernel.org
Message-id: <1004974140.19387.14.camel@crash.fnal.gov>
MIME-version: 1.0
X-Mailer: Evolution/0.16 (Preview Release)
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a 8 CPU/8GB Dell 8450 running 2.4.13 (NFS and XFS patches) which
hangs regularly. 

I'd say that the problem is memory related. What seems to occur is that
mem cache grows until physical mem is exhausted at which time the system
hangs.

This is the top screen that printed out seconds before the machine
became unresponsive.  I was typing in another window and it stopped
responding but this screen had just updated.


  4:13pm  up 2 days,  5:55,  5 users,  load average: 22.02, 19.27, 19.90
247 processes: 228 sleeping, 19 running, 0 zombie, 0 stopped
CPU0 states: 20.53% user, 79.8% system,  0.0% nice,  0.1% idle
CPU1 states:  5.46% user, 94.16% system,  0.0% nice,  0.1% idle
CPU2 states:  7.37% user, 71.45% system,  0.2% nice, 20.42% idle
CPU3 states:  4.40% user, 95.23% system,  0.0% nice,  0.0% idle
CPU4 states:  8.45% user, 91.18% system,  0.0% nice,  0.0% idle
CPU5 states:  5.38% user, 89.24% system,  0.1% nice,  4.63% idle
CPU6 states:  5.12% user, 87.18% system,  0.0% nice,  7.33% idle
CPU7 states:  6.55% user, 88.41% system,  0.1% nice,  4.29% idle
Mem:  8246096K av, 8233888K used,   12208K free,       0K shrd,       0K
buff
Swap: 8371784K av,       0K used, 8371784K free                 7441040K
cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 7516 d0relmgr  14   0 43296  42M  2580 R    58.9  0.5   2:34 kfront
 8626 d0relmgr  13   0 29276  28M  2180 R    15.4  0.3   0:48 kfront
 8893 d0relmgr  10   0 25732  25M  2180 R    15.7  0.3   0:36 kfront
 9241 d0relmgr  10   0 20824  20M  2180 R    15.6  0.2   0:13 kfront
 9112 d0relmgr  11   0 20180  19M  2180 R    15.1  0.2   0:17 kfront
 9230 d0relmgr  10   0 19596  19M  2180 R    16.0  0.2   0:14 kfront
 9448 d0relmgr  12   0 16456  16M  2180 R    17.0  0.1   0:13 kfront
 9487 d0relmgr  15   0 14292  13M  2180 D    14.9  0.1   0:13 kfront
 9800 d0relmgr  15   0  8744 8744  2160 R    10.7  0.1   0:06 cc1
 3408 d0relmgr   9   0  4888 4888   580 S     0.0  0.0   0:03 gmake
27680 d0relmgr   8   0  4380 4380   572 S     0.0  0.0   0:03 gmake
30697 d0relmgr   9   0  4348 4348   568 S     0.0  0.0   0:00 gmake
31964 d0relmgr   9   0  4348 4348   568 S     0.0  0.0   0:00 gmake
30499 d0relmgr   9   0  4344 4344   568 S     0.0  0.0   0:00 gmake
 3609 d0relmgr   9   0  3840 3840   580 S     0.0  0.0   0:02 gmake
 2987 d0relmgr   9   0  3600 3600   600 S     0.0  0.0   0:02 gmake
  911 xfs        9   0  3360 3360   916 S     0.0  0.0   0:00 xfs
 9014 d0relmgr   9   0  3360 3356  1772 S     0.0  0.0   0:24 xterm
 9757 d0relmgr  13   0  2532 2532  1776 R    17.7  0.0   0:11
kfront-thin
 9016 d0relmgr   8   0  2416 2416   984 S     0.0  0.0   0:06 tcsh
22852 d0relmgr   8   0  2052 2052  1132 S     0.0  0.0   0:13 tcsh
 9102 boyd       9   0  2000 2000  1128 S     0.1  0.0   0:02 tcsh
  572 root       9   0  1988 1988  1728 S     0.0  0.0  12:47 ntpd
  850 root       9   0  1968 1968  1424 S     0.0  0.0   0:22 sendmail
 8220 boyd       9   0  1924 1924  1064 S     0.0  0.0   0:30 tcsh
 8885 d0relmgr   9   0  1808 1808   600 S     0.0  0.0   0:01 gmake
 7598 d0relmgr   9   0  1744 1744   600 S     0.0  0.0   0:00 gmake

This is from a few seconds before:

d0lomite 4:13pm ~ 5 > cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  8444002304 8418140160 25862144        0        0 7619543040
Swap: 8572706816        0 8572706816
MemTotal:      8246096 kB
MemFree:         25256 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:        7440960 kB
SwapCached:          0 kB
Active:        5300072 kB
Inactive:      2140888 kB
HighTotal:     7471104 kB
HighFree:         2044 kB
LowTotal:       774992 kB
LowFree:         23212 kB
SwapTotal:     8371784 kB
SwapFree:      8371784 kB


Any assistance or words of wisdom would be appreciated.

Jason Allen





