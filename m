Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVDEIAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVDEIAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVDEH7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:40 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:31637 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261582AbVDEH6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:58:14 -0400
Date: Tue, 5 Apr 2005 02:00:16 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Li Shaohua <shaohua.li@intel.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC 1/6]SEP initialization rework
In-Reply-To: <1112662825.17861.4.camel@sli10-desk.sh.intel.com>
Message-ID: <Pine.LNX.4.61.0504050159590.2566@montezuma.fsmlabs.com>
References: <1112580349.4194.331.camel@sli10-desk.sh.intel.com> 
 <Pine.LNX.4.61.0504041235001.30273@montezuma.fsmlabs.com>
 <1112662825.17861.4.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2005, Li Shaohua wrote:

> On Tue, 2005-04-05 at 03:10, Zwane Mwaikambo wrote:
> > On Mon, 4 Apr 2005, Li Shaohua wrote:
> > 
> > >  linux-2.6.11-root/arch/i386/kernel/smpboot.c           |    6 ++++++
> > >  linux-2.6.11-root/arch/i386/kernel/sysenter.c          |   10 ++++++----
> > >  linux-2.6.11-root/arch/i386/mach-voyager/voyager_smp.c |    6 ++++++
> > >  3 files changed, 18 insertions(+), 4 deletions(-)
> > > 
> > > diff -puN arch/i386/kernel/sysenter.c~sep_init_cleanup arch/i386/kernel/sysenter.c
> > > --- linux-2.6.11/arch/i386/kernel/sysenter.c~sep_init_cleanup	2005-03-28 09:32:30.936304248 +0800
> > > +++ linux-2.6.11-root/arch/i386/kernel/sysenter.c	2005-03-28 09:58:20.703703792 +0800
> > > @@ -26,6 +26,11 @@ void enable_sep_cpu(void *info)
> > >  	int cpu = get_cpu();
> > >  	struct tss_struct *tss = &per_cpu(init_tss, cpu);
> > >  
> > > +	if (!boot_cpu_has(X86_FEATURE_SEP)) {
> > > +		put_cpu();
> > > +		return;
> > > +	}
> > > +
> > 
> > Do you have systems like this? Is it really skipping SEP if the boot 
> > processor doesn't have SEP?
> No, I haven't such system. This is the logic of original SEP
> initialization. If the CPU hasn't SEP, original logic doesn't call
> 'on_each_cpu(enable_sep_cpu,...)'.

Got it, so i misread.

Thanks,
	Zwane

