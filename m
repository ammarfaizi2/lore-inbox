Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266721AbUGLFMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266721AbUGLFMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266742AbUGLFMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:12:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:42386 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266721AbUGLFMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:12:47 -0400
Date: Sun, 11 Jul 2004 22:11:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shai Fultheim" <shai@scalex86.org>
Cc: anton@samba.org, linux-kernel@vger.kernel.org, jes@trained-monkey.org,
       mort@wildopensource.com
Subject: Re: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Message-Id: <20040711221126.198ec0ac.akpm@osdl.org>
In-Reply-To: <200407120444.i6C4iAws031156@fire-2.osdl.org>
References: <20040712000218.GC30109@krispykreme>
	<200407120444.i6C4iAws031156@fire-2.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Shai Fultheim" <shai@scalex86.org> wrote:
>
> > > diff -Nru a/kernel/softirq.c b/kernel/softirq.c
> > > --- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > > +++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > > @@ -36,8 +36,8 @@
> > >   */
> > >
> > >  #ifndef __ARCH_IRQ_STAT
> > > -irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> > > -EXPORT_SYMBOL(irq_stat);
> > > +DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
> > ____cacheline_maxaligned_in_smp;
> > > +EXPORT_PER_CPU_SYMBOL(irq_stat);
> > >  #endif
> > 
> > Is there a need for the cacheline alignment? We want to keep that per
> > cpu data area as packed as possible, we only want to explicitly pad if
> > we need to (eg other cpus are accessing that variable a lot).
> > 
> > Also it looks like we will have to push the above change into the other
> > architectures.
> > 
> > Anton
> > 
> 
> IMHO, we want to keep irq_stat aligned from performance perspectives. You
> can never know if the info before and after it in the per-cpu area are going
> to be cached (and thefore crossing cache-line boundary will cost us more).  
> 
> Anyhow, since that also accesses by other CPUs (not a lot...), I think it's
> better to keep it aligned (the utilization of per-cpu areas is so low now
> that it doesn't really matter).
> 

That seems a bit debatable.

But anyway, as Anton points out, the patch breaks !x86 architectures.
