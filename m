Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSANXoe>; Mon, 14 Jan 2002 18:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289301AbSANXoY>; Mon, 14 Jan 2002 18:44:24 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:61658 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289296AbSANXoM>; Mon, 14 Jan 2002 18:44:12 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: George Anzinger <george@mvista.com>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 15 Jan 2002 00:42:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020114234418Z289296-13997+4929@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger wrote:
> jogi@planetzork.ping.de wrote:
> > That's the second test I am normally running. Just running xmms while
> > doing the kernel compile. I just wanted to check if the system slows
> > down because of preemption but instead it compiled the kernel even
> > faster :-) 
>
> This sort of thing is nice to hear, but, it does show up a problem in
> the non-preempt kernel.  That preemption improves compile performance
> implies that the kernel is not doing the right thing during a normal
> compile and that preemption, to some extent, corrects the problem.  But
> preemption adds the overhead of additional context switches.  It would
> be nice to know where the time is coming from.  I.e. lets assume that
> the actual compile takes about the same amount of execution time with or
> without preemption.

That's the case in most of my "benchmarks".

e.g. dbench 32:

2.4.18-pre3
sched-O1-2.4.17-H7.patch
10_vm-22
00_nanosleep-5
bootmem-2.4.17-pre6
read-latency.patch
waitq-2.4.17-mainline-1
plus
all 2.4.18-pre3.pending ReiserFS stuff

Throughput 41.5565 MB/sec (NB=51.9456 MB/sec  415.565 MBit/sec)
14.860u 48.320s 1:41.66 62.1%   0+0k 0+0io 938pf+0w

with preempt+lock-break

Throughput 47.0049 MB/sec (NB=58.7561 MB/sec  470.049 MBit/sec)
14.280u 49.370s 1:30.88 70.0%   0+0k 0+0io 939pf+0w

user:	nearly equally
system:	1 second more with preempt+lock-break
all:	11 less with preempt+lock-break

> Then for the preemptable kernel to do the job
> faster something else must go up, idle time perhaps.  If this is the
> case, then there is some place in the kernel that is wasting cpu time
> and that is preemptable and the preemptable patch is moving this idle
> time to the idle process.  

> What ever the reason, while I do want to promote preemption, I think we
> should look at this issue and, at the very least, explain it.

What do you think about IO-wait for top/ps like SUN have?
Do you think we lost CPU cycles, there?

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
