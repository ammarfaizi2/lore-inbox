Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbTBIMuA>; Sun, 9 Feb 2003 07:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTBIMt7>; Sun, 9 Feb 2003 07:49:59 -0500
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:16378 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267221AbTBIMt6>; Sun, 9 Feb 2003 07:49:58 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200302091259.h19Cxfn0031212@twopit.underworld>
Subject: Linux 2.4.20-SMP: where is all my CPU time going?
To: linux-kernel@vger.kernel.org
Date: Sun, 9 Feb 2003 12:59:41 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been running Linux-2.4.20-SMP on my dual PIII-9333MHz machine
(1 GB RAM) for over 3 weeks as a desktop machine, with 2 instances of
SETI@Home running at nice 19 in the background the whole time:

# uptime
 12:25:44 up 24 days, 17:51,  7 users,  load average: 2.03, 2.05, 2.13

However, I have occasionally been noticing that some SETI jobs have
been taking longer than I would otherwise suppose. Here is what
wait4() has to say about the CPU time for each work unit over the last
few days:

TIMESTAMP [2003] CLIENT NAME             RUN-TIME         SYS-TIME
Feb 07 16:16:48: SETI-6              33215.280000       278.470000
Feb 07 18:20:19: SETI-1              33722.820000       203.570000
Feb 08 02:27:32: SETI-4              33207.240000       219.950000
Feb 08 04:26:54: SETI-3              32954.330000       217.670000
Feb 08 15:24:00: SETI-5              29543.910000      1908.440000
Feb 08 17:30:35: SETI-6              29512.810000      1949.680000
Feb 09 06:14:08: SETI-1              33391.280000      2165.590000
Feb 09 12:22:21: SETI-4              32747.760000      3840.990000

Each work unit is run as a distinct process. When the process
terminates, a super-demon program writes an entry in a log file, along
with the data from the struct rusage. However, over the last few days,
more and more time has started being spent in the kernel. The last
work unit to complete must have begun around 17:30:35 on Feb 8th, but
didn't finish until 12:22:21 on Feb 9th. That's about 19 hours of
wall-time, of which 9 hours were spent crunching the work unit and 1
hour was spent "doing things" in the kernel. That leaves 9 hours
unaccounted for! Granted, the SETI process was running at nice 19 but
then the machine was also idle since at least midnight on Feb 9th.

Can anyone suggest what the kernel might be doing to generate one hour
of sys-time (compared to a more usual ~ 4 minutes?) And where could
those missing 9 hours of run time have gone?

Thanks for any insights here,
Cheers,
Chris

P.S. This isn't the first time that this has happened. The *very*
first sys-time "spike" happened in Oct 2001, but they've become much
more regular since about Oct 2002, appearing approximately one or two
weeks apart.
