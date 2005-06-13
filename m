Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVFMBLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVFMBLk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFMBLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:11:40 -0400
Received: from fmr17.intel.com ([134.134.136.16]:7620 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261306AbVFMBLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:11:15 -0400
Subject: Re: [PATCH]x86-x86_64 flush cache for CPU hotplug
From: Shaohua Li <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, ak <ak@muc.de>
In-Reply-To: <Pine.LNX.4.61.0506101310120.31175@montezuma.fsmlabs.com>
References: <1118374208.7510.6.camel@linux-hp.sh.intel.com>
	 <Pine.LNX.4.61.0506101310120.31175@montezuma.fsmlabs.com>
Content-Type: text/plain
Date: Mon, 13 Jun 2005 09:18:44 +0800
Message-Id: <1118625524.3822.12.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 13:11 -0600, Zwane Mwaikambo wrote:
> Hello Shaohua,
> 
> On Fri, 10 Jun 2005, Shaohua Li wrote:
> 
> > We should flush cache at CPU hotplug. An error has been observed data is
> > corrupted after CPU hotplug in CPUs with bigger cache.
> > I guess IA64 requires similar change, Ashok?
> 
> Interesting, which processor was this?
It's a kind of Pentium M. 

> > 
> >  linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c   |    1 +
> >  linux-2.6.12-rc6-mm1-root/arch/x86_64/kernel/process.c |    1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff -puN arch/i386/kernel/process.c~flush_cache_cpuhotplug arch/i386/kernel/process.c
> > --- linux-2.6.12-rc6-mm1/arch/i386/kernel/process.c~flush_cache_cpuhotplug	2005-06-10 10:56:05.082247160 +0800
> > +++ linux-2.6.12-rc6-mm1-root/arch/i386/kernel/process.c	2005-06-10 11:05:10.597316264 +0800
> > @@ -155,6 +155,7 @@ static inline void play_dead(void)
> >  {
> >  	/* This must be done before dead CPU ack */
> >  	cpu_exit_clear();
> > +	wbinvd();
> >  	mb();
> 
> We shouldn't need that mb() there anymore then, ditto for the other 
> location.
Indead. How about just leave it here for clearness?

Thanks,
Shaohua

