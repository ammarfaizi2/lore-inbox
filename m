Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264596AbSIQUbI>; Tue, 17 Sep 2002 16:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264597AbSIQUbI>; Tue, 17 Sep 2002 16:31:08 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:48023 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S264596AbSIQUbG>; Tue, 17 Sep 2002 16:31:06 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032293199.4588.235.camel@phantasy>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy> 
	<1032292468.11907.44.camel@spc9.esa.lanl.gov> 
	<1032293199.4588.235.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 17 Sep 2002 14:32:28 -0600
Message-Id: <1032294748.11913.59.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 14:06, Robert Love wrote:
> On Tue, 2002-09-17 at 15:54, Steven Cole wrote:
> 
> Thank you for the testing, Steven.
> 
> > Running dbench 3 resulted in the dbench clients hanging and being
> > unkillable with kill -9 in the D state.
> 
> Hrm, I cannot reproduce this.  I just successfully completed a `dbench
> 16'.  Can you find where they are hanging?  You can get a trace via
> sysrq.  You can also see where they are in the kernel via the wchan
> field of ps: "ps -ewo user,pid,priority,%cpu,stat,command,wchan" is a
> favorite of mine.

I rebooted the box, but had to SYSRQ-S, SYSRQ-B, due to shutdown -r now
hanging up. On reboot, the init scripts froze after "starting atd", but
fortunately this was after sshd, so I ssh'd to the box several times,
and did your ps command before hanging it with dbench 3 (dbench 1 and 2
were successful again).  I have that ps output if you want it.  I could
NOT do that, or even ls, after the dbench 3 hang.  When I shutdown,
SYSRQ-S only partially synced (just one partition).
> 
> Sure it does not happen with a stock kernel (no preempt)?

I'll try 2.5.35-bk3 (no other patches) without preempt shortly.
I'll report any failures, but no news is good news.
> 
> What if you replace the printk() and dump_stack() in schedule() with a
> no-op (but not something that will optimize away the conditional, i.e.
> try a cpu_relax()).

I'll try that if I get the time.  But I wasn't getting any dump info in
dmesg for those boots.
> 
> Oh, is the previous patch fully backed out?  None of that do_exit muck
> anymore, right?
Yep, plain 2.5.35, then patched with 2.5.35-bk3, then with your patch
posted at 15:23.  Nothing else.
> 
> > Test box is 2-way pIII, kernel SMP.
> 
> I too am SMP with kernel preemption, dual Athlon MP.

Steven

