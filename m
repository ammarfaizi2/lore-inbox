Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUJXAwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUJXAwl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 20:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUJXAwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 20:52:40 -0400
Received: from p508EF532.dip.t-dialin.net ([80.142.245.50]:61570 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id S261372AbUJXAvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 20:51:45 -0400
Date: Sun, 24 Oct 2004 02:51:42 +0200
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Wrong calculation of load average ?
Message-ID: <20041024005142.GA26209@oscar.prima.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo everyone,

I'm using a BK snapshot of linux 2.6 from today and have a strange
problem with an otherwise stable SMP System. The calculated load average
seems to "wrap around".

The exact kernel version is:
Linux oscar 2.6.10-2.6bk #1 SMP Sat Oct 23 16:45:50 CEST 2004

Below is the output of a looping 'cat /proc/loadavg'.
The load drops to near-zero and then wraps to 1024. 

I already looked at the code involved but I am unable to see how this
could happen. Timer interrupts are occuring on both CPU's:

root@oscar] cat /proc/interrupts
CPU0       CPU1
17159225   17408595    IO-APIC-edge  timer

The system is a dual P3 450Mhz (Asus P2B-DS), ACPI not compiled in,
Preempt disabled, no regparams, but 4K stacks. 2.6.9 vanilla did not
show these symptoms. System performance is not affected at all, but exim
refuses to deliver mail ;)

The gcc used is:
[root@oscar] gcc --version
gcc (GCC) 3.3.5 (Debian 1:3.3.5-1)

I also tried a gcc 3.4 branch, but that didn't help either.
This report is based on a kernel compiled with gcc 3.3

[root@oscar] /opt/gcc/bin/gcc --version
gcc (GCC) 3.4.3 20041017 (prerelease)

I'd appreciate any comments,
Patrick

[root@oscar] while true ; do cat /proc/loadavg ; sleep 10 ; done
112.95 1.94 2.54 1/139 25916
94.81 1.71 2.46 1/139 25918
79.47 1.49 2.38 1/139 25920
66.56 1.29 2.31 1/139 25925
55.56 1.08 2.23 1/139 25927
46.25 0.88 2.15 1/139 25929
38.59 0.74 2.09 1/139 25931
31.89 0.55 2.01 1/139 25933
26.21 0.36 1.94 1/139 25935
21.41 0.19 1.86 2/139 25937
17.35 0.02 1.79 1/139 25939	<--- here
13.92 1006.85 1.72 1/139 25941
11.01 973.53 1.64 1/139 25943
8.55 941.31 1.57 1/139 25945
6.46 910.15 1.50 1/139 25947
4.70 880.02 1.43 7/139 25949
3.28 850.89 1.37 1/139 25960
2.16 822.74 1.31 1/139 25970
1.14 795.50 1.25 1/142 25981
0.41 769.19 1.20 1/140 25983	<--- and here
941.66 743.72 1.13 1/158 26114
796.19 719.08 1.07 1/140 26164
673.09 695.25 1.01 1/140 26167
568.84 672.19 0.95 1/140 26169
480.61 649.89 0.88 1/140 26171
405.95 628.33 0.82 1/140 26173
342.77 607.48 0.76 1/140 26175
289.30 587.31 0.69 1/139 26177
244.14 567.82 0.64 1/139 26179
205.91 548.97 0.58 1/139 26181
173.48 530.73 0.52 1/139 26183
146.04 513.09 0.46 1/139 26185
122.82 496.03 0.40 1/139 26187
103.17 479.53 0.35 3/139 26189
86.77 463.63 0.30 1/139 26194
72.81 448.23 0.26 2/139 26196
60.85 433.31 0.20 1/139 26198

