Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263570AbSITVEM>; Fri, 20 Sep 2002 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263579AbSITVEM>; Fri, 20 Sep 2002 17:04:12 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:46296 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S263570AbSITVEL>; Fri, 20 Sep 2002 17:04:11 -0400
Subject: 2.5.37 lockup with dbench 36 and make -j3 bzImage and PREEMPT=y.
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 20 Sep 2002 15:05:32 -0600
Message-Id: <1032555932.14946.225.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running 2.5.37 with 36 dbench clients and doing a kernel compile
with make -j3 bzImage, my test machine locked up.  Repeating the test,
the box ran up to 80 dbench clients and was doing make clean on a kernel
tree when the freeze occurred.  (My dbench ramp-up test runs dbench with
1,2,3,4,6,8,10,12,16,20,24,28,32,36,40,44,48,52,56,64,80,96,112, and 128
clients). When the box froze, it did not even respond to SYSRQ-H (tested
OK before lockup).  Each time, I gave the system a few minutes to come
out of its coma, but it didn't.

I also saw this with 2.5.36-bk3, patched with Robert's preempt-fix,
under similar circumstances (dbench 40 and parallel make). 

Without doing a kernel compile at the same time, the text box was able
to run up to 128 dbench clients successfully with 2.5.37 and PREEMPT.

The 2.5.37 kernel was patched with this fix for PREEMPT:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103255294016473&w=2
and this fix for eepro100:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103253526526144&w=2

Both of those kernels were configured with SMP and PREEMPT.

The test box is dual PIII, 1GB, scsi, ext3 fs.  The dbench runs and
kernel compiles were both run from the same disk.

I have been unable so far to repeat this failure with plain 2.5.37 and
no PREEMPT.  Plain vanilla 2.5.37 no preempt has run up to 112 dbench
clients while doing make -j3 bzImage.  At one point, the box appeared to
have frozen, with  vmstat -n 1 3600 output stopped printing for a while,
but the system is still responsive to SYSRQ-H, P, T, just slow with
dbench 128 running.

Steven



