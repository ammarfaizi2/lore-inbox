Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVD0L5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVD0L5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 07:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVD0L5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 07:57:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:30595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261501AbVD0L4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 07:56:31 -0400
Date: Wed, 27 Apr 2005 04:55:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on
 AMD64
Message-Id: <20050427045546.7c769a4f.akpm@osdl.org>
In-Reply-To: <200504271305.10882.rjw@sisk.pl>
References: <200504271152.15423.rjw@sisk.pl>
	<20050427031956.7fd67b31.akpm@osdl.org>
	<200504271305.10882.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Wednesday, 27 of April 2005 12:19, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Hi,
> > > 
> > > I'm having a problem with 2.6.12-rc3 and the Java VM (from SuSE 9.2)
> > > on AMD64.  Namely, after trying to open a web page containing a Java
> > > applet, my browser starts a java process that takes almost 100% of the CPU
> > > (system load, according to gkrellm) and cannot be killed (even by root,
> > > although it executes with a non-root UID).  Apparently, it is in TASK_RUNNING
> > > (according to ps).
> > > 
> > > The problem is 100% reproducible (it is enough to visit
> > > http://java.sun.com/docs/books/tutorial/getStarted/index.html to trigger it)
> > > and it does not depend on the web browser used.
> > > 
> > > The Java JRE version is:
> > > 
> > > java version "1.4.2_06"
> > > Java(TM) 2 Runtime Environment, Standard Edition (build 1.4.2_06-b03)
> > > Java HotSpot(TM) Client VM (build 1.4.2_06-b03, mixed mode)
> > > 
> > > (I guess it's 32-bit, but I'm not quite sure) and I've installed it from the
> > > SuSE 9.2 RPM.
> > > 
> > > It really is a show stopper to me, so please advise.
> > 
> > Where is it running?
> > 
> > You can tell this from a kernel profile, or by using sysrq-P five or ten
> > times then looking at the output.
> 
> >From sysrq-P, I get this:
> 
> Pid: 11073, comm: java Not tainted 2.6.12-rc3
> RIP: 0010:[<ffffffff8010f675>] <ffffffff8010f675>{retint_signal+20}
> RSP: 0018:ffff810012d6ff58  EFLAGS: 00000282
> RAX: 0000000000020000 RBX: ffff810010868820 RCX: ffff810012d6e000
> RDX: 0000000000020000 RSI: 0000000000000000 RDI: ffff810012d6ff58
> RBP: 000000a30c153a4a R08: ffff810012d6e000 R09: ffffffff804c6068
> R10: 0000000000000001 R11: 0000000000000001 R12: ffffffff804ccd40
> R13: ffff810010868820 R14: ffff81002cff2cf0 R15: ffffffff8010d3a7
> FS:  00002aaaae6389c0(0000) GS:ffffffff8054a600(0063) knlGS:00000000556c9080
> CS:  0010 DS: 002b ES: 002b CR0: 000000008005003b
> CR2: 00002aaaaabab000 CR3: 0000000012930000 CR4: 00000000000006e0
> 
> Call Trace:<ffffffff8010f697>{retint_signal+54}
> 
> all the time.

All the time?  Exactly the same?  If you could do something crude like hit
sysrq-P 100 times then do `dmesg|grep RIP' we could possibly determine
whether things are indeed stuck in that potential infinite loop in there.

I assume you're using CONFIG_PREEMPT?

It'd be interesting to know the interrupt rate and context switch rate
which this is going on.


> I've also found out that in fact the problem is not 100% reproducible, but it is much
> more likely to be reproduced if the CPU is heavily loaded.


