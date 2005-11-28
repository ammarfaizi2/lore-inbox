Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVK1VId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVK1VId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVK1VIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:08:32 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52179 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751310AbVK1VIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:08:31 -0500
Subject: Re: 2.6.14-rt15: cannot build with !PREEMPT_RT
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       david singleton <dsingleton@mvista.com>
In-Reply-To: <20051128160052.GA29540@elte.hu>
References: <1132987928.4896.1.camel@mindpipe>
	 <20051126122332.GA3712@elte.hu> <1133031912.5904.12.camel@mindpipe>
	 <1133034406.32542.308.camel@tglx.tec.linutronix.de>
	 <20051127123052.GA22807@elte.hu> <1133141224.4909.1.camel@mindpipe>
	 <20051128114852.GA3391@elte.hu> <1133189789.5228.7.camel@mindpipe>
	 <20051128160052.GA29540@elte.hu>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 15:34:06 -0500
Message-Id: <1133210046.4998.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 17:00 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > On Mon, 2005-11-28 at 12:48 +0100, Ingo Molnar wrote:
> > > which was the last -rt kernel that worked fine for you in 
> > > PREEMPT_DESKTOP mode?
> > 
> > It has been a long time, possibly months - I've mostly been using 
> > PREEMPT_RT.  But now I am working on a soft RT project that for 
> > various reasons would like to use the mainline kernel, and I've found 
> > it still has some scheduling bumps up to 5-7ms and am trying to 
> > identify the problem.
> 
> ok.
> 
> > Would you like me to do a binary search?
> 
> that would certainly be very helpful!
> 

With 2.6.13-rc4-RT-V0.7.52-02 (the oldest version I still have around) I
still can't build that config, but it fails with:

  LD      .tmp_vmlinux1
net/built-in.o: In function `rt_check_expire':
route.c:(.text+0x1a66a): undefined reference to `__bad_spinlock_type'
route.c:(.text+0x1a68d): undefined reference to `__bad_spinlock_type'
net/built-in.o: In function `rt_run_flush':
route.c:(.text+0x1a7c1): undefined reference to `__bad_spinlock_type'
route.c:(.text+0x1a7d9): undefined reference to `__bad_spinlock_type'
net/built-in.o: In function `rt_garbage_collect':
route.c:(.text+0x1aa2a): undefined reference to `__bad_spinlock_type'
net/built-in.o:route.c:(.text+0x1aa55): more undefined references to
`__bad_spinlock_type' follow
make: *** [.tmp_vmlinux1] Error 1

AFAICT all the realtime-preempt patches have references to
__bad_spinlock_type but none of them ever define it - I can't figure out
what's going on.

I'll try to build something older.

Lee

