Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269059AbUHMK3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269059AbUHMK3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUHMK1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:27:18 -0400
Received: from nl-ams-slo-l4-01-pip-3.chellonetwork.com ([213.46.243.17]:52263
	"EHLO amsfep12-int.chello.nl") by vger.kernel.org with ESMTP
	id S269059AbUHMKXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:23:15 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml@lpbproduction.scom, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813101928.GE8135@elte.hu>
References: <20040726082330.GA22764@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <200408122149.41490.lkml@lpbproductions.com>
	 <1092390820.6815.11.camel@twins>  <20040813101928.GE8135@elte.hu>
Content-Type: text/plain
Date: Fri, 13 Aug 2004 12:23:03 +0200
Message-Id: <1092392583.17555.1.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 12:19 +0200, Ingo Molnar wrote:
> * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> 
> > > arch/i386/kernel/traps.c: In function `do_nmi':
> > > arch/i386/kernel/traps.c:539: error: syntax error before "do"
> 
> > This fixes it.
> > 
> > --- ./include/asm-i386/hardirq.h~       2004-08-13 11:17:38.668333125 +0200
> > +++ ./include/asm-i386/hardirq.h        2004-08-13 11:51:40.835968747 +0200
> > @@ -73,7 +73,7 @@
> >  #define hardirq_endlock()      do { } while (0)
> >  
> >  #define irq_enter()            add_preempt_count(HARDIRQ_OFFSET)
> > -#define nmi_enter()            (irq_enter())
> > +#define nmi_enter()            irq_enter()
> 
> yep - thx, this fix too will be in -O7. It seems this compilation error
> only happens with older gcc and i'm using 3.3.
> 
> 	Ingo
FYI,

peter@twins ~ $ gcc --version
gcc (GCC) 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)
Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

and it hits here too.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

