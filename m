Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTHaFTN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 01:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTHaFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 01:19:13 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:40887 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S262499AbTHaFTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 01:19:09 -0400
Subject: [PATCH] Add documentation for /proc/stat
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1062307148.17532.17.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Aug 2003 22:19:08 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus -

This patch adds documentation for the contents of the /proc/stat file. 
The BK version of the patch at the URL below also instructs BK to ignore
cscope database files.

Please do a pull from

    bk://klibc.bkbits.net/stat-doc


proc.txt |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
1 files changed, 53 insertions(+)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1291  -> 1.1292 
#	Documentation/filesystems/proc.txt	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/30	bos@camp4.serpentine.com	1.1292
# Add documentation for /proc/stat.
# This is based on reading of the code in fs/proc/proc_misc.c, so it
# ought to be 100% accurate.
# 
# Tell BitKeeper to ignore cscope database files.
# --------------------------------------------
#
diff -Nru a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	Sat Aug 30 22:11:50 2003
+++ b/Documentation/filesystems/proc.txt	Sat Aug 30 22:11:50 2003
@@ -25,6 +25,7 @@
   1.5	SCSI info
   1.6	Parallel port info in /proc/parport
   1.7	TTY info in /proc/tty
+  1.8	Miscellaneous kernel statistics in /proc/stat
 
   2	Modifying System Parameters
   2.1	/proc/sys/fs - File system data
@@ -702,6 +703,58 @@
   /dev/console         /dev/console    5       1 system:console 
   /dev/tty             /dev/tty        5       0 system:/dev/tty 
   unknown              /dev/tty        4    1-63 console 
+
+
+1.8 Miscellaneous kernel statistics in /proc/stat
+-------------------------------------------------
+
+Various pieces   of  information about  kernel activity  are  available in the
+/proc/stat file.  All  of  the numbers reported  in  this file are  aggregates
+since the system first booted.  For a quick look, simply cat the file:
+
+  > cat /proc/stat
+  cpu  2255 34 2290 22625563 6290 127 456
+  cpu0 1132 34 1441 11311718 3675 127 438
+  cpu1 1123 0 849 11313845 2614 0 18
+  intr 114930548 113199788 3 0 5 263 0 4 [... lots more numbers ...]
+  ctxt 1990473
+  btime 1062191376
+  processes 2915
+  procs_running 1
+  procs_blocked 0
+
+The very first  "cpu" line aggregates the  numbers in all  of the other "cpuN"
+lines.  These numbers identify the amount of time the CPU has spent performing
+different kinds of work.  Time units are in USER_HZ (typically hundredths of a
+second).  The meanings of the columns are as follows, from left to right:
+
+- user: normal processes executing in user mode
+- nice: niced processes executing in user mode
+- system: processes executing in kernel mode
+- idle: twiddling thumbs
+- iowait: waiting for I/O to complete
+- irq: servicing interrupts
+- softirq: servicing softirqs
+
+The "intr" line gives counts of interrupts  serviced since boot time, for each
+of the  possible system interrupts.   The first  column  is the  total of  all
+interrupts serviced; each  subsequent column is the  total for that particular
+interrupt.
+
+The "ctxt" line gives the total number of context switches across all CPUs.
+
+The "btime" line gives  the time at which the  system booted, in seconds since
+the Unix epoch.
+
+The "processes" line gives the number  of processes and threads created, which
+includes (but  is not limited  to) those  created by  calls to the  fork() and
+clone() system calls.
+
+The  "procs_running" line gives the  number of processes  currently running on
+CPUs.
+
+The   "procs_blocked" line gives  the  number of  processes currently blocked,
+waiting for I/O to complete.
 
 
 ------------------------------------------------------------------------------


