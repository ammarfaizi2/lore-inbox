Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbWFUJW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWFUJW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 05:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWFUJW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 05:22:29 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:34433 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932492AbWFUJW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 05:22:28 -0400
Date: Wed, 21 Jun 2006 05:17:31 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: halt the CPU on serious errors
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606210520_MC3-1-C307-8E12@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060620050910.GA6091@redhat.com>

On Tue, 20 Jun 2006 01:09:10 -0400, Dave Jones wrote:

> > --- 2.6.17-32.orig/arch/i386/kernel/crash.c
> > +++ 2.6.17-32/arch/i386/kernel/crash.c
> > @@ -113,8 +113,8 @@ static int crash_nmi_callback(struct pt_
> >     disable_local_APIC();
> >     atomic_dec(&waiting_for_crash_ipi);
> >     /* Assume hlt works */
> > -   halt();
> > -   for(;;);
> > +   for (;;)
> > +           halt();
> >  
> >     return 1;
>
> But we should never get past that first halt(), as interrupts are disabled.

Yeah, but why not do it anyway?  I'll change the comment.

> > --- 2.6.17-32.orig/arch/i386/kernel/doublefault.c
> > +++ 2.6.17-32/arch/i386/kernel/doublefault.c
> > @@ -44,7 +44,8 @@ static void doublefault_fn(void)
> >             }
> >     }
> >  
> > -   for (;;) /* nothing */;
> > +   for (;;)
> > +           halt();
> >  }
>
> This one would probably be better off as a cpu_relax()

OK.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
