Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUIFM1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUIFM1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267879AbUIFM1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 08:27:25 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:32158 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S267872AbUIFMZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 08:25:40 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
From: Alexander Nyberg <alexn@dsv.su.se>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
In-Reply-To: <200409061348.41324.rjw@sisk.pl>
References: <20040903120957.00665413@mango.fruits.de>
	 <20040905140249.GA23502@elte.hu> <20040906110626.GA32320@elte.hu>
	 <200409061348.41324.rjw@sisk.pl>
Content-Type: text/plain
Message-Id: <1094473527.13114.4.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 06 Sep 2004 14:25:28 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-06 at 13:48, Rafael J. Wysocki wrote:
> On Monday 06 of September 2004 13:06, Ingo Molnar wrote:
> > 
> > i've released the -R6 patch:
> > 
> >   
> http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R6
> > 
> > Changes in -R6:
> > 
> >  - fixed a CONFIG_SMP + CONFIG_PREEMPT bug that had the potential to
> >    cause spinlock related lockups. (UP kernels are unaffected.) This bug 
> >    got introduced in -R5.
> > 
> > 2.6.9-rc1-bk12 patching order is:
> >  
> >     http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
> >   + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
> >   + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2
> 
> I did as instructed, but it didn't compile (on a UP x86-64 system).  I got 
> this:
> 
>   CC      arch/x86_64/kernel/irq.o
> arch/x86_64/kernel/irq.c: In function `request_irq':
> arch/x86_64/kernel/irq.c:498: warning: implicit declaration of function 
> `setup_irq'
>   CC      arch/x86_64/kernel/ptrace.o
>   CC      arch/x86_64/kernel/i8259.o
> arch/x86_64/kernel/i8259.c: In function `init_IRQ':
> arch/x86_64/kernel/i8259.c:570: warning: implicit declaration of function 
> `setup_irq'
>   CC      arch/x86_64/kernel/ioport.o
>   CC      arch/x86_64/kernel/ldt.o
>   CC      arch/x86_64/kernel/setup.o
>   CC      arch/x86_64/kernel/time.o
> arch/x86_64/kernel/time.c: In function `time_init':
> arch/x86_64/kernel/time.c:820: warning: implicit declaration of function 
> `setup_irq'
>   CC      arch/x86_64/kernel/sys_x86_64.o
> [- snip -]
> C      kernel/hardirq.o
> kernel/hardirq.c: In function `recalculate_desc_flags':
> kernel/hardirq.c:314: error: `SA_NODELAY' undeclared (first use in this 
> function)
> kernel/hardirq.c:314: error: (Each undeclared identifier is reported only once
> kernel/hardirq.c:314: error: for each function it appears in.)
> kernel/hardirq.c: In function `generic_setup_irq':
> kernel/hardirq.c:344: error: `SA_NODELAY' undeclared (first use in this 
> function)
> kernel/hardirq.c: In function `threaded_read_proc':
> kernel/hardirq.c:659: error: `SA_NODELAY' undeclared (first use in this 
> function)
> kernel/hardirq.c: In function `threaded_write_proc':
> kernel/hardirq.c:677: error: `SA_NODELAY' undeclared (first use in this 
> function)
> make[1]: *** [kernel/hardirq.o] Error 1
> make: *** [kernel] Error 2
> 

It doesn't look like it is fully ported to x86_64 systems yet, these
compile errors are easy to move away but the functionality doesn't seem
to be there. Probably why Ingo hasn't added the PREEMPT_VOLUNTARY to the
x86_64 Kconfig even though I saw a few bits of x86_64 code in the patch.

Or am I missing something?


