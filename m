Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266716AbUGLEoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266716AbUGLEoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUGLEoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:44:13 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:54247 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S266716AbUGLEoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:44:11 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Anton Blanchard'" <anton@samba.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Linux Kernel ML'" <linux-kernel@vger.kernel.org>,
       "'Jes Sorensen'" <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: RE: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Date: Sun, 11 Jul 2004 21:44:00 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040712000218.GC30109@krispykreme>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRnxr8RqepZ7bHSQqaQXGUKyTxYeAAAuqEg
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S266716AbUGLEoL/20040712044411Z+1440@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff -Nru a/kernel/softirq.c b/kernel/softirq.c
> > --- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > +++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > @@ -36,8 +36,8 @@
> >   */
> >
> >  #ifndef __ARCH_IRQ_STAT
> > -irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> > -EXPORT_SYMBOL(irq_stat);
> > +DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
> ____cacheline_maxaligned_in_smp;
> > +EXPORT_PER_CPU_SYMBOL(irq_stat);
> >  #endif
> 
> Is there a need for the cacheline alignment? We want to keep that per
> cpu data area as packed as possible, we only want to explicitly pad if
> we need to (eg other cpus are accessing that variable a lot).
> 
> Also it looks like we will have to push the above change into the other
> architectures.
> 
> Anton
> 

IMHO, we want to keep irq_stat aligned from performance perspectives. You
can never know if the info before and after it in the per-cpu area are going
to be cached (and thefore crossing cache-line boundary will cost us more).  

Anyhow, since that also accesses by other CPUs (not a lot...), I think it's
better to keep it aligned (the utilization of per-cpu areas is so low now
that it doesn't really matter).

--shai

