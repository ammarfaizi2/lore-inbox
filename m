Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbVCVFCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbVCVFCZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVCVE72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 23:59:28 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47331 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262404AbVCVEZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 23:25:23 -0500
Subject: Re: kernel bug: futex_wait hang
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Chris Morgan <cmorgan@alum.wpi.edu>, paul@linuxaudiosystems.com,
       Jamie Lokier <jamie@shareable.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
In-Reply-To: <20050321202051.2796660e.akpm@osdl.org>
References: <1111463950.3058.20.camel@mindpipe>
	 <20050321202051.2796660e.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 21 Mar 2005 23:25:20 -0500
Message-Id: <1111465520.3058.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 20:20 -0800, Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> >
> > Paul Davis and Chris Morgan have been chasing down a problem with
> > xmms_jack and it really looks like this bug, thought to have been fixed
> > in 2.6.10, is the culprit.
> > 
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.0/2044.html
> > 
> > (for more info google "futex_wait 2.6 hang")
> > 
> > It's simple to reproduce.  Run JACK and launch xmms with the JACK output
> > plugin.  Close XMMS.  The xmms process hangs.  Strace looks like this:
> > 
> > rlrevell@krustophenia:~$ strace -p 7935
> > Process 7935 attached - interrupt to quit
> > futex(0xb5341bf8, FUTEX_WAIT, 7939, NULL
> > 
> > Just like in the above bug report, if xmms is run with
> > LD_ASSUME_KERNEL=2.4.19, it works perfectly.
> > 
> > I have reproduced the bug with 2.6.12-rc1.
> > 
> 
> iirc we ended up deciding that the futex problems around that time were due
> to userspace problems (a version of libc).  But then, there's no discussion
> around Seto's patch and it didn't get applied.  So I don't know what
> happened to that work - it's all a bit mysterious.
> 

It does seem like it could be a different problem.  Maybe Paul can
provide some more evidence that it's a kernel and not a glibc/NPTL bug.
I'm really just posting this on Paul's behalf; I don't claim to
understand the issue. ;-)

> Is this a 100% repeatable hang, or is it some occasional race?
> 

100% repeatable.

Lee

