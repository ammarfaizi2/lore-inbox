Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWEMRAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWEMRAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 13:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbWEMRAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 13:00:21 -0400
Received: from tayrelbas03.tay.hp.com ([161.114.80.246]:47291 "EHLO
	tayrelbas03.tay.hp.com") by vger.kernel.org with ESMTP
	id S932482AbWEMRAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 13:00:20 -0400
Date: Sat, 13 May 2006 09:53:55 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/11] perfmon2 patch for review: modified i386 files
Message-ID: <20060513165355.GA28704@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200605122132_MC3-1-BFA1-E625@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605122132_MC3-1-BFA1-E625@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Fri, May 12, 2006 at 09:30:04PM -0400, Chuck Ebbert wrote:
> In-Reply-To: <200605121633.k4CGXmKd027348@frankl.hpl.hp.com>
> 
> On Fri, 12 May 2006 09:33:48 -0700, Stephane Eranian wrote:
> 
> <snip>
> 
>  > --- linux-2.6.17-rc4.orig/arch/i386/kernel/entry.S    2006-05-12 03:16:09.000000000 -0700
>  > +++ linux-2.6.17-rc4/arch/i386/kernel/entry.S 2006-05-12 03:18:52.000000000 -0700
>  > @@ -436,6 +436,16 @@
>  >  /* The include is where all of the SMP etc. interrupts come from */
>  >  #include "entry_arch.h"
>  >  
>  > +#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFMON)
>  > +ENTRY(pmu_interrupt)
>  > +     pushl $LOCAL_PERFMON_VECTOR-256
>  > +     SAVE_ALL
>  > +     pushl %esp
>  > +     call pfm_intr_handler
>  > +     addl $4, %esp
>  > +     jmp ret_from_intr
>  > +#endif
>  > +
>  >  ENTRY(divide_error)
>  >       pushl $0                        # no error code
>  >       pushl $do_divide_error
> 
> You should rename pfm_intr_handler to smp_pmu_interrupt (yes, it's not
> really SMP but other functions have that problem too, e.g.
> smp_error_interrupt) and make it fastcall, then you can do:
> 
> BUILD_INTERRUPT(pmu_interrupt, LOCAL_PERFMON_VECTOR)
> 
> instead of open-coding it.  Then the Xen patch that extends the interrupt
> vector range won't have to change to accommodate your patch.
> 
> You should also probably move the BUILD_INTERRUPT() into entry_arch.h
> with the rest of them.
> 

Thanks you for the tip. I made the change for i386 and everything is working
fine. It will be in my next release.

-- 
-Stephane
