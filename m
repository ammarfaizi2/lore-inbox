Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbVG1VkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbVG1VkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVG1Vh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:37:58 -0400
Received: from grendel.sisk.pl ([217.67.200.140]:43905 "HELO mail.sisk.pl")
	by vger.kernel.org with SMTP id S261449AbVG1Vf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:35:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm3
Date: Thu, 28 Jul 2005 23:40:57 +0200
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ak@suse.de
References: <20050728025840.0596b9cb.akpm@osdl.org> <200507282111.32970.rjw@sisk.pl> <20050728121656.66845f70.akpm@osdl.org>
In-Reply-To: <20050728121656.66845f70.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507282340.57905.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 28 of July 2005 21:16, Andrew Morton wrote:
> 
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > There are two problems with the compilation of arch/x86_64/kernel/nmi.c.
> 
> Thanks.
> 
> > --- linux-2.6.13-rc3-mm3/arch/x86_64/kernel/nmi.c	2005-07-28 21:05:53.000000000 +0200
> >  +++ patched/arch/x86_64/kernel/nmi.c	2005-07-28 18:58:02.000000000 +0200
> >  @@ -152,8 +152,10 @@ int __init check_nmi_watchdog (void)
> >   
> >   	printk(KERN_INFO "testing NMI watchdog ... ");
> >   
> >  +#ifdef CONFIG_SMP
> >   	if (nmi_watchdog == NMI_LOCAL_APIC)
> >   		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
> >  +#endif
> >   
> >   	for (cpu = 0; cpu < NR_CPUS; cpu++)
> >   		counts[cpu] = cpu_pda[cpu].__nmi_count; 
> 
> This bit is no longer needed, since
> alpha-fix-statement-with-no-effect-warnings.patch got dropped.

OK

BTW, -mm3 works fine for me on two AMD64 boxes except for one thing:
On Asus L5D, if I resume the box from disk on battery power (ie the box is started
on battery power and resumes from disk), it hangs solid right after copying
the image (100% of the time).  If it is resumed on AC power, everything is fine.

Well, -mm1[1-2] did the same thing so I think I'll create a Bugzilla entry and
start a binary search. :-(  The -git[5-9] kernels are not affected by this issue.

Greets,
Rafael

PS
Could you please tell me how I can figure out the order in which the individual
patches in -mm have been applied?


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
