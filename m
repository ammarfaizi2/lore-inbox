Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSG3SbO>; Tue, 30 Jul 2002 14:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSG3SbN>; Tue, 30 Jul 2002 14:31:13 -0400
Received: from gatekeeper.agave.com ([209.241.135.2]:30112 "EHLO agave.com")
	by vger.kernel.org with ESMTP id <S315279AbSG3SbK>;
	Tue, 30 Jul 2002 14:31:10 -0400
Message-ID: <3D46DC36.4469328E@caseta.com>
Date: Tue, 30 Jul 2002 13:34:30 -0500
From: Jim Duchek <jduchek@caseta.com>
Organization: Caseta Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18pre21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Quick Q on kernel threads and RT thread priorities
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I'm using kernel 2.4.18 in a semi-RT application.  I'm using the
SCHED_RR scheduler with a number of processes, priorities running from 5
up through 90.  Default processes, of course, run under SCHED_OTHER at
priority 0.  There are a number of kernel threads running, quick example
from busybox's ps (modified to show scheduling prios), see bottom of
email.   I have tested and the priorities do work correctly -- a prio 50
process can completely starve a prio 49 process, as it should be.  My
question is:  Do I need to worry about kernel processes, such as
[keventd], [eth0], etc, running at 0 priority?  Should I run them at
99?  I have experienced no problems seeing ethernet traffic with process
53 in the list below at prio 0 and a CPU-starving test process running
at prio 50.   I am worried that the kernel may lock up if it's processes
get starved.  I am also worried that some of these processes may depend
on the fact that everyone can get equal scheduling and setting them to
99 will starve my application.  Any advice?

Thanks in advance,
Jim Duchek
Caseta Technologies, inc.

sample PS output:

 PID  Uid     Pri VmSize Stat Command
    1 root       0   1724 S    init
    2 root       0        S    [keventd]
    3 root       0        S    [ksoftirqd_CPU0]
    4 root       0        S    [kswapd]
    5 root       0        S    [bdflush]
    6 root       0        S    [kupdated]
    7 root       0        S    [mtdblockd]
   20 root       0   1700 S    syslogd -m 0
   22 root       0   1708 S    klogd
   53 root       0        S    [eth0]
   63 root      50   1676 S    /usr/sbin/inetd /etc/inetd.conf
   64 root       0   1724 S    init
   65 root       0   1728 S    init
   66 root      50   2112 S    telnetd
   67 root      50   1784 S    -sh
  142 root      50   2112 R    telnetd
  143 root      50   1784 S    -sh
  871 root      50   1844 R    ps


