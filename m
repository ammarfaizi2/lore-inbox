Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUGLFUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUGLFUK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 01:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266733AbUGLFUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 01:20:10 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:9452 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S266732AbUGLFT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 01:19:58 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       <jes@trained-monkey.org>, <mort@wildopensource.com>
Subject: RE: [PATCH] PER_CPU [4/4] - PER_CPU-irq_stat
Date: Sun, 11 Jul 2004 22:19:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040711221126.198ec0ac.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRnztNZ0PjImz5hQLmS/nDN7TJppQAAJ7mQ
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S266732AbUGLFT6/20040712051958Z+1468@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Andrew Morton" <akpm@osdl.org>:
> 
> "Shai Fultheim" <shai@scalex86.org> wrote:
> >
> > > > diff -Nru a/kernel/softirq.c b/kernel/softirq.c
> > > > --- a/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > > > +++ b/kernel/softirq.c	2004-07-09 01:34:13 -07:00
> > > > @@ -36,8 +36,8 @@
> > > >   */
> > > >
> > > >  #ifndef __ARCH_IRQ_STAT
> > > > -irq_cpustat_t irq_stat[NR_CPUS] ____cacheline_aligned;
> > > > -EXPORT_SYMBOL(irq_stat);
> > > > +DEFINE_PER_CPU(irq_cpustat_t, irq_stat)
> > > ____cacheline_maxaligned_in_smp;
> > > > +EXPORT_PER_CPU_SYMBOL(irq_stat);
> > > >  #endif
> > >
> > > Is there a need for the cacheline alignment? We want to keep that per
> > > cpu data area as packed as possible, we only want to explicitly pad if
> > > we need to (eg other cpus are accessing that variable a lot).
> > >
> > > Also it looks like we will have to push the above change into the
> other
> > > architectures.
> > >
> > > Anton
> > >
> >
> > IMHO, we want to keep irq_stat aligned from performance perspectives.
> You
> > can never know if the info before and after it in the per-cpu area are
> going
> > to be cached (and thefore crossing cache-line boundary will cost us
> more).
> >
> > Anyhow, since that also accesses by other CPUs (not a lot...), I think
> it's
> > better to keep it aligned (the utilization of per-cpu areas is so low
> now
> > that it doesn't really matter).
> >
> 
> That seems a bit debatable.
> 
> But anyway, as Anton points out, the patch breaks !x86 architectures.
> 

It seems that I missed that, will send update soon.
 
-----------------
Shai Fultheim
Scalex86.org

