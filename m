Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUJLOQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUJLOQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJLOQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:16:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:33225 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261724AbUJLOQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:16:30 -0400
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20041012060410.GE1479@elte.hu>
References: <20041001204533.GA18684@elte.hu>
	 <20041001204642.GA18750@elte.hu> <20041001143332.7e3a5aba.akpm@osdl.org>
	 <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
	 <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>
	 <1097560787.6557.99.camel@biclops>  <20041012060410.GE1479@elte.hu>
Content-Type: text/plain
Message-Id: <1097590569.6557.107.camel@biclops>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 09:16:09 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 01:04, Ingo Molnar wrote:
> * Nathan Lynch <nathanl@austin.ibm.com> wrote:
> 
> > I fixed up the warning in cpu_down with the following patch and now am
> > running with that + 2.6.9-rc4-mm1 + your patch while doing continuous
> > online/offline and make -j8.  It's been running for about 45 minutes
> > and I haven't seen the panic yet, although I'm at a loss to explain
> > why the change would fix it.  Will let it run overnight and report
> > back...
> 
> >  	/* Move it here so it can run. */
> > -	kthread_bind(p, smp_processor_id());
> > +	kthread_bind(p, get_cpu());
> > +	put_cpu();
> 
> >  	/* CPU is completely dead: tell everyone.  Too late to complain. */
> >  	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
> 
> hm, is there any assurance that smp_processor_id() == cpu?

Actually, cpu != smp_processor_id().  cpu is the processor we have just
taken down at that point; we want the kthread to run on some other cpu.

Nathan


